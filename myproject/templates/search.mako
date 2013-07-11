<%inherit file="base.mako"/>

<%block name="result">

    % if status == 'OK':

        <div class="main_box_left">
            <div class="name_product">
                ${product}
            </div>
        </div>

        <div class="main_box_right">

            <div class="compare_box">
                <a href=${allegro['url']}>
                    <img src="${request.static_path('myproject:static/img/logo_allegro.png')}" alt="logo_allegro"/>
                </a>
                     % if (allegro['price'] is not None and nokaut['price'] is not None \
                          and allegro['price'] < nokaut['price']) or\
                          (allegro['price'] is not None and nokaut['price'] is None):
                         <div class="price win">${nokaut['price']} zł</div>
                     % elif allegro['price'] is None:
                         <div class="price">No result</div>
                     % else:
                        <div class="price">${allegro['price']} zł</div>
                     % endif

            </div>

            <div class="compare_box">
                <a href=${nokaut['url']}>
                    <img src="${request.static_path('myproject:static/img/logo_nokaut.png')}" alt="logo_nokaut"/>
                </a>
                     % if (nokaut['price'] is not None and allegro['price'] is not None \
                          and nokaut['price'] < allegro['price'])or\
                          (nokaut['price'] is not None and allegro['price'] is None):
                         <div class="price win">${nokaut['price']} zł</div>
                     % elif nokaut['price'] is None:
                         <div class="price">No result</div>
                     % else:
                        <div class="price">${nokaut['price']} zł</div>
                     % endif

            </div>

        </div>
    % else:
            <div class='price'>Enter a product name!!</div>
    % endif


</%block>
