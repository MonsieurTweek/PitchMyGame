{def
        $events = array()
        $projects = array()
		$home = ezini('NodeSettings', 'RootNode', 'content.ini')
		$events_container = 	fetch( 'content', 'list',
			    					hash(
			        					'parent_node_id', $home,
			        					'class_filter_type', include,
			        					'class_filter_array', array('events_container'),
			              				'limit', 1
			              			)
			              		)
		$projects_container = 	fetch( 'content', 'list',
			    					hash(
			        					'parent_node_id', $home,
			        					'class_filter_type', include,
			        					'class_filter_array', array('projects_container'),
			              				'limit', 1
			              			)
			              		)
		$limit = 6
		$offset = 0
}
{if is_set($events_container.0)}
	{set $events_container = $events_container.0}
{/if}
{if is_set($projects_container.0)}
	{set $projects_container = $projects_container.0}
{/if}
{set $events = fetch('content','list',
					hash('parent_node_id', $events_container.node_id,
						 'class_filter_type', 'include',
						 'class_filter_array', array('event'),
						 'sort_by', array('attribute', false(), 'event/date')
					)
				)
}
{set $projects = fetch('content','list',
					hash('parent_node_id', $projects_container.node_id,
						 'class_filter_type', 'include',
						 'class_filter_array', array('project'),
						 'sort_by', $projects_container.sort_array
					)
				)
}

{def
		$query = ''
		$name = ''
		$edition = ''
		$category = ''
}
{if is_set($view_parameters.q)}
	{set $query = $view_parameters.q|explode('|')}
	{if is_set($query.0)}{set $name = $query.0}{/if}
	{if is_set($query.1)}{set $edition = $query.1}{/if}
	{if is_set($query.2)}{set $category = $query.2}{/if}
{/if}

<div id="full-{$node.class_identifier}">

	<div id="search-block" class="block">
		<div class="full title">
			<h2>{'Research'|i18n('pmg')}</h2>
		</div>
		<div class="outside">
			<h3>{'Filter projects by'|i18n('pmg')} : </h3>
			<div class="inside">
				<div class="content">
					<form action="" method="post">
						<div class="input-block first">
							<label for="name">{'Name'|i18n('pmg')}</label>
							<input type="text" id="name" name="name" value="{$name}" />
						</div>
						<div class="input-block">
							<label for="edition">{'Edition'|i18n('pmg')}</label>
							<select name="edition" id="edition">
								<option value='*'>{'All'|i18n('pmg')}</option>
								{foreach $events as $event}
									<option value="{$event.contentobject_id}"{if $event.contentobject_id|eq($edition)} selected=selected{/if}>{$event.name|wash}</option>
								{/foreach}
							</select>
						</div>
						<div class="input-block last">
							<label for="category">{'Category'|i18n('pmg')}</label>
							<select name="category" id="category">
								<option value='*'>{'All'|i18n('pmg')}</option>
								{def $tags = fetch('tags', 'tree', hash('parent_tag_id', '4'))}
								{foreach $tags as $tag}
									<option value="{$tag.id}">{$tag.keyword}</option>
								{/foreach}
								{undef $tags}
							</select>
						</div>
						<div class="button-block">
							<input type="button" id="cancel" name="CancelButton" class="btn black first" value="{'Cancel'|i18n('pmg')}" />
							<input type="submit" id="submit" name="SubmitButton" class="btn orange last" value="{'Research'|i18n('pmg')}" />
							<input type="hidden" name="RedirectURI" value="{$node.url_alias|ezurl(no)}" />
							<input type="hidden" name="Query" id="query" value="{if $query|count}{$query|implode('|')}{else}{$query}{/if}" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div id="result-block" class="block">
		<input type="hidden" value="{$limit}" id="data-current-limit" />
		<input type="hidden" value="{$offset}" id="data-current-offset" />
		<input type="hidden" value="{$projects|count}" id="data-current-max" />
		<div class="full title">
			<h2>{'All projects'|i18n('pmg')}</h2>
		</div>
		<div class="outside">
			<div class="inside">
				<div class="content"></div>
			</div>
			{if $projects|count|gt($limit)}
				<div class="pager">
					<a href="#" class="arrow prev"></a>
					<span class="page">1</span><span class="separator">/</span><span class="nb_page">1</span>
					<a href="#" class="arrow next"></a>
				</div>
			{/if}
		</div>
	</div>
</div>
{undef $events $projects $home $events_container $projects_container $limit $query $name $edition $category}