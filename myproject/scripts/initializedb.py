# -*- coding: utf-8 -*-
import os
import sys
import transaction

from sqlalchemy import engine_from_config
from pyramid.paster import get_appsettings, setup_logging
from ..models import DBSession, User, Product


def usage(argv):
    cmd = os.path.basename(argv[0])
    print('usage: %s <config_uri>\n'
          '(example: "%s development.ini")' % (cmd, cmd))
    sys.exit(1)


def main(argv=sys.argv):
    if len(argv) != 2:
        usage(argv)
    config_uri = argv[1]
    setup_logging(config_uri)
    settings = get_appsettings(config_uri)
    engine = engine_from_config(settings, 'sqlalchemy.')
    DBSession.configure(bind=engine)
    Base.metadata.create_all(engine)
    with transaction.manager:
        model_p = Product(
            name='one',
            price_a=1,
            url_a='http://allegro.pl',
            price_n=None,
            url_n=None,
            user_id=0

        )
        model_u = User(
            login='mal',
            password='trololo'
        )
        DBSession.add(model_p, model_u)
