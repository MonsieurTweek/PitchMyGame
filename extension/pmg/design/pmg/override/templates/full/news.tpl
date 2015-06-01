<div id="full-{$node.class_identifier}" class="{$node.class_identifier}">

	<div class="news-article">
		<div class="title">
			<h2>{$node.name|wash}</h2>
		</div>
		<div class="outside block">
			<div class="inside xml">
				<div class="thumbnail">
					{attribute_view_gui attribute=$node.data_map.image image_class="news_full"}
				</div>				
				{attribute_view_gui attribute=$node.data_map.content}
			</div>
			<div class="author">
				<p class="text-shadow">{'By'|i18n('pmg')} <span class="name">{$node.object.author_array.0.contentobject.data_map.first_name.content}</span>, {'the'|i18n('pmg')} {$node.object.published|datetime('custom', '%l %d/%m/%Y')}</p>
			</div>
			<div class="share">
				<a class="twitter custom-tweet-button" href="https://twitter.com/share" data-url="{$node.url_alias|ezurl(no,full)}" data-text="{$node.name}" data-related="PitchMyGame:L'évènement parisien du jeu indé" data-via="PitchMyGame" ></a>
				<a class="facebook custom-facebook-button" href="https://www.facebook.com/sharer/sharer.php" data-url="{$node.url_alias|ezurl(no,full)}"></a>				
			</div>
		</div>
	</div>

	{if $node.data_map.show_comments.content}
		<div class="comments">
			<div class="title">
				<h2>{'Comments'|i18n('pmg')}</h2>
			</div>
			<div class="form-container">
				{if $node.data_map.edit_comments.content}
					<div class="form">
						<form>
							<textarea rows=5></textarea>
							<input type="submit" value="{'Post a comment'|i18n('pmg')}" />
							<a href="#" class="link-submit">{'Post a comment'|i18n('pmg')}</a>
						</form>
					</div>
				{/if}
				<div class="comments-list">

				</div>
			</div>
		</div>
	{/if}
</div>
