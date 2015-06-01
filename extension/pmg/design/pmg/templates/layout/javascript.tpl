{def
    $scripts = array()
    $specScripts = array()
    $cond = array()
    $context = array()
}

{if ezini_hasvariable('JavaScriptSettings', 'JSFileListFirst', 'design.ini')}
    {set $scripts = merge($scripts, ezini('JavaScriptSettings', 'JSFileListFirst', 'design.ini'))}
{/if}

{if ezini_hasvariable('JavaScriptSettings', 'JSFileList', 'design.ini')}
    {set $scripts = merge($scripts, ezini('JavaScriptSettings', 'JSFileList', 'design.ini'))}
{/if}

{if ezini_hasvariable('JavaScriptSettings', 'JSFileListSpec', 'design.ini')}
    {set $specScripts = merge($specScripts, ezini('JavaScriptSettings', 'JSFileListSpec', 'design.ini'))}
{/if}

{foreach $specScripts as $file => $params}
    {set 
        $cond = $params|explode(';')
        $context = $cond[1]|explode(',')
    }
    
    {if
        or(
            and(is_set($module_result.content_info[$cond[0]]), $context|contains($module_result.content_info[$cond[0]])),
            and(is_set($module_result[$cond[0]]), $context|contains($module_result[$cond[0]]))
        )
    }
        {set $scripts = $scripts|append(concat($file, '.js'))}    
    {/if}
{/foreach}

{set $scripts = $scripts|unique()}
{ezscript($scripts, 'text/javascript', '', '', 3)}

{if ezini_hasvariable('JavaScriptSettings', 'JSFileListIE', 'design.ini')}
    <!--[if IE]>
        {ezscript(ezini( 'JavaScriptSettings', 'JSFileListIE', 'design.ini' ), 'text/javascript', '', '', 3)}
    <![endif]-->
{/if}

{if ezini_hasvariable('JavaScriptSettings', 'JSFileListIE6', 'design.ini')}
    <!--[if IE 6]>
        {ezscript(ezini( 'JavaScriptSettings', 'JSFileListIE6', 'design.ini' ), 'text/javascript', '', '', 3)}
    <![endif]-->
{/if}

{undef $scripts $specScripts $cond $context}