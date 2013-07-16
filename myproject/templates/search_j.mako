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
