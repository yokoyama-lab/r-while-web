<?php

namespace Tests\Feature;

use Tests\TestCase;

class ExecuteTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        if (! is_executable(config('rwhile.ri_bin'))) {
            $this->markTestSkipped('R-WHILE の処理系が未ビルド（cd src && make install）');
        }
    }

    private function program(string $name): string
    {
        return file_get_contents(public_path('examples/'.$name));
    }

    public function test_it_runs_a_program_against_its_input(): void
    {
        $response = $this->postJson('/execute', [
            'prog' => $this->program('reverse.rwhile'),
            'data' => $this->program('list123.val'),
        ])->assertOk();

        $this->assertSame("('3 . ('2 . ('1 . nil)))\n", $response->json('output'));
    }

    public function test_it_inverts_a_program_and_ignores_the_input_data(): void
    {
        $response = $this->postJson('/execute', [
            'prog' => $this->program('reverse.rwhile'),
            'data' => 'this would not parse as data',
            'invert' => 1,
        ])->assertOk();

        // 反転すると read/write が入れ替わる。
        $this->assertStringContainsString('read X;', $response->json('output'));
        $this->assertStringContainsString('write Y', $response->json('output'));
    }

    public function test_it_expands_macros(): void
    {
        $this->postJson('/execute', [
            'prog' => $this->program('reverse.rwhile'),
            'data' => '',
            'exp' => 1,
        ])->assertOk()->assertJsonStructure(['output']);
    }

    public function test_a_syntax_error_is_reported_instead_of_an_empty_box(): void
    {
        // Laravel 6 版は標準出力だけを返していたので、構文エラーは空欄になった。
        $response = $this->postJson('/execute', [
            'prog' => 'this is not an R-WHILE program',
            'data' => 'nil',
        ])->assertOk();

        $this->assertStringContainsString('Parse_error', $response->json('output'));
    }

    public function test_a_non_terminating_program_is_cut_off(): void
    {
        config(['rwhile.timeout' => 2]);

        $response = $this->postJson('/execute', [
            'prog' => $this->program('infinite.rwhile'),
            'data' => $this->program('nil.val'),
        ])->assertOk();

        $this->assertSame("Execution timed out!\n", $response->json('output'));
    }

    public function test_it_leaves_no_scratch_files_behind(): void
    {
        $dir = storage_path('app/rwhile');

        $this->postJson('/execute', [
            'prog' => $this->program('reverse.rwhile'),
            'data' => $this->program('list123.val'),
        ])->assertOk();

        // Laravel 6 版は public/programs/ と public/data/ に投稿を溜め続けた。
        $this->assertSame([], is_dir($dir) ? array_values(array_diff(scandir($dir), ['.', '..'])) : []);
    }

    public function test_it_rejects_a_missing_program(): void
    {
        $this->postJson('/execute', ['data' => 'nil'])
            ->assertStatus(422)
            ->assertJsonValidationErrors('prog');
    }

    public function test_it_rejects_an_oversized_program(): void
    {
        $this->postJson('/execute', [
            'prog' => str_repeat('a', config('rwhile.max_input_bytes') + 1),
            'data' => 'nil',
        ])->assertStatus(422)->assertJsonValidationErrors('prog');
    }

    public function test_the_interpreter_runs_under_a_memory_limit(): void
    {
        $prlimit = config('rwhile.prlimit_bin');

        if (! is_executable($prlimit)) {
            $this->markTestSkipped('prlimit が無い環境');
        }

        $controller = new \App\Http\Controllers\RWHILEController;
        $method = (new \ReflectionClass($controller))->getMethod('withResourceLimits');
        $command = $method->invoke($controller, ['/bin/ri', 'prog']);

        $this->assertSame($prlimit, $command[0]);
        $this->assertContains('--data='.(config('rwhile.memory_limit_mb') * 1024 * 1024), $command);
        $this->assertContains('--core=0', $command);
        $this->assertSame(['/bin/ri', 'prog'], array_slice($command, -2));
    }

    public function test_a_program_that_allocates_without_bound_is_cut_off(): void
    {
        if (! is_executable(config('rwhile.prlimit_bin'))) {
            $this->markTestSkipped('prlimit が無い環境');
        }

        // examples/infinite.rwhile は止まらないうえに確保し続ける（実測で 10 秒 192MB）。
        // 上限を小さくすれば、時間切れを待たずに落ちるはずである。
        config(['rwhile.memory_limit_mb' => 16, 'rwhile.timeout' => 20]);

        $started = microtime(true);
        $response = $this->postJson('/execute', [
            'prog' => $this->program('infinite.rwhile'),
            'data' => $this->program('nil.val'),
        ])->assertOk();
        $elapsed = microtime(true) - $started;

        $this->assertLessThan(20, $elapsed, '時間切れではなくメモリ上限で落ちること');
        $this->assertStringContainsString('Out of memory', $response->json('output'));
        $this->assertStringNotContainsString(storage_path(), $response->json('output'));
    }

    public function test_it_refuses_when_every_execution_slot_is_taken(): void
    {
        $slots = (int) config('rwhile.max_concurrent');

        $held = [];
        for ($i = 0; $i < $slots; $i++) {
            $lock = \Illuminate\Support\Facades\Cache::lock("rwhile-exec-$i", 30);
            $this->assertTrue($lock->get(), "slot $i を掴めること");
            $held[] = $lock;
        }

        try {
            $this->postJson('/execute', [
                'prog' => $this->program('reverse.rwhile'),
                'data' => $this->program('list123.val'),
            ])->assertStatus(503);
        } finally {
            foreach ($held as $lock) {
                $lock->release();
            }
        }
    }

    public function test_it_frees_its_slot_after_a_normal_run(): void
    {
        $this->postJson('/execute', [
            'prog' => $this->program('reverse.rwhile'),
            'data' => $this->program('list123.val'),
        ])->assertOk();

        // 解放されていなければ 2 回目以降が詰まる。
        $lock = \Illuminate\Support\Facades\Cache::lock('rwhile-exec-0', 5);
        $this->assertTrue($lock->get(), '実行後にスロットが解放されていること');
        $lock->release();
    }
}
