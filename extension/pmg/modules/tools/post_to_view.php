<?php
/**
 *
 *
 * @copyright	PitchMyGame
 * @author		Gaëtan
 * @version		1.0.0
* 
*/

$Module = $Params["Module"];
$http = eZHTTPTool::instance();
var_dump($http->postVariable( 'name'));

exit();

eZExecution::cleanExit();

?>