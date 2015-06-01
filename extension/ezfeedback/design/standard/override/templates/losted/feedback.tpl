{def
    $currentUser = fetch('user', 'current_user')
    $objectContacts = fetch(content, list, hash(
        parent_node_id, $node.node_id,
        class_filter_type, include,
        class_filter_array, array('object_contact'),
        sort_by, array(array('name', true())),
        attribute_filter, array(
            array('object_contact/islost', '=', true())
        ),
        limit, 1
    ))
    $name = ''
    $user = false()
}
{if is_set($view_parameters.id)}
    {set $user = fetch('content', 'object', hash('object_id', $view_parameters.id))}
{/if}

{set $name = concat('<span class="disparu">', $user.current.data_map.first_name.content, ' ', $user.current.data_map.last_name.content, '</span>')}
{set $persistent_variable = hash('site', hash(
    'page_title', $node.name|wash
))}

<div id="popin-losted">
    <h1 class="ico ico_{$node.class_identifier}">{'Des infos sur un disparu ?'}</h1>
    <div class="content">
        <p>{'Vous avez des infos sur %user ? Merci de nous les communiquer.'|i18n('extension/ezfeedback', '', hash('%user',$name))}<p>
        {if is_set($view_parameters.valid)}<p class="valid">{'Votre message a bien été envoyé.'|i18n('extension/ezfeedback')}</p> 
        {elseif is_set($view_parameters.err)}<p class="error">{$view_parameters.err|wash}</p>{/if}
    </div>
    {if is_set($view_parameters.valid)|not}
        <form class="formJS contact_form ezcontent" action={"feedback/action"|ezurl} method="post" enctype="multipart/form-data">
            <fieldset>
                <div class="style_form">
                <h3>{'Merci de votre aide'|i18n('extension/ezfeedback')}</h3>
                    {def    
                        $def = true()
                        $value = ''
                        $disabled = false()
                        $more = ''
                    }
                    {foreach $node.data_map as $field}
                        {if $field.is_information_collector}
                            {set   
                                $def = true()
                                $value = ''
                                $disabled = false()
                                $more = ''
                            }

                            {if $field.contentclass_attribute_identifier|eq('your_name')}
                                {set $value = ''}
                                {set $disabled = $currentUser.is_logged_in}
                            {elseif $field.contentclass_attribute_identifier|eq('mail')}
                                {set $value = ''}
                                {set $disabled = $currentUser.is_logged_in}
                            {elseif $field.contentclass_attribute_identifier|eq('to')}
                                {set $def = false()}
                            {elseif $field.contentclass_attribute_identifier|eq('object')}
                                <input name="object" type="hidden" value="{$objectContacts.0.node_id}"/>
                                {continue}
                            {elseif $field.data_type_string|eq('ezselection')}
                                {set $def = false()}
                                <div class="block">
                                    <label for="{$field.contentclass_attribute_identifier}">{$field.contentclass_attribute_name}{if $field.is_required}<span class="required">*</span>{/if}</label>
                                    <select id="{$field.contentclass_attribute_identifier}" class="forms fform{if $field.is_required} validate['required']{/if}" name="{$field.contentclass_attribute_identifier}" >
                                        {foreach $field.class_content.options as $opt}
                                            <option value="{$opt.id}">{$opt.name|wash}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            {/if}
                            {if $disabled}
                                {continue}
                            {/if}
                            {if $def}
                                <div class="block">
        {*
                                    <label for="{$field.contentclass_attribute_identifier}">
                                        {concat($field.object.class_identifier,'/',$field.contentclass_attribute_identifier)|i18n('extension/ezcontent')}
                                        {if $field.is_required}
                                            <span class="required">*</span>
                                        {/if}
                                    </label>
        *}
                                    {if $field.data_type_string|eq('eztext')}
                                        <textarea
                                            rows="10" cols="60"
                                            id="{$field.contentclass_attribute_identifier}"
                                            name="{$field.contentclass_attribute_identifier}"
                                            class="{if $field.is_required} validate['required']{/if}"
                                            placeholder="{concat($field.object.class_identifier,'/',$field.contentclass_attribute_identifier, '/lost')|i18n('extension/ezcontent/title')}"
                                            {if $disabled} disabled="disabled"{/if}
                                        >{$value}</textarea>
                                    {else}
                                        <input
                                            type="text"
                                            value="{$value}"
                                            id="{$field.contentclass_attribute_identifier}"
                                            name="{$field.contentclass_attribute_identifier}"
                                            class="{if $field.is_required} validate['required']{/if}{if $field.contentclass_attribute_identifier|eq('mail')} validate['email']{/if}"
                                            placeholder="{concat($field.object.class_identifier,'/',$field.contentclass_attribute_identifier)|i18n('extension/ezcontent/title')}"
                                            {if $disabled}disabled="disabled"{/if}
                                        />
                                    {/if}
                                </div>
                            {/if}

                        {/if}
                    {/foreach}
                    {undef $value $disabled $def $more}
                    {*
                    <div class="block">
                            (<span class="required">*</span>) {'champs obligatoires'|i18n('extension/ezfeedback')}
                    </div>
                    *}
                </div>
                <input class="button" type="submit" name="send" id="send" value="{'Envoyer'|i18n('extension/ezfeedback')}" />
                <input type="hidden" name="userID" value="{$view_parameters.id}" />
                <input type="hidden" name="RedirectURI" value={concat('/layout/set/naked/content/view/losted/', $node.node_id, '/(id)/', $view_parameters.id|int)|ezurl()} />
            </fieldset>
        </form>
    {/if}
</div>
