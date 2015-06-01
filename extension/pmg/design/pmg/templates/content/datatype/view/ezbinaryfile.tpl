{default icon_size='normal' icon_title=$attribute.content.mime_type icon=false()}
{if $attribute.has_content}
    {if $icon}
        <span class="file-type">{$attribute.content.mime_type|mimetype_icon( $icon_size, $icon_title )}</span>
    {/if}
    <a class="file-link" href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl}>{$attribute.object.name|wash(xhtml)}</a><br />
    <span class="file-infos">{$attribute.content.filesize|si(byte)}</span>
{else}
    <div class="message-error"><h1>{"The file could not be found."|i18n("design/base")}</h1></div>
{/if}
{/default}
