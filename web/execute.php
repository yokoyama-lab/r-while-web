<?php
set_time_limit(10);             // 時間制限の設定

function convertEOL($string, $to = "\n")
{
    return strtr($string, array(
        "\r\n" => $to,
        "\r" => $to,
        "\n" => $to,
    ));
}

$dir = dirname(__FILE__);
$cmd = "timeout -sKILL 10 $dir/ri";

// 引数の設定
$invert = filter_input(INPUT_POST, "invert", FILTER_VALIDATE_BOOLEAN);
$p2d =    filter_input(INPUT_POST, "p2d",    FILTER_VALIDATE_BOOLEAN);
$exp =    filter_input(INPUT_POST, "exp",    FILTER_VALIDATE_BOOLEAN);
$ri_flags = array();
if ($invert) { $cmd .= " -inverse"; }
if ($p2d)    { $cmd .= " -p2d"; }
if ($exp)    { $cmd .= " -exp"; }

// プログラムを保存する
$prog_text = convertEOL(filter_input(INPUT_POST, "prog", FILTER_UNSAFE_RAW));
$prog_hash = substr(sha1($prog_text), 0, 8);
$res = file_put_contents("$dir/programs/$prog_hash.rwhile", $prog_text);
if ($res === FALSE) {
    header("HTTP/1.1 500 Internal Server Error");
    exit;
}
$cmd .= " $dir/programs/$prog_hash.rwhile";

// データを保存する
$data_text = convertEOL(filter_input(INPUT_POST, "data", FILTER_UNSAFE_RAW));
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
      echo "Execution timed out!\n";
    }
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>R-WHILE Result</title>
    <link href="static/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="static/css/main.css">
    <link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
  </head>

  <body style="padding-top:50px">
    <script src="static/js/jquery-3.3.1.slim.min.js"></script>
    <script src="static/js/bootstrap.bundle.min.js"></script>

    <nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
      <a class="navbar-brand" href="#">R-WHILE PLAYGROUND</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="ナビゲーション切り替え">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item">
          <button type="button" class="square_btn" onclick="history.back()">Back<i class="fas fa-step-backward"></i></button>
        </li>
      </ul>
      </div>
    </nav>

    <div class="py-3">
      <div class="container-fluid">
        <div class="col-lg-7" id="result">
          <h3>Result</h3>
          <textarea name="output">
<?php
    echo $output;
?>
          </textarea>
<?php
}

?>
        </div>
      </div>
    </div>
  </body>
</html>
