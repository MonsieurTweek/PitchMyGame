{def $link = ''
	 $image = ''
	 $style = ''
}

{switch match = $block.custom_attributes.color}
	{case match = 'Fond gris foncé'}
		{set $style = "style_one"}
	{/case}
	{case match = 'Fond orange'}
		{set $style = "style_two"}
	{/case}
	{case match = 'Fond bleu ciel'}
		{set $style = "style_three"}
	{/case}
	{case match = 'Fond noir'}
		{set $style = "style_four"}
	{/case}
{/switch}


{if is_set($block.custom_attributes.link_internal)}
	{set $link = fetch('content', 'node', hash('node_id', $block.custom_attributes.link_internal))}
{/if}

{if is_set($block.custom_attributes.img)}
	{set $image = fetch('content', 'node', hash('node_id', $block.custom_attributes.img))}
{/if}

<div class="home_module {$style}">
	<a href="{$link.url_alias|ezurl(no)}">
		<div>
			{if is_set($image.data_map.image)}
				{attribute_view_gui attribute=$image.data_map.image}
			{/if}
			<h3>{$block.name|wash}</h3>
			<p>{$block.custom_attributes.text}</p>
			{if $block.custom_attributes.textButton}
				<span class="button">{$block.custom_attributes.textButton}</span>
			{/if}
		</div>
	</a>
</div>

{undef $link}