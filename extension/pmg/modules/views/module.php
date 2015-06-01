<?php

$Module = array( 'name' => 'Views Module - List content' );

$ViewList['projects'] = array(
    'script' => 'projects.php',
    'functions' => array('list'),
    'params' => array( 'Name', 'Edition', 'Category' )
);

$ViewList['events'] = array(
    'script' => 'events.php',
    'functions' => array('list'),
    'params' => array(  )
);

$ClassID = array(
	'name'=> 'Class',
	'values'=> array(),
	'class' => 'eZContentClass',
	'function' => 'fetchList',
	'parameter' => array( 0, false, false, array( 'name' => 'asc' ) )
);

$SectionID = array(
	'name'=> 'Section',
	'values'=> array(),
	'class' => 'eZSection',
	'function' => 'fetchList',
	'parameter' => array( false )
);

$Assigned = array(
	'name'=> 'Owner',
	'values'=> array(
	    array(
	        'Name' => 'Self',
	        'value' => '1')
	    )
);

$AssignedGroup = array(
    'name'=> 'Group',
    'single_select' => true,
    'values'=> array(
        array( 'Name' => 'Self',
               'value' => '1') ) );

$Node = array(
    'name'=> 'Node',
    'values'=> array()
);

$Subtree = array(
	'name'=> 'Subtree',
	'values'=> array()
);

$FunctionList = array();
$FunctionList['list'] = array( 'Class' => $ClassID,
                               'Section' => $SectionID,
                               'Owner' => $Assigned,
                               'Group' => $AssignedGroup,
                               'Node' => $Node,
                               'Subtree' => $Subtree);

?>
