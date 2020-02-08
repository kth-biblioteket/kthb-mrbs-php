<?php
    require_once "config.inc.php";
    global $cas_server;
    session_name($session_name);
    session_start();
    // Unset the session variables
    if (isset($_SESSION))
    {
      $_SESSION = array();
    }
    else
    {
      global $HTTP_SESSION_VARS;
      $HTTP_SESSION_VARS = array();
    }

    if(isset($_REQUEST['authmethod']) && $_REQUEST['authmethod']=='kthcas') {
      header("location: https://$cas_server/logout");
    } else {
      header("location: index.php");
    }
  ?>