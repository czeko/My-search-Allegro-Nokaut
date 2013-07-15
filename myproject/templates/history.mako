<%inherit file="base.mako"/>


<%block name="history">

                <table cellpadding="0" celllspacing="0" border="0" class="list">
                    <tr>
                        <td class="price_list">Nazwa</td>
                        <td class="price_list">Allegro<br>( pln )</td>
                        <td class="price_list">Nokaut<br>( pln )</td>
                        <td class="price_list">Ilosc</td>
                        <td class="price_list">Data</td>
                        <td> </td>
                    </tr>
                    %for product in objs:
                    <tr>
                        <td class="name_list">${product.name}</td>
                        <td class="price_list">${product.price_a or 'No result'}</td>
                        <td class="price_list">${product.price_n or 'No result'}</td>
                        <td class="price_list">${product.count}</td>
                        <td class="price_list">${product.time.time()}</td>
                        <td class="more"><a href="/result?product=${product.name}" class="link_more btn">Odśwież</a></td>
                    </tr>
                    %endfor
                </table>


    <script type="text/javascript" src="${request.static_path('myproject:static/js/jquery-1.8.3.min.js')}"></script>
    <script type="text/javascript">
        $(document).ready(function(){
          $(".more").click(function(){
            $(this).hide();
            $(this).animate({left:'250px'});
            return  false;
          });
        });

    </script>

</%block>