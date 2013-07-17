<%inherit file="base.mako"/>


<%block name="history">

                <table cellpadding="0" celllspacing="0" border="0" class="list">
                    <tr>
                        <td class="thumb"></td class="thumb">
                        <td class="price_list">Nazwa</td>
                        <td class="price_list">Allegro<br>( pln )</td>
                        <td class="price_list">Nokaut<br>( pln )</td>
                        <td class="price_list">Ilosc</td>
                        <td class="price_list">Data</td>
                        <td> </td>
                    </tr>
                    %for product in objs:
                    <tr>
                        <td class="thumb"><a href="${request.static_path('myproject:static/img/tmp/%s.jpg' % product.name)}" data-lightbox="${product.name}"><img src="${request.static_path('myproject:static/img/tmp/t_%s.jpg' % product.name)}" alt="img_demo"/></a></td>
                        <td class="name_list">${product.name}</td>
                        <td class="price_list" data-row_id="price_allegro">${product.price_a or 'No result'}</td>
                        <td class="price_list" data-row_id="price_nokaut">${product.price_n or 'No result'}</td>
                        <td class="price_list" data-row_id="count">${product.count}</td>
                        <td class="price_list" data-row_id="time">${product.time.strftime('%H:%M:%S  %d-%m-%Y')}</td>
                        <td class="more" ><a data-name="${product.name}" class="link_more btn"> Odśwież </a></td>
                    </tr>
                    %endfor
                </table>


    <script type="text/javascript" src="${request.static_path('myproject:static/js/jquery-1.8.3.min.js')}"></script>
    <script type="text/javascript" src="${request.static_path('myproject:static/js/lightbox-2.6.min.js')}"></script>
    <script type="text/javascript">
        $(document).ready(function(){
          $(".more").click(function(){
            $(this).animate({left:'250px'});
          });
        });

    </script>

<script type="text/javascript">
var $spinner = $('<img>', {src: '/static/img/loading.gif'});
    $(document).ready(function() {
        $(".more a").click(function(){
            var $this = $(this);
            var $row = $(this).parent().parent();
            var url = '/history_jq?product='+$(this).data('name');
            $this.html($spinner);
            $.getJSON(url).success(function(data){
                $this.html('Odśwież');
                $row.find("[data-row_id='price_allegro']").text(data.price_a || "No result");
                $row.find("[data-row_id='price_nokaut']").text(data.price_n || "No result");
                $row.find("[data-row_id='count']").text(data.count);
                $row.find("[data-row_id='time']").text(data.timee);
        }).error(function(){
                alert("Error! Try later.");
        });
        });
    });

</script>

</%block>
