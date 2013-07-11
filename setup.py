import os

from setuptools import setup, find_packages

here = os.path.abspath(os.path.dirname(__file__))
README = open(os.path.join(here, 'README.txt')).read()
CHANGES = open(os.path.join(here, 'CHANGES.txt')).read()

requires = [
    'pyramid',
    'SQLAlchemy',
    'transaction',
    'pyramid_tm',
    'pyramid_debugtoolbar',
    'zope.sqlalchemy',
    'waitress',
    'nokaut',
    'allegro', 'wtforms'

    ]
dependency_links = [
    'https://github.com/czeko/nokaut/archive/master.tar.gz#egg=nokaut',
    'https://github.com/czeko/allegro/archive/master.tar.gz#egg=allegro'
    ]

setup(name='MyProject',
      version='0.0',
      description='MyProject',
      long_description=README + '\n\n' + CHANGES,
      classifiers=[
        "Programming Language :: Python",
        "Framework :: Pyramid",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
        ],
      author='',
      author_email='',
      url='',
      keywords='web wsgi bfg pylons pyramid',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      test_suite='myproject',
      install_requires=requires,
      dependency_links=dependency_links,
      entry_points="""\
      [paste.app_factory]
      main = myproject:main
      [console_scripts]
      initialize_MyProject_db = myproject.scripts.initializedb:main
      """,
      )
