<?php

function outputCSV($data, $delimiter = ',', $enclosure = '"') {
    $outstream = fopen("php://output", 'w');

    foreach($data as $vals)
        fputcsv($outstream, $vals, $delimiter, $enclosure);

    fclose($outstream);
}


$data = $line = array();
$module = $Params['Module'];
$objectID = $Params['ObjectID'];

//fetch object & objectAttributes
$object = eZContentObject::fetch( (int) $objectID );
if( !$object ) return $module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );
$contentObjectAttributes = $object->currentVersion()->contentObjectAttributes();

foreach($contentObjectAttributes as $contentObjectAttribute){
    $attribute = $contentObjectAttribute->contentClassAttribute();

    if($attribute->IsInformationCollector)
        $line[] = $attribute->attribute('name');
}
$data[] = $line;

$contacts = eZInformationCollection::fetchCollectionsList($object->ID);
foreach($contacts as $contact){
    $line = array();
    foreach($contact->dataMap() as $attribute) {
        $objAttr = $attribute->contentObjectAttribute();
        switch( $objAttr->attribute('data_type_string') ){
            case 'ezselection':
                $line[] = $objAttr->dataType()->title($attribute);
            break;
            default:
                $line[] = $attribute->content();
            break;
        }
    }
    $data[] = $line;
}

//Sending mime-type & content
header('Content-Type: text/comma-separated-values; charset=utf-8');
header('Content-Disposition: attachment; filename="contacts-export.csv"');
outputCSV($data, ',', '"');
eZExecution::cleanExit();
?>

