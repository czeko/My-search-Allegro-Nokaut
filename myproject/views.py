import datetime


from pyramid.response import Response
from pyramid.view import view_config, forbidden_view_config
from sqlalchemy.exc import DBAPIError
from pyramid_handlers import action
from pyramid.exceptions import Forbidden
from pyramid.security import Authenticated
from .models import (
    DBSession,
    User,
    Product,
    update
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


@view_config(route_name='home', renderer='myproject:templates/base.mako', permission='all')
def my_view2(request):
    return {}


@view_config(route_name='compare', renderer='myproject:templates/search.mako')
def my_view(request):
    product_name = request.GET.get('product')
    nokaut_key = request.registry.settings.get('nokaut.key')

    if not product_name:
        return dict(
            status='NO_ITEM'
        )

    product = DBSession.query(Product).filter(Product.name == product_name, Product.user_id == request.user.id).order_by(Product.time.desc()).first()

    if product is None:
        try:
            url_a, price_a = downolad_data(product_name)
        except AllegroError as e:
            url_a = '#'
            price_a = None
        try:
            price_n, url_n = nokaut_api(nokaut_key, product_name)
        except NokautError as e:
            url_n = '#'
            price_n = None

        product = Product(
            name=product_name,
            price_a=price_a,
            url_a=url_a,
            price_n=price_n,
            url_n=url_n,
            user_id=request.user.id,
            count=1
        )
        DBSession.add(product)

    elif (datetime.datetime.now() - product.time).days > 2:
        try:
            url_a, price_a = downolad_data(product_name)
        except AllegroError:
            url_a = None
            price_a = None
        try:
            price_n, url_n = nokaut_api(nokaut_key, product_name)
        except NokautError:
            url_n = None
            price_n = None

            product.price_a=price_a,
            product.url_a=url_a,
            product.price_n=price_n,
            product.url_n=url_n,
            product.count +=1

    product.count +=1
    response = dict(
            status='OK',
            allegro=dict(),
            nokaut=dict(),
            product=product_name
        )
    response['allegro']['price'] = product.price_a
    response['allegro']['url'] = product.url_a
    response['nokaut']['price'] = product.price_n
    response['nokaut']['url'] = product.url_n


    return response




@view_config(route_name='register', renderer='myproject:templates/register.mako', permission='all')
def register(request):
    form = RegisterForm(request.POST)

    if request.method == 'POST' and form.validate():
        login = form.login.data
        password = form.password.data
        password2 = form.password2.data
        if not login or not password or password != password2:
            return {}
        model = User(login=login, password=password)
        DBSession.add(model)
        DBSession.flush()
        headers = remember(request, model.id)
        return HTTPFound(location='/welcome',
                         headers=headers)

    return dict(
        form=form,
    )


@view_config(route_name='login', renderer='myproject:templates/login.mako', permission='all')
def login(request):
    form = LoginForm(request.POST)

    if request.method == 'POST' and form.validate():
        login = form.login.data
        password = form.password.data
        user = DBSession.query(User).filter(User.login == login)\
                                    .filter(User.password == password)\
                                    .first()
        if user:
            headers = remember(request, user.id)
            return HTTPFound(location='/welcome',
                             headers=headers)
        else:
            return dict(
                form=form,
                message=True
            )

    return dict(
        form=form,
        message=False
    )


@view_config(route_name='welcome', renderer='myproject:templates/base.mako')
def my_data(request):
    return dict()


@view_config(route_name='logout')
def logout(request):
    headers = forget(request)
    return HTTPFound('/', headers=headers)


@view_config(route_name='history', renderer='myproject:templates/history.mako' )
def history(request):
    objs = DBSession.query(Product).filter(Product.user_id == request.user.id).order_by(Product.time.desc()).all()
    return dict(
        objs=objs
    )


@view_config(route_name='popular', renderer='myproject:templates/history.mako' )
def popular(request):
    objs = DBSession.query(Product).filter(Product.user_id == request.user.id).order_by(Product.count.desc()).all()
    return dict(
        objs=objs[:3]
    )


@forbidden_view_config(renderer='myproject:templates/forbidden.mako')
def forbidden(request):
    return {}
