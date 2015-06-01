<?php
class ezVideo {

    static public function operatorList() {
        return array_keys(self::namedParameterList());
    }

    static public function namedParameterPerOperator() {
        return true;
    }

    static public function namedParameterList() {
        return array(
            'ezVideo' => array(
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
            $operatorValue = $this->$operatorName($tpl, $operatorValue, $operatorName);
            
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
    
    /*
    http://www.youtube.com/watch?v=prvEyPaNzGo&feature=popular
    http://www.dailymotion.com/user/franceinter/video/x9zc6m_france-inter-retour-sur-le-malaise_news?hmz=7461626d656d626572
    http://www.youtube.com/v/prvEyPaNzGo
    http://www.dailymotion.com/swf/x9ywp5
    */
    public function ezVideo($tpl, $operatorValue, $operatorName) {
        //@bug, il ne devrait pas y avoir de $m[2] = '' quand le domaine est dailymotion
        preg_match('#^http://www\.(youtube|dailymotion)\.com/(?:(?:watch\?v=([a-zA-Z0-9]+))|(?:.+video/([^_]+)))#', $operatorValue, $m);
        if($m[1] === 'youtube') {
            return 'http://www.youtube.com/v/' . $m[2];
        }
        elseif($m[1] === 'dailymotion') {
            return 'http://www.dailymotion.com/swf/' . $m[3];
        }
        
        return $operatorValue;
    }
}
?>