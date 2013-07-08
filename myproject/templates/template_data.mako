<%inherit file="mytemplate2.mako"/>
<%block name="result">
<div>
    DZIALAA !@!!!
    <ul>
    % for o in objs:
        <li>!!!!${o.name}!!!</li>
    % endfor
    </ul>

</div>
</%block>