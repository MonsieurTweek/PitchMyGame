{def
    $n = ''
    $attribute = ''
    $url = false()
    $protocols = array('http', 'file', 'ftp', 'mailto', 'https')
}

{if and(
    $protocols|contains($href|explode(':')|extract_left(1).0)|not(),
    $href|begins_with('/')|not()
    )
}
    {* Va chercher les informatios sur le noeud *}
    {set $n = fetch(content, node, hash(node_path, $href))}
    
    {* Si le noeud revele que l'objet est un fichier (class = file) *}
    {if and($n, $n.object.class_identifier|eq('file'))}
        {set
            $attribute = $n.data_map.file
            $url = concat( '/content/download/', $attribute.contentobject_id, '/', $attribute.id,'/version/', $attribute.version , '/file/', $attribute.content.original_filename|urlencode )
        }
    {/if}
{/if}

{if $url|not()}
    {set $url = $href}
{/if}

<a href="{$url|contains('mailto:')|not|choose($url|wash(email), or($url|begins_with('http://'),$url|begins_with('https://'))|choose($url|ezurl('no'), $url))}"{if $id|compare('')|not} id="{$id}"{/if}{if $title|compare('')|not} title="{$title}"{/if}{if $target|compare('_blank')}{set $classification = $classification|trim()|compare('')|choose(concat($classification, ' external'), concat($classification, 'external'))}{/if}{if $classification|trim()|compare('')|not} class="{$classification|wash}"{/if}{if and(is_set($rel), $rel|compare('')|not)} rel="{$rel}"{/if}>{$url|contains('mailto:')|choose($content, $content|wash(email))}</a>
{undef $n $attribute $url $protocols}