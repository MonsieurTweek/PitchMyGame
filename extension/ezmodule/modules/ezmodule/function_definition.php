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

$FunctionList = array();

$FunctionList['allowed_zones'] = array( 'name' => 'allowed_zones',
                                        'operation_types' => array( 'read' ),
                                        'call_method' => array( 'include_file' => 'extension/ezmodule/modules/ezmodule/functioncollection.php',
                                                                'class' => 'eZModuleFunctionCollection',
                                                                'method' => 'fetchAllowedZones' ),
                                        'parameter_type' => 'standard',
                                        'parameters' => array() );
?>