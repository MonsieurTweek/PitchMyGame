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

include_once( 'kernel/common/template.php' );

$module = $Params["Module"];
$contentObjectAttributeID = $Params['ContentObjectAttributeID'];
$version = $Params['Version'];
$zoneID = $Params['ZoneID'];

$contentObjectAttribute = eZContentObjectAttribute::fetch( $contentObjectAttributeID, $version );
$page = $contentObjectAttribute->content();
$zone = $page->getZone( $zoneID );

$tpl = templateInit();

$tpl->setVariable('zone_id', $zoneID );
$tpl->setVariable('zone', $zone );
$tpl->setVariable('attribute', $contentObjectAttribute );

$ini = eZINI::instance('block.ini');
$options = array();
foreach( $ini->variable('General', 'AllowedTypes') as $type ){
    $zones = $ini->variable($type, 'AllowedZones');
    if( !$zones || in_array($zone->attribute('zone_identifier'), $zones) )
        $options[$type] = $ini->variable($type, 'Name');
}
asort($options);
$tpl->setVariable('options', $options);


echo $tpl->fetch( 'design:page/zone.tpl' );

eZExecution::cleanExit();

?>
