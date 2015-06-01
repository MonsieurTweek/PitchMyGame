<?php
/**
 *
 * Action for feedback
 *
 * @copyright   Maecia
 * @author      Nicolas
 * @version     1.0.0
 * @since       Feedback available since Release 1.0.0
* 
*/

require_once 'lib/ezutils/classes/ezhttptool.php';
require_once 'kernel/common/template.php';

$http = eZHTTPTool::instance();


#require_once 'ezc/Base/base.php';
/*
require 'extension/ezfeedback/modules/feedback/notification/common/classes/db.php';
require 'extension/ezfeedback/modules/feedback/notification/classes/notification.php';
require 'extension/ezfeedback/modules/feedback/notification/classes/mailer.php';
require 'extension/ezfeedback/modules/feedback/notification/config/config.php';
require 'extension/ezfeedback/modules/feedback/notification/config/databases.php';
*/
$module = $Params['Module'];

function endFeedback($err=0, $trad=true)
{
    //redirect to
    $redirectTo = $_SERVER['HTTP_REFERER'];
    if(isset($_POST['RedirectURI']) && !empty($_POST['RedirectURI']))
        $redirectTo = $_POST['RedirectURI'];

    //url suffix
    // if($err) $suffix = '/(err)/'.ezpI18n::tr('extension/ezfeedback', $err);
    // else $suffix = '/(valid)';

    // Champs saisies par l'utilisateur
    $your_name = isset($_POST['your_name']) ? $_POST['your_name'] : '';
    $mail = isset($_POST['mail']) ? $_POST['mail'] : '';
    $object = isset($_POST['object']) ? $_POST['object'] : '';
    $message = isset($_POST['message']) ? $_POST['message'] : '';

    $http = eZHTTPTool::instance();
    if ($err) {
        $http->setSessionVariable('err', ezpI18n::tr('extension/ezfeedback', $err));
        $http->setSessionVariable('your_name', $your_name);
        $http->setSessionVariable('mail', $mail);
        $http->setSessionVariable('object', $object);
        $http->setSessionVariable('message', $message);
    }
    else
        $http->setSessionVariable('valid', 1);

    //redirection
    header('Location: '.$redirectTo.$suffix);

    //exit
    eZExecution::cleanExit();
    return;
}

$infos = array();
foreach ($_POST as $k => $v) {
    $infos[$k] = $v;
}

//current user:
$user = eZUser::currentUser();
$attributesError = array();


if($user->isAnonymous()) {

    if(!isset($_POST['your_name']) || empty($_POST['your_name']))
        $attributesError[] = 'Nom';
    if(!isset($_POST['mail']) || empty($_POST['mail']))
        $attributesError[] = 'E-mail';
    if(!isset($_POST['object']) || empty($_POST['object']))
        $attributesError[] = 'Objet';
    if(!isset($_POST['message']) || empty($_POST['message']))
        $attributesError[] = 'Message';

    if (count($attributesError) != 0)
        endFeedback('Les champs suivants sont manquants : '.implode(', ',$attributesError));

    $infos['name'] = $_POST['your_name'];
    $infos['from'] = $_POST['mail'];
}
else  {

    if(!isset($_POST['object']) || empty($_POST['object']))
        $attributesError[] = 'Objet';
    if(!isset($_POST['message']) || empty($_POST['message']))
        $attributesError[] = 'Message';

    if (count($attributesError) != 0)
        endFeedback('Les champs suivants sont manquants : '.implode(', ',$attributesError));

    $usrObj = eZContentObject::fetch($user->attribute('contentobject_id'));
    $usrDm = $usrObj->DataMap();
    $infos['name'] = $usrDm['first_name']->content().' '.$usrDm['last_name']->content();
    $infos['from'] = $user->attribute('email');
}
$infos['message'] = nl2br($_POST['message']);

$settingsINI = eZINI::instance('settings.ini');
$infos['to'] = $settingsINI->variable('ezfeedback', 'DefaultEmail');
$prefixSubject = $settingsINI->variable('ezfeedback', 'PrefixSubject');
$infos['mail'] = $infos['from'];
$infos['your_name'] = $infos['name'];

//fetch object & objectAttributes
$contactObject = eZContentObject::fetchSameClassList(eZContentObjectTreeNode::classIDByIdentifier('contact_form'));
$contactObjectAttributes = $contactObject[0]->currentVersion()->contentObjectAttributes();

//Nouvelle collection
$collection = eZInformationCollection::create( $contactObject[0]->ID, ezInformationCollection::currentUserIdentifier() );
$collection->store();

//db instance
$db = eZDB::instance();
$db->begin();

//boucle des attributs
foreach($contactObjectAttributes as $contentObjectAttribute){
    $attribute = $contentObjectAttribute->contentClassAttribute();

    if ($attribute->IsInformationCollector){
        if(isset($infos[$attribute->Identifier]))
            $data = $infos[$attribute->Identifier];
        elseif(isset($_POST[$attribute->Identifier]) && !empty($_POST[$attribute->Identifier]))
                $data = $_POST[$attribute->Identifier];
        else
            $data = '';
        $null = null;
        $type = $attribute->attribute('data_type_string').'_';
        if($type == 'eztext_') $type = '';
        if ($type == 'ezselection_')
        {
            $http->setPostVariable('ContentObjectAttribute_ezselect_selected_array_' . $contentObjectAttribute->attribute('id'), array($data));
        }
        else
            $http->setPostVariable('ContentObjectAttribute_'.$type.'data_text_'.$contentObjectAttribute->attribute('id'), $data);
        if ( empty($data) && $contentObjectAttribute->validateIsRequired() ) {
            $contentObjectAttribute->setValidationError( ezpI18n::tr( 'kernel/classes/datatypes','Input required.' ) );
            endFeedback($attribute->name().' '.ezpI18n::tr('extension/ezfeedback', 'est requis.'), false);
        }
        elseif( $contentObjectAttribute->validateInformation($http, 'ContentObjectAttribute', $null) != eZInputValidator::STATE_ACCEPTED ){
            endFeedback($attribute->name().' '.ezpI18n::tr('extension/ezfeedback', 'est invalide.'), false);
        }

        //collect
        $collectionAttribute = eZInformationCollectionAttribute::create($collection->attribute('id')); 
        if( $collectionAttribute && $contentObjectAttribute->collectInformation($collection, $collectionAttribute, $http, 'ContentObjectAttribute') )
            $collectionAttribute->store();
    }
}
$db->commit();
$collection->sync();

// Informations liées à l'objet contact
if ($infos['object'] == 'default' && isset($infos['subject']))
    $infos['object'] = $infos['subject'];
elseif ($infos['object'] != 'default') {
    $infos['object'] = eZContentObjectTreeNode::fetchByContentObjectID($infos['object']);
    if (isset($infos['object'][0])) 
        $infos['object'] = $infos['object'][0];


    $dataMap = $infos['object']->dataMap();
    $infos['object'] = $dataMap['name']->content();
    $infos['to'] = $dataMap['to']->content();
}

// Construction du templates
$infos['message'] = str_replace('<br />', "\n", $infos['message']);
$t = templateInit();
$t->setVariable('infos', $infos);
$userID = false;
if (isset($_POST['userID']))
    $userID = $_POST['userID'];
$t->setVariable('userID', $userID);
$templateResult = $t->fetch('design:mail/contact.tpl');

$receivers = explode(';',$infos['to']);
$receiverElements = array();
for ($i=0; $i < count($receivers); $i++) {
    $receiverElements[] = array('name' => '', 'email' => $receivers[$i]);
}
$receivers = $receiverElements;

$subject = $prefixSubject .' - '. $infos['object'];

$mail = new eZMail();
$mail->setSender($infos['mail'], $infos['name']);
$mail->setReceiverElements($receivers);
$mail->setSubject($subject);
$mail->setBody($templateResult);

$mailResult = eZMailTransport::send($mail);


if ($mailResult)
        endFeedback();
else
        endFeedback('An error occurred on sending email.');
?>

