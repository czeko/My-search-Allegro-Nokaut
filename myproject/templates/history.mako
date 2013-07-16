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
                        <td class="price_list" data-price_a="price_a">${product.price_a or 'No result'}</td>
                        <td class="price_list" data-price_n="price_n">${product.price_n or 'No result'}</td>
                        <td class="price_list" data-count="price_n">${product.count}</td>
                        <td class="price_list" data-time="url_n">${product.time.strftime('%H:%M:%S  %d-%m-%Y')}</td>
                        <td class="more" ><a data-name="${product.name}" class="link_more btn"> Odśwież </a></td>
                    </tr>
                    %endfor
                </table>

<script type="text/javascript">
    var $spinner = $('<img>', {src: '/static/img/4-0.gif'});
    $(document).ready(function() {
        $(".more a").click(function(){
            var $this = $(this)
            var $node = $(this).parent().parent()
            var $url = '/history_jq?product='+$(this).data('name')
            $this.html($spinner);

            $.getJSON($url).success(function(date){
                $this.html('Odśwież');
                if (date.price_n == null){
                    $node.find("[data-price_n]").text('No result');
                }
                else {
                $node.find("[data-price_n]").text(date.price_n);
                }
                if (date.price_a == null){
                    $node.find("[data-price_a]").text('No result');
                }
                else {
                $node.find("[data-price_a]").text(date.price_a);
                }
                $node.find("[data-count]").text(date.count);
                $node.find("[data-time]").text(date.timee);

        }).error(function(){
                alert("Error! Try later.");
                    })
        })
    });

</script>

</%block>
