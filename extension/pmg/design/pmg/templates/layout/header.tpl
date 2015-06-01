{def $homeNode = fetch( 'content', 'node', hash( 'node_id', $home))}
<div id="header-wrap">
	<div id="header">
		<h1 class="sitename">
			<a href="{'/'|ezurl('no', 'full')}">{ezini("SiteSettings", "SiteName", "site.ini")}</a>
			<div class="share">
				<a href="https://twitter.com/PitchMyGame" target="_blank" class="twitter"></a>
				<a href="https://www.facebook.com/PitchMyGame" target="_blank" class="facebook"></a>
				<a href="http://www.flickr.com/search/?q=pitchmygame" target="_blank" class="flickr"></a>
			</div>
		</h1>
		<p class="baseline">{$homeNode.data_map.baseline.content}</p>
		{include uri="design:menu/nav.tpl"}
	</div>
</div>