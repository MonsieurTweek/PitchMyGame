<div id="full-{$node.class_identifier}">
	<div id="main">
		<div class="full title">
			<h2>{$node.name|wash}</h2>
		</div>
		<div id="body" class="outside block">
			<div class="inside xml">
				{attribute_view_gui attribute=$node.data_map.content}
			</div>
		</div>
	</div>
</div>