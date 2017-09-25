<?php

   /**
    *  vkbo.net :: Get BibTeX Entry
    * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    *  Created 2015-12-08 :: File created
    *  Updated 2017-02-04 :: Edited for bibtex only use
    *  Updated 2017-09-25 :: Rewritten for reading bib file directly
    */

    // PHP Settings
    ob_start();      //Enabeling Output Buffer
    session_start(); //Starting Sessions
    require_once "functions.php";

    $sKey = fGet("Key",1,false,"");

    header("Content-Type: text/plain");

    if($sKey != "") {
        $bibTex     = file_get_contents("publications.bib");
        $bibEntries = explode("@",$bibTex);
        foreach($bibEntries as $bibEntry) {
            if(strpos($bibEntry, "{".$sKey.",") !== false) {
                echo "@".$bibEntry."\n";
            }
        }
    } else {
        echo "Nothing";
    }

?>
