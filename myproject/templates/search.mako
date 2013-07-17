<%inherit file="base.mako"/>

<%block name="result">

    % if status == 'OK':

        <div class="main_box_left">
            <div class="name_product">
                ${product.name}
            </div>
            <div class="box_photo">
                <img src="${request.static_path('myproject:static/img/tmp/%s.jpg' % product.name)}" alt="img_demo"/>
            </div>
        </div>

        <div class="main_box_right">

            <div class="compare_box">
                <a href=${product.url_a or '#'}>
                    <img src="${request.static_path('myproject:static/img/logo_allegro.png')}" alt="logo_allegro"/>
                </a>
                     % if (product.price_a is not None and product.price_n is not None \
                          and product.price_a < product.price_n) or\
                          (product.price_a is not None and product.price_n is None):
                         <div class="price win">${product.price_a} zł</div>
                     % elif product.price_a is None:
                         <div class="price">No result</div>
                     % else:
                        <div class="price">${product.price_a} zł</div>
                     % endif

            </div>

            <div class="compare_box">
                <a href=${product.url_n or '#'}>
                    <img src="${request.static_path('myproject:static/img/logo_nokaut.png')}" alt="logo_allegro"/>
                </a>
                     % if (product.price_n is not None and product.price_a is not None \
                          and product.price_n < product.price_a) or\
                          (product.price_n is not None and product.price_a is None):
                         <div class="price win">${product.price_n} zł</div>
                     % elif product.price_n is None:
                         <div class="price">No result</div>
                     % else:
                        <div class="price">${product.price_n} zł</div>
                     % endif

            </div>

        </div>
    % else:
            <div class='price'>Enter a product name!!</div>
    % endif


</%block>
