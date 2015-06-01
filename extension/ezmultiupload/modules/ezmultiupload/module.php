<?php
/**
 * File containing the eZ Publish module definition.
 *
 * @copyright Copyright (C) 1999-2012 eZ Systems AS. All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version 1.0.0
 * @package ezmultiupload
 */

$Module = array( 'name' => 'eZ Multiupload', 'variable_params' => true );

$ViewList = array();
$ViewList['upload'] = array( 'script' => 'upload.php',
                             'single_post_actions' => array( 'UploadButton' => 'Upload' ),
                             'params' => array( 'ParentNodeID' ) );

?>
