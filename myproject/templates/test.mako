<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="${request.static_path('myproject:static/css/style_login.css')}">
    <script>
        function loadXMLDoc()
        {
        var xmlhttp;
        if (window.XMLHttpRequest)
          {// code for IE7+, Firefox, Chrome, Opera, Safari
          xmlhttp=new XMLHttpRequest();
          }
        else
          {// code for IE6, IE5
          xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
          }
        xmlhttp.onreadystatechange=function()
          {
          if (xmlhttp.readyState==4 && xmlhttp.status==200)
            {
            document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
            }
          }
        xmlhttp.open("GET","/",true);
        xmlhttp.send();
        }
    </script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"/>

    <script>
$(document).ready(function(){
  $("p").click(function(){
    $(this).hide();
  });
});
</script>
</head>
</head>
<body>
    <div id="container">
        <div class="main_box">
            <div class="head">
                <a href=/>
                <div class="logo_img"><img src="${request.static_path('myproject:static/img/logo.png')}" alt="logo"></div>
                </a>
                <div class="logo_txt">
                    <p>Compare products</p>
                    <div class="logo_txt_small">We will help you find and compare products</div>
                </div>
                <div class="box_login">
                    <a class="btn btn-success" href="/register">Register</a>
                    <a class="btn" href="/login">Login</a>
                </div>
            </div>
        <div id="myDiv"><h2>Let AJAX change this text</h2></div>
        <button type="button" onclick="loadXMLDoc()">Change Content</button>


        </div>
        <div class="footer">
            <img src="${request.static_path('myproject:static/img/logo_stx.png')}" alt="logo_stx"/>
        </div>
    </div>
    <script type="text/javascript" src="${request.static_path('myproject:static/js/jquery-1.8.3.min.js')}"></script>
    <script type="text/javascript">
    $(document).ready(function() {
        var btn_search = $('.search input');
        btn_search.focus(function() {
            $(this).attr('value','');
        });
    });
    </script>
</body>
</html>