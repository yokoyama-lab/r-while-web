<?php

use App\Http\Controllers\RWHILEController;
use Illuminate\Support\Facades\Route;

Route::get('/', [RWHILEController::class, 'index']);
// 1 回の実行にプロセスを 1 つ起こし、最大 RWHILE_TIMEOUT 秒走る。公開の
// 実行エンドポイントなので、1 つの相手が際限なく起動できないようにする。
Route::post('/execute', [RWHILEController::class, 'execute'])->middleware('throttle:30,1');

// サンプル読み込み。ビューの Sample ドロップダウンが 0〜8 を相対 URL で叩く。
// 数字に限定しないと、あらゆる 1 階層のパスがこの経路に落ちる（Laravel 6 版はそうだった）。
Route::get('/{sample}', [RWHILEController::class, 'sample'])->whereNumber('sample');
