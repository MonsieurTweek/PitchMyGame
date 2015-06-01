{def $events =	fetch( 'content', 'list', 
					hash(
			            'parent_node_id', $node.node_id,
			            'class_filter_type', 'include',
			            'class_filter_array', array('event'),
			            'sort_by', $node.sort_array
			        )
			    )
	$limit = 8
	$offset = 0
}

<div id="full-{$node.class_identifier}">
	<div id="result-block" class="block">

		<input type="hidden" value="{$limit}" id="data-current-limit" />
		<input type="hidden" value="{$offset}" id="data-current-offset" />
		<input type="hidden" value="{$events|count}" id="data-current-max" />

		<div class="full title">
			<h2>{'Previous editions'|i18n('pmg/events')}</h2>
		</div>
		<div class="outside">
			<div class="inside">
				<div class="content"></div>
			</div>
			{if $events|count|gt($limit)}
				<div class="pager">
					<a href="#" class="arrow prev"></a>
					<span class="page">1</span><span class="separator">/</span><span class="nb_page">1</span>
					<a href="#" class="arrow next"></a>
				</div>
			{/if}
		</div>
	</div>
</div>

{undef $events}
