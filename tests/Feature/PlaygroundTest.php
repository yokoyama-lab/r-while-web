<?php

namespace Tests\Feature;

use Tests\TestCase;

class PlaygroundTest extends TestCase
{
    public function test_the_playground_page_renders(): void
    {
        $this->get('/')
            ->assertOk()
            ->assertSee('R-WHILE PLAYGROUND')
            ->assertSee('Execute');
    }

    public function test_a_sample_loads_its_program_and_data(): void
    {
        // 2 番は piorder。プログラムとデータの両方が入った状態で描画される。
        $response = $this->get('/2')->assertOk();

        $this->assertStringContainsString('piorder', $response->getContent());
        $this->assertStringContainsString('read ', $response->getContent());
    }

    public function test_an_unknown_sample_number_falls_back_to_reverse(): void
    {
        // Laravel 6 版の if 連鎖と同じ振る舞い（未知の番号は reverse）。
        $expected = file_get_contents(public_path('examples/reverse.rwhile'));

        $this->get('/999')
            ->assertOk()
            ->assertSee(e($expected), false);
    }

    public function test_a_non_numeric_path_is_not_swallowed_by_the_sample_route(): void
    {
        // 制約が無いと、あらゆる 1 階層のパスがサンプル表示に落ちてしまう。
        $this->get('/robots')->assertNotFound();
    }

    public function test_the_health_endpoint_still_answers(): void
    {
        $this->get('/up')->assertOk();
    }

    public function test_the_execute_route_is_rate_limited(): void
    {
        // 実行 1 回につきプロセスが 1 つ立つので、制限が外れると素朴な DoS になる。
        $route = collect(\Illuminate\Support\Facades\Route::getRoutes()->getRoutes())
            ->first(fn ($r) => $r->uri() === 'execute');

        $this->assertNotNull($route);
        $this->assertContains('throttle:30,1', $route->gatherMiddleware());
    }
}
