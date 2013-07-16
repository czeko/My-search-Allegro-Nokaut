from pyramid.config import Configurator
from sqlalchemy import engine_from_config
from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy
from pyramid.security import Allow, Everyone
from myproject.views import forbidden
from .utils.request import MyRequest
from .models import DBSession, Base, User


class Root(object):
    __acl__ = [
        (Allow, Everyone, 'all'),
        (Allow, 'g:user', 'view'),
    ]

    def __init__(self, request):
        self.request = request


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    def groupfinder(userid, request):
        if userid:
            user = DBSession.query(User).filter(User.id == userid).first()
            if user:
                group = 'g:%s' % user.group
                frst = {'userid': [group]}
                return frst.get('userid')
    engine = engine_from_config(settings, 'sqlalchemy.')
    DBSession.configure(bind=engine)
    Base.metadata.bind = engine
    authn_policy = AuthTktAuthenticationPolicy(
        'sosecret', callback=groupfinder, hashalg='sha512')
    authz_policy = ACLAuthorizationPolicy()
    config = Configurator(
        settings=settings,
        request_factory=MyRequest,
        default_permission='view',
        root_factory=Root
    )
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('home', '/')
    config.add_route('compare', '/result')
    config.add_route('welcome', '/welcome')
    config.add_route('register', '/register')
    config.add_route('login', '/login')
    config.add_route('logout', '/logout')
    config.add_route('forbidden', '/forbidden')
    config.add_route('history', '/history')
    config.add_route('popular', '/popular')
    config.add_route('history_jq', '/history_jq')
    config.set_authentication_policy(authn_policy)
    config.set_authorization_policy(authz_policy)
    config.scan()
    return config.make_wsgi_app()
