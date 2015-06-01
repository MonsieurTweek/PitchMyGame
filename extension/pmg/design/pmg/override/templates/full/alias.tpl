{if $node.children_count|gt(0)}
    {wrap_user_func('redirectRelative', array($node.children[0].url_alias|ezurl(no)))}
{/if}