# -*- coding: utf-8 -*-
from wtforms import validators, Form, TextField, PasswordField, ValidationError

from myproject.models import User, DBSession


class RegisterForm(Form):
    def validate_login(form, field):
        log = DBSession.query(User).filter(User.login == field.data).first()
        if log is not None:
            raise ValidationError("This login is not available")

    login = TextField('Login', [validators.Length(min=4, max=25)])
    password = PasswordField('New Password', [
        validators.Required(),
        validators.Length(min=4, max=25),
        validators.EqualTo('password2', message='Passwords must match')
    ])
    password2 = PasswordField('Repeat Password')
