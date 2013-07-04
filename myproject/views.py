from pyramid.response import Response
from pyramid.view import view_config
from sqlalchemy.exc import DBAPIError

from .models import (
    DBSession,
    MyModel,
    )

from nokaut.lib import nokaut_api, NokautError
from allegro.lib import downolad_data, AllegroError

@view_config(route_name='compare', renderer='myproject:templates/mytemplate.mako')
def my_view(request):
    #import ipdb; ipdb.set_trace()
    if 'product' in request.GET and request.GET['product'] != '':
        try:
            price_n, url_n = nokaut_api('a8839b1180ea00fa1cf7c6b74ca01bb5', request.GET['product'])
        except NokautError:
            price_n, url_n = 0, "http://nokaut.pl"
        try:
            url_a, price_a = downolad_data(request.GET['product'])
        except AllegroError:
            price_a, url_a = 0, "http://allegro.pl"
        return{
            'price_n': price_n,
            'url_n': "http://nokaut.pl",
            'price_a': price_a,
            'url_a': url_a,
            'pro': request.GET['product']
        }
    else:
        return{
            'price_n': 0,
            'url_n': "http://nokaut.pl",
            'price_a': 0,
            'url_a': "http://allegro.pl",
            'pro': request.GET['product']
        }



@view_config(route_name='home', renderer='myproject:templates/mytemplate2.mako')
def my_view2(request):
    return {}