{def	$currentUser = fetch('user', 'current_user')
        $objectContacts = fetch(content, list, hash(
            parent_node_id, $node.node_id,
            class_filter_type, include,
            class_filter_array, array('object_contact'),
            sort_by, array(array('name', true()))
        ))
}
{set $persistent_variable = hash('site', hash(
    'page_title', $node.name|wash
))}

<div id="full-{$node.class_identifier}">
    <div id="main">
        <div class="full title">
            <h2 class="">{$node.name|wash}</h2>
        </div>
        <div id="body" class="outside block">
            {if $node.data_map.intro.has_content}
                <div class="intro">
                    {attribute_view_gui attribute=$node.data_map.intro}
                </div>
            {/if}
            {if is_set($view_parameters.valid)}<p class="valid">{'Votre message a bien été envoyé.'|i18n('extension/ezfeedback')}</p> 
            {elseif and(is_set($view_parameters.err), $view_parameters.err)}<p class="error">{$view_parameters.err|wash}</p>{/if}
            <form class="formJS contact_form" action={"feedback/action"|ezurl} method="post" enctype="multipart/form-data">
                <fieldset class="left">
                    {foreach $node.data_map as $field}
                        {if $field.is_information_collector}

                            {def    
                                $def = true()
                                $value = ''
                                $more = ''
                            }

                            {if $field.contentclass_attribute_identifier|eq('your_name')}
                                {if $currentUser.is_logged_in}
                                    {set $value = concat($currentUser.contentobject.data_map.first_name.content, ' ',  $currentUser.contentobject.data_map.last_name.content)}
                                {/if}
                            {elseif $field.contentclass_attribute_identifier|eq('mail')}
                                {if $currentUser.is_logged_in}
                                    {set $value = $currentUser.email}
                                {/if}
                            {elseif $field.contentclass_attribute_identifier|eq('to')}
                                {set $def = false()}
                            {elseif $field.contentclass_attribute_identifier|eq('object')}
                                {set $def = false()}
                                {if and($objectContacts|count|le(2), $node.data_map.show_other_object_contact.content|not)}
                                    <input name="object" type="hidden" value="{$objectContacts.0.node_id}"/>
                                {else}
                                    <div class="input-block">
                                        <label class="selectBoxLabel" for="objSelect">{$field.contentclass_attribute_name}{if $field.is_required} <span class="required">*</span>{/if}</label>
                                        <select class="forms fform{if $field.is_required} validate['required']{/if} selectBox" name="object" id="objSelect">
                                        {def $vp = false()}
                                        {if and(is_set($view_parameters.obj), $view_parameters.obj|eq('')|not)}
                                            {set $vp = $view_parameters.obj}
                                        {else}
                                            {foreach $objectContacts as $objectContact}
                                                {if $objectContact.data_map.default.content}
                                                    {set $vp = $objectContact.name}
                                                    {break}
                                                {/if}
                                            {/foreach}
                                            {if $vp|not}
                                                <option selected="selected" value="">{'Veuillez choisir un objet'|i18n('extension/ezfeedback')}</option>
                                            {/if}
                                        {/if}
                                        {foreach $objectContacts as $objectContact}
                                            <option {if and($vp, $vp|eq($objectContact.name))}selected="selected" {/if}value="{$objectContact.contentobject_id}">{$objectContact.name}</option>
                                        {/foreach}
                                        {undef $vp}
                                        {if ezini_hasvariable('ezfeedback', 'ActiveOther', 'settings.ini')}
                                            {if ezini('ezfeedback', 'ActiveOther', 'settings.ini')|eq('true')}
                                                {if $node.data_map.show_other_object_contact.content}
                                                    <option value="default">{'Autre'|i18n('extension/ezfeedback')}</option>
                                                {/if}
                                            {/if}
                                        {/if}
                                        </select>
                                    </div>
                                {/if}
                            {elseif $field.data_type_string|eq('ezselection')}
                                {set $def = false()}
                                <div class="input-block">
                                    <label for="{$field.contentclass_attribute_identifier}">{$field.contentclass_attribute_name}{if $field.is_required}<span class="required">*</span>{/if}</label>
                                    <select id="{$field.contentclass_attribute_identifier}" class="forms fform{if $field.is_required} validate['required']{/if}" name="{$field.contentclass_attribute_identifier}" >
                                        {foreach $field.class_content.options as $opt}
                                            <option value="{$opt.id}">{$opt.name|wash}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            {/if}
                            {if $def}
                                <div class="input-block">
                                    {if not($field.data_type_string|eq('eztext'))}
                                        <label for="{$field.contentclass_attribute_identifier}">
                                            {concat($field.object.class_identifier,'/',$field.contentclass_attribute_identifier)|i18n('pmg/feedback')}
                                            {if $field.is_required}
                                                <span class="required">*</span>
                                            {/if}
                                        </label>
                                    {/if}
                                    {if $field.data_type_string|eq('eztext')}
                                        <textarea
                                            rows="10" cols="74"
                                            id="{$field.contentclass_attribute_identifier}"
                                            name="{$field.contentclass_attribute_identifier}"
                                            class="{if $field.is_required} validate['required']{/if}"
                                            placeholder="{'Enter your message here ...'|i18n('pmg')}"
                                        >{$value}</textarea>
                                    {else}
                                        <input
                                            type="text"
                                            value="{$value}"
                                            id="{$field.contentclass_attribute_identifier}"
                                            name="{$field.contentclass_attribute_identifier}"
                                            class="{if $field.is_required} validate['required']{/if}{if $field.contentclass_attribute_identifier|eq('mail')} validate['email']{/if}"
                                            placeholder="{concat($field.object.class_identifier,'/',$field.contentclass_attribute_identifier)|i18n('extension/ezcontent/title')}"
                                        />
                                    {/if}
                                </div>
                            {/if}

                            {undef $value $def $more}
                        {/if}
                    {/foreach}
                    <p class="infos">(*) {'champs obligatoires'|i18n('extension/ezfeedback')}</p>
                </fieldset>
                <fieldset class="right">
                    <input class="button btn orange" type="submit" name="send" id="send" value="{'Envoyer'|i18n('extension/ezfeedback')}" />
                    <input type="hidden" name="RedirectURI" value={$node.url_alias|ezurl} />
                </fieldset>
            </form>
            <hr>
        </div>
    </div>
</div>

{undef $currentUser $objectContacts}
