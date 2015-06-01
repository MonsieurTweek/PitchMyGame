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

class eZPageBlock
{
	private $attributes = array();
	private $dynamicAttributeFunctions = array( 'view_template' => 'viewTemplate',
												'edit_template' => 'editTemplate');

	/**
	 * Constructor
	 *
	 * @param string $name
	 * @param array $row
	 * @param array $visibilty
	 */
	function __construct( $name = null, $row = null )
	{
		if ( isset( $name ) )
			$this->attributes['name'] = $name;

		if ( isset( $row ) )
			$this->attributes = $row;
	}

	/**
	 * Return object ID
	 *
	 * @return string
	 */
	public function id()
	{
		return $this->attribute( 'id' );
	}

	/**
	 * Creates DOMElement with block data
	 *
	 * @param DOMDocument $dom
	 * @return DOMElement
	 */
	public function toXML( DOMDocument $dom )
	{
		$blockNode = $dom->createElement( 'block' );

		foreach ( $this->attributes as $attrName => $attrValue )
		{
			switch ( $attrName )
			{
				case 'id':
					$blockNode->setAttribute( 'id', 'id_' . $attrValue );
					break;

				case 'action':
					$blockNode->setAttribute( 'action', $attrValue );
					break;

				case 'custom_attributes':
				case 'visibility':
					$node = $dom->createElement( $attrName );
					$blockNode->appendChild( $node );

					foreach ( $attrValue as $arrayItemKey => $arrayItemValue )
					{
						$tmp = $dom->createElement( $arrayItemKey );
						$tmpValue = $dom->createTextNode( $arrayItemValue );
						$tmp->appendChild( $tmpValue );
						$node->appendChild( $tmp );
					}
					break;

				default:
					$node = $dom->createElement( $attrName );
					$nodeValue = $dom->createTextNode( $attrValue );
					$node->appendChild( $nodeValue );
					$blockNode->appendChild( $node );
					break;
			}
		}

		return $blockNode;
	}

	/**
	 * Creates and return eZPageBlock object from given XML
	 *
	 * @static
	 * @param DOMElement $node
	 * @return eZPageBlock
	 */
	public static function createFromXML( DOMElement $node )
	{
		$newObj = new eZPageBlock();

		if ( $node->hasAttributes() )
		{
			foreach ( $node->attributes as $attr )
			{
				if ( $attr->name == 'id' )
				{
					$value = explode( '_', $attr->value );
					$newObj->setAttribute( $attr->name, $value[1] );
				}
				else
				{
					$newObj->setAttribute( $attr->name, $attr->value );
				}
			}
		}

		foreach ( $node->childNodes as $node )
		{
			if ( $node->nodeType == XML_ELEMENT_NODE && $node->nodeName == 'item' )
			{
				$blockItemNode = eZPageBlockItem::createFromXML( $node );
				$newObj->addItem( $blockItemNode );
			}
			elseif ( $node->nodeType == XML_ELEMENT_NODE && $node->nodeName == 'rotation' )
			{
				$attrValue = array();

				foreach ( $node->childNodes as $subNode )
				{
					if ( $subNode->nodeType == XML_ELEMENT_NODE )
						$attrValue[$subNode->nodeName] = $subNode->nodeValue;
				}

				$newObj->setAttribute( $node->nodeName, $attrValue );
			}
			elseif ( $node->nodeType == XML_ELEMENT_NODE && ($node->nodeName == 'custom_attributes' || $node->nodeName == 'visibility') )
			{
				$attrValue = array();

				foreach ( $node->childNodes as $subNode )
				{
					if ( $subNode->nodeType == XML_ELEMENT_NODE )
						$attrValue[$subNode->nodeName] = $subNode->nodeValue;
				}

				$newObj->setAttribute( $node->nodeName, $attrValue );
			}
			else
			{
				if ( $node->nodeType == XML_ELEMENT_NODE )
					$newObj->setAttribute( $node->nodeName, $node->nodeValue );
			}
		}

		return $newObj;
	}

	/**
	 * Return eZPageBlock name attribute
	 *
	 * @return string
	 */
	public function getName()
	{
		return isset( $this->attributes['name'] ) ? $this->attributes['name'] : null;
	}

	/**
	 * Return attributes names
	 *
	 * @return array(string)
	 */
	public function attributes()
	{
		return array_merge( array_keys( $this->attributes ), array_keys( $this->dynamicAttributeFunctions ) );
	}

	/**
	 * Checks if attribute with given $name exists
	 *
	 * @param string $name
	 * @return bool
	 */
	public function hasAttribute( $name )
	{
		return in_array( $name, array_keys( $this->attributes ) ) || isset( $this->dynamicAttributeFunctions[$name] );
	}

	/**
	 * Set attribute with given $name to $value
	 *
	 * @param string $name
	 * @param mixed $value
	 */
	public function setAttribute( $name, $value )
	{
		$this->attributes[$name] = $value;
	}

	/**
	 * Return value of attribute with given $name
	 *
	 * @return mixed
	 * @param string $name
	 */
	public function attribute( $name )
	{
		if ( isset( $this->dynamicAttributeFunctions[$name] ) )
		{
			if ( is_array( $this->dynamicAttributeFunctions[$name] ) )
			{
				return $this->dynamicAttributeFunctions[$name];
			}
			else
			{
				$attribute = call_user_func( array( $this, $this->dynamicAttributeFunctions[$name] ) );
				return $attribute;
			}
		}
		else
		{
			if ( $this->hasAttribute( $name ) )
			{
				return $this->attributes[$name];
			}
			else
			{
				$value = null;
				return $value;
			}
		}
	}

	/**
	 * Cleanup processed objects, removes action attribute
	 * removes all items marked with "remove" action
	 *
	 * @return eZPageBlock
	 */
	public function removeProcessed()
	{
		if ( $this->hasAttribute( 'action' ) )
		{
			unset( $this->attributes['action'] );
		}

		return $this;
	}

	/**
	 * Fetches block from database by given $blockID
	 *
	 * @param string $blockID
	 * @param bool $asObject
	 * @return eZPageBlock
	 */
	public function fetch( $blockID, $asObject = true )
	{
		$db = eZDB::instance();
		$row = $db->arrayQuery( "SELECT * FROM ezm_block WHERE id='$blockID'" );

		if ( $asObject )
		{
			$block = new eZPageBlock( null, $row[0] );
			return $block;
		}
		else
		{
			return $row[0];
		}
	}

	/**
	 * Return view template string
	 *
	 * @return string
	 */
	public function viewTemplate()
	{
		$template = 'view';
		return $template;
	}

	/**
	 * Return edit template string
	 *
	 * @return string
	 */
	public function editTemplate()
	{
		$template = 'edit';
		return $template;
	}

	/**
	 * Checks if current block is to be removed
	 *
	 * @return bool
	 */
	public function toBeRemoved()
	{
		return isset( $this->attributes['action'] ) && $this->attributes['action'] == 'remove';
	}

	/**
	 * Checks if current block is to be modified
	 *
	 * @return bool
	 */
	public function toBeModified()
	{
		return isset( $this->attributes['action'] ) && $this->attributes['action'] == 'modify';
	}

	/**
	 * Checks if current block is to be added
	 *
	 * @return bool
	 */
	public function toBeAdded()
	{
		return isset( $this->attributes['action'] ) && $this->attributes['action'] == 'add';
	}
}

?>