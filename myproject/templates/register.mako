<%def name="render_field(field, **kwargs)">
  <dt>${field.label }
  <dd>${field(**kwargs)}
  % if field.errors:
    <ul class=errors>
    % for error in field.errors:
      <li class='my_error'>${error}</li>
    % endfor
    </ul>
  % endif
  </dd>
</%def>

<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="${request.static_path('myproject:static/css/style_login.css')}">
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
                    <a class="btn btn-success" href="/register">Register</a>
                    <a class="btn" href="/login">Login</a>
                </div>
            </div>
            <%block name="result">
            <div class="middle">
                <div class="form_login">
                    <div class="head_login">Register</div>
                    <form method="post" action="/register">
                        ${render_field(form.login, class_='input_text')}
                        ${render_field(form.password, class_='input_text')}
                        ${render_field(form.password2, class_='input_text')}
                        <button class="btn btn-primary" type=submit>Register</button>
                    </form>
                </div>
            </div>
            </%block>
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