<div class="list-{$node.class_identifier}">
	<div class="hover_on">
		<h3 class="title depth">{$node.name}</h3>
		{if $node.data_map.studio.has_content}
			<p class="studio">{$node.data_map.studio.content.name|wash}</p>
		{/if}
	</div>
	<div class="hover_off">
		<a href="{$node.url_alias|ezurl(no)}">
			{if $node.data_map.image_list.has_content}
				{attribute_view_gui attribute=$node.data_map.image_list image_class=project_list}
			{else}
				<img src="{'class/project/420x150.jpg'|ezimage(no)}" />
			{/if}
		</a>
	</div>
</div>