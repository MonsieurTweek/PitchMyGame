<?php
/**
 * File containing the eZIEImageToolFlipHor class.
 * 
 * @copyright Copyright (C) 1999-2012 eZ Systems AS. All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version 1.4.0
 * @package ezie
 */
class eZIEImageToolFlipHorizontally extends eZIEImageAction
{
    /**
     * Creates a horizontal flip filter
     * @param  array(int) $region Affected region, as an array of 4 keys: w, h, x, y
     * @return array( ezcImageFilter )
     */
    static function filter( $region = null )
    {
        return array(
            new ezcImageFilter( 
                'horizontalFlip',
                array( 
                    'region' => $region 
                )
            )
        );
    }
}

?>
