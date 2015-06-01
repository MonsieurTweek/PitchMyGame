{default 
	$limit = $node.data_map.limit.content
	$offset = 0
}
{def 	$children = 	fetch( 'content', 'list',
        					hash( 
	        					'parent_node_id', $node.node_id,
	        					'class_filter_type', include,
	        					'class_filter_array', array('news'),
	        					'offset', $offset|mul($limit),
	        					'sort_by', $node.sort_array,
	              				'limit', $limit
	              			)
	              		)
    	$nb_children = 	fetch( 'content', 'list_count',
    						hash(
    							'parent_node_id', $node.node_id,
	        					'class_filter_type', include,
	        					'class_filter_array', array('news')
    						)
    					)
}

<div id="block-{$node.class_identifier}" class="sidebar-block {$node.class_identifier} block-{$node.class_identifier}">
	<div class="title">
		<h2>{if not($node.name|eq(''))}{$node.name|wash}{else}{'News'|i18n('pmg')}{/if}</h2>
	</div>
	<div class="container outside">
		<div class="inside">
			<div class="slider">
				{foreach $children as $idx=>$child}
                    {if $child.node_id|eq($current_node.node_id)}
                        {continue}
                    {/if}
					{node_view_gui content_node=$child view="line"}
				{/foreach}
			</div>
		</div>

		{if $nb_children|gt($children|count)}
		<div class="pager">
			<a href="#" data-offset="{$offset}" data-limit="{$limit}" class="arrow prev disabled"></a>
			<span class="page">{$offset|sum(1)}</span>/<span class="nb_page">{$nb_children|div($limit)|ceil}</span>
			<a href="#" data-offset="{$offset|sum($limit)}" data-limit="{$limit}" class="arrow next"></a>
		</div>
		{/if}
	</div>
</div>
