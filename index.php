<?php

// $Id$

// Index is just a stub to redirect to the appropriate view
// as defined in config.inc.php using the variable $default_view
// If $default_room is defined in config.inc.php then this will
// be used to redirect to a particular room.

require "defaultincludes.inc";
require_once "mrbs_sql.inc";
$area = get_default_area();
$default_view = get_default_view($area); //KTH

if($environment == 'development') {
  error_log("default_view: " . $default_view);
}

switch ($default_view)
{
  case 2:
    $redirect_str = "month.php";
    break;
  case 1:
    $redirect_str = "week.php";
    break;
  case 0:
    $redirect_str = "day.php";
    break;
  default:
    $redirect_str = "day.php";
}
//echo $redirect_str;
$redirect_str .= "?year=$year&month=$month&day=$day&area=$area&room=$room";

if($environment == 'development') {
  error_log("redirect_str: " . $redirect_str);
}
header("Location: $redirect_str");

