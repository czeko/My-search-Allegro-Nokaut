<%inherit file="mytemplate2.mako"/>
<%block name="result">
    <div class="main_box_left">
                    <div class="name_product">
                      ${pro}
                    </div>

    </div>
                <div class="main_box_right">
                    <div class="compare_box">
                        <a href=${url_a}>
                            <img src="${request.static_url('myproject:static/allegro_nokaut_html-css/img/logo_allegro.png')}" alt="logo_allegro"/>
                        </a>
                        %if price_a < price_n:
                            <div class="price win">${price_a} zł</div>
                        %else:
                            <div class="price">${price_a} zł</div>
                         %endif
                    </div>
                    <div class="compare_box">
                        <a href=${url_n}>
                            <img src="${request.static_url('myproject:static/allegro_nokaut_html-css/img/logo_nokaut.png')}" alt="logo_nokaut" ${url_n}/>
                        </a>
                        %if price_n < price_a:
                            <div class="price win">${price_n} zł</div>
                        %else:
                            <div class="price">${price_n} zł</div>
                        %endif
                    </div>
                </div>


</%block>
