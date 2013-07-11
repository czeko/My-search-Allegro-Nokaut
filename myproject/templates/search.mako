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
                     % if nokaut['price'] > allegro['price']:
                        <div class="price win">${allegro['price']} zł</div>
                     % else:
                        <div class="price">${allegro['price']} zł</div>
                     % endif

            </div>

            <div class="compare_box">
                <a href=${nokaut['url']}>
                    <img src="${request.static_path('myproject:static/img/logo_nokaut.png')}" alt="logo_nokaut"/>
                </a>
                     % if nokaut['price'] < allegro['price']:
                        <div class="price win">${nokaut['price']} zł</div>
                     % else:
                        <div class="price">${nokaut['price']} zł</div>
                     % endif

            </div>

        </div>
    % else:
            <div class='price'>Enter a product name!!</div>
    % endif


</%block>
