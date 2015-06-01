{default $events = array()}
{foreach $events as $k => $event}
	{def $class = array()}
	{if $k|mod(2)|eq(0)}
		{set $class = $class|append('even')}
	{else}
		{set $class = $class|append('odd')}
	{/if}
	{set $class = $class|implode(', ')}
	{node_view_gui content_node=$event view='list' idx=$events|count|sub($k) custom_class=$class}
	{undef $class}
{/foreach}
{/default}