<?php

namespace Tests\Unit;

use PHPUnit\Framework\TestCase;

class SampleMapTest extends TestCase
{
    /**
     * ビューの Sample ドロップダウンは 0〜8 を出す。対応する例題ファイルが
     * すべて実在することを確かめる（欠けても画面は空欄になるだけで気づけない）。
     */
    public function test_every_sample_file_exists(): void
    {
        $examples = __DIR__.'/../../public/examples/';

        $reflection = new \ReflectionClass(\App\Http\Controllers\RWHILEController::class);
        $samples = $reflection->getConstant('SAMPLES');

        $this->assertCount(9, $samples);

        foreach ($samples as $id => [$program, $data]) {
            $this->assertFileExists($examples.$program, "sample $id のプログラム");
            $this->assertFileExists($examples.$data, "sample $id のデータ");
        }
    }
}
