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

class eZPageType extends eZDataType
{
	const DATA_TYPE_STRING = 'ezpage';

	/**
	 * Constructor
	 *
	 */
	function __construct()
	{
		parent::__construct( self::DATA_TYPE_STRING, "Layout" );
	}

	/**
	 * Initialize contentobject attribute content
	 *
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @param integer $currentVersion
	 * @param eZContentObjectAttribute $originalContentObjectAttribute
	 */
	function initializeObjectAttribute( $contentObjectAttribute, $currentVersion, $originalContentObjectAttribute )
	{
		if ( $currentVersion != false )
		{
			$contentObjectID = $contentObjectAttribute->attribute( 'contentobject_id' );
			$originalContentObjectID = $originalContentObjectAttribute->attribute( 'contentobject_id' );

			if ( $contentObjectID != $originalContentObjectID )
			{
				$page = $originalContentObjectAttribute->content();
				$clonedPage = clone $page;
				$contentObjectAttribute->setContent( $clonedPage );
				$contentObjectAttribute->store();
			}
			else
			{
				$dataText = $originalContentObjectAttribute->attribute( 'data_text' );
				$contentObjectAttribute->setAttribute( 'data_text', $dataText );
			}
		}
		else
		{
			$contentClassAttribute = $contentObjectAttribute->contentClassAttribute();
			$defaultLayout = $contentClassAttribute->attribute( "data_text1" );
			$zoneINI = eZINI::instance( 'zone.ini' );
			$page = new eZPage();
			$zones = array();
			if ( $defaultLayout !== '' )
			{
				if ( $zoneINI->hasVariable( $defaultLayout, 'Zones' ) )
					$zones = $zoneINI->variable( $defaultLayout, 'Zones' );

				$page->setAttribute( 'zone_layout', $defaultLayout );
				foreach ( $zones as $zoneIdentifier )
				{
					$newZone = $page->addZone( new eZPageZone() );
					$newZone->setAttribute( 'id', md5( mt_rand() . microtime() . $page->getZoneCount() ) );
					$newZone->setAttribute( 'zone_identifier', $zoneIdentifier );
					$newZone->setAttribute( 'action', 'add' );
				}
			}
			else
			{
				$allowedZones = array();
				if ( $zoneINI->hasGroup( 'General' ) && $zoneINI->hasVariable( 'General', 'AllowedTypes' ) )
					$allowedZones = $zoneINI->variable( 'General', 'AllowedTypes' );

				$class = eZContentClass::fetch( $contentClassAttribute->attribute( 'contentclass_id' ) );

				foreach ( $allowedZones as $allowedZone )
				{
					$availableForClasses = array();
					if ( $zoneINI->hasVariable( $allowedZone, 'AvailableForClasses' ) )
						$availableForClasses = $zoneINI->variable( $allowedZone, 'AvailableForClasses' );
					
					if ( in_array( $class->attribute( 'identifier' ), $availableForClasses ) )
					{
						if ( $zoneINI->hasVariable( $allowedZone, 'Zones' ) )
							$zones = $zoneINI->variable( $allowedZone, 'Zones' );
							
						$page->setAttribute( 'zone_layout', $allowedZone );
						foreach ( $zones as $zoneIdentifier )
						{
							$newZone = $page->addZone( new eZPageZone() );
							$newZone->setAttribute( 'id', md5( mt_rand() . microtime() . $page->getZoneCount() ) );
							$newZone->setAttribute( 'zone_identifier', $zoneIdentifier );
							$newZone->setAttribute( 'action', 'add' );
						}

						break;
					}
					else
						continue;
				}
			}
			$contentObjectAttribute->setContent( $page );
		}
	}

	/**
	 * Checks if contentobject attribute has content
	 *
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @return bool
	 */
	function hasObjectAttributeContent( $contentObjectAttribute )
	{
		$page = $contentObjectAttribute->content();
		$zones = $page->attribute( 'zones' );
		
		foreach ( $zones as $zone )
		{
			if ( $zone->getBlockCount() > 0 )
				return true;
		}
		
		return false;
	}

	/**
	 * Validates all variables given on content class level
	 * return eZInputValidator::STATE_ACCEPTED or eZInputValidator::STATE_INVALID if
	 * the values are accepted or not
	 *
	 * @param eZHTTPTool $http
	 * @param string $base
	 * @param eZContentClassAttribute $classAttribute
	 * @return int
	 */
	function validateClassAttributeHTTPInput( $http, $base, $classAttribute )
	{
		return eZInputValidator::STATE_ACCEPTED;
	}

	/**
	 * Fetches all variables inputed on content class level
	 * return true if fetching of class attributes are successfull, false if not
	 *
	 * @param eZHTTPTool $http
	 * @param string $base
	 * @param eZContentClassAttribute $classAttribute
	 * @return bool
	 */
	function fetchClassAttributeHTTPInput( $http, $base, $classAttribute )
	{
		if ( $http->hasPostVariable( $base . '_ezpage_default_layout_' . $classAttribute->attribute( 'id' ) ) )
		{
			$defaultLayout = $http->postVariable( $base . '_ezpage_default_layout_' . $classAttribute->attribute( 'id' ) );
			$classAttribute->setAttribute( 'data_text1', $defaultLayout );
		}
		return true;
	}

	/**
	 * Validates input on content object level
	 * return eZInputValidator::STATE_ACCEPTED or eZInputValidator::STATE_INVALID if
	 * the values are accepted or not
	 *
	 * @param eZHTTPTool $http
	 * @param string $base
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @return int
	 */
	function validateObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
	{
		return eZInputValidator::STATE_ACCEPTED;
	}

	/**
	 * Fetches all variables from the object
	 * return true if fetching of object attributes are successfull, false if not
	 *
	 * @param eZHTTPTool $http
	 * @param string $base
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @return bool
	 */
	function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
	{
		$page = $contentObjectAttribute->content();
		$blockINI = eZINI::instance( 'block.ini' );

		if ( $http->hasPostVariable( $base . '_ezpage_block_custom_attribute_' . $contentObjectAttribute->attribute( 'id' ) ) )
		{
			$blockCustomAttributes = $http->postVariable( $base . '_ezpage_block_custom_attribute_' . $contentObjectAttribute->attribute( 'id' ) );

			foreach ( $blockCustomAttributes as $zoneID => $blocks )
			{
				$zone = $page->getZone( $zoneID );

				foreach ( $blocks as $blockID => $params )
				{
					$block = $zone->getBlock( $blockID );

					$customAttributes = $block->attribute( 'custom_attributes' );

					foreach ( $params as $param => $value )
					{
						$customAttributes[$param] = $value;
					}

					$block->setAttribute( 'custom_attributes', $customAttributes );
				}
			}
		}

		if ( $http->hasPostVariable( $base . '_ezpage_block_view_' . $contentObjectAttribute->attribute( 'id' ) ) )
		{

			$blockViewArray = $http->postVariable( $base . '_ezpage_block_view_' . $contentObjectAttribute->attribute( 'id' ) );

			foreach ( $blockViewArray as $zoneID => $blocks )
			{
				$zone = $page->getZone( $zoneID );

				foreach ( $blocks as $blockID => $view )
				{
					$block = $zone->getBlock( $blockID );
					$block->setAttribute( 'view', $view );

				}
			}
		}

		if ( $http->hasPostVariable( $base . '_ezpage_block_name_array_' . $contentObjectAttribute->attribute( 'id' ) ) )
		{
			$blockNameArray = $http->postVariable( $base . '_ezpage_block_name_array_' . $contentObjectAttribute->attribute( 'id' ) );

			foreach ( $blockNameArray as $zoneID => $blocks )
			{
				$zone = $page->getZone( $zoneID );

				foreach ( $blocks as $blockID => $blockName )
				{
					$block = $zone->getBlock( $blockID );
					$block->setAttribute( 'name', $blockName );
				}
			}

		}
		
		if ( $http->hasPostVariable( $base . '_ezpage_visibility_' . $contentObjectAttribute->attribute( 'id' ) ) ) {
			$visibility = $http->postVariable( $base . '_ezpage_visibility_' . $contentObjectAttribute->attribute( 'id' ) );

			foreach ( $visibility as $zoneID => $blocks )
			{
				$zone = $page->getZone( $zoneID );

				foreach ( $blocks as $blockID => $groups )
				{
					$block = $zone->getBlock( $blockID );
					$blockVisibility = array();
					$cpt = 0;
					foreach ($groups as $group)
					{
						$blockVisibility['group' . $cpt] = $group;
						$cpt++;
					}
					$block->setAttribute( 'visibility', $blockVisibility );
				}
			}
		}

		$contentObjectAttribute->setContent( $page );

		return true;
	}

	/**
	 * Stores the datatype data to the database which is related to the object attribute.
	 *
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @return bool
	 */
	function storeObjectAttribute( $contentObjectAttribute )
	{
		$page = $contentObjectAttribute->content();
		$contentObjectAttribute->setAttribute( 'data_text', $page->toXML() );
		return true;
	}

	/**
	 * Returns the content data for the given content object attribute.
	 *
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @return eZPage
	 */
	function objectAttributeContent( $contentObjectAttribute )
	{
		$source = $contentObjectAttribute->attribute( 'data_text' );
		$page = eZPage::createFromXML( $source );

		return $page;
	}

	/**
	 * Returns the meta data used for storing search indeces.
	 *
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @return string
	 */
	function metaData( $contentObjectAttribute )
	{
		return $contentObjectAttribute->attribute( 'data_text' );
	}

	/**
	 * Returns the value as it will be shown if this attribute is used in the object name pattern.
	 *
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @param string $name
	 * @return string
	 */
	function title( $contentObjectAttribute, $name = null  )
	{
		return '';
	}

	/**
	 * Executes a custom action for an object attribute which was defined on the web page.
	 *
	 * @param eZHTTPTool $http
	 * @param string $action
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @param array $parameters
	 */
	function customObjectAttributeHTTPAction( $http, $action, $contentObjectAttribute, $parameters )
	{
		$params = explode( '-', $action );

		switch ( $params[0] )
		{
			case 'new_zone_layout':
				if ( $http->hasPostVariable( 'ContentObjectAttribute_ezpage_zone_allowed_type_' . $contentObjectAttribute->attribute( 'id' ) ) )
				{
					$zoneMap = array();
					if ( $http->hasPostVariable( 'ContentObjectAttribute_ezpage_zone_map' ) )
						$zoneMap = $http->postVariable( 'ContentObjectAttribute_ezpage_zone_map' );

					$zoneINI = eZINI::instance( 'zone.ini' );
					$page = $contentObjectAttribute->content();
					$zoneAllowedType = $http->postVariable( 'ContentObjectAttribute_ezpage_zone_allowed_type_' . $contentObjectAttribute->attribute( 'id' ) );
					
					if ( $zoneAllowedType == $page->attribute('zone_layout') )
						return false;
					
					$allowedZones = $zoneINI->variable( $zoneAllowedType, 'Zones' );
					$allowedZonesCount = count( $allowedZones );
					
					$page->setAttribute( 'zone_layout', $zoneAllowedType );
					$existingZoneCount = $page->getZoneCount();
					
					$zoneCountDiff = 0;
					if ( $allowedZonesCount < $existingZoneCount )
						$zoneCountDiff = $existingZoneCount - $allowedZonesCount;

					if ( count( $zoneMap ) > 0 )
					{
						foreach( $page->attribute( 'zones' ) as $zoneIndex => $zone )
						{
							$zoneMapKey = array_search( $zone->attribute( 'zone_identifier' ), $zoneMap );

							if ( $zoneMapKey )
							{
								$zone->setAttribute( 'action', 'modify' );
								$zone->setAttribute( 'zone_identifier', $zoneMapKey );
							}
							else
							{
								if ( $zone->toBeAdded() )
									$page->removeZone( $zoneIndex );
								else
									$zone->setAttribute( 'action', 'remove' );
							}
						}
					}
					else
					{
						foreach ( $allowedZones as $index => $zoneIdentifier )
						{
							$existingZone = $page->getZone($index);
						
							if ( $existingZone instanceof eZPageZone )
							{
								$existingZone->setAttribute( 'action', 'modify' );
								$existingZone->setAttribute( 'zone_identifier', $zoneIdentifier );
							}
							else
							{
								$newZone = $page->addZone( new eZPageZone() );
								$newZone->setAttribute( 'id', md5( mt_rand() . microtime() . $page->getZoneCount() ) );
								$newZone->setAttribute( 'zone_identifier', $zoneIdentifier );
								$newZone->setAttribute( 'action', 'add' );
							}
						}

						if ( $zoneCountDiff > 0 )
						{
							while ( $zoneCountDiff != 0 )
							{
								$existingZoneIndex = $existingZoneCount - $zoneCountDiff;
								$existingZone = $page->getZone( $existingZoneIndex );
					
								if ( $existingZone->toBeAdded() )
									$page->removeZone( $existingZoneIndex );
								else
									$existingZone->setAttribute( 'action', 'remove' );
					
								$zoneCountDiff -= 1;
							}
						}
					}
					
					$page->sortZones();
				}
				break;
			case 'remove_block':
				$page = $contentObjectAttribute->content();
				$zone = $page->getZone( $params[1] );
				$block = $zone->getBlock( $params[2] );

				if ( $block->toBeAdded() )
				{
					$zone->removeBlock( $params[2] );
				}
				else
				{
					$block->setAttribute( 'action', 'remove' );
				}
				break;
			case 'new_block':
				$page = $contentObjectAttribute->content();
				$zone = $page->getZone( $params[1] );

				if ( $http->hasPostVariable( 'ContentObjectAttribute_ezpage_block_type_' . $contentObjectAttribute->attribute( 'id' ) . '_' . $params[1] ) )
					$blockType = $http->postVariable( 'ContentObjectAttribute_ezpage_block_type_' . $contentObjectAttribute->attribute( 'id' ) . '_' . $params[1] );

				if ( $http->hasPostVariable( 'ContentObjectAttribute_ezpage_block_name_' . $contentObjectAttribute->attribute( 'id' ) . '_' . $params[1] ) )
					$blockName = $http->postVariable( 'ContentObjectAttribute_ezpage_block_name_' . $contentObjectAttribute->attribute( 'id' ) . '_' . $params[1] );

				$block = $zone->addBlock( new eZPageBlock( $blockName, null ) );
				$block->setAttribute( 'action', 'add' );
				$block->setAttribute( 'id', md5( mt_rand() . microtime() . $zone->getBlockCount() ) );
				$block->setAttribute( 'zone_id', $zone->attribute( 'id' ) );
				$block->setAttribute( 'type', $blockType );
				break;
			case 'move_block_up':
				$page = $contentObjectAttribute->content();
				$zone = $page->getZone( $params[1] );
				$zone->moveBlockUp( $params[2] );
				break;
			case 'move_block_down':
				$page = $contentObjectAttribute->content();
				$zone = $page->getZone( $params[1] );
				$zone->moveBlockDown( $params[2] );
				break;
			case 'custom_attribute':
				$page = $contentObjectAttribute->content();
				$zone = $page->getZone( $params[1] );
				$block = $zone->getBlock( $params[2] );

				if ( !$http->hasPostVariable( 'BrowseCancelButton' ) )
				{
					$customAttributes = $block->attribute( 'custom_attributes' );

					if ( $http->hasPostVariable( 'SelectedNodeIDArray' ) )
					{
						$selectedNodeIDArray = $http->postVariable( 'SelectedNodeIDArray' );
						$customAttributes[$params[3]] = $selectedNodeIDArray[0];
					}

					$block->setAttribute( 'custom_attributes', $customAttributes );
					$contentObjectAttribute->setContent( $page );
					$contentObjectAttribute->store();
				}
				break;
			case 'custom_attribute_browse':
				$module = $parameters['module'];
				$redirectionURI = $redirectionURI = $parameters['current-redirection-uri'];


				eZContentBrowse::browse( array( 'action_name' => 'CustomAttributeBrowse',
												'browse_custom_action' => array( 'name' => 'CustomActionButton[' . $contentObjectAttribute->attribute( 'id' ) . '_custom_attribute-' . $params[1] . '-' . $params[2] . '-' . $params[3] . ']',
																				 'value' => $contentObjectAttribute->attribute( 'id' ) ),
												'from_page' => $redirectionURI,
												'cancel_page' => $redirectionURI,
												'persistent_data' => array( 'HasObjectInput' => 0 ) ), $module );
				break;
			default:
			break;
		}
	}

	/**
	 * Performs necessary actions with attribute data after object is published,
	 * it means that you have access to published nodes.
	 *
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @param eZContentObject $contentObject
	 * @param array(eZContentObjectTreeNode) $publishedNodes
	 * @return bool
	 */
	function onPublish( $contentObjectAttribute, $contentObject, $publishedNodes )
	{
		$db = eZDB::instance();
		$page = $contentObjectAttribute->content();

		foreach ( $publishedNodes as $node )
		{
			$nodeID = $node->attribute( 'node_id' );

			if ( $page->getZoneCount() != 0 )
			{
				foreach ( $page->attribute( 'zones' ) as $zone )
				{
					if ( $zone->getBlockCount() != 0 )
					{
						if ( $zone->toBeRemoved() )
						{
							foreach ( $zone->attribute( 'blocks' ) as $index => $block )
							{
								$block->setAttribute( 'action', 'remove' );
							}
						}

						foreach ( $zone->attribute( 'blocks' ) as $block )
						{
							$blockID = $block->attribute( 'id' );
							$blockType = $block->attribute( 'type' );
							$escapedBlockType = $db->escapeString( $blockType );
							$action = $block->attribute( 'action' );
							$zoneID = $block->attribute( 'zone_id' );
							$blockName = $block->attribute( 'name' );
							$escapedBlockName = $db->escapeString( $blockName );

							switch ( $action )
							{
								case 'remove':
									$db->query( "UPDATE ezm_block SET is_removed='1' WHERE id='" . $blockID . "'" );
									break;

								case 'add':
									$blockCount = $db->arrayQuery( "SELECT COUNT( id ) as count FROM ezm_block WHERE id='" . $blockID ."'" );

									if ( $blockCount[0]['count'] == 0 )
									{
										$db->query( "INSERT INTO ezm_block ( id, zone_id, name, node_id, block_type )
																	VALUES ( '" . $blockID . "',
																			 '" . $zoneID . "',
																			 '" . $escapedBlockName . "',
																			 '" . $nodeID . "',
																			 '" . $escapedBlockType . "' )" );
									}
									break;

								default:
									$db->query( "UPDATE ezm_block SET name='" . $escapedBlockName . "'
															WHERE id='" . $blockID . "'" );
									break;
							}
						}
					}
				}
			}
		}

		$db->begin();
		$db->query( "DELETE FROM ezm_block WHERE is_removed=1" );
		$db->commit();

		foreach ( $publishedNodes as $node )
		{
			$url = $node->attribute( 'path_identification_string' );
			eZURI::transformURI( $url, false, 'full' );
			eZHTTPCacheManager::execute( $url );
		}

		$page->removeProcessed();

		$contentObjectAttribute->content( $page );
		$contentObjectAttribute->store();

		return true;
	}

	/**
	 * return true if the datatype can be indexed
	 *
	 * @return bool
	 */
	function isIndexable()
	{
		return true;
	}

	/**
	 * return string representation of an contentobjectattribute data for simplified export.
	 *
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @return string
	 */
	function toString( $contentObjectAttribute )
	{
		return $contentObjectAttribute->attribute( 'data_text' );
	}

	/**
	 * Set contentobject attribute data from $string
	 *
	 * @param eZContentObjectAttribute $contentObjectAttribute
	 * @param string $string
	 * @return bool
	 */
	function fromString( $contentObjectAttribute, $string )
	{
		return $contentObjectAttribute->setAttribute( 'data_text', $string );
	}

	/**
	 * Return a DOM representation of the content object attribute
	 *
	 * @param eZPackage $package
	 * @param eZContentObjectAttribute $objectAttribute
	 * @return DOMElement
	 */
	function serializeContentObjectAttribute( $package, $objectAttribute )
	{
		$node = $this->createContentObjectAttributeDOMNode( $objectAttribute );

		$dom = new DOMDocument( '1.0', 'utf-8' );
		$success = $dom->loadXML( $objectAttribute->attribute( 'data_text' ) );

		$importedRoot = $node->ownerDocument->importNode( $dom->documentElement, true );
		$node->appendChild( $importedRoot );
		return $node;
	}

	/**
	 * Unserailize contentobject attribute
	 *
	 * @param eZPackage $package
	 * @param eZContentObjectAttribute $objectAttribute
	 * @param DOMElement $attributeNode
	 */
	function unserializeContentObjectAttribute( $package, $objectAttribute, $attributeNode )
	{
		$rootNode = $attributeNode->childNodes->item( 0 );
		$xmlString = $rootNode ? $rootNode->ownerDocument->saveXML( $rootNode ) : '';
		$objectAttribute->setAttribute( 'data_text', $xmlString );
	}
    
    
    function serializeContentClassAttribute( $classAttribute, $attributeNode, $attributeParametersNode )
    {
        $default = $classAttribute->attribute('data_text1');
        $dom = $attributeParametersNode->ownerDocument;
        $defaultNode = $dom->createElement( 'data_text1' );
        $defaultNode->appendChild( $dom->createTextNode( $default ) );
        $attributeParametersNode->appendChild( $defaultNode );
    }

    function unserializeContentClassAttribute( $classAttribute, $attributeNode, $attributeParametersNode )
    {
        $default = $attributeParametersNode->getElementsByTagName( 'data_text1' )->item( 0 )->textContent;
        $classAttribute->setAttribute('data_text1', $default );
    }
}

eZDataType::register( eZPageType::DATA_TYPE_STRING, "ezpagetype" );
?>