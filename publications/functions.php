<?php

   /**
    *  vkbo.net :: Functions
    * =======================
    *  Created 2015-08-18 :: Rewritten
    *  Updated 2015-08-19 :: Added hits count
    *  Updated 2017-02-04 :: Stripped down for bibtex only use
    */

    // $_POST
    function fPost($sVar, $vDefault) {
        if(array_key_exists($sVar, $_POST)) {
            $vData = $_POST[$sVar];
            //~ $vData = str_replace("'",     "", $vData);
            $vData = str_replace(";",     "", $vData);
            $vData = str_replace(chr(34), "", $vData);
            return $vData;
        } else {
            return $vDefault;
        }
    }

    // $_GET
    function fGet($sVar, $iType, $bMeta, $vDefault) {
        if(array_key_exists($sVar, $_GET)) {
            $vData = $_GET[$sVar];
            if($iType == 0) { // Number
                if(is_numeric($vData)) {
                    return $vData;
                } else {
                    return $vDefault;
                }
            } elseif($iType == 1) { // String
                if(is_string($vData)) {
                    $vMeta = htmlentities($vData, ENT_QUOTES);
                    if($bMeta == true) {
                        return $vMeta;
                    } else {
                        if(strlen($vMeta) > strlen($vData)) {
                            return $vDefault;
                        } else {
                            return $vData;
                        }
                    }
                } else {
                    return $vDefault;
                }
            }
        } else {
            return $vDefault;
        }
    }

?>
