<div id="embed-{$node.class_identifier}">

	<a href="{$node.url_alias|ezurl(no)}"><img src="{'class/homepage/star.png'|ezimage(no)}" class="border"/></a>

	<div class="thumbnail">

		{attribute_view_gui attribute=$node.data_map.image_star image_class="star_project"}

	</div>

	<div class="title">

		<a href="{$node.url_alias|ezurl(no)}"><strong>{$node.name|wash}</strong></a>

	</div>

</div>