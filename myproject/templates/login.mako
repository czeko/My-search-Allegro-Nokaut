<%inherit file="register.mako"/>
<%namespace file="render_field.mako" import="*"/>
<%block name="result">
<div class="middle">
    <div class="form_login">
        <div class="head_login">Login in</div>
        <form method='post' action="/login">
            ${render_field(form.login, class_='input_text')}
            ${render_field(form.password, class_='input_text')}
            <button class="btn btn-primary" type=submit>Login</button>
        </form>
    </div>
</div>
</%block>
