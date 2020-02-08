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
switch ($default_view)
{
  case "month":
    $redirect_str = "month.php";
    break;
  case "week":
    $redirect_str = "week.php";
    break;
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

header("Location: $redirect_str");

