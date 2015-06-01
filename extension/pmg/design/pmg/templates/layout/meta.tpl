{def
    $meta_desc = false()
    $path = $module_result.path
    $reverse_path = array()
    $meta = false()
}

{if $site.redirect}
<meta http-equiv="Refresh" content="{$site.redirect.timer}; URL={$site.redirect.location}" />
{/if}

{foreach $site.http_equiv as $key => $value}
<meta http-equiv="{$key|wash}" content="{$value|wash}" />
{/foreach}

{if is_set( $module_result.node_id )}
    {if ezini('ExtensionSettings', 'ActiveExtensions')|contains('ezmetadatatype')}
        {set $meta = metadata( $module_result.node_id )}
    {/if}
	
	{if is_set($module_result.title_path)}
	    {set $path = $module_result.title_path}
	{/if}

	{foreach $site.meta as $key => $value}
	    {if $key|eq('description')}
	        {if and( is_set( $meta.description), $meta.description|compare('')|not )}
	            {set $meta_desc = $meta.description|extract_left(150)}
	        {else}
	            {set $meta_desc = $value|wash}
	        {/if}
<meta name="description" content="{$meta_desc}" />
<meta property="og:description" content="{$meta_desc}" />
	    {elseif $key|eq('keywords')}
	        {if and( is_set( $meta.keywords), $meta.keywords|compare('')|not )}
<meta name="keywords" content="{$meta.keywords|wash}" />
	        {else}
<meta name="keywords" content="{$value|wash}" />
	        {/if}
	    {else}
	        {if $value|compare('')|not}
<meta name="{$key|wash}" content="{$value|wash}" />
	        {/if}
	    {/if}
	{/foreach}

	{if and(is_set($meta.title), $meta.title|compare('')|not)}
<meta property="og:title" content="{$meta.title|wash}" />
<meta property="og:site_name" content="{$site.title|wash}" />
	{else}
		{if and($path|is_array(), $path|count()|gt(1))}
			{set $reverse_path=$path|extract_right(1)}
<meta property="og:title" content="{$reverse_path.0.text|wash}" />
<meta property="og:site_name" content="{$site.title|wash}" />
		{else}
<meta property="og:title" content="{$site.title|wash}" />
		{/if}
	{/if}

<meta property="og:url" content="{$module_result.content_info.url_alias|ezurl('no', 'full')}" />
{else}
<meta property="og:title" content="{$site_title}" />
	{foreach $site.meta as $key => $value}
		{if $key|eq('description')}
<meta name="description" content="{$value|wash}" />
<meta property="og:description" content="{$value|wash}" />
		{elseif $key|eq('keywords')}
<meta name="keywords" content="{$value|wash}" />
		{else}
	        {if $value|compare('')|not}
<meta name="{$key|wash}" content="{$value|wash}" />
	        {/if}
		{/if}
	{/foreach}
<meta property="og:url" content="{'/'|ezurl('no', 'full')}" />
{/if}

{if and(is_set($module_result.content_info.class_identifier), array('news')|contains($module_result.content_info.class_identifier))}
	{def $node = fetch( 'content', 'node', hash( 'node_id', $module_result.node_id ))}

	<meta property="og:image" content="{$node.data_map.image.content.original.url|ezurl(no, full)}" />

	{undef $node}
{else}
	<meta property="og:image" content="{'fb-default.jpg'|ezimage('no')|ezurl('no','full')}" />
{/if}

<meta property="og:locale" content="fr_FR" />

{undef $meta_desc $path $reverse_path $meta}