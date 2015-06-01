{default $projects = array()}
{foreach $projects as $project}
	{node_view_gui content_node=$project view='list'}
{/foreach}
{/default}