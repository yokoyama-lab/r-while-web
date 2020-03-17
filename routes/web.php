<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'RWHILEController@index');
Route::get('/{id}', 'RWHILEController@index_sample');
Route::post('/execute', 'RWHILEController@execute');

/*Route::get('/', function () {
  $program = "test";
  $data = "test";
  return view('index', compact('program','data'));
});

Route::get('/index', function () {
    return view('index');
});

Route::get('/index/{id}', function ($id) {
    #$data["program"] = "test";
    #$data["data"] = "test";

});*/
