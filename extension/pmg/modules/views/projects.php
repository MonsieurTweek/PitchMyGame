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
$DefaultNodeID = isset($DefaultNodeID['projects']) ? $DefaultNodeID['projects'] : $content_ini->variable('NodeSettings', 'RootNode');

$NodeID = isset($Params['NodeID']) ? $Params['NodeID'] : $DefaultNodeID;
$Name = isset($Params['Name']) ? $Params['Name'] : '';
$Edition = isset($Params['Edition']) ? $Params['Edition'] : '';
$Category = isset($Params['Category']) ? $Params['Category'] : '';

$Parameters = array();
if (!empty($Name)) {
	$Name = explode('|', $Name);
	$Parameters['AttributeFilter'] = array('and', array('project/name', 'like', "*".$Name[0]."*"));
}

$Parent = eZContentObjectTreeNode::fetch($NodeID);
$params = array(
                'ClassFilterType' => 'include',
                'ClassFilterArray' => array( 'project' ),
                'SortBy' => $Parent->sortArray()
);

$params = array_merge($params, $Parameters);
$projects = eZContentObjectTreeNode::subTreeByNodeID( $params, $NodeID );

$AllowedProjects = array();
$FilteredProjectsByEdition = array();
$FilteredProjectsByCategory = array();

/* Edition Filtering */
if (!empty($Edition)) {
	$Edition = eZContentObject::fetch($Edition);
	$datamap = $Edition->datamap();
	$FilteredProjectsByEdition = explode('-', $datamap['projects']->toString());
}

/* Category Filtering */
$keyword = eZTagsObject::fetch($Category);
if ($keyword instanceof eZTagsObject) {
    foreach ($keyword->getRelatedObjects() as $relatedObject) {
        $FilteredProjectsByCategory[] = $relatedObject->ID;
    }
}

$Data = array();
foreach ($projects as $project) {
	if ( empty($FilteredProjectsByEdition) || in_array($project->ContentObjectID, $FilteredProjectsByEdition) ) {
        if ( empty($FilteredProjectsByCategory) || in_array($project->ContentObjectID, $FilteredProjectsByCategory) ) {
		  $AllowedProjects[] = $project;
        }
	}
}

$tpl = eZTemplate::factory();
$tpl->setVariable( 'projects', $AllowedProjects );
$result = $tpl->fetch( 'design:ajax/projects_container.tpl' );

echo $result;

eZExecution::cleanExit();

?>
