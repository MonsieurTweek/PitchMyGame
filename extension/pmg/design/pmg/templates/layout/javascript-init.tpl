{def $initScripts = array()}

{if ezini_hasvariable('JavaScriptSettings', 'JSFileListInit', 'design.ini')}
    {set $initScripts = merge($initScripts, ezini('JavaScriptSettings', 'JSFileListInit', 'design.ini'))}
{/if}

<script type="text/javascript"> 
	uriBaseFull = "{ezini('SiteSettings', 'SiteURL', 'site.ini')}";
    if(!uriBaseFull.match(/http/))
        uriBaseFull = 'http://' + uriBaseFull;
    if(!uriBaseFull.match(/\/$/))
        uriBaseFull += '/';
    uriDesign = {''|ezdesign};
    {if is_set($module_result.content_info.node_id)}
        node_id = {$module_result.content_info.node_id};
    {/if}
</script>

{ezscript($initScripts, 'text/javascript', '', '', 3)}

{if ezini_hasvariable('JavaScriptSettings', 'JSFileListInitIE6', 'design.ini')}
    <!--[if IE 6]>
        {ezscript(ezini( 'JavaScriptSettings', 'JSFileListInitIE6', 'design.ini' ), 'text/javascript', '', '', 3)}
    <![endif]-->
{/if}

{undef $initScripts}