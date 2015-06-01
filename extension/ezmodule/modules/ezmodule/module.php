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

$Module = array( 'name' => 'eZ Module',
				 'functions' => array( 'changelayout' ));

$ViewList = array();
$ViewList['zone'] = array( 'script' => 'zone.php',
						   'functions' => array( 'edit' ),
						   'params' => array( 'ContentObjectAttributeID', 'Version', 'ZoneID' ) );

$FunctionList = array();
$FunctionList['edit'] = array();
$FunctionList['changelayout'] = array( 'Class' => array( 'name'=> 'Class',
																  'values'=> array(),
																  'path' => 'classes/',
																  'file' => 'ezcontentclass.php',
																  'class' => 'eZContentClass',
																  'function' => 'fetchList',
																  'parameter' => array( 0, false, false, array( 'name' => 'asc' ) ) ) );

?>