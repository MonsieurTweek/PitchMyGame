{if $item_count|gt($item_limit)}
{default
    $page_uri_suffix = false()
    $item_previous = sub(first_set($offset, 0), $item_limit)
    $item_next = sum(first_set($offset, 0), $item_limit)
    $node_id = false()
	$param = ''
	$invert = false()
}
<ul class="navigator simple">
	{if $invert}
	    {if $item_next|lt($item_count)}
	    <li class="prev">
	        <a {if $idLabel}id="{$idLabel}-next" {/if}href="{concat($page_uri,'/(offset)/',$item_next, $param)|ezurl(no)}"{if $node_id} rel="{$node_id}"{/if}>{$next_label}</a>
	    </li>
	    {/if}
	    {if $item_previous|ge(0)}
	    <li class="next">
	        <a {if $idLabel}id="{$idLabel}-prev" {/if}href="{concat($page_uri,$item_previous|gt(0)|choose('',concat('/(offset)/',$item_previous)), $param)|ezurl(no)}"{if $node_id} rel="{$node_id}"{/if}>{$previous_label}</a>
	    </li>
	    {/if}
	{else}
	    {if $item_previous|ge(0)}
	    <li class="prev">
	        <a {if $idLabel}id="{$idLabel}-prev" {/if}href="{concat($page_uri,$item_previous|gt(0)|choose('',concat('/(offset)/',$item_previous)), $param)|ezurl(no)}"{if $node_id} rel="{$node_id}"{/if}>{$next_label}</a>
	    </li>
	    {/if}
	    {if $item_next|lt($item_count)}
	    <li class="next">
	        <a {if $idLabel}id="{$idLabel}-next" {/if}href="{concat($page_uri,'/(offset)/',$item_next, $param)|ezurl(no)}"{if $node_id} rel="{$node_id}"{/if}>{$previous_label}</a>
	    </li>
	    {/if}
	{/if}
</ul>
{/default}
{/if}