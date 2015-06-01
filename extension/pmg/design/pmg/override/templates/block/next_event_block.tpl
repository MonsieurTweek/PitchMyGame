{default $class = "collapsed"}
{def 	$home = ezini('NodeSettings', 'RootNode', 'content.ini')
		$events_container = 	fetch( 'content', 'list',
		        					hash( 
			        					'parent_node_id', $home,
			        					'class_filter_type', include,
			        					'class_filter_array', array('events_container'),
			              				'limit', 1 
			              			)
			              		)
}
{if is_set($events_container.0)}
    {set $events_container = $events_container.0}
{/if}
{def 	$next_event_node = 	fetch( 'content', 'list',
	        					hash( 
		        					'parent_node_id', $events_container.node_id,
		        					'class_filter_type', include,
		        					'class_filter_array', array('event'),
		        					'sort_by', array('attribute', false(), 'event/date'),
		              				'limit', 1 
		              			)
		              		)
}
{if is_set($next_event_node.0)}
    {set $next_event_node = $next_event_node.0}
{/if}

{if currentdate()|le($next_event_node.data_map.date.content.timestamp|sum(3600))}
{*if false()*}

    <div id="block-{$next_event_node.class_identifier}" class="sidebar-block {$class}">
        <div class="date-block">
            <strong class="date text-shadow">{$next_event_node.data_map.date.content.timestamp|datetime('event')}</strong>
        </div>
        <div class="title-ribbon">
            <strong class="title text-shadow">{'Next'|i18n('pmg')}</strong>
            <strong class="title text-shadow">{'Event'|i18n('pmg')}</strong>
        </div>
        <div class="container outside">
            <div class="inside">
                <div class="address-block text-shadow">
                    <p class="location">{$next_event_node.data_map.location.content}</p>
                    <p class="address">{$next_event_node.data_map.address.content}</p>
                    <p class="city">
                        {$next_event_node.data_map.city.content}
                    </p>
                    {*if $next_event_node.data_map.metro.has_content}
                        <div style="display:none">
                        {$node.data_map.metro.content|attribute(show)}
                        </div>
                        <ul class="metro-block">
                            <li class="metro">M</li>
                            {def $selected_id_array=$next_event_node.data_map.metro.content}
                            {section var=Options loop=$next_event_node.data_map.metro.class_content.options}
                                {section-exclude match=$selected_id_array|contains( $Options.item.id )|not}
                                <li class="metro m{$Options.item.name|wash( xhtml )}">{$Options.item.name|wash( xhtml )}</li>
                            {/section}
                            {undef $selected_id_array}
                        </ul>
                    {/if*}
                </div>
                <ul class="projects">
                    {foreach $next_event_node.data_map.projects.content.relation_list as $project sequence array('odd','even') as $style}
                        {def $current_project = fetch( 'content', 'node', hash( 'node_id', $project.node_id))}
                        <a href="{$current_project.url_alias|ezroot(no)}">
                            <li class="project {$style}">
                                <span class="name">{$current_project.name|shorten(18)}</span>
                                <span class="next"><img src="{'class/event/arrow.png'|ezimage('no')}" /></span>
                            </li>
                        </a>
                        {undef $current_project}
                    {/foreach}
                </ul>
            </div>
        </div>
        <div class="button-block">
            <!--<a href="#" class="button first"><p class="head">{'Present'|i18n('pmg')}</p><p class="line">{'your project'|i18n('pmg')}</p></a>-->
            <a target="_blank" href="{$next_event_node.data_map.registration.content}" class="button"><p class="head">{'Assist'|i18n('pmg')}</p><p class="line">{'to the event'|i18n('pmg')}</p></a>
        </div>
        <div class="expand-button-block">
            <a href="#" class="button expand"></a>
            <a href="#" class="button collapse"></a>
        </div>
    </div>

{/if}
