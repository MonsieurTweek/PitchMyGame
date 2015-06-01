<div id="sidebar-feedback_google_map">
	<h2>{$block.name|wash}</h2>
	<ul class="ico_phone">
		<li><label>{"Tel :"|i18n('extension/ezfeedback')}</label> {$block.custom_attributes.phone|wash}</li>
		<li><label>{"Fax :"|i18n('extension/ezfeedback')}</label> {$block.custom_attributes.fax|wash}</li>
	</ul>
    {if $block.custom_attributes.address}
        <div id="sidebar-googlemap-addr">
            <address class="addr-sidebar">
                {$block.custom_attributes.address|wash|nl2br}
            </address>
            <div id="googlemap"></div>
        </div>
    {/if}
</div>
