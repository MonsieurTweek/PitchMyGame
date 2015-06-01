{set $classification = cond( and(is_set( $align ), $align ), concat( $classification, ' object-', $align ), $classification )}
<table{if $classification} class="{$classification|wash}"{else} class="renderedtable"{/if}{if ne($border|trim,'')} border="{$border}"{/if} cellpadding="{first_set($cellpadding, '2')}" cellspacing="0"{if ne($width|trim,'')} width="{$width}"{/if}{if and(is_set( $summary ), $summary)} summary="{$summary|wash}"{/if}{if and(is_set( $title ), $title)} title="{$title|wash}"{/if} summary="">
{if and(is_set( $caption ), $caption)}<caption>{$caption|wash}</caption>{/if}
{$rows}
</table>
