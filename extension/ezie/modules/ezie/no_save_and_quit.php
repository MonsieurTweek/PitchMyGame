<?php
/**
 * File containing the ezie no save & quit menu item handler
 *
 * @copyright Copyright (C) 1999-2012 eZ Systems AS. All rights reserved.
 * @license http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
 * @version 1.4.0
 * @package ezie
 */
include_once 'kernel/common/template.php';

$prepare_action = new eZIEImagePreAction();

// @todo Use the cluster handler code

// delete all the images in working directory
// delete working directory
$working_folder = eZDir::dirpath( $prepare_action->getImagePath() );

// deletes the working folder recursively
eZDir::recursiveDelete($working_folder);

// @todo delete the user directory if empty

echo json_encode( new StdClass() );
eZExecution::cleanExit();
?>
