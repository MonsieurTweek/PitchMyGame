{def $current_user = fetch_alias('current_user') }

<div id="main-content">
	{if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
		{foreach $zones[0].blocks as $block}
			{block_view_gui block=$block}
		{/foreach}
	{/if}
</div>

<div id="sidebar">
	{if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
		{foreach $zones[1].blocks as $block}
			{block_view_gui block=$block}
		{/foreach}
	{/if}
</div>

{undef $current_user}