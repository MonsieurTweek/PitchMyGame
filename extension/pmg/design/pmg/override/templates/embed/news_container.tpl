{def $children = 	fetch( 'content', 'list',
        					hash( 
	        					'parent_node_id', $node.node_id,
	        					'class_filter_type', include,
	        					'class_filter_array', array('news'),
	        					'sort_by', $node.sort_array
	              			)
	              		)
}
<div id="embed-{$node.class_identifier}">
	{foreach $children as $idx=>$child}
		{node_view_gui content_node=$child view="list"}
	{/foreach}
</div>