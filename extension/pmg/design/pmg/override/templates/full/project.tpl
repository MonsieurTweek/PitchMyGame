<div id="full-{$node.class_identifier}">
	<div id="main">
		<div class="full title">
			<h2>{$node.name|wash|truncate(30)}</h2>
		</div>
		<div id="body" class="outside block">
			<div id="project-content">
				<div id="image" class="left">
                    {if $node.data_map.url.has_content}
                        <a target="_blank" href="{$node.data_map.url.content}">{attribute_view_gui attribute=$node.data_map.image_full image_class='project_full'}</a>
                    {else}
                        {attribute_view_gui attribute=$node.data_map.image_full image_class='project_full'}
                    {/if}
				</div>
				<div id="informations" class="right">
					<div id="description" class="xml">
						{attribute_view_gui attribute=$node.data_map.description}				
					</div>
					<div id="tags">
						{if $node.data_map.studio.has_content}
							<ul id="studio" class="tag first">
								<li class="label">{'Studio'|i18n('pmg')}</li>
                                {if $node.data_map.studio.content.data_map.url.has_content}
    								<li class="value" title="{$node.data_map.studio.content.name}"> : <a target="_blank" href="{$node.data_map.studio.content.data_map.url.content}">{$node.data_map.studio.content.name}</a></li>
                                {else}
    								<li class="value" title="{$node.data_map.studio.content.name}"> : {$node.data_map.studio.content.name}</li>
                                {/if}
							</ul>
						{/if}
						{if $node.data_map.genres.has_content}
							<ul id="genres" class="tag">
								<li class="label">{'Genres'|i18n('pmg')}</li>
								{def $value = array()}
								{foreach $node.data_map.genres.content.tags as $tag}
									{set $value = $value|append($tag.keyword)}
								{/foreach}
								<li class="value"> : {$value|implode(', ')}</li>
								{undef $value}
							</ul>
						{/if}
						{if $node.data_map.platforms.has_content}
							<ul id="platforms" class="tag last">
								<li class="label">{'Platforms'|i18n('pmg')}</li>
								{def $value = array()}
								{foreach $node.data_map.platforms.content.tags as $tag}
									{set $value = $value|append($tag.keyword)}
								{/foreach}
								<li class="value"> : {$value|implode(', ')}</li>
								{undef $value}
							</ul>
						{/if}
					</div>
				</div>
			</div>

			<div id="project-links">

			</div>

			<hr />

			<div class="share">
				{if $node.data_map.twitter.has_content}
					<a href="{$node.data_map.twitter.content}" class="twitter btn-share" target="_blank"></a>
				{/if}
				{if $node.data_map.facebook.has_content}
					<a href="{$node.data_map.facebook.content}" class="facebook btn-share" target="_blank"></a>
				{/if}
				{if $node.data_map.mail.has_content}
					<a href="mailto:{$node.data_map.mail.content}" class="mail btn-share" target="_blank"></a>
				{/if}
			</div>
		</div>
	</div>
</div>

{* Pictures *}
{def $pictures = 	fetch( 'content', 'list', 
						hash(
				            'parent_node_id', $node.node_id,
				            'class_filter_type', 'include',
				            'class_filter_array', array('image'),
				            'sort_by', $node.sort_array,
				            'limit', 18,
				            'depth', 2
				        )
				    )
}

{if $pictures|count|gt(0)}
	<div id="pictures">
		<div class="full title">
			<h2>{'Pictures'|i18n('pmg')}</h2>
		</div>
		<div id="pictures" class="additional-block outside block">
			<ul class="pictures-list row">
				{foreach $pictures as $idx => $picture}
					{if and($idx|mod(6)|eq(0), $idx|gt(1))}
			</ul>
			<ul class="pictures-list row">
					{/if}
					<li class="picture">
						<a class="fancybox" rel="pictures" href="{$picture.data_map.image.value.original.full_path|ezurl(no, full)}">
							{attribute_view_gui attribute=$picture.data_map.image image_class='project_picture_list'}
						</a>
					</li>   
				{/foreach}
			</ul>
		</div>	
	</div>
{/if}

{undef $pictures}

{* Videos *}
{def $videos = 	fetch( 'content', 'list', 
						hash(
				            'parent_node_id', $node.node_id,
				            'class_filter_type', 'include',
				            'class_filter_array', array('video'),
				            'sort_by', $node.sort_array,
				            'limit', 3,
				            'depth', 2
				        )
				    )
}

{if $videos|count|gt(0)}
	<div id="videos">
		<div class="full title">
			<h2>{'Videos'|i18n('pmg')}</h2>
		</div>
		<div class="additional-block outside block">
			<ul class="videos-list row">
				{foreach $videos as $idx => $video}
				    {if and($idx|mod(4)|eq(3), $idx|gt(1))}
			</ul>
			<ul class="videos-list row">
					{/if}
					<li class="video">
						<a href="{$video.data_map.url.content}" target="_blank" title="{$video.name}">
							{attribute_view_gui attribute=$video.data_map.thumbnail image_class='video_thumbnail'}							
						</a>
					</li>
				{/foreach}
			</ul>
		</div>
	</div>
{/if}

{undef $videos}
