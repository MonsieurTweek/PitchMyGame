{if is_set($link_parameters.href)}
    {if is_set($object_parameters.size)}
        {attribute_view_gui attribute=$object.data_map.image image_class=$object_parameters.size href=$link_parameters.href|ezurl(no) target=$link_parameters.target link_class=$link_parameters.classification}
    {else}
        {attribute_view_gui attribute=$object.data_map.image image_class=ezini( 'ImageSettings', 'DefaultEmbedAlias', 'content.ini' ) href=$link_parameters.href|ezurl(no) target=$link_parameters.target link_class=$link_parameters.classification}
    {/if}
{else}
    {if is_set($object_parameters.size)}
        {attribute_view_gui attribute=$object.data_map.image image_class=$object_parameters.size}
    {else}
        {attribute_view_gui attribute=$object.data_map.image image_class=ezini( 'ImageSettings', 'DefaultEmbedAlias', 'content.ini' )}
    {/if}
{/if}