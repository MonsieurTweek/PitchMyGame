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
$content_ini = eZIni::instance('content.ini');
$DefaultNodeID = $content_ini->variable('NodeSettings','ContainerNodeID');
$DefaultNodeID = isset($DefaultNodeID['events']) ? $DefaultNodeID['events'] : $content_ini->variable('NodeSettings', 'RootNode');

$NodeID = isset($Params['NodeID']) ? $Params['NodeID'] : $DefaultNodeID;

$Parent = eZContentObjectTreeNode::fetch($NodeID);

$Parameters = array();
$params = array(
                'ClassFilterType' => 'include',
                'ClassFilterArray' => array( 'event' ),
                'SortBy' => $Parent->sortArray()
);

$params = array_merge($params, $Parameters);
$events = eZContentObjectTreeNode::subTreeByNodeID( $params, $NodeID );

$tpl = eZTemplate::factory();
$tpl->setVariable( 'events', $events );
$result = $tpl->fetch( 'design:ajax/events_container.tpl' );

echo $result;

eZExecution::cleanExit();

?>
