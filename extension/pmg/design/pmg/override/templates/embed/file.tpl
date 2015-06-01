{def $attribute = $object.data_map.file}
{if $attribute.content}
	<a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl}>{$object.data_map.name.content|wash(xhtml)}</a>
{/if}
{undef $attribute}
