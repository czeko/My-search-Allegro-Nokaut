<%inherit file="register.mako"/>

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

<%block name="result">
<div class="middle">
    <div class="form_login">
        <div class="head_login">Login in</div>
        <form method='post' action="/login">
            ${render_field(form.login, class_='input_text')}
            ${render_field(form.password, class_='input_text')}
            %if message:
                <div class='my_error'>Enter a correct password</div>
            %endif
            <button class="btn btn-primary" type=submit>Login</button>
        </form>
    </div>
</div>
</%block>
