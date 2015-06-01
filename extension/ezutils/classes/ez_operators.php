<?php

class ezOperators {
    static public function operatorList() {
        return array_keys(self::namedParameterList());
    }

    static public function namedParameterPerOperator() {
        return true;
    }

    static public function namedParameterList() {
        return array(
            'hasRole' => array(
                'roleName' => array(
                    'type' => 'string',
                    'required' => false,
                    'default' => ''
                ),
                'userID' => array(
                    'type' => 'integer',
                    'required' => false,
                    'default' => 0
                )
            ),
			'nofollow' => array(
                'first_param' => array(
                    'type' => 'string',
                    'required' => false,
                    'default' => 'default text'
                ),
                'second_param' => array(
                    'type' => 'integer',
                    'required' => false,
                    'default' => 0
                )
            ),
            'redirectURL' => array(),
            'redirect301' => array(),
            'redirect401' => array(),
            'strip_tags' => array(
                'allowable_tags' => array(
                    'type' => 'string',
                    'required' => false,
                    'default' => ''
                )
            ),

            /**
              * http://smarty.net/manual/en/language.modifier.truncate.php
              * This truncates a variable to a character length, the default is 80.
              * As an optional second parameter, you can specify a string of text to display at the end if the variable was truncated. The characters in the string are included with the original truncation length.
              * By default, truncate will attempt to cut off at a word boundary. If you want to cut off at the exact character length, pass the optional third parameter of TRUE.
              */
            'truncate' => array(
                'length' => array(
                    'type' => 'integer',
                    'required' => false,
                    'default' => '80'
                ),
                'etc' => array(
                    'type' => 'string',
                    'required' => false,
                    'default' => '...'
                ),
                'break_words' => array(
                    'type' => 'boolean',
                    'required' => false,
                    'default' => false
                ),
                'middle' => array(
                    'type' => 'boolean',
                    'required' => false,
                    'default' => false
                )
            )
        );
    }

    function modify($tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters, $placement) {
        switch($operatorName) {
           case 'hasRole':
                $role = eZRole::fetchByName($namedParameters['roleName']);
                if( $role == NULL )
                    $operatorValue = false;
                else {
                    if ($namedParameters['userID'])
                        $user = eZUser::fetch($namedParameters['userID']);
                    else
                        $user = eZUser::currentUser();
                    $rolesID = $user->roleIDList();

                    if (in_array($role->attribute('id'), $rolesID))
                        $operatorValue = true;
                    else
                        $operatorValue = false;
                }
                
		   break;
		   case 'nofollow':
                preg_match('/<a.* (title="[^"]*")/Uis', $operatorValue, $m);
                $title = isset($m[1]) ? $m[1] : '';
                unset($m);

                preg_match('/<a.* (href="[^"]*")/Uis', $operatorValue, $m);
                $href = isset($m[1]) ? $m[1] : '';
                unset($m);

                $operatorValue= preg_replace('/<a[^>]*>/', '<a ' . $href . ' ' . $title . ' rel="nofollow">', $operatorValue);
            break;

            case 'redirectURL':
                $operatorValue = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '/';
            break;

            case 'redirect301':
                header('HTTP/1.1 301 Moved Permanently');
                header('Location: '.$operatorValue);
                eZExecution::cleanExit();
            break;

            case 'redirect401':
                header('HTTP/1.1 401 Unauthorized');
                header('Location: '.$operatorValue);
                eZExecution::cleanExit();
            break;

            case 'strip_tags':
                $allowable_tags = $namedParameters['allowable_tags'];
                $operatorValue = strip_tags($operatorValue, $allowable_tags);
            break;

            case 'truncate':
                $length = $namedParameters['length'];
                $etc = $namedParameters['etc'];
                $break_words = $namedParameters['break_words'];
                $middle = $namedParameters['middle'];
                
                $string = $operatorValue;
                $operatorValue = ezOperators::truncate($string, $length, $etc, $break_words, $middle);


            break;
        }
    }
    
    public static function truncate($string, $length = 80, $etc = '...', $break_words = false, $middle = false) {
        if ($length == 0) {
            return '';
        }

        if (strlen($string) > $length) {
            if(mb_detect_encoding($string) == 'UTF-8')
                $string = html_entity_decode(utf8_decode(htmlentities($string)));

            $length -= min($length, strlen($etc));

            if (!$break_words && !$middle) {
                $string = preg_replace('/\s+?(\S+)?$/', '', substr($string, 0, $length + 1));
            }

            if(!$middle) {
                $string = substr($string, 0, $length) . $etc;
            } else {
                $string = substr($string, 0, $length / 2) . $etc . substr($string, -$length/2);
            }
            
        }
        return $string;
    }
}
?>
