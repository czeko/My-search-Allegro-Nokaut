from datetime import datetime


from sqlalchemy import (
    Column,
    Integer,
    Text,
    DateTime,
    ForeignKey,
    )
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import (
    scoped_session,
    sessionmaker,
    relationship,
    )
from zope.sqlalchemy import ZopeTransactionExtension

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))
Base = declarative_base()


class Product(Base):
    __tablename__ = 'products'
    id = Column(Integer, primary_key=True)
    name = Column(Text, nullable=False)
    price_a = Column(Integer)
    url_a = Column(Text)
    price_n = Column(Integer)
    url_n = Column(Text)
    time = Column(DateTime, default=datetime.now, onupdate=datetime.now)
    user_id = Column(Integer, ForeignKey('user.id'), nullable=False)
    count = Column(Integer)


class User(Base):
    __tablename__ = 'user'
    id = Column(Integer, primary_key=True)
    login = Column(Text)
    password = Column(Text)
    group = Column(Text, default='user')

    products = relationship("Product", backref='user', lazy='dynamic')