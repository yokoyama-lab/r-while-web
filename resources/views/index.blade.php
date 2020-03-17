<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>R-WHILE Playground</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Write and run R-WHILE programs in your browser">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">
  </head>

  <body style="padding-top:50px">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="js/ace/ace.js" charset="utf-8"></script>
    <script src="/js/main.js"></script>

    <!--ナビゲーションバー-->
    <nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
      <!--ブランド-->
      <a class="navbar-brand" href="#">R-WHILE PLAYGROUND</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="ナビゲーション切り替え">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav mr-auto">
        <!--Executeボタン-->
        <li class="nav-item">
          <button class="square_btn" id="execute" type="button" name="button">Execute</button>
        </li>
        <!--サンプルリスト-->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="example" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Sample</a>
          <div class="dropdown-menu" aria-labelledby="example">
            <a class="dropdown-item" href="0">reverse</a>
            <a class="dropdown-item" href="1">swap</a>
            <a class="dropdown-item" href="2">translation from a tree to its preorder and inorder traversal (piorder)</a>
            <a class="dropdown-item" href="3">self-interpretation of an identity function</a>
            <a class="dropdown-item" href="4">self-interpretation of reverse</a>
            <a class="dropdown-item" href="5">self-interpretation of piorder</a>
            <a class="dropdown-item" href="6">self-interpretation of self-interpretation of reverse (This will probably time out in this playground.)</a>
            <a class="dropdown-item" href="7">Infinite loop (in *both* directions)</a>
            <a class="dropdown-item" href="8">Enumeration of trees</a>
          </div>
        </li>
        <!--オプション-->
        <li class="nav-item">
          <a class="nav-link" href="#option" data-toggle="modal">Options  <i class="fas fa-cogs"></i></a>
        </li>
        <!--概要-->
        <li class="nav-item">
          <a class="nav-link" href="#about" data-toggle="modal">About</a>
        </li>
        </ul>
        <!--右側の要素-->
        <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="#"><i class="fab fa-github my-icon"></i></a>
        </li>
      </ul>
      </div>
    </nav>

    <!--モーダル(オプション)-->
    <div class="modal fade" id="option" tabindex="-1" role="dialog" aria-labelledby="option" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title" id="exampleModalLabel">Options</h3>
          </div>
          <div class="modal-body">
            <div class="custom-control custom-checkbox mb-3">
              <input type="checkbox" class="custom-control-input" id="customCheck1" name="invert" value="1">
              <label class="custom-control-label" for="customCheck1">Inversion</label>
            </div>
            <div class="custom-control custom-checkbox mb-3">
              <input type="checkbox" class="custom-control-input" id="customCheck2" name="p2d" value="1">
              <label class="custom-control-label" for="customCheck2">Program2data</label>
            </div>
            <div class="custom-control custom-checkbox mb-3">
              <input type="checkbox" class="custom-control-input" id="customCheck3" name="exp" value="1">
              <label class="custom-control-label" for="customCheck3">Expand macros</label>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-brand" data-dismiss="modal">close</button>
          </div>
        </div>
      </div>
    </div>

    <!--モーダル(概要)-->
    <div class="modal fade" id="about" tabindex="-1" role="dialog" aria-labelledby="about" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title" id="exampleModalLabel">About the R-WHILE Playground</h3>
          </div>
          <div class="modal-body">
            <p>The Playground lets you try out the R-WHILE programming language in your browser without having to install anything. When you click "Execute" the program is sent to the server where it is executed and the result is returned.
                The R-WHILE Playground has been created by students of Yokoyama lab.</p>
            <h3>Usage</h3>
            <p>You can load example programs by clicking on the <b>Sample</b> dropdown in the menu and selecting an example which will then be loaded into the text area.</p>
            <p>The code in the text area can be run by pressing the <b>Execute</b> button in the menu and the result will appear.</p>
            <p>If you wish to see the inversion of the program currently written in the text area, press the <b>Option</b> button. The inverted program will then show up in the result window.</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-brand" data-dismiss="modal">close</button>
          </div>
        </div>
      </div>
  </div>

  <!--メインコンテンツ-->
  <div class="py-3">
    <div class="container-fluid">
        <div class="form-group row">
          <!--Rwhile_code-->
          <div class="col-lg-7">
            <div class="col-md-12 col-sm-12 codeSide" id="programinput">
            <h3>R-WHILE code</h3>
            <input id="rwhile-code" type="hidden" value="{{ $program }}">
            <div id="code" style="height: 75vh; width: 100%"></div>
            <script>
              var editor1 = ace.edit("code");
              var js_var = $('#rwhile-code').val();
              editor1.getSession().setUseWrapMode(true);
              editor1.setFontSize(14);
              editor1.setTheme("ace/theme/tommorow");
              editor1.setValue(js_var,-1);
              var value1;
              function get_value1_variable(){
                value1 = editor1.getValue();
              }
            </script>
            </div>
          </div>
          <!--data,result-->
          <div class="col-lg-5">
            <div class="col-md-12 col-sm-12 codeSide" id="codeinput">
              <h3>Input data</h3>
              <input id="input-data" type="hidden" value="{{ $data }}">
              <div id="data" style="height: 40vh; width: 100%"></div>
              <script>
                var js_var = $('#input-data').val();
                var editor2 = ace.edit("data");
                editor2.setFontSize(14);
                editor2.setTheme("ace/theme/tommorow");
                editor2.getSession().setUseWrapMode(true);
                editor2.setValue(js_var,-1)
                var value2;
                function get_value2_variable(){
                  value2 = editor2.getValue();
                }
              </script>
            </div>
            <div class="codeSide" id="showresult">
              <h3>Result</h3>
              <textarea id="output" disabled></textarea>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script>
      $("#execute").on('click',function(){
        var inv = 0;
        var p2 = 0;
        var ex = 0;
        get_value1_variable();
        get_value2_variable();
        if(document.getElementById("customCheck1").checked){
          inv = 1;
        }
        if(document.getElementById("customCheck2").checked){
          p2 = 1;
        }
        if(document.getElementById("customCheck3").checked){
          ex = 1;
        }
        $.ajax({
            headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
            url: "execute",
            type: 'post',
            dataType: 'json',
            data : {
                "prog" : value1,
                "data" : value2,
                "invert" : inv,
                "p2d" : p2,
                "exp" : ex
            },
        }).done(function(data){
            $("#output").text(data["output"]);
        }).fail(function(jqXHR,textStatus,errorThrown){ //ajaxの通信に失敗した場合
            $("#output").text("Syntax error!");
        });
      });
    </script>
  </body>
</html>
