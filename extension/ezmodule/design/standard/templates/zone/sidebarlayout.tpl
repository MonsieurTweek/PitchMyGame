<div id="sidebar">
	{if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
		{foreach $zones[0].blocks as $block}
            {if is_set($current_node)}
    			{block_view_gui block=$block node=$current_node}
            {else}
    			{block_view_gui block=$block}
            {/if}
		{/foreach}
	{/if}
</div>
