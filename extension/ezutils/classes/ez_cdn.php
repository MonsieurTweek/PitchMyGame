<?php
class ezCDNClass {

    public function __construct() {
        return true;
    }

    static public function operatorList() {
        return array_keys(self::namedParameterList());
    }

    static public function namedParameterPerOperator() {
        return true;
    }

    static public function namedParameterList() {
        return array(
            'ezCDN' => array(
                'type' => array(
                    'type' => 'string',
                    'required' => true,
                    'default' => ''
                ),
                'quote_val' => array(
                    'type' => 'string',
                    'required' => false,
                    'default' => 'double'
                )
            )
        );
    }

     public function modify($tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters, $placement) {
    	if(in_array($operatorName, $this->operatorList())) {
            $type = $namedParameters['type'];
            $operatorValue = $this->$operatorName($type, $tpl, $operatorValue, $operatorName);
            
            $quote = '"';
            $val = $namedParameters['quote_val'];
            if($val == 'single')
                $quote = '\'';
            elseif($val == 'no')
                $quote = false;

            $http = eZHTTPTool::instance();

            if(isset($http->UseFullUrl) && $http->UseFullUrl && strncasecmp($operatorValue, '/' , 1 ) === 0) // do not prepend the site path if it's not a http url
                $operatorValue = $http->createRedirectUrl($operatorValue, array('pre_url' => false));

            if ($quote !== false)
                $operatorValue = $quote . $operatorValue . $quote;
        }
    }
    
    public function ezCDN($type, $tpl, $operatorValue, $operatorName) {
        $ini = eZINI::instance('site.ini');

        $iniGroup = 'SiteSettings';
        $iniVariable = 'StaticURL';
        $domain = $ini->hasVariable($iniGroup, $iniVariable) ? $ini->variable($iniGroup, $iniVariable) : '';

        switch($type) {
            case 'image':
            case 'design':
                $callback = 'eZURLOperator::eZ' . ucfirst($type);
                $operatorValue = call_user_func($callback, $tpl, $operatorValue, $operatorName);
            break;
            
            case 'root':
                if(preg_match('#^[a-zA-Z0-9]+:#', $operatorValue) || substr($operatorValue, 0, 2) == '//')
                     break;

                if(strlen($operatorValue) > 0 && $operatorValue[0] != '/')
                    $operatorValue = '/' . $operatorValue;

                // Same as "ezurl" without "index.php" and the siteaccess name in the returned address.
                eZURI::transformURI($operatorValue, true, false);
            break;
        }

        return 'http://' . $domain . $operatorValue;
    }
}

?>
