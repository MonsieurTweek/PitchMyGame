{def 
	$fullList = fetch(content, list, hash('parent_node_id', $node.parent_node_id,
				'class_filter_type', 'include',
				'class_filter_array', array($node.class_identifier),
				'sort_by', array('attribute', true(), concat($node.class_identifier, '/date'))
		)
	)
	$prev = ''
	$next = ''
}

{foreach $fullList as $i => $l}
	{if $l.node_id|eq($node.node_id)}
		{if is_set($fullList[$i|dec()])}
			{set $prev = $fullList[$i|dec()]}
		{/if}
		{if is_set($fullList[$i|inc()])}
			{set $next = $fullList[$i|inc()]}
		{/if}
		{break}
	{/if}
{/foreach}
{if or($prev, $next)}
	<ul class="navigator simple">
	{if $prev}
		<li class="prev"><a href={$prev.url_alias|ezurl}>{$previous_label}</a></li>
	{/if}
	{if $next}
		<li class="next"><a href={$next.url_alias|ezurl}>{$next_label}</a></li>
	{/if}
	</ul>
{/if}

{undef $fullList $prev $next}