{def $site_url = ezini('SiteSettings','SiteURL')}

{'Message de la part de'|i18n('extension/feedback')} : {$infos.name}

{'E-mail'|i18n('extension/feedback')} : {$infos.from}

{'Objet'|i18n('extension/feedback')} : {$infos.object}

{if $userID}
{def
    $user = fetch('content', 'object', hash('object_id', $userID))
    $AdminURL = ezini('SiteSettings','AdminURL')
}

Concernant l'utilisateur {$user.current.data_map.first_name.content} {$user.current.data_map.last_name.content}
http://{$AdminURL}{$user.main_node.url_alias|ezurl(no)}


{undef $user $AdminURL}
{/if}
{'Message'|i18n('extension/feedback')} :
{$infos.message}

-- 
{"Signature email %siteurl"|i18n('extension/ezuser',, hash('%siteurl', $site_url))}

{undef $site_url}
