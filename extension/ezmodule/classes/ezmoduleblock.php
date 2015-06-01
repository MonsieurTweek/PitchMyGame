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
class eZModuleBlock extends eZPersistentObject
{
    /**
     * Constructor
     * 
     * @param array $row
     */
    function __construct( $row )
    {
        parent::__construct( $row );
    }

    /**
     * Return the definition for the object
     * 
     * @static
     * @return array
     */
    public static function definition()
    {
        return array( 'fields' => array( 'id' => array( 'name' => 'ID',
                                                        'datatype' => 'string',
                                                        'default' => '',
                                                        'required' => true ),
                                         'zone_id' => array( 'name' => 'ZoneID',
                                                             'datatype' => 'string',
                                                             'default' => '',
                                                             'required' => true ),
                                         'name' => array( 'name' => 'Name',
                                                          'datatype' => 'string',
                                                          'default' => '',
                                                          'required' => false ),
                                         'node_id' => array( 'name' => 'NodeID',
                                                             'datatype' => 'integer',
                                                             'default' => '0',
                                                             'required' => true ),
                                         'block_type' => array( 'name' => 'BlockType',
                                                                'datatype' => 'string',
                                                                'default' => '',
                                                                'required' => false ),
                                         'is_removed' => array( 'name' => 'IsRemoved',
                                                                          'datatype' => 'integer',
                                                                          'default' => '0',
                                                                          'required' => false ) ),
                      'keys' => array( 'id' ),
                      'class_name' => 'eZModuleBlock',
                      'sort' => array( 'id' => 'asc' ),
                      'name' => 'ezm_block' );
    }

    /**
     * Fetch block by ID
     * 
     * @param int $id
     * @return null|eZModuleBlock
     */
    static function fetch( $id )
    {
        $cond = array( 'id' => $id );
        $rs = eZPersistentObject::fetchObject( self::definition(), null, $cond );
        return $rs;
    }

}

?>