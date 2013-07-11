from pyramid.request import Request
from pyramid.security import authenticated_userid
from pyramid.decorator import reify

from myproject.models import DBSession, User

class MyRequest(Request):
    @reify
    def user(self):
        id_ = authenticated_userid(self)
        if id_:
            return DBSession.query(User).filter(User.id == id_).first()