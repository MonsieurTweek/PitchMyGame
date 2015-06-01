{def 	$homeNode = fetch( 'content', 'node', hash( 'node_id', $home))
        $allowedClasses = ezini('FooterSettings', 'AllowedClasses', 'settings.ini')
		$children = fetch( 'content', 'list',
        					hash( 
	        					'parent_node_id', $homeNode.node_id,
	        					'class_filter_type', 'include',
	        					'class_filter_array', $allowedClasses
	              			)
	              		)
		$events_container = fetch( 'content', 'list',
	        					hash( 
		        					'parent_node_id', $homeNode.node_id,
		        					'class_filter_type', 'include',
		        					'class_filter_array', array('events_container')
		              			)
		              		)
}
{if is_set($events_container.0)}
	{set $events_container = $events_container.0}
{/if}
{def 	$events = fetch( 'content', 'list',
        					hash( 
	        					'parent_node_id', $events_container.node_id,
	        					'class_filter_type', 'include',
	        					'class_filter_array', array('event'),
	        					'sort_by', array('attribute', false(), 'event/date'),
	        					'limit', 3
	              			)
	              		)
}
<div id="footer-wrap">

	<div id="footer">
		<div class="sitemap">
			<p class="title">{'Sitemap'|i18n('pmg')}</p>
			<ul class="children">
			{foreach $children as $child}
				<li><a href="{$child.url_alias|ezurl(no)}">{$child.name}</a></li>
			{/foreach}
			</ul>
		</div>
		<div class="events">
			<p class="title">{'Previous editions'|i18n('pmg')}</p>
			{foreach $events as $event}
				{node_view_gui content_node=$event view=footer}
			{/foreach}
		</div>
		<div class="copyright">
			<p>© Pitch My Game {currentdate()|datetime('custom', '%Y')}</p>
		</div>
	</div>
</div>
{undef $children $homeNode $events_container $events}
