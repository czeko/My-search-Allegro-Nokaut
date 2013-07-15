<%inherit file="base.mako"/>


<%block name="history">

                <table cellpadding="0" celllspacing="0" border="0" class="list">
                    %for product in objs:
                    <tr>
                        <td class="thumb"><img src="img/img_demo.jpg" alt="img_demo"/></td>
                        <td class="name_list">${product.name}</td>
                        % if product.price_a is None:
                            <td class="price_list">Allegro: No result</td>
                        %else:
                            <td class="price_list">Allegro: ${product.price_a}</td>
                        % endif
                         % if product.price_n is None:
                            <td class="price_list">Nokaut: No result</td>
                        %else:
                            <td class="price_list">Nokaut: ${product.price_n}</td>
                        % endif
                        <td class="more"><a href="/result?product=${product.name}" class="link_more btn">Zobacz</a></td>
                    </tr>
                    %endfor
                </table>


</%block>

<script type="text/javascript" src="${request.static_path('myproject:static/js/jquery-1.8.3.min.js')}"></script>








    <script type="text/javascript">
    $(document).ready(function() {
        $('button.btn_search').hover(function(e){
            $.get()
            return false;
        })
    });
    </script>

document).ready(function() {

        var callback = function(){
            alert('a');
        };
        var $buttons = ;

        $('button.btn_search').hover(function(e){
            alert('a');
            return false;
        })


