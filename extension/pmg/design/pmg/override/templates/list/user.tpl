{if not(is_set($class_array))} {def $class_array = array()} {/if}
<div class="list-{$node.class_identifier} {$class_array|implode(' ')}">
    {if $class_array|contains('even')}
        <div class="left user-picture">
            {attribute_view_gui attribute=$node.data_map.picture image_class=user_list}
        </div>
        <div class="right user-infos">
            <h3>
                <p>{$node.data_map.first_name.content} {$node.data_map.last_name.content}</p>
                <small class="sub-infos">{$node.data_map.pmg_job.content} - <a target="_blank" href="https://twitter.com/{$node.data_map.twitter.content}">@{$node.data_map.twitter.content}</a></small>
            </h3>
            <p>{attribute_view_gui attribute=$node.data_map.about}</p>
        </div>
    {else}
        <div class="left user-infos">
            <h3>
                <p>{$node.data_map.first_name.content} {$node.data_map.last_name.content}</p>
                <small class="sub-infos">{$node.data_map.pmg_job.content} - <a target="_blank" href="https://twitter.com/{$node.data_map.twitter.content}">@{$node.data_map.twitter.content}</a></small>
            </h3>
            <p>{attribute_view_gui attribute=$node.data_map.about}</p>
        </div>
        <div class="right user-picture">
            {attribute_view_gui attribute=$node.data_map.picture image_class=user_list}
        </div>
    {/if}
</div>
{if is_set($class_array)} {undef $class_array} {/if}
