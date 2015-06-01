{def 
        $l = ''
        $target = ''
}

{if $node.data_map.internal_link.has_content}
    {set $l = $node.data_map.internal_link.content.main_node.url_alias|ezurl(no,full)}
{elseif $node.data_map.external_link.has_content}
    {set $l = $node.data_map.external_link.content}
    {set $target = '_blank'}
{/if}

{if not($l|eq(''))}
    <a href="{$l}" {if not($target|eq(''))}target="{$target}"{/if}>
{/if}
{attribute_view_gui attribute=$node.data_map.image image_class=slideshow}
{if not($l|eq(''))}
    </a>
{/if}

{undef $l}
