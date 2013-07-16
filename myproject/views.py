# -*- coding: utf-8 -*-

import datetime
import json

from pyramid.response import Response
from pyramid.view import view_config, forbidden_view_config
from sqlalchemy.exc import DBAPIError
from pyramid.exceptions import Forbidden
from pyramid.security import Authenticated
from .models import (
    DBSession,
    User,
    Product,
    )
from pyramid.security import (
    remember,
    forget,
    authenticated_userid
    )
from pyramid.httpexceptions import HTTPFound

from nokaut.lib import nokaut_api, NokautError
from allegro.lib import downolad_data, AllegroError
from register import RegisterForm
from log import LoginForm
import transaction


@view_config(route_name='home', renderer='myproject:templates/base.mako', permission='all')
def my_view2(request):
    return {}


@view_config(route_name='compare', renderer='myproject:templates/search.mako')
def my_view(request):
    product_name = request.GET.get('product')
    product_name_encode = product_name.encode('utf-8')
    nokaut_key = request.registry.settings.get('nokaut.key')
    if not product_name:
        return dict(
            status='NO_ITEM'
        )

    product = DBSession.query(Product) \
        .filter(Product.name == product_name) \
        .filter(Product.user_id == request.user.id) \
        .order_by(Product.time.desc()).first()

    if product is None:
        model = Product()
        model.name = product_name
        model.user_id = request.user.id
    elif (datetime.datetime.now() - product.time).days > 2:
        model = Product()
        model = product
        model.count += 1
    else:
        product.count += 1
        return dict(
            status='OK',
            product=product
        )

    try:
        url_a, price_a = downolad_data(product_name_encode)
    except AllegroError as e:
        url_a = None
        price_a = None
    else:
        model.url_a = url_a
        model.price_a = price_a
    try:
        price_n, url_n = nokaut_api(nokaut_key, product_name)
    except NokautError as e:
        url_n = None
        price_n = None
    else:
        model.url_n = url_n
        model.price_n = price_n

    DBSession.add(model)

    return dict(
        status='OK',
        product=model
    )


@view_config(renderer='json', route_name='history_jq')
def history_jq(request):

    response_j = my_view(request)
    return dict(
        status=response_j['status'],
        name=response_j['product'].name,
        url_a=response_j['product'].url_a,
        price_a=response_j['product'].price_a,
        url_n=response_j['product'].url_n,
        price_n=response_j['product'].price_n,
        time=response_j['product'].time.ctime(),
        count=response_j['product'].count
    )


@view_config(route_name='register', renderer='myproject:templates/register.mako', permission='all')
def register(request):
    form = RegisterForm(request.POST)

    if request.method == 'POST' and form.validate():
        login = form.login.data
        password = form.password.data
        password2 = form.password2.data
        model = User(login=login, password=password)
        DBSession.add(model)
        DBSession.flush()
        headers = remember(request, model.id)
        return HTTPFound(
            location='/welcome',
            headers=headers
        )

    return dict(
        form=form,
    )


@view_config(route_name='login', renderer='myproject:templates/login.mako', permission='all')
def login(request):
    form = LoginForm(request.POST)

    if request.method == 'POST' and form.validate():
        login = form.login.data
        password = form.password.data
        user = DBSession.query(User) \
            .filter(User.login == login) \
            .filter(User.password == password).first()

        headers = remember(request, user.id)
        return HTTPFound(
            location='/welcome',
            headers=headers
        )

    return dict(
        form=form,
    )


@view_config(route_name='welcome', renderer='myproject:templates/base.mako')
def my_data(request):
    return dict()


@view_config(route_name='logout')
def logout(request):
    headers = forget(request)
    return HTTPFound('/', headers=headers)


@view_config(route_name='history', renderer='myproject:templates/history.mako')
def history(request):
    objs = DBSession.query(Product)\
        .filter(Product.user_id == request.user.id)\
        .order_by(Product.time.desc()).all()

    return dict(
        objs=objs
    )


@view_config(route_name='popular', renderer='myproject:templates/history.mako')
def popular(request):
    objs = DBSession.query(Product) \
               .filter(Product.user_id == request.user.id) \
               .order_by(Product.count.desc())[:3]

    return dict(
        objs=objs
    )


@forbidden_view_config(renderer='myproject:templates/forbidden.mako')
def forbidden(request):
    return {}
