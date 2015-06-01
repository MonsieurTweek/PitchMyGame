{if is_set($block.custom_attributes.embed)}
	{def $content_node = fetch('content', 'node', hash('node_id', $block.custom_attributes.embed))}
	{node_view_gui content_node=$content_node view=block current_node=$current_node}
	{undef $content_node}
{/if}
