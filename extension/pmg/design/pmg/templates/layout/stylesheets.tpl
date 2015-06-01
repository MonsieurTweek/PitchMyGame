{def
    $styles = array()
    $specStyles = array()
    $cond = array()
    $context = array()
}

{if ezini_hasvariable('StylesheetSettings', 'CSSFileList', 'design.ini')}
{set $styles = merge($styles, ezini('StylesheetSettings', 'CSSFileList', 'design.ini'))}
{/if}

{if ezini_hasvariable('StylesheetSettings', 'CSSFileListSpec', 'design.ini')}
{set $specStyles = merge($specStyles, ezini('StylesheetSettings', 'CSSFileListSpec', 'design.ini'))}

{foreach $specStyles as $file => $params}
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
{set $styles = $styles|append(concat($file, '.css'))}    
{/if}

{if $cond[0]|compare( 'uri' )}
{foreach $context as $value}
{if $module_result.uri|contains( $value )}
{set $styles = $styles|append(concat($file, '.css'))}
{/if}
{/foreach}    
{/if}
{/foreach}
{/if}

{set $styles = $styles|unique()}
{ezcss( $styles )}

{if ezini_hasvariable('StylesheetSettings', 'CSSFileListIE', 'design.ini')}
    <!--[if IE]>
    	{ezcss(ezini('StylesheetSettings', 'CSSFileListIE', 'design.ini'))}


    <![endif]-->
{/if}

{if ezini_hasvariable('StylesheetSettings', 'CSSFileListIE6', 'design.ini')}
    <!--[if IE 6]>
    	{ezcss(ezini('StylesheetSettings', 'CSSFileListIE6', 'design.ini'))}

        <style type="text/css">
            .png, .transparent-png-icon, .radioButton {literal}{{/literal} behavior: url({"stylesheets/iepngfix.htc"|ezdesign}) {literal}}{/literal}
        </style>
    <![endif]-->
{/if}

{undef $styles $specStyles $cond $context}