<?php
$eZTemplateOperatorArray = array();
$eZTemplateOperatorArray[] = array(
    'script' => 'extension/ezutils/classes/ez_cdn.php',
    'class' => 'ezCDNClass',
    'operator_names' => ezCDNClass::operatorList()
);
$eZTemplateOperatorArray[] = array(
    'script' => 'extension/ezutils/classes/ez_video.php',
    'class' => 'ezVideo',
    'operator_names' => ezVideo::operatorList()
);
$eZTemplateOperatorArray[] = array(
    'script' => 'extension/ezutils/classes/ez_operators.php',
    'class' => 'ezOperators',
    'operator_names' => ezOperators::operatorList()
);
?>
