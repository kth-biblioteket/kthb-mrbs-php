<?php
// $Id$



require "defaultincludes.inc";
require_once "mincals.inc";
require_once "functions_table.inc";

// Get non-standard form variables
$timetohighlight = get_form_var('timetohighlight', 'int');
$ajax = get_form_var('ajax', 'int');
$ajaxuser = get_form_var('user', 'string');
//KTH
$times_along_top = get_times_along_top($area); //KTH
unset($periods);
get_periods($area,$periods);

$inner_html = day_table_innerhtml($day, $month, $year, $room, $area, $timetohighlight, $_SESSION["UserName"] );

if ($ajax)
{
  if (checkAuthorised(TRUE))
  {
    //191003
    //logga ut vid expire
    global $auth;
    if($auth['ajaxlogout'] == "TRUE" && isset($_SESSION['UserName']) && $_SESSION['UserName'] != ''){
      echo "ajaxlogout";
    } else {
      echo $inner_html;
    }
  }
  exit;
}

// Check the user is authorised for this page
checkAuthorised();

// Form the room parameter for use in query strings.    We want to preserve room information
// if possible when switching between views
$room_param = (empty($room)) ? "" : "&amp;room=$room";

$timestamp = mktime(12, 0, 0, $month, $day, $year);

// print the page header
print_header($day, $month, $year, $area, isset($room) ? $room : "");

// Section with areas, rooms, minicals.

echo "<div id=\"dwm_header\" class=\"screenonly\">\n";

// Show all available areas
//KTH visa bara länkar för de som har hide_links = 0
if(get_hide_links($area)) {

} else {
	echo make_area_select_html('day.php', $area, $year, $month, $day);
}

// Draw the three month calendars
if (!$display_calendar_bottom)
{
  //KTH visa inte kalendrar
  //minicals($year, $month, $day, $area, $room, 'day');
}

echo "</div>\n";

//KTH Extra info
$extra_info = "";
$extra_info = get_area_extra_info($area,$lang);
if ($extra_info != "") {
	echo "<div id=\"extrainfo\" style=\"\">" . $extra_info ."</div>";
}

//KTH Modal box
//191003
get_area_settings($area);
echo "<div style=\"padding-bottom:10px\">";
print_modal($area,$lang,$area_map,$area_map_image);
//200309 visa länk till nästa lediga bokning om bokningar är stängda som default
$nextavailable = "";
if (!$default_bookings_open) {
  $next_start_time = get_next_available_start_time($room,date('Y-m-d'));
  if ($next_start_time) {
    $nextavailable = "
    <div style=\"text-align:right\">
      <a class=\"btn btn-primary\" style=\"background-color: #d85497; color: #fff; border-color: #d85497\" href=\"day.php?year=" . date("Y",$next_start_time). 
            "&amp;month=". date("m",$next_start_time) . 
            "&amp;day=" .date("d",$next_start_time) . 
            "&amp;area=$area&amp;room=$room\">"
            .get_vocab("nextavailable").
          "</a>
    </div>\n";
  }
}
echo $nextavailable;
echo "</div>";
//y? are year, month and day of yesterday
//t? are year, month and day of tomorrow

// find the last non-hidden day
$d = $day;
do
{  
  $d--;
  $i= mktime(12,0,0,$month,$d,$year);
}
while (is_hidden_day(date("w", $i)) && ($d > $day - 7));  // break the loop if all days are hidden
$yy = date("Y",$i);
$ym = date("m",$i);
$yd = date("d",$i);

// find the next non-hidden day
$d = $day;
do
{
  $d++;
  $i= mktime(12, 0, 0, $month, $d, $year);
}
while (is_hidden_day(date("w", $i)) && ($d < $day + 7));  // break the loop if all days are hidden
$ty = date("Y",$i);
$tm = date("m",$i);
$td = date("d",$i);



// Show current date and timezone
echo "<div id=\"dwm\">\n";
//KTH Visa areanamn
//if(get_hide_links($area)) {
	//echo "<h2>" . get_area_name($area) . "<h2>";
	//echo "<h2> <h2>";
//}
//echo "<h2>" . utf8_strftime($strftime_format['date'], $timestamp) . "</h2>\n";

//KTH Dateselector
echo "<form style=\"\" action=\"day.php\" method=\"get\" id=\"Form1\">";
echo "<div>";
// Give the form id as the optional fifth parameter because we want
// the form to be automatically submitted when the datepicker is closed
genDateSelector("", $day, $month, $year, "Form1");
if (!empty($area))
{
  echo "<input type=\"hidden\" name=\"area\" value=\"$area\">\n";
}
if (!empty($room))
{
  echo "<input type=\"hidden\" name=\"room\" value=\"$room\">\n";
}
// Although the datepicker will automatically go to the new date when
// the date is changed, we still need a submit button because there
// are occasions when you want to go to the date without changing it -
// for example when you've been on a Search or Report page
//echo "<input type=\"submit\" value=\"" . get_vocab("goto") . "\">\n";
echo   "</div>";
echo "</form>";

if ($display_timezone)
{
  echo "<div class=\"timezone\">";
  echo get_vocab("timezone") . ": " . date('T', $timestamp) . " (UTC" . date('O', $timestamp) . ")";
  echo "</div>\n";
}
echo "</div>\n";
  
// Generate Go to day before and after links
// KTH
$before_after_links_html = "
<div class=\"before_after_links\">
  <div class=\"date_nav\">
    <div class=\"date_before\">
      <a href=\"day.php?year=$yy&amp;month=$ym&amp;day=$yd&amp;area=$area$room_param\">
	  <img src=\"images/arrow-left-white-bold.png\" alt=\"Föregående dag\"> " . get_vocab("daybefore") . "</a>
    </div>
    <div class=\"date_now\">
      <a href=\"day.php?area=$area$room_param\">" . get_vocab("gototoday") . "</a>
    </div>
    <div class=\"date_after\">
      <a href=\"day.php?year=$ty&amp;month=$tm&amp;day=$td&amp;area=$area$room_param\">" . get_vocab("dayafter") . " <img src=\"images/arrow-right-white-bold.png\" alt=\"Föregående dag\">
      </a>
    </div>
  </div>
</div>\n";

// and output them
echo $before_after_links_html;

echo "<table class=\"dwm_main\" id=\"day_main\" data-resolution=\"$resolution\">\n";
echo $inner_html;
echo "</table>\n";
 
//KTH
//Rita upp egna färgkodningsnycklar
//show_colour_key();
show_colour_key_KTH();
// Draw the three month calendars
if ($display_calendar_bottom)
{
  //KTH
  //Visa inte kalendrar
  //minicals($year, $month, $day, $area, $room, 'day');
}
echo "</div>\n"; // Slut contents
echo "</div>\n"; //Slut contentwrapper
// Print footer
print_footer(FALSE);

//KTH Hämta språk
if(isset($_COOKIE["mrbslang"])) {
	if(isset($mrbslang)) {
		$lang = $mrbslang;
	} else {
		$lang = $_COOKIE["mrbslang"];
	}
}
