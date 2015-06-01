<?php

/**
 * eZJSON class impelement json tpl operator methods
 * 
 */
class eZJSON
{
    /**
     * Constructor
     * 
     */
    function __construct()
    {
    }

    /**
     * Return an array with the template operator name.
     * 
     * @return array
     */
    public function operatorList()
    {
        return array( 'json' );
    }

    /**
     * Return true to tell the template engine that the parameter list exists per operator type,
     * this is needed for operator classes that have multiple operators.
     * 
     * @return bool
     */
    function namedParameterPerOperator()
    {
        return false;
    }

    /**
     * Returns an array of named parameters, this allows for easier retrieval
     * of operator parameters. This also requires the function modify() has an extra
     * parameter called $namedParameters.
     * 
     * @return array
     */
    public function namedParameterList()
    {
        return array();
    }

    /**
     * Executes the PHP function for the operator cleanup and modifies $operatorValue.
     * 
     * @param eZTemplate $tpl
     * @param string $operatorName
     * @param array $operatorParameters
     * @param string $rootNamespace
     * @param string $currentNamespace
     * @param mixed $operatorValue
     * @param array $namedParameters
     */
    public function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters )
    {
        switch ( $operatorName )
        {
            case 'json':
            {
                $operatorValue = eZModuleAjaxContent::jsonEncode( $operatorValue );
            } break;
        }
    }
}

?>