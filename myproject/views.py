from pyramid.response import Response
from pyramid.view import view_config
from sqlalchemy.exc import DBAPIError

from .models import (
    DBSession,
    MyModel,
    )

from nokaut.lib import nokaut_api, NokautError
from allegro.lib import downolad_data, AllegroError


@view_config(route_name='home', renderer='myproject:templates/mytemplate2.mako')
def my_view2(request):
    return {}


@view_config(route_name='compare', renderer='myproject:templates/mytemplate.mako')
def my_view(request):
    #import ipdb; ipdb.set_trace()
    product = request.GET.get('product')
    nokaut_key = request.registry.settings.get('nokaut.key')

    if not product:
        return dict(
            status='NO_ITEM'
        )

    response = dict(
        status='OK',
        allegro=dict(),
        nokaut=dict(),
        product=product
    )

    try:
        url_a, price_a = downolad_data(product)
    except AllegroError as e:
        response['allegro']['status'] = 'NO_ITEM'
        response['allegro']['reason'] = str(e)
    else:
        response['allegro']['status'] = 'OK'
        response['allegro']['price'] = price_a
        response['allegro']['url'] = url_a

    try:
        price_n, url_n = nokaut_api(nokaut_key, product)
    except NokautError as e:
        response['nokaut']['status'] = 'NO_ITEM'
        response['nokaut']['reason'] = str(e)
    else:
        response['nokaut']['status'] = 'OK'
        response['nokaut']['price'] = price_n
        response['nokaut']['url'] = url_n

    return response
