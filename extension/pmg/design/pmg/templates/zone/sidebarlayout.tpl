<div id="sidebar">
	{if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
		{foreach $zones[0].blocks as $block}
			{block_view_gui block=$block current_node=$current_node}
		{/foreach}
	{/if}
</div>
