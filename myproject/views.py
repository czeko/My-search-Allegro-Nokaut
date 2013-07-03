from pyramid.response import Response
from pyramid.view import view_config

from sqlalchemy.exc import DBAPIError

from .models import (
    DBSession,
    MyModel,
    )

from nokaut.lib import nokaut_api
from allegro.lib import downolad_data

@view_config(route_name='compare', renderer='myproject:templates/mytemplate.mako')
def my_view(request):
    if 'product' in request.GET:

        price_n, url_n = nokaut_api('a8839b1180ea00fa1cf7c6b74ca01bb5', request.GET['product'])
        url_a, price_a = downolad_data(request.GET['product'])
        return{
            'price_n': price_n,
            'url_n': url_n,
            'price_a': price_a,
            'url_a': url_a
        }

@view_config(route_name='home', renderer='myproject:templates/mytemplate2.mako')
def my_view2(request):

    return {}