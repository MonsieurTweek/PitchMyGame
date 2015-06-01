<?php 
/**
 * File containing the eZIEImageFilterBW class.
 *
 * @copyright Copyright (C) 1999-2012 eZ Systems AS. All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version 1.4.0
 * @package ezie
 */

class eZIEImageFilterBW extends eZIEImageAction
{
    /**
     * Creates a black & white filter
     * 
     * @param  array(int) $region Affected region, as an array of 4 keys: x, y, w, h
     * 
     * @return array( ezcImageFilter ) 
     */
    static function filter( $region = null )
    {
        return array(
            new ezcImageFilter( 
                'colorspace',
                array( 
                    'space' => ezcImageColorspaceFilters::COLORSPACE_GREY,
                    'region' => $region, 
                )
            )
        );
    }
}

?>
