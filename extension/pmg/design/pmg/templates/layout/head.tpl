{def
	$path = ''
    $reverse_path = array()
    $site_name = ezini('SiteSettings', 'SiteName')
    $meta = array()
}

{if is_set($module_result.path)}
	{set $path = $module_result.path}
{/if}

{if and(ezini('ExtensionSettings', 'ActiveExtensions')|contains('ezmetadatatype'), is_set($module_result.node_id))}
	{set $meta = metadata( $module_result.node_id )}
{/if}

{if is_set($module_result.title_path)}
    {set $path = $module_result.title_path|extract(2)}
{/if}

{if and(is_set($meta.title), $meta.title|compare('')|not)}
    {def $site_title = concat($meta.title|wash, ' - ', $site_name)}
{else}
    {if and($path|is_array(), $path|count()|gt(0))}
        {foreach $path as $item}
            {set $reverse_path=$reverse_path|array_prepend($item)}
        {/foreach}
        
        {def $site_title=""}
        {foreach $reverse_path as $key => $item}
            {set $site_title = $site_title|append($item.text|wash)}
            {if ne( count($reverse_path),inc($key) ) }
                {set $site_title = $site_title|append(" / ")}
            {/if}
        {/foreach}
        {set $site_title = $site_title|append(" - ", $site.title|wash)}
    {else}
        {def $site_title = $site.title|wash}
    {/if}
{/if}

<title>{$site_title}</title>
<link rel="shortcut icon" type="image/x-icon" href={'images/favicon.ico'|ezdesign} />

{undef $path $reverse_path $site_title $site_name $meta}