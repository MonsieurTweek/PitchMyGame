{def 
	$is_custom = false()
	$userGroup = fetch( 'content', 'list', hash( 'parent_node_id', ezini('NodeSettings', 'UserRootNode', 'content.ini') ) )
}
{if eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' )}
	{set $is_custom = true()}
{/if}
<div id="id_{$block.id}" class="block-container">
	<div class="block-header float-break">
		<div class="button-left">
			<em class="trigger expand"></em> {ezini( $block.type, 'Name', 'block.ini' )}
		</div>
		<div class="button-right">
			<input class="block-control" type="image" src="{'ezpage/block_up.gif'|ezimage(no)}" name="CustomActionButton[{$attribute.id}_move_block_up-{$zone_id}-{$block_id}]" alt="{'Move up'|i18n( 'design/standard/block/edit' )}" title="{'Move up'|i18n( 'design/standard/block/edit' )}" /> <input class="block-control" type="image" src="{'ezpage/block_down.gif'|ezimage(no)}" name="CustomActionButton[{$attribute.id}_move_block_down-{$zone_id}-{$block_id}]" alt="{'Move down'|i18n( 'design/standard/block/edit' )}" title="{'Move down'|i18n( 'design/standard/block/edit' )}" /> <input class="block-control" type="image" src="{'ezpage/block_del.gif'|ezimage(no)}" name="CustomActionButton[{$attribute.id}_remove_block-{$zone_id}-{$block_id}]" title="{'Remove'|i18n( 'design/standard/block/edit' )}" alt="{'Remove'|i18n( 'design/standard/block/edit' )}" value="{'Remove'|i18n( 'design/standard/block/edit' )}" onclick="return confirmDiscard( '{'Are you sure you want to remove this block?'|i18n( 'design/standard/block/edit' )}' );" />
		</div>
	</div>

	<div class="block-content collapsed">
		<div class="block-controls float-break">
			<div class="left blockname">
				<label>{'Block name:'|i18n( 'design/standard/datatype/ezpage' )}</label>
				<input class="textfield block-control" type="text" name="ContentObjectAttribute_ezpage_block_name_array_{$attribute.id}[{$zone_id}][{$block_id}]" value="{$block.name}" size="35" />
			</div>
		</div>

		<div class="block-parameters float-break">
			<div class="left">
				{if $is_custom}
					{def $custom_attributes = ezini( $block.type, 'CustomAttributes', 'block.ini' )
						 $custom_attribute_types = ezini( $block.type, 'CustomAttributeTypes', 'block.ini' )
						 $custom_attribute_name = ezini( $block.type, 'CustomAttributeName', 'block.ini') }
					{if $custom_attributes|count|gt(0)}
						<hr />
						{foreach $custom_attributes as $custom_attrib}
							{def $use_browse_mode = ezini( $block.type, 'UseBrowseMode', 'block.ini' )}
							{if eq( $use_browse_mode[$custom_attrib], 'true' )}
								<label>{$custom_attribute_name[$custom_attrib]} :</label>
								<input class="button block-control" name="CustomActionButton[{$attribute.id}_custom_attribute_browse-{$zone_id}-{$block_id}-{$custom_attrib}]" type="submit" value="{'Choose source'|i18n( 'design/standard/block/edit' )}" />
								{def $source_node = fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes[$custom_attrib] ) )}
								{$source_node.name|wash}
								{undef $source_node}
							{else}
								<label>{$custom_attribute_name[$custom_attrib]} :</label> 
								{if is_set( $custom_attribute_types[$custom_attrib] )}
									{switch match = $custom_attribute_types[$custom_attrib]}
										{case match = 'text'}
											<script>alert("TOTO");</script>
											<textarea class="textbox block-control" name="ContentObjectAttribute_ezpage_block_custom_attribute_{$attribute.id}[{$zone_id}][{$block_id}][{$custom_attrib}]" rows="7">{$block.custom_attributes[$custom_attrib]|wash()}</textarea>
										{/case}
										{case match = 'checkbox'}
											<input class="block-control" type="hidden" name="ContentObjectAttribute_ezpage_block_custom_attribute_{$attribute.id}[{$zone_id}][{$block_id}][{$custom_attrib}]" value="0" />
											<input class="block-control" type="checkbox" name="ContentObjectAttribute_ezpage_block_custom_attribute_{$attribute.id}[{$zone_id}][{$block_id}][{$custom_attrib}]"{if eq( $block.custom_attributes[$custom_attrib], '1')} checked="checked"{/if} value="1" />
										{/case}
										{case match = 'select'}
											{def $custom_attribute_values = ezini( $block.type, 'CustomAttributeValues', 'block.ini')}
											
											{if is_set($custom_attribute_values[$custom_attrib])}
												<select name="ContentObjectAttribute_ezpage_block_custom_attribute_{$attribute.id}[{$zone_id}][{$block_id}][{$custom_attrib}]">
													{foreach $custom_attribute_values[$custom_attrib]|explode(';') as $option}
														<option value="{$option}" {if eq( $block.custom_attributes[$custom_attrib], $option)} selected="selected"{/if}>{$option}</option>
													{/foreach}
												</select>
											{/if}
											
											{undef $custom_attribute_values}
										{/case}
										{case match = 'string'}
											<input class="textfield block-control" type="text" name="ContentObjectAttribute_ezpage_block_custom_attribute_{$attribute.id}[{$zone_id}][{$block_id}][{$custom_attrib}]" value="{$block.custom_attributes[$custom_attrib]}" />
										{/case}
										{case}
											<input class="textfield block-control" type="text" name="ContentObjectAttribute_ezpage_block_custom_attribute_{$attribute.id}[{$zone_id}][{$block_id}][{$custom_attrib}]" value="{$block.custom_attributes[$custom_attrib]}" />
										{/case}
									{/switch}
								{else}
									<input class="textfield block-control" type="text" name="ContentObjectAttribute_ezpage_block_custom_attribute_{$attribute.id}[{$zone_id}][{$block_id}][{$custom_attrib}]" value="{$block.custom_attributes[$custom_attrib]}" />
								{/if}
							{/if}
							<br /><br />
							{undef $use_browse_mode}
						{/foreach}
					{/if}
				{else}
					<input class="button block-control" name="CustomActionButton[{$attribute.id}_new_item_browse-{$zone_id}-{$block_id}]" type="submit" value="{'Add item'|i18n( 'design/standard/block/edit' )}" />
				{/if}
				
				{if $userGroup|count|gt(0)}
					<hr />
					<div class="visibility">
						<label>{'Visibility:'|i18n( 'design/standard/datatype/ezpage' )}</label>
						{foreach $userGroup as $group}
							<div>
								<input id="ContentObjectAttribute_ezpage_visibility_{$attribute.id}[{$zone_id}][{$block_id}]{$group.contentobject_id}" type="checkbox" name="ContentObjectAttribute_ezpage_visibility_{$attribute.id}[{$zone_id}][{$block_id}][]" value="{$group.contentobject_id}" {if and($block.visibility, $block.visibility|contains($group.contentobject_id)|not)}{else}checked="checked"{/if} />
								<label for="ContentObjectAttribute_ezpage_visibility_{$attribute.id}[{$zone_id}][{$block_id}]{$group.contentobject_id}">{$group.name|wash}</label>
							</div>
						{/foreach}
					</div>
				{/if}
			</div>
		</div>
	</div>
</div>

{undef $userGroup $is_custom $custom_attributes $custom_attribute_types $custom_attribute_name}