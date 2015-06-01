<?php
/**
 * File containing the eZIEImageFilterContrast class.
 *
 * @copyright Copyright (C) 1999-2012 eZ Systems AS. All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version 1.4.0
 * @package kernel
 */
class eZIEImageFilterContrast extends eZIEImageAction
{
    /**
     * Creates a contrast filter
     * @param int $value Contrast value
     * @return array( ezcImageFilter )
     */
    static function filter( $value = 0, $region = null )
    {
        return array(
            new ezcImageFilter(
                'contrast',
                array(
                    'value' => $value,
                    'region' => $region
                )
            )
        );
    }
}

?>
