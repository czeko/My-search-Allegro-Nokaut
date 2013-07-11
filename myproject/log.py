# -*- coding: utf-8 -*-
"""
Forms for register users
"""
import wtforms as wtf
from wtforms import validators, Form, BooleanField, TextField, PasswordField, ValidationError
from pyramid.i18n import TranslationStringFactory

from myproject.models import User, DBSession

def validate_login(form, field):
    log = DBSession.query(User).filter(User.login == field.data).first()
    if log is None:
        raise ValidationError("Enter correct login")


class LoginForm(wtf.Form):

    login = TextField('Login', [validate_login])
    password = PasswordField('Password', [
        validators.Required()])
