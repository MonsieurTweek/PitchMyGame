<?php
/**
 *
 * Ez module 
 *
 * @copyright	Maecia
 * @author		Lucie
 * @version		1.0.0
 * @since		Module available since Release 1.0.0
* 
*/

$eZTemplateOperatorArray = array();
$eZTemplateOperatorArray[] = array( 'script' => 'extension/ezmodule/autoloads/ezunserialize.php',
                                    'class' => 'eZUnserialize',
                                    'operator_names' => array( 'unserialize' ) );
$eZTemplateOperatorArray[] = array( 'script' => 'extension/ezmodule/autoloads/ezjson.php',
                                    'class' => 'eZJSON',
                                    'operator_names' => array( 'json' ) );
                                    
$eZTemplateFunctionArray = array();
$eZTemplateFunctionArray[] = array( 'function' => 'eZPageForwardInit',
                                    'function_names' => array( 'block_edit_gui',
                                                               'block_view_gui') );

if ( !function_exists( 'eZPageForwardInit' ) )
{
    function eZPageForwardInit()
    {
        include_once( 'kernel/common/ezobjectforwarder.php' );
        $forward_rules = array(
                'block_edit_gui' => array( 'template_root' => 'block/edit',
                                           'input_name' => 'block',
                                           'output_name' => 'block',
                                           'namespace' => 'ContentAttributeBlockEdit',
                                           'attribute_keys' => array( 'type' => array( 'type' ) ),
                                           'attribute_access' => array( array( 'edit_template' ) ),
                                           'optional_views' => true,
                                           'use_views' => 'view' ),
                'block_view_gui' => array( 'template_root' => 'block/view',
                                           'render_mode' => false,
                                           'input_name' => 'block',
                                           'output_name' => 'block',
                                           'namespace' => 'ContentAttributeBlockView',
                                           'attribute_keys' => array( 'type' => array( 'type' ),
                                                                      'view' => array( 'view' ) ),
                                           'attribute_access' => array( array( 'view_template' ) ),
                                           'optional_views' => true,
                                           'use_views' => 'view' ) );

        return new eZObjectForwarder( $forward_rules );
    }
}

?>