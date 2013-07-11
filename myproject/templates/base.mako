<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="${request.static_path('myproject:static/css/style.css')}">
</head>
<body>
    <div id="container">
        <div class="main_box">
            <div class="head">
                <a href=/>
                <div class="logo_img"><img src="${request.static_path('myproject:static/img/logo.png')}" alt="logo"></div>
                </a>
                <div class="logo_txt">
                    Compare products
                    <div class="logo_txt_small">We will help you find and compare products</div>
                </div>
                <div class="box_login">
                    % if request.user:
                        <span>${request.user.login}</span>
                        <a class="btn" href="/logout">logout</a>
                    % else:
                        <a class="btn btn-success" href="/register">Register</a>
                        <a class="btn" href="/login">Login</a>
                    % endif

                </div>
            </div>
            <div class="middle">
                <div class="box_search">
                 <form  method="get" action='/result'>
                        <div class="search">
                            <input type="text" name='product' value=""/>
                        </div>
                        <button class="btn_search btn btn-primary" type=submit>Search</button>
                    </form>
                    <a class="btn" href="/history">Historia wyszukiwania</a>
                    <div class="clear"></div>
                </div>
                <%block name='history'/>
                <%block name="result"/>

            </div>
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
