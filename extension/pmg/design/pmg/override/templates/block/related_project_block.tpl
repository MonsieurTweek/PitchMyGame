{def $relatedObjects = array()}
{foreach $current_node.data_map.genres.content.tags as $loopTags}
	{foreach $loopTags.related_objects as $relatedObject}
		{if $relatedObject.main_node_id|eq($current_node.node_id)}
			{skip}
		{/if}
		{if $relatedObject.class_identifier|compare($current_node.class_identifier)}
			{set $relatedObjects = $relatedObjects|append(hash('published', $relatedObject.main_node.object.published, 'main_node', $relatedObject.main_node))}
		{/if}
	{/foreach}
{/foreach}

{*foreach $current_node.data_map.platforms.content.tags as $loopTags}
	{foreach $loopTags.related_objects as $relatedObject}
		{if $relatedObject.main_node_id|eq($current_node.node_id)}
			{skip}
		{/if}
		{if $relatedObject.class_identifier|compare($current_node.class_identifier)}
			{set $relatedObjects = $relatedObjects|append(hash('published', $relatedObject.main_node.object.published, 'main_node', $relatedObject.main_node))}
		{/if}
	{/foreach}
{/foreach*}

{if $relatedObjects|count|gt(0)}
	<div id="block-related-projects" class="sidebar-block related-block related-projects-block block-{$current_node.parent.class_identifier}">
		<div class="title">
			<h2>{if not($block.name|eq(''))}{$block.name|wash}{else}{'Related projects'|i18n('pmg')}{/if}</h2>
		</div>

		<div class="container outside">
			<div class="inside">
				{foreach $relatedObjects as $idx => $object max 3}
					<div class="related-object line-{$current_node.class_identifier}{if $idx|eq(0)} first{/if}{if $idx|eq($relatedObjects|count|sub(1))} last{/if}">
						{def $main_node = $object.main_node}
						<a href="{$main_node.url_alias|ezurl('no')}">{$main_node.name}</a>
						{undef $main_node}
					</div>
				{/foreach}
			</div>
		</div>

		
	</div>
{/if}
{undef $relatedObjects}
