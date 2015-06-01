{def $edition = concat('Edition'|i18n('pmg'), ' #', $idx)}
<div class="list-{$node.class_identifier} {$custom_class}">
	<p>
		<span class="edition">{$edition}</span>
		<span class="location"> - {$node.data_map.location.content}, </span>
		<span class="city">{$node.data_map.city.content}</span>
		<span class="date">{concat($node.data_map.date.content.day, '/', $node.data_map.date.content.month, '/', $node.data_map.date.content.year)}</span>
	</p>
</div>
{undef $edition}