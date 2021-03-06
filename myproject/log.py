# -*- coding: utf-8 -*-
import wtforms as wtf
from wtforms import validators, TextField, PasswordField, ValidationError

from myproject.models import User, DBSession


def validate_login(form, field):
    log = DBSession.query(User).filter(User.login == field.data).first()
    if log is None:
        raise ValidationError("Enter correct login")


def validate_pass1(form, field):
    log = DBSession.query(User).filter(User.login == form.login.data)\
        .filter(User.password == field.data).first()
    if log is None:
        raise ValidationError("Enter a correct password")


class LoginForm(wtf.Form):

    login = TextField('Login', [validate_login])
    password = PasswordField('Password', [
        validators.Required(), validate_pass1])
