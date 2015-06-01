{def 	$allowedClasses = ezini('NavSettings', 'AllowedClasses', 'settings.ini')
        $homeNode = fetch('content', 'node', hash('node_id', $home))
		$children = 	fetch( 'content', 'list',
        					hash( 
	        					'parent_node_id', $home,
	        					'class_filter_type', include,
	        					'class_filter_array', $allowedClasses,
                                'sort_by', $homeNode.sort_array,
	        					'depth', 1
	              			)
	              		)
}


<div id="nav">
	{if $children|count|gt(0)}
		<ul>
			<li class="level1 first{if $current_node.node_id|eq($home)} active-trail{/if}">
				<a href="{$homeNode.url_alias|ezurl(no)}">{'Home'|i18n('pmg')}</a>
			</li>
			{foreach $children as $idx=>$child}
				<li class="level1{if $children|count|eq($idx|sum(1))} last{/if}{if $current_node.node_id|eq($child.node_id)} active-trail{elseif $current_node.parent.node_id|eq($child.node_id)} active-trail{elseif $current_node.parent.parent.node_id|eq($child.node_id)} active-trail{/if}">
					<a href="{$child.url_alias|ezurl(no)}">{$child.name}</a>
				</li>
			{/foreach}
		</ul>
	{/if}
</div>

{undef $allowedClasses $homeNode $children}
