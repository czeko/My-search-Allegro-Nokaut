<%inherit file="mytemplate2.mako"/>

 <%block name='history'>
   <table cellpadding="0" celllspacing="0" border="0" class="list">

    %for product in objs:
        <tr>
            <td class="name_list">${product.name}</td>
            <td class="price_list">${product.price_n}</td>
            <td class="more"><a href=${product.url_n} class="link_more btn">Zobacz</a></td>
        </tr>
    %endfor
    </table>
 </%block>