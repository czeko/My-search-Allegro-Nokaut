<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="${request.static_path('myproject:static/login/css/style.css')}">
</head>
<body>
    <div id="container">
        <div class="main_box">
            <div class="head">
                <div class="logo_img"><img src="${request.static_path('myproject:static/allegro_nokaut_html-css/img/logo.png')}" alt="logo"></div>
                <div class="logo_txt">
                    Compare products
                    <div class="logo_txt_small">We will help you find and compare products</div>
                </div>
                <div class="box_login">
                    <a class="btn btn-success" href="#register">Register</a>
                    <a class="btn" href="#login">Login</a>
                </div>
            </div>
            <div class="middle">
                <div class="form_login">
                    <div class="head_login">Register</div>
                    <form method="get" action="#">
                        <input class="input_text" type="text" name="login" value="login"/>
                        <input class="input_text" type="password" name="password" value="password"/>
                        <input class="input_text" type="password" name="password" value="password"/>
                        <button class="btn btn-primary" type=submit>Register</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="footer">
            <img src="${request.static_path('myproject:static/allegro_nokaut_html-css/img/logo_stx.png')}" alt="logo_stx"/>
        </div>
    </div>
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
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