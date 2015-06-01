{switch name=sw match=$level}
{case match=1}
<h2{if ne($classification|trim,'')} class="{$classification|wash}"{/if}>{$content}</h2>
{/case}
{case match=2}
<h3{if ne($classification|trim,'')} class="{$classification|wash}"{/if}>{$content}</h3>
{/case}
{case match=3}
<h4{if ne($classification|trim,'')} class="{$classification|wash}"{/if}>{$content}</h4>
{/case}
{case match=4}
<h5{if ne($classification|trim,'')} class="{$classification|wash}"{/if}>{$content}</h5>
{/case}
{case match=5}
<h6{if ne($classification|trim,'')} class="{$classification|wash}"{/if}>{$content}</h6>
{/case}
{case match=6}
<h6{if ne($classification|trim,'')} class="{$classification|wash}"{/if}>{$content}</h6>
{/case}
{case}
<h2{if ne($classification|trim,'')} class="{$classification|wash}"{/if}>{$content}</h2>
{/case}
{/switch}
