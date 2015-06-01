<?php

    require 'autoload.php';

    // Instance the cli object
    $cli = eZCLI::instance();
    // To have a colorized output
    $cli->setUseStyles(true);

    $script = eZScript::instance( array(    'description' => ('Test Email\n'),
                                            'use-session' => false,
                                            'use-modules' => true,
                                            'use-extensions' => true ) );

    // Options processing
    $options = $script->getOptions(
        '[password:][classes_identifier:][same_password:]',
        '',
        array(
            'password'              => 'New password to set to user, default is webnet',
            'classes_identifier'    => 'User classes to reset, default is licencie',
            'same_password'         => 'To create a new password for account(value != 1) or to give the same password for all account(value = 1). By default value is 1',
        )
    );

    // Mon texte avec retour à la ligne
    $cli->output($cli->stylize( 'green', 'Mon texte avec retour à la ligne' ));
    // Mon texte sans retour à la ligne (false en deuxième argument)
    $cli->output($cli->stylize( 'green', 'Mon texte sans retour à la ligne' ), false);

    $cli->output($cli->stylize('green-bg', '=================================' ));
    $cli->output($cli->stylize('green-bg', '   Parameters and configuration   ' ));
    $cli->output($cli->stylize('green-bg', '=================================' ));
    $cli->output($cli->stylize('green',"New password\t : " . $password));
    $cli->output($cli->stylize('green',"Same password\t : " . $same_password));
    $cli->output($cli->stylize('green',"User classes\t : " . $identifier));
    $cli->output($cli->stylize('green',"user count\t : " . $count));
    $cli->output($cli->stylize('green-bg', '================================='));
    $cli->output($cli->stylize('cyan', "\n" . 'Check parameters before launch the script.' ));
    $cli->output($cli->stylize('green', "\n" . 'Continue [Y/n] ?'));
    $choix = trim(fgets(STDIN));
    if($choix != "Y") {
        $cli->error('Script abort.');
    }

    $pos_store =  $cli->storePosition();
    $pos_restore =  $cli->restorePosition();

    $cli->output( $pos_store . $cli->stylize('green', 'New password for ' . $user->Login . " \t" . $i . "/" . $count) . $pos_restore, false);

    $script->shutdown(); 
