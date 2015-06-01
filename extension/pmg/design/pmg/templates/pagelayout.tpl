{if is_set($current_user)|not}
{def $current_user = fetch('user', 'current_user')}
{/if}
{def    
        $home = ezini('NodeSettings','RootNode', 'content.ini')
        $current_node = fetch( 'content', 'node', hash( 'node_id', $module_result.node_id ))
}


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$site.http_equiv.Content-language|wash}" lang="{$site.http_equiv.Content-language|wash}">
    <head>
        {include uri="design:layout/head.tpl"}
        {include uri="design:layout/meta.tpl"}
        {include uri="design:layout/stylesheets.tpl"}
        {include uri="design:layout/javascript-init.tpl"}
        {*include uri="design:konami/header.tpl"*}
    </head>
    <body>
        {include uri="design:layout/header.tpl"}
        
        <div id="page-wrap">
            <div id="page">
                {def $layout = array()}
                {if and(is_set($current_node.data_map.layout), $current_node.data_map.layout.has_content)}
                    {set $layout = $current_node.data_map.layout}
                {elseif and(is_set($current_node.parent.data_map.layout), $current_node.parent.data_map.layout.has_content)}
                    {set $layout = $current_node.parent.data_map.layout}
                {/if}

                {* Special case *}
                {if and( array('project')|contains($current_node.class_identifier), not(is_set($layout.content.zone_layout)) )}
    
                    {def $parent = fetch( 'content', 'node', hash( 'node_id', $current_node.parent_node_id ))}
                    {if is_set($parent.data_map.children_layout)}
                        {set $layout = $parent.data_map.children_layout}
                    {/if}
                    {undef $parent}
                {/if}

                {if $layout}

                    {switch match=$layout.content.zone_layout}

                        {* Si c'est une sidebar latérale gauche, on l'affiche avant le contenu *}
                        {case match='LeftSidebar'}
                            <div id="content" {if array('homepage', 'news', 'project')|contains($current_node.class_identifier)}class="without-padding"{/if}>
                                <aside>
                                    {include uri="design:zone/sidebarlayout.tpl" zones=$layout.content.zones current_node=$current_node}
                                </aside>
                                <div id="main">
                                    {$module_result.content}
                                </div>
                            </div>
                        {/case}

                        {* Si c'est une sidebar latérale droite, on l'affiche après le contenu *}
                        {case match='RightSidebar'}
                            <div id="content" {if array('homepage', 'news', 'project')|contains($current_node.class_identifier)}class="without-padding"{/if}>
                                <div id="main">
                                    {$module_result.content}
                                </div>
                                <aside>
                                    {include uri="design:zone/sidebarlayout.tpl" zones=$layout.content.zones current_node=$current_node}
                                </aside>
                            </div>
                        {/case}

                        {* Si c'est un layout homepage, on gère ça dans le template du node *}
                        {case match='Homepage'}
                            <div id="content" {if array('homepage', 'news', 'project')|contains($current_node.class_identifier)}class="without-padding"{/if}>
                                {$module_result.content}
                            </div>
                        {/case}

                        {case}
                            {$module_result.content}                            
                        {/case}

                    {/switch}
                {else}
                    {$module_result.content}
                {/if}
            </div>
        </div>

        {*include uri="design:konami/game.tpl"*}
        {include uri="design:layout/footer.tpl"}
        {include uri="design:layout/javascript.tpl"}
        {include uri="design:layout/statistics.tpl"}
        {undef $home}
        <!--DEBUG_REPORT-->
    </body>
</html>
