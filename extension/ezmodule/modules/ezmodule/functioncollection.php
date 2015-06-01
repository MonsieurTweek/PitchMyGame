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

class eZModuleFunctionCollection
{
    function fetchBlock( $blockID )
    {
        $result = array( 'result' => eZPageBlock::fetch( $blockID ) );
        return $result;
    }

    function fetchAllowedZones()
    {
        $res = array();
        $ini = eZINI::instance( 'zone.ini' );
        $allowedZoneTypes = $ini->variable( 'General', 'AllowedTypes' );

        foreach ( $allowedZoneTypes as $allowedZoneType )
        {
            $row = array( 'type' => $allowedZoneType, 'name' => '', 'thumbnail' => '', 'classes' => array(), 'zones' => array() );

            $row['name'] = $ini->variable( $allowedZoneType, 'ZoneTypeName' );
            $row['thumbnail'] = $ini->variable( $allowedZoneType, 'ZoneThumbnail' );
            $row['classes'] = $ini->variable( $allowedZoneType, 'AvailableForClasses' );
            $zones =& $row['zones'];
            
            $allowedZones = $ini->variable( $allowedZoneType, 'Zones' );
            $allowedZoneNames = $ini->variable( $allowedZoneType, 'ZoneName' );
            
            foreach ( $allowedZones as $allowedZone )
            {
                $zones[] = array( 'id' => $allowedZone, 'name' => $allowedZoneNames[$allowedZone] );
            }
            
            $res[] = $row;
        }

        $result = array( 'result' => $res );
        return $result;
    }
}

?>