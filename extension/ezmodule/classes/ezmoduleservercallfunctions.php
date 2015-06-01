<?php

/**
 * Implements methods called remotely by sending XHR calls
 * 
 */
class eZModuleServerCallFunctions
{

    /**
     * Update blocks order based on AJAX data send after D&D operation is finished
     * 
     * @param mixed $args
     * @return array
     */
    public static function updateblockorder( $args )
    {
        $http = eZHTTPTool::instance();

        if ( $http->hasPostVariable( 'contentobject_attribute_id' ) )
            $contentObjectAttributeID = $http->postVariable( 'contentobject_attribute_id' );

        if ( $http->hasPostVariable( 'version' ) )
            $version = $http->postVariable( 'version' );

        if ( $http->hasPostVariable( 'zone' ) )
            $zoneID = $http->postVariable( 'zone' );

        if ( $http->hasPostVariable( 'block_order' ) )
            $blockOrder = $http->postVariable( 'block_order' );

        $contentObjectAttribute = eZContentObjectAttribute::fetch( $contentObjectAttributeID, $version );
        $sortArray = array();
        foreach ( $blockOrder as $blockID )
        {
            $idArray = explode('_', $blockID);

            if ( isset( $idArray[1]) )
                $sortArray[] = $idArray[1];
        }

        if ( $contentObjectAttribute )
            $page = $contentObjectAttribute->content();
        if ( $page )
            $zone = $page->getZone( $zoneID );
        if ( $zone )
            $zone->sortBlocks( $sortArray );

        $contentObjectAttribute->setContent( $page );
        $contentObjectAttribute->store();

        return array();
    }
}

?>