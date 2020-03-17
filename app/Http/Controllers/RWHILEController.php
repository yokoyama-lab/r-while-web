<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

function convertEOL($string, $to = "\n")
{
    return strtr($string, array(
        "\r\n" => $to,
        "\r" => $to,
        "\n" => $to,
    ));
}

class RWHILEController extends Controller
{
  public function index()
  {
    $program = "";
    $data = "";
    return view('index', compact('program', 'data'));
  }

  public function index_sample($id)
  {
    $example = $id;
    if ($example == 1) {
       $filename = "swap.rwhile";
    } else if ($example == 2) {
       $filename = "piorder.rwhile";
    } else if ($example == 3) {
       $filename = "ri.rwhile";
    } else if ($example == 4) {
       $filename = "ri.rwhile";
    } else if ($example == 5) {
       $filename = "ri.rwhile";
    } else if ($example == 6) {
       $filename = "ri.rwhile";
    } else if ($example == 7) {
       $filename = "infinite.rwhile";
    } else if ($example == 8) {
       $filename = "enumeration.rwhile";
    } else {
       $filename = "reverse.rwhile";
    }

    if ($example == 1) {
      $data = "list123.val";
    } else if ($example == 2) {
      $data = "piorder_input05.val";
    } else if ($example == 3) {
      $data = "id_and_nil.p_val";
    } else if ($example == 4) {
      $data = "reverse_and_list123.p_val";
    } else if ($example == 5) {
      $data = "piorder.p_val";
    } else if ($example == 6) {
      $data = "ri_ri_reverse_list123.p_val";
    } else if ($example == 8) {
      $data = "nil.val";
    } else {
      $data = "list123.val";
    }
    $program = file_get_contents(public_path().'/examples/'.$filename);
    $data = file_get_contents(public_path().'/examples/'.$data);
    return view('index', compact('program', 'data'));
  }

  public function execute(Request $request)
  {
    $program = $request->input('prog');
    $data = $request->input('data');

    set_time_limit(10);             // 時間制限の設定

    $dir = public_path();
    $cmd = "timeout -sKILL 10 $dir/ri";

    // 引数の設定
    $invert = $request->input('invert');
    $p2d =    $request->input('p2d');
    $exp =    $request->input('exp');
    $ri_flags = array();
    if ($invert) { $cmd .= " -inverse"; }
    if ($p2d)    { $cmd .= " -p2d"; }
    if ($exp)    { $cmd .= " -exp"; }

    // プログラムを保存する
    $prog_text = convertEOL($program);
    $prog_hash = substr(sha1($prog_text), 0, 8);
    $res = file_put_contents("$dir/programs/$prog_hash.rwhile", $prog_text);
    if ($res === FALSE) {
        header("HTTP/1.1 500 Internal Server Error");
        exit;
    }
    $cmd .= " $dir/programs/$prog_hash.rwhile";

    // データを保存する
    $data_text = convertEOL($data);
    $data_hash = substr(sha1($data_text), 0, 8);
    $res = file_put_contents("$dir/data/$data_hash.rwhile", $data_text);
    if ($res === FALSE) {
        header("HTTP/1.1 500 Internal Server Error");
        exit;
    }
    if (!($invert || $p2d || $exp)) {
      $cmd .= " $dir/data/$data_hash.rwhile";
    }

    $cwd = "/tmp";
    $descriptorspec = array(
        0 => array("pipe", "r"),
        1 => array("pipe", "w")
    );
    $env = array();

    // echo $cmd . "\n";
    $process = proc_open($cmd, $descriptorspec, $pipes, $cwd, $env);

    if (is_resource($process)) {

        fwrite($pipes[0], $prog_text);
        fclose($pipes[0]);

        $output = stream_get_contents($pipes[1]);
        fclose($pipes[1]);

        $return_value = proc_close($process);

        // echo $return_value . "\n";

        if ($return_value === 124) {
          $output = "Execution timed out!\n";
        }
      }
    $response = array();
    $response["output"] = $output;
    return $response;
  }
}
