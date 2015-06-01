{def $relatedObjects = array()}
{foreach $node.data_map.keywords.content.tags as $loopTags}
	{foreach $loopTags.related_objects as $relatedObject}
		{if $relatedObject.main_node_id|eq($node.node_id)}
			{skip}
		{/if}
		{if $relatedObject.class_identifier|compare($node.class_identifier)}
			{set $relatedObjects = $relatedObjects|append(hash('published', $relatedObject.main_node.object.published, 'main_node', $relatedObject.main_node))}
		{/if}
	{/foreach}
{/foreach}
{*set $relatedObjects=$relatedObjects|rsort*}
{if $relatedObjects|count|gt(0)}
	<div id="block-related-content" class="sidebar-block related-topic-block block-{$node.parent.class_identifier}">
		<div class="title">
			<h2>{if not($block.name|eq(''))}{$block.name|wash}{else}{'Related content'|i18n('pmg')}{/if}</h2>
		</div>

		<div class="container outside">
			<div class="inside">
				{foreach $relatedObjects as $idx => $object max 3}
					<div class="related-object line-{$node.class_identifier}{if $idx|eq(0)} first{/if}{if $idx|eq($relatedObjects|count|sub(1))} last{/if}">
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