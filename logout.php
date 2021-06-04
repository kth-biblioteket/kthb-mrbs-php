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

    //kth cas är nu ändrat till openid
    if(isset($_REQUEST['authmethod']) && $_REQUEST['authmethod']=='kthcas') {
      header("location: $kth_auth_endpoint/oauth2/logout");
    } else {
      header("location: index.php");
    }
  ?>