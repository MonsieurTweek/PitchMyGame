<div class="footer-{$node.class_identifier}">
	<p class="subtitle">{$node.data_map.footer_title.content|wash} - {$node.data_map.date.content.timestamp|datetime('footer')}</p>
	<ul class="projects">
		{foreach $node.data_map.projects.content.relation_list as $project}
			{def $current_project = fetch('content','node', hash('node_id', $project.node_id))}
			<li><a href="{$current_project.url_alias|ezurl(no)}">{$current_project.name|wash}</a></li>
			{undef $current_project}
		{/foreach}
	</ul>
</div>