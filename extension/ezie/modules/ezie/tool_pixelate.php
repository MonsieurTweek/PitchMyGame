<?php
/**
 * File containing the pixelate tool handler
 *
 * @copyright Copyright (C) 1999-2012 eZ Systems AS. All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version 1.4.0
 * @package ezie
 */
$prepare_action = new eZIEImagePreAction();

$http = eZHTTPTool::instance();

$region = null;
if ( $prepare_action->hasRegion() )
{
    $region = $prepare_action->getRegion();
}

// retrieve image dimensions
$analyzer = new eZIEImageAnalyzer( $prepare_action->getImagePath() );

$imageconverter = new eZIEezcImageConverter(
    eZIEImageToolPixelate::filter(
        $analyzer->data->width,
        $analyzer->data->height,
        $region
    )
);

$imageconverter->perform(
    $prepare_action->getImagePath(),
    $prepare_action->getNewImagePath()
);

eZIEImageToolResize::doThumb(
    $prepare_action->getNewImagePath(),
    $prepare_action->getNewThumbnailPath()
);

echo (string)$prepare_action;
eZExecution::cleanExit();
?>
