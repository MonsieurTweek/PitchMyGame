<?php
/**
 *
 *
 * @copyright	PitchMyGame
 * @author		Gaëtan
 * @version		1.0.0
* 
*/

function truncate($text, $chars = 25) {
    if (strlen($text) > $chars) {
        $text = $text." ";
        $text = substr($text,0,$chars);
        $text = substr($text,0,strrpos($text,' '));
        $text = $text."...";
    }
    return $text;
}

$Module = $Params["Module"];
$content_ini = eZIni::instance('content.ini');
$DefaultNodeID = $content_ini->variable('NodeSettings','ContainerNodeID');
$DefaultNodeID = $DefaultNodeID['news'];

$Offset = isset($Params['Offset']) ? $Params['Offset'] : 0;
$Limit = isset($Params['Limit']) ? $Params['Limit'] : 3;
$Direction = isset($Params['Direction']) ? $Params['Direction'] : 'next';
$NodeID = isset($Params['NodeID']) ? $Params['NodeID'] : $DefaultNodeID;

if ($Direction == 'prev')
	$Offset = $Offset - $Limit >= 0 ? $Offset - $Limit : 0;

$params = array(
                'Limit' => $Limit,
                'Offset' => $Offset,
                'ClassFilterType' => 'include',
                'ClassFilterArray' => array( 'news' ),
                'SortBy' => array( 'published', false )
);
$news = eZContentObjectTreeNode::subTreeByNodeID( $params, $NodeID );

$data = array();
foreach ($news as $n) {
	$url = $n->urlAlias();
	eZURI::transformURI($url);
	$data[] = array('Name' => truncate($n->Name, 30), 'URL' => $url);
}

echo json_encode($data);

eZExecution::cleanExit();

?>
