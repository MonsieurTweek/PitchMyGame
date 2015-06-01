{def $related_objects = array()}
{def $tags = fetch('tags', 'tags_by_keyword', hash('keyword', $current_node.name))}
{foreach $tags as $tag}
	{foreach $tag.related_objects as $related_object}
	    {if $related_object.class_identifier|eq('news')}
	    	{set $related_objects = $related_objects|append($related_object)}
	    {/if}
	{/foreach}
{/foreach}


{*set $related_objects=$related_objects|rsort*}
{if $related_objects|count|gt(0)}
	<div id="block-related-news" class="sidebar-block related-block related-news-block block-{$current_node.parent.class_identifier}">
		<div class="title">
			<h2>{if not($block.name|eq(''))}{$block.name|wash}{else}{'Related news'|i18n('pmg')}{/if}</h2>
		</div>

		<div class="container outside">
			<div class="inside">
				{foreach $related_objects as $idx => $object max 5}
					<div class="related-object line-{$current_node.class_identifier}{if $idx|eq(0)} first{/if}{if $idx|eq($related_objects|count|sub(1))} last{/if}">
						{def $main_node = $object.main_node}
                        {node_view_gui content_node=$main_node view="line"}
						{undef $main_node}
					</div>
				{/foreach}
			</div>
		</div>

		
	</div>
{/if}
{undef $related_objects $tags}
