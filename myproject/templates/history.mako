<%inherit file="base.mako"/>


<%block name="history">

                <table cellpadding="0" celllspacing="0" border="0" class="list">
                    %for product in objs:
                    <tr>
                        <td class="thumb"><img src="img/img_demo.jpg" alt="img_demo"/></td>
                        <td class="name_list">${product.name}</td>
                        <td class="price_list">Allegro: ${product.price_a}</td>
                        <td class="more"><a href=${product.url_a} class="link_more btn">Zobacz</a></td>
                        <td class="price_list">Nokaut: ${product.price_n}</td>
                        <td class="more"><a href=${product.url_n} class="link_more btn">Zobacz</a></td>
                    </tr>
                    %endfor
                </table>


</%block>