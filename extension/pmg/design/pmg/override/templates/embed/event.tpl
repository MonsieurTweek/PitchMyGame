<div id="embed-{$node.class_identifier}" class="expanded">
	<div class="date-block">
		<strong class="date text-shadow">{$node.data_map.date.content.timestamp|datetime('event')}</strong>
	</div>
	<div class="title-ribbon">
		<strong class="title text-shadow">{'Next'|i18n('pmg')}</strong>
		<strong class="title text-shadow">{'Event'|i18n('pmg')}</strong>
	</div>
	<div class="address-block text-shadow">
		<p class="location">{$node.data_map.location.content}</p>
		<p class="address">{$node.data_map.address.content}</p>
		<p class="city">
			{$node.data_map.city.content}
		</p>
		{if $node.data_map.metro.has_content}
			<ul class="metro-block">
				<li class="metro">M</li>
				{def $selected_id_array=$node.data_map.metro.content}
				{section var=Options loop=$node.data_map.metro.class_content.options}
					{section-exclude match=$selected_id_array|contains( $Options.item.id )|not}
					<li class="metro m{$Options.item.name|wash( xhtml )}">{$Options.item.name|wash( xhtml )}</li>
				{/section}
				{undef $selected_id_array}
			</ul>
		{/if}
	</div>
	<ul class="projects">
		{foreach $node.data_map.projects.content.relation_list as $project sequence array('odd','even') as $style}
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
	<div class="button-block">
		<!--<a href="#" class="button first"><p class="head">{'Present'|i18n('pmg')}</p><p class="line">{'your project'|i18n('pmg')}</p></a>-->
		<a href="#" class="button"><p class="head">{'Assist'|i18n('pmg')}</p><p class="line">{'to the event'|i18n('pmg')}</p></a>
	</div>
	<div class="expand-button-block">
		<a href="#" class="button expand"></a>
		<a href="#" class="button collapse"></a>
	</div>
</div>
