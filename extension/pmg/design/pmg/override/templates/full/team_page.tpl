{def $user_class = fetch('content', 'class', hash( 'class_id', 'user' ))}

<div id="full-{$node.class_identifier}">

    {foreach $user_class.data_map.location.content.options as $location}

        {* Skip N/A *}
        {if $location.id|eq(0)}{skip}{/if}

        {* Get users of current location *}
        {def $users = fetch('content', 'list',
                hash(
                    'parent_node_id', 5,
                    'class_filter_type', include,
                    'class_filter_array', array('user'),
                    'sort_by', array('name', true()),
                    'attribute_filter', array( 'and', array('user/team_member', '=', '1'), array('user/location', '=', $location.id) ),
                    'depth', 3,
                    'limitation', array()
                )
            )
        }

        {* We have users in this location *}
        {if $users|count|gt(0)}
            <div id="main">
                <div class="full title">
                    <h2>{$location.name}</h2>
                </div>
                <div id="team-paris" class="outside block">
                    <div class="inside xml">
                        {foreach $users as $k => $user}
                            {def $class_array = array()}
                            {if $k|mod(2)|eq(0)}{set $class_array = $class_array|append('even')}{else}{set $class_array = $class_array|append('odd')}{/if}
                            {if $k|eq(0)}{set $class_array = $class_array|append('first')}{/if}
                            {if count($users)|sub(1)|eq($k)}{set $class_array = $class_array|append('last')}{/if}
                            {node_view_gui content_node=$user view="list" class_array=$class_array}
                            {undef $class_array}
                        {/foreach}
                    </div>
                </div>
            </div>
        {/if}

        {undef $users}

    {/foreach}

</div>

{undef $user_class}
