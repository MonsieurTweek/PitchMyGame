<?php
/**
 *
 * Feedback module 
 *
 * @copyright	Maecia
 * @author		Nicolas
 * @version		1.0.0
 * @since		Module available since Release 1.0.0
* 
*/

$Module = array('name' => 'Web Alumni Feedback');

$ViewList['action'] = array(
		'script' => 'action.php',
		'functions' => array('create'),
		'default_navigation_part' => 'ezfeedbacknavigationpart',
		'params' => array()
);

$ViewList['export'] = array(
		'script' => 'export.php',
		'functions' => array('export'),
		'default_navigation_part' => 'ezfeedbacknavigationpart',
        'params' => array('ObjectID')
);

$FunctionList = array();
$FunctionList['create'] = array( );
$FunctionList['export'] = array( );

?>
