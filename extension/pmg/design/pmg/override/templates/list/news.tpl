<div id="list-{$node.class_identifier}" class="{$node.class_identifier}">
	<div class="title">
		<h2 title="{$node.name}"><a href="{$node.url_alias|ezurl(no)}">{if $node.name|count|lt(22)}{$node.name}{else}{$node.name|truncate(45)}{/if}</a></h2>
	</div>
	<div class="content">
		<div class="thumbnail">
			{attribute_view_gui attribute=$node.data_map.image image_class="news_list"}
		</div>
		<div class="description">
			{attribute_view_gui attribute=$node.data_map.description}
			<a href="{$node.url_alias|ezurl(no)}" class="read-more">Lire la suite...</a>
		</div>
		<div class="published">
			<time>{$node.object.published|datetime('custom', '%d/%m/%Y')}</time>
		</div>
	</div>
</div>