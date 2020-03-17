

//$(window).on('beforeunload', function(e) {
//return "All your changes will be lost when you leave the site.";
//});

function get_javascript_variable(){
  var inv = 0;
  var p2 = 0;
  var ex = 0;
  get_value1_variable();
  get_value2_variable();
  document.forms['input_form'].elements['prog'].value = value1;
  document.forms['input_form'].elements['data'].value = value2;
  if(document.getElementById("customCheck1").checked){
    inv = 1;
  }
  if(document.getElementById("customCheck2").checked){
    p2 = 1;
  }
  if(document.getElementById("customCheck3").checked){
    ex = 1;
  }
  document.forms['input_form'].elements['invert'].value = inv;
  document.forms['input_form'].elements['p2d'].value = p2;
  document.forms['input_form'].elements['exp'].value = ex;
}

function goClick() {
  window.open("http://www.tetsuo.jp/");
}
