{if $item_count|gt($item_limit)}
{default
    $page_uri_suffix = false()
    $left_max = 7
    $right_max = 6
    $item_previous = sub(first_set($offset, 0), $item_limit)
    $item_next = sum(first_set($offset, 0), $item_limit)
    $node_id = false()
    $param = false()
    $page_count = int(ceil(div($item_count,$item_limit)))
    $current_page = min($page_count, int(ceil(div(first_set($offset, 0), $item_limit))))
    $left_length = min($current_page, $left_max)
    $right_length = max(min(sub($page_count, $current_page, 1), $right_max), 0)
}
<ul class="navigator google">
    {if $item_previous|lt(0)|not}
    <li class="prev">
        <a href="{concat($page_uri,$item_previous|gt(0)|choose('',concat('/(offset)/',$item_previous)), $param)|ezurl(no)}"{if $node_id} rel="{$node_id}"{/if}><span>{$previous_label}</span></a>
    </li>
    {/if}
    {def $nb_pages = $page_count|sub(1)}
    {for 0 to $nb_pages as $page}
        <li{if $current_page|eq($page)} class="selected"{/if}>
            {if $current_page|eq($page)}
                {$current_page|sum(1)}
            {elseif $page|eq(0)}
                <a href="{concat($page_uri, $param)|ezurl(no)}"{if $node_id} rel="{$node_id}"{/if}>{$page|sum(1)}</a>
            {else}
                <a href="{concat($page_uri,'/(offset)/', $page|mul($item_limit), $param)|ezurl(no)}"{if $node_id} rel="{$node_id}"{/if}>{$page|sum(1)}</a>
            {/if}
        </li>
    {/for}
    {if $item_next|lt($item_count)}
    <li class="next">
        <a href="{concat($page_uri,'/(offset)/',$item_next, $param)|ezurl(no)}"{if $node_id} rel="{$node_id}"{/if}><span>{$next_label}</span></a>
    </li>
    {/if}
</ul>
{/default}
{/if}
