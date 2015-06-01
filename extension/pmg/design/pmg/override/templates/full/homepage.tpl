{def 	$news_container = 	fetch( 'content', 'list',
        					hash( 
	        					'parent_node_id', $node.node_id,
	        					'class_filter_type', include,
	        					'class_filter_array', array('news_container'),
	              				'limit', 1 
	              			)
	              		)
		$events_container = 	fetch( 'content', 'list',
		        					hash( 
			        					'parent_node_id', $node.node_id,
			        					'class_filter_type', include,
			        					'class_filter_array', array('events_container'),
			              				'limit', 1 
			              			)
			              		)
}
{if is_set($news_container.0)}
    {set $news_container = $news_container.0}
{/if}
{if is_set($events_container.0)}
    {set $events_container = $events_container.0}
{/if}
{def 	$next_event = 	fetch( 'content', 'list',
        					hash( 
	        					'parent_node_id', $events_container.node_id,
	        					'class_filter_type', include,
	        					'class_filter_array', array('event'),
	        					'sort_by', $events_container.sort_array,
	              				'limit', 1 
	              			)
	              		)
}
{if is_set($next_event.0)}
    {set $next_event = $next_event.0}
{/if}

<div id="full-{$node.class_identifier}">
	<div id="slideshow" class="flexslider">
		{if $node.data_map.slideshow.content.relation_list|count|gt(0)}
			<ul class="slides">
				{foreach $node.data_map.slideshow.content.relation_list as $obj}
					{def $image = fetch('content', 'node', hash('node_id', $obj.node_id))}
					<li class="slide">{node_view_gui content_node=$image view=slideshow}</li>
					{undef $image}
				{/foreach}
			</ul>
		{/if}
	</div>

	<div id="left">
		{node_view_gui content_node=$news_container view="embed"}
	</div>

	<div id="right">
		{if $node.data_map.project.has_content}
		<div id="star_project">
			{def $star_project = fetch( 'content', 'node', hash( 'node_id', $node.data_map.project.content.main_node_id ))}
			{node_view_gui content_node=$star_project view="embed"}
			{undef $star_project}
		</div>
		{/if}
		<div id="next_event">
			{node_view_gui content_node=$next_event view="block" class="expanded"}
		</div>
	</div>
</div>
{undef $news_container $next_event $events_container}