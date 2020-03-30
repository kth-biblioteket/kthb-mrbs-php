<?php 

// $Id$

require_once "../systemdefaults.inc.php";
require_once "../config.inc.php";
require_once "../functions.inc";
require_once "../theme.inc";

header("Content-type: text/css"); 
expires_header(60*30); // 30 minute expiry
                                
// IMPORTANT *************************************************************************************************
// In order to avoid problems in locales where the decimal point is represented as a comma, it is important to
//   (1) specify all PHP length variables as strings, eg $border_width = '1.5'; and not $border_width = 1.5;
//   (2) convert PHP variables after arithmetic using number_format
// ***********************************************************************************************************
                                
?>


/* ------------ GENERAL -----------------------------*/
/* 191003 */
body {
  margin-top: 0 !important;
  font-size: small;
  margin: 0;
  padding: 0;
  color:            <?php echo $standard_font_color ?>;
  font-family:      <?php echo $standard_font_family ?>;
  background-color: <?php echo $body_background_color ?>;
  line-height: normal !important;
}

.current {color: <?php echo $highlight_font_color ?>}                        /* used to highlight the current item */
.error   {color: <?php echo $highlight_font_color ?>; font-weight: bold}     /* for error messages */
.warning {color: <?php echo $highlight_font_color ?>}                        /* for warning messages */
.note    {font-style: italic}

/* KTH 191003 */
div#contents, div.trailer {
  float: left;
  width: 100%;
  box-sizing: border-box;
  padding: 0;
}
/* 191003 */
h1 {font-size: 2.75rem; font-weight: 600; clear: both}
h2 {font-size: large; clear: both;color: #8b9f22;} /* KTH-gröna h2-rubriker */

img {border: 0}

a:link    {color: <?php echo $anchor_link_color ?>;    text-decoration: none; font-weight: inherit}
a:visited {color: <?php echo $anchor_visited_color ?>; text-decoration: none; font-weight: inherit}
a:hover   {color: <?php echo $anchor_hover_color ?>;   text-decoration: underline; font-weight: inherit} 

/* 191003 ändra till bara vitt(via styling.inc)*/
tr.even_row td.new {background-color: <?php echo $row_even_color ?>}
tr.odd_row td.new {background-color: <?php echo $row_odd_color ?>}

td, th {vertical-align: top}

td form {margin: 0}     /* Prevent IE from displaying margins around forms in tables. */

legend {font-weight: bold; font-size: large;
    font-family: <?php echo $standard_font_family ?>;
    color: <?php echo $standard_font_color ?>}
fieldset {margin: 0; padding: 0; border: 0; 
    border-radius: 8px;
    -moz-border-radius: 8px;
    -webkit-border-radius: 8px}
fieldset.admin {width: 100%; padding: 0 1.0em 1.0em 1.0em;
    border: 1px solid <?php echo $admin_table_border_color ?>}
fieldset fieldset {position: relative; clear: left; width: 100%; padding: 0; border: 0; margin: 0}  /* inner fieldsets are invisible */
fieldset fieldset legend {font-size: 0}        /* for IE: even if there is no legend text, IE allocates space  */

<?php
// DataTables don't work well with border-collapse: collapse and scrollX: 100%.   In fact they
// don't work well either with a border round the table.   So we put the left and right borders
// on the table cells.
?>


table.admin_table {
  border-collapse: separate;
  border-spacing: 0;
  border-color: <?php echo $admin_table_border_color ?>;
}

.admin_table th, .admin_table td,
table.dataTable thead th, table.dataTable thead td,
table.dataTable tbody th, table.dataTable tbody td {
  box-sizing: border-box;
  vertical-align: middle;
  text-align: left;
  padding: 0.1em 24px 0.1em 0.6em;
  border-style: solid;
  border-width: 0 1px 0 0;
}

.admin_table th:first-child, .admin_table td:first-child,
table.dataTable thead th:first-child, table.dataTable thead td:first-child {
  border-left-width: 1px;
}

.admin_table td, .admin_table th,
table.dataTable thead th, table.dataTable thead td {
  border-color: <?php echo $admin_table_border_color ?>;
}

.admin_table th:first-child,
table.dataTable thead th:first-child, table.dataTable thead td:first-child {
  border-left-color: <?php echo $admin_table_header_back_color ?>
}

.admin_table th:last-child {
  border-right-color: <?php echo $admin_table_header_back_color ?>
}

.admin_table.DTFC_Cloned th:last-child {
  border-right-color: <?php echo $admin_table_border_color ?>
}

.admin_table th,
table.dataTable thead .sorting,
table.dataTable thead .sorting_asc,
table.dataTable thead .sorting_desc {
  color: <?php echo $admin_table_header_font_color ?>; 
  background-color: <?php echo $admin_table_header_back_color ?>
}

.admin_table td.action {
  text-align: center
}

/* 191003 */
th {
    text-align: center
}

.admin_table td.action div {
  display: inline-block
}

.admin_table td.action div div {
  display: table-cell
}

table.display {
  width: 100%;
}

table.display tbody tr:nth-child(2n) {
  background-color: white;
}

table.display tbody tr:nth-child(2n+1) {
  background-color: #E2E4FF;
}

table.display th, table.display td {
  height: 2em;
  white-space: nowrap;
  overflow: hidden;
}

table.display th {
  padding: 3px 24px 3px 8px;
}

table.display span {
  display: none;
}

table.display span.normal {
  display: inline;
}

select.room_area_select {margin-right: 0.5em}

<?php
// Don't display anything with a class of js_none (used for example for hiding Submit
// buttons when we're submitting onchange).  The .js class is added to the <body> by JavaScript
?>
.js .js_none {display: none}
.js .js_hidden {visibility: hidden}

/* ------------ ADMIN.PHP ---------------------------*/
<?php
// Adjust the label width to suit the longest label - it will depend on the translation being used
// The input width can normally be left alone
$admin_form_label_width       = '7.0';   // em
$admin_form_gap               = '1.0';   // em
$admin_form_input_width       = '10.5';   // em   (Also used in edit_area_room.php)

?>
form.form_admin {float: left; clear: left; margin: 2em 0 0 0}
.form_admin fieldset {float: left; width: auto; border: 1px solid <?php echo $admin_table_border_color ?>; padding: 1em}
.form_admin legend {font-size: small}
.form_admin div {float: left; clear: left} 
.form_admin label {
    display: block; float: left; clear: left; 
    width: <?php echo $admin_form_label_width ?>em; min-height: 2.0em; text-align: right;
}
.form_admin input {
    display: block; float: left; clear: right;
    width: <?php echo $admin_form_input_width ?>em;
    margin-top: -0.2em; margin-left: <?php echo $admin_form_gap ?>em;
    font-family: <?php echo $standard_font_family ?>; font-size: small;
}
.form_admin input.submit {
    width: auto; margin-top: 1.2em; margin-left: <?php echo number_format(($admin_form_gap + $admin_form_label_width), 1, '.', '')?>em
}
.admin h2 {clear: left}
div#area_form, div#room_form {float: left; padding: 0 0 2em 0}
div#area_form {width: auto}
div#room_form {width: 100%}
div#custom_html {float: left; padding: 0 0 3em 1em}
#area_form form {float: left; margin-right: 1em}
#area_form label#area_label {display: block; float: left; font-weight: bold; margin-right: <?php echo $admin_form_gap ?>em}
#roomChangeForm select, #areaChangeForm select {display: block; float: left; margin: -0.1em 1.5em 0 0}
#roomChangeForm input, #areaChangeForm input {float: left; margin: -0.2em 0.5em 0 0}
#roomChangeForm input.button, #areaChangeForm input.button {display: block; float: left; margin: 0 0.7em}

div.header_columns, div.body_columns {position: relative; float: left; overflow-x: scroll; overflow-y: hidden}
div.header_columns {max-width: 20%}
div.body_columns {max-width: 80%}

.body_columns .admin_table th:first-child {border-left-color: <?php echo $admin_table_border_color ?>}


/* ------------ DAY/WEEK/MONTH.PHP ------------------*/

<?php
$column_hidden_width  = 0;       // (%) width of the column for hidden days (set to 0 for no column at all; 1 for a narrow column);
                                 //     when $times_along_top is TRUE, hidden days (rows) are not shown at all
$column_row_labels_width   = 1;  // (%) width of the row label columns (will expand if necessary)
$n_hidden_days = count($hidden_days);

// month view:  work out what percentage of the width is available to
// normal columns (ie columns that are not hidden)
$column_month = 100 - ($column_hidden_width *  $n_hidden_days);
if ($n_hidden_days < 7)                                  // (avoid the div by zero)
{
  $column_month = $column_month/(7 - $n_hidden_days);      // divide what's left between the number of days to display
}
$column_month = number_format($column_month, 1, '.', '');  // (%) tidy the number up and make sure it's valid for CSS (no commas)

?>
/*KTH få plats med extrainfo*/
div#dwm_header {width: 70%; float: none; margin-top: 1.0em; margin-bottom: 0.5em}
/* 191003 */
div#dwm_header.screenonly {width: 100%; float: none; 
margin-top: 0em; 
margin-bottom: 0em}
div#dwm_areas, div#dwm_rooms  {float: left; margin-right: 2.0em}
/* KTH Blå på rubrik-länkar*/
div#dwm_areas a, div#dwm_rooms a, div#more_info a {color: #24a0d8; font-weight: normal;text-decoration: none;}
#dwm_header h3 {font-size: small; font-weight: normal; text-decoration: underline; 
    margin-top: 0; margin-bottom: 0.5em; padding-bottom: 0}
#dwm_header ul {list-style-type: none; padding-left: 0; margin-left: 0; margin-top: 0; overflow: auto;}
/* KTH margin och float left på rum och areas i header*/
#dwm_header li {
  padding-left: 0; 
  margin-left: 0; 
  margin-right: 10px;
  margin-bottom: 10px;
  float:left;
  font-family: <?php echo $standard_font_family ?>
}

div#dwm {
	margin-bottom: 0.5em;
	float: left;
    width: 100%;
}
#dwm {text-align: center}
#dwm h2 {margin-bottom: 0}
#dwm div.timezone {opacity: 0.8}
/* KTH */
div.date_nav    {1float: left;  1width: 100%; 1margin-top: 0.5em; 1margin-bottom: 0.5em; font-weight: bold}
div.date_before {float: left;  width: 33%; text-align: left}
div.date_now    {float: left;  width: 33%; text-align: center}
div.date_after  {float: right; width: 33%; text-align: right}

table.dwm_main {
  float: left;
  clear: both; 
  width: 100%; 
  border-spacing: 0;
  border-collapse: separate;
  border-color: <?php echo $main_table_border_color ?>;
  border-width: <?php echo $main_table_border_width ?>px;
  border-style: solid
}

.dwm_main td {
	/* KTH 1 */
	word-break: break-all;
	word-break: break-word;
	padding: 0;
    border-top:  <?php echo $main_table_cell_border_width ?>px solid <?php echo $main_table_body_h_border_color ?>;
    border-left: <?php echo $main_table_cell_border_width ?>px solid <?php echo $main_table_body_v_border_color ?>;
    border-bottom: 0;
    border-right: 0
}

.dwm_main td:first-child {border-left: 0}
<?php
// Note that it is important to have zero padding-left and padding-top on the th cells and the celldiv divs.
// These elements are used to calculate the offset top and left of the position of bookings in
// the grid when using resizable bookings.   jQuery.offset() measures to the content.  If you
// need padding put it on the contained element.
?>
.dwm_main th {
	/* KTH 191003*/
	1word-break: break-all;
	font-size: small; font-weight: normal; vertical-align: top; padding: 0 2px;
    color: <?php echo $header_font_color ?>; 
    background-color: <?php echo $header_back_color ?>;
    border-left: <?php echo $main_table_cell_border_width ?>px solid <?php echo $main_table_header_border_color ?>;
    border-bottom: 0px;
    border-right: 0px;
}
  
.dwm_main th.first_last, .dwm_main th span {padding: 0 2px}
.dwm_main th:first-child {
  border-left: 0;
  border: 0px !important;
  }
.dwm_main a {display: block; min-height: inherit}
.dwm_main tbody a {padding: 0 2px}
.dwm_main th a:link    {color: <?php echo $anchor_link_color_header ?>;    text-decoration: none; font-weight: normal}
.dwm_main th a:visited {color: <?php echo $anchor_visited_color_header ?>; text-decoration: none; font-weight: normal}
.dwm_main th a:hover   {color: <?php echo $anchor_hover_color_header ?>;   text-decoration:underline; font-weight: normal}
/* KTH dagens datum till annan färg*/
.dwm_main th.today {background-color: #1954A6;}

.dwm_main#week_main th.first_last {vertical-align: bottom}
/* KTH */
.dwm_main td.invalid {background-color: <?php echo $main_table_slot_invalid_color ?> ;}
.dwm_main#month_main th {width: <?php echo $column_month ?>%}
.dwm_main#month_main td {
  border-top:  <?php echo $main_table_cell_border_width ?>px solid <?php echo $main_table_body_v_border_color ?>;
  border: 0 !important;
  }
.dwm_main#month_main td.valid   {background-color: <?php echo $main_table_month_color ?>}
.dwm_main#month_main td.invalid {background-color: <?php echo $main_table_month_invalid_color ?>}
.dwm_main#month_main a {height: 100%; width: 100%; padding: 0 2px 0 2px}

td.new a, a.new_booking {display: block; font-size: medium; text-align: center}
td.new img, .new_booking img {margin: auto; padding: 4px 0 2px 0}
img.repeat_symbol {float: right; padding: 3px}
.dwm_main#month_main img.repeat_symbol {padding: 2px}


<?php
// The following section deals with the contents of the table cells in the month view.    It is designed
// to ensure that the new booking link is active anywhere in the cell that there isn't another link, for 
// example the link to the day in question at the top left and the bookings themselves.   It works by using
// z-index levels and placing the new booking link at the bottom of the pile.
//
// [There is in fact one area where the new booking link is not active and that is to the right of the last
// booking when there is an odd number of bookings and the mode is 'slot' or 'description' (ie not 'both').
// This is because the list of bookings is in a div of its own which includes that bottom right hand corner.   One
// could do without the container div, and then you could solve the problem, but the container div is there to
// allow the bookings to scroll without moving the date and new booking space at the top of the cell.   Putting up
// with the small gap at the end of odd rows is probably a small price worth paying to ensure that the date and the 
// new booking link remain visible when you scroll.]
?>
div.cell_container {position: relative; float: left; width: 100%;        /* the containing div for a.new_booking */ 
<?php echo ($month_cell_scrolling ? 'height:' : 'min-height:') ?> 100px} /* NOTE:  if you change the value of (min-)height, make sure you */
                                                                         /* also change the value of height in mrbs-ielte6.css */
.month a.new_booking {position: absolute; top: 0; left: 0; z-index: 10}  /* needs to be above the base, but below the date (monthday) */
       
div.cell_header {position: relative; width: 100%; z-index: 20;         /* needs to be above the new booking anchor */
     min-height: 20%; height: 20%; max-height: 20%; overflow: hidden}

#month_main div.cell_header a {display: block; width: auto; float: left}                                                                               
#month_main div.cell_header a.monthday {font-size: medium}  /* the date in the top left corner */
#month_main div.cell_header a.week_number {opacity: 0.5; padding: 2px 4px 0 4px}

div.booking_list {position: relative; z-index: 20;                      /* contains the list of bookings */
    max-height: 80%; font-size: x-small;                                /* needs to be above new_booking */
    overflow: <?php echo ($month_cell_scrolling ? 'auto' : 'visible') ?>}
.booking_list a {font-size: x-small}


<?php
// Generate the classes to give the colour coding by booking type in the day/week/month views
foreach ($color_types as $type => $col)
{
  echo "td.$type {background-color: $col}\n";         // used in the day and week views
  if( $clipped_month )
    echo ".month div.$type {float: left; max-height: 1.3em; height: 1.3em; min-height: 1.3em; overflow: hidden; background-color: $col}\n";   // used in the month viewa
  else
    echo ".month div.$type {float: left; min-height: 1.3em; overflow: hidden; background-color: $col}\n";   // used in the month view
}

?>

/* For floating header in the day and week views */

.floatingHeader {
  position: fixed;
  top: 0;
  z-index: 2000;
  display: none;
}

.dwm_main#month_main th.hidden_day     
    {width: <?php echo $column_hidden_width ?>%; 
    <?php 
      echo (empty($column_hidden_width) ? " display: none" : ""); // if the width is set to zero, then don't display anything at all
    ?>
    }
td.hidden_day     {background-color: <?php echo $column_hidden_color ?>; /* hidden columns (eg weekends) in the week and month views */
    font-size: medium; font-weight: bold;
    border-top: <?php echo $main_table_cell_border_width ?>px solid <?php echo $column_hidden_color ?>;
    <?php 
      echo (empty($column_hidden_width) ? " display: none" : ""); // if the width is set to zero, then don't display anything at all
    ?>
    }
tr.row_highlight td.new {background-color: <?php echo $row_highlight_color ?>} /* used for highlighting a row */
.dwm_main td.row_labels     {background-color: <?php echo $main_table_labels_back_color ?>; white-space: nowrap}    /* used for the row labels column */
.row_labels a:link    {color: <?php echo $anchor_link_color_header ?>;    text-decoration: none; font-weight: normal}
.row_labels a:visited {color: <?php echo $anchor_visited_color_header ?>; text-decoration: none; font-weight: normal}
.row_labels a:hover   {color: <?php echo $anchor_hover_color_header ?>;   text-decoration: underline; font-weight: normal}

<?php
// HIGHLIGHTING:  Set styles for the highlighted cells under the cursor (the time/period cell and the current cell)

// The *hover classes are applied by JavaScript when running IE6 because IE6 does
// not support the :hover pseudo class on anything other than an anchor.
?>
.dwm_main td:hover.new, .dwm_main td.new_hover {background-color: <?php echo $row_highlight_color ?>}
.dwm_main tr:hover td.row_labels, .dwm_main td.row_labels_hover {background-color: <?php echo $row_highlight_color ?>; color: <?php echo $standard_font_color ?>}
.dwm_main#month_main td:hover.valid, .dwm_main#month_main td.valid_hover {background-color: <?php echo $row_highlight_color ?>}
<?php
// would be nicer to use color: inherit in the four rules below, but inherit is not supported by IE until IE8.   
// inherit would mean that (1) you didn't have to specify the colour again and (2) you needn't use the tbody selector to
// stop the header links changing colour.
?>

.dwm_main tbody tr:hover a:link,    td.row_labels_hover a:link    {color: <?php echo $anchor_link_color ?>}
.dwm_main tbody tr:hover a:visited, td.row_labels_hover a:visited {color: <?php echo $anchor_link_color ?>}
<?php // Disable the highlighting when we're in resize mode ?>
.resizing .dwm_main tr.even_row td:hover.new {background-color: <?php echo $row_even_color ?>}
.resizing .dwm_main tr.odd_row td:hover.new {background-color: <?php echo $row_odd_color ?>}
.resizing .dwm_main tr:hover td.row_labels {background-color: <?php echo $main_table_labels_back_color ?>; color: <?php echo $anchor_link_color_header ?>}
.resizing .row_labels a:hover {text-decoration: none}
.resizing .dwm_main tbody tr:hover td.row_labels a:link {color: <?php echo $anchor_link_color_header ?>}
.resizing .dwm_main tbody tr:hover td.row_labels a:visited {color: <?php echo $anchor_link_color_header ?>}
.resizing .dwm_main tr td.row_labels.selected {background-color: <?php echo $row_highlight_color ?>}
.resizing .dwm_main tr:hover td.row_labels.selected,
.resizing .dwm_main tr td.row_labels.selected a:link,
.resizing .dwm_main tr td.row_labels.selected a:visited {color: <?php echo $standard_font_color ?>}


.dwm_main .ui-resizable-handle {z-index: 1000}
.dwm_main .ui-resizable-n {top: -1px}
.dwm_main .ui-resizable-e {right: -1px}
.dwm_main .ui-resizable-s {bottom: -1px}
.dwm_main .ui-resizable-w {left: -1px}
.dwm_main .ui-resizable-se {bottom: 0; right: 0}
.dwm_main .ui-resizable-sw {bottom: -2px; left: -1px}
.dwm_main .ui-resizable-ne {top: -2px; right: -1px}
.dwm_main .ui-resizable-nw {top: -2px; left: -1px}

<?php
// We make the position property !important because otherwise IE seems to give it an inline style
// of position: relative for some unknown reason
?>
div.outline {
  position: absolute !important;
  border: 1px dotted <?php echo $header_back_color ?>;
  z-index: 700;
}

<?php

/* SLOTS CLASSES

The next section generates the slot classes (i.e. slots1, slots2, etc.).   We need
enough of them so that they cover a booking spanning all the slots.

These classes are used to control the styling of the main div in a cell in the main display table.
By editing $clipped the styling can be set to be either 
(1) CLIPPED.
The cells are all a standard height and any content that does not fit in the cell is clipped.
The height is a multiple of the height for a single cell, defined by $main_cell_height.   For 
example if you define the main cell height to be 1.1em high, then a booking that is only one slot long
will be 1.1 em high and a booking two slots long will be 2.2em high, etc.
(2) NOT CLIPPED
The cells expand to fit the content.

(Although the style information could be put in an inline style declaration, this would mean that every
cell in the display would carry the extra size of the style declaration, whereas the classes here mean
that we only need the style declaration for each row.) 

In the classes below
- slotsN is the class for displaying a booking N slots long
- height is the height of N slots (ie N * $main_cell_height)
- you need to specify max-height so that clipping works correctly in Firefox
- you need to specify height so that clipping works correctly in IE and also
  to force min-height to work correctly in IE
- you need to specify min-height to force the box to be the min-height in
  IE (Firefox works OK without min-height)

*/


// work out how many classes we'll need.   If we're transposing the table then we'll only need one, since all
// cells are the same height (it's the width that varies, controlled by the colspan attribute).   For a normal
// table we'll need at least as many as we've got slots, since a booking could span as many as all the slots
// (in this case controlled by a rowspan).
$classes_required = ($times_along_top) ? 1 : $max_slots;
for ($i=1; $i<=$classes_required; $i++) 
{
  $div_height = $main_cell_height * $i;
  $div_height = $div_height + (($i-1)*$main_table_cell_border_width);
  $div_height = (int) $div_height;    // Make absolutely sure it's an int to avoid generating invalid CSS
  
  $rule = "div.slots" . $i . " {min-height: " . $div_height . "px";
  if ($clipped)
  {
    $rule .= "; max-height: " . $div_height . "px"; 
    $rule .= "; height: "     . $div_height . "px";
  }
  $rule .= "}";
  echo $rule . "\n";
}

?>
div.celldiv {max-width: 100%; overflow: hidden; margin: 0; padding: 0}
.row_labels div.celldiv {overflow: visible}  /* we want to see the content in the row label columns */
<?php


// Multiple bookings.  These rules control the styling of the cells and controls when there is more than
// one booking in a time slot.
?>
div.mini, div.maxi {position: relative}     /* establish a relative position for the absolute position to follow */
div.multiple_control {
    display: none;       /* will be over-ridden by JavaScript if enabled */
    position: absolute; z-index: 20;
    width: <?php echo $main_cell_height ?>px;
    text-align: center;
    padding: 0;
    border-right: <?php echo $main_table_cell_border_width . "px solid " . $main_table_body_v_border_color ?>;
    background-color: <?php echo $multiple_control_color ?>}
.mini div.multiple_control {                /* heights for maxi are set using in-line styles */
    height: <?php echo $main_cell_height ?>px;
    max-height: <?php echo $main_cell_height ?>px;
    min-height: <?php echo $main_cell_height ?>px}
div:hover.multiple_control {cursor: pointer}
.multiple_booking table {height: 100%; width: 100%; border-spacing: 0; border-collapse: collapse}
.multiple_booking td {border-left: 0}

/* used for toggling multiple bookings from mini to maxi size */
.maximized div.mini {display: none}
.maximized div.maxi {display: block}
.minimized div.mini {display: block}
.minimized div.maxi {display: none}

<?php
// Over-rides for multiple bookings.  If JavaScript is enabled then we want to see the JavaScript controls.
// And we will need to extend the padding so that the controls don't overwrite the booking text
?>

.js div.multiple_control {
    display: block;   /* if JavaScript is enabled then we want to see the JavaScript controls */
  }
.js .multiple_booking .maxi a {padding-left: <?php echo $main_cell_height + $main_table_cell_border_width + 2 ?>px}

div.div_select {
  position: absolute;
  border: 0;
  opacity: 0.2;
  background-color: <?php echo $main_table_labels_back_color ?>;
}

div.div_select.outside {
  background-color: transparent;
}   

/* booking privacy status */
.private {opacity: 0.6; font-style: italic}

/* booking approval status */
.awaiting_approval {opacity: 0.6}
.awaiting_approval a:before {content: "? "}

/* booking confirmation status */
/* KTH */
.invalid, .dwm_main td.invalid {
  background-color: #CACACA; /* GRÅ */
}
<?php //191003 ?>
td.unset {
    background-color: #fcf8e3;
}

td.K,
.1B {
  opacity: 1;
  background-color: #ffffff !important
} /*vit*/

td.K,
.I.tentativeconfirmable {
  opacity: 1;
  background-color: rgba(243, 179, 27, 0.85) !important
} /*orange*/

.1I.confirmed {
  opacity: 1;
  background-color: rgba(249, 58, 58, 0.701961)
} /*röd*/

.I.tentative {
  background-color: rgba(249, 243, 58, 0.701961)
} /*gul*/

.D {
  background-color: #a9a9a9
}

.S {
  background-color: #5D007A !important
} /* KTH-grön(#B0C949), ljusblå(#7eddfc) lila(#5D007A )*/

td.D.invalid.confirmed {
    background-color: #CE3232 !important; /* CC6666 */
} /*röd*/

td.I.confirmed div, 
td.I.confirmed a,
td.I.confirmed a:link,
td.I.confirmed a:visited,
.dwm_main tbody tr:hover td.I.confirmed a,
td.I.confirmed a:hover,
td.D.confirmed div, 
td.D.confirmed a,
td.D.confirmed a:link,
td.D.confirmed a:visited,
.dwm_main tbody tr:hover td.D.confirmed a,
td.S.confirmed a:hover,
td.S.confirmed div,
td.S div, 
td.S.confirmed a,
td.S.confirmed a:link,
td.S.confirmed a:visited,
.dwm_main tbody tr:hover td.S.confirmed a,
td.S.confirmed a:hover {
    color: white;
}

/* ------------ DEL.PHP -----------------------------*/
div#del_room_confirm {padding-bottom: 3em}
#del_room_confirm p {text-align: center; font-size: large; font-weight: bold}
div#del_room_confirm_links {position: relative; margin-left: auto; margin-right: auto}
span#del_yes {display:block; position: absolute; right: 50%; margin-right: 1em; font-size: large}
span#del_no  {display:block; position: absolute; left: 50%; margin-left: 1em; font-size: large}
#del_room_confirm_links a:hover {cursor: pointer}                  /* for IE */
#del_room_confirm_links span:hover {text-decoration: underline}    /* for Firefox */


/* ------------ EDIT_AREA_ROOM.PHP ------------------*/
.edit_area_room .form_general fieldset fieldset {
  padding-top: 0.5em;
  padding-bottom: 0.5em
}

.edit_area_room .form_general fieldset fieldset fieldset {
  margin-bottom: 1em;
}

.edit_area_room .form_general fieldset fieldset legend {
  font-size: small;
  font-style: italic;
  font-weight: normal
}

.edit_area_room .form_general fieldset fieldset fieldset legend {
  padding-left: 2em;
}

.edit_area_room fieldset#time_settings {padding:0; margin: 0}
span#private_display_caution {display: block; margin-top: 1em; font-style: italic; font-weight: normal}
#book_ahead_periods_note span {display: block; float: left; width: 24em; margin: 0 0 1em 1em; font-style: italic}
/* KTH Större för custom_html(regler) */
/*.edit_area_room .form_general textarea {height: 6em; width: 25em}*/
.edit_area_room .form_general textarea {height: 15em; width: 23em}
.edit_area_room div#custom_html {margin-top: 8px}


/* ------------ FORM_GENERAL ------------------------*/
/*                                                   */
/*   used in EDIT_ENTRY.PHP, REPORT.PHP,             */
/*   SEARCH.PHP and EDIT_AREA_ROOM.PHP               */

<?php
// Common to all forms in the class "form_general"
$general_label_height          = '1.0';     // em
$general_left_col_width        = '20';      // %
$general_right_col_width       = '79';      // %  (79 to avoid rounding problems)
$general_gap                   = '1.0';     // em  (gap between left and right columns)

// Specific to the "edit_entry" form
$edit_entry_left_col_max_width = '10';      // em
$edit_entry_textarea_width     = '26';      // em
$edit_entry_ampm_width         = '16';      // em
$edit_entry_form_min_width     = $edit_entry_left_col_max_width + $edit_entry_textarea_width + $general_gap;
$edit_entry_form_min_width     = number_format($edit_entry_form_min_width, 1, '.', '');   // get rid of any commas

// Specific to the "import" form
$import_left_col_max_width     = '12';      // em

// Specific to the "report" form
$report_left_col_max_width     = '12';      // em
$report_input_width            = '12';      // em
$report_form_min_width         = $report_left_col_max_width + $report_input_width + $general_gap;
$report_form_min_width         = number_format($report_form_min_width, 1, '.', '');   // get rid of any commas

// Specific to the "search" form
$search_left_col_max_width     = '8';       // em
$search_input_width            = '12';      // em
$search_form_min_width         = $search_left_col_max_width + $search_input_width + $general_gap;
$search_form_min_width         = number_format($search_form_min_width, 1, '.', '');   // get rid of any commas

// Specific to the "logon" form
$logon_left_col_max_width      = '8';       // em
$logon_input_width             = '12';      // em
$logon_form_min_width          = $logon_left_col_max_width + $logon_input_width + $general_gap;
$logon_form_min_width          = number_format($logon_form_min_width, 1, '.', '');   // get rid of any commas

// Specific to the "db_logon" form
$db_logon_left_col_max_width   = '12';      // em
$db_logon_input_width          = '12';      // em
$db_logon_form_min_width       = $db_logon_left_col_max_width + $db_logon_input_width + $general_gap;
$db_logon_form_min_width       = number_format($db_logon_form_min_width, 1, '.', '');   // get rid of any commas

// Specific to the "edit_area_room" form
$edit_area_room_left_col_width      = '17';      // em
$edit_area_room_left_col_max_width  = '30';      // em

//KTH längre area namn
$edit_area_room_input_width         = '23';      // em

//KTH
//$edit_area_room_form_min_width      = $edit_area_room_left_col_width + $edit_area_room_input_width + $general_gap;
$edit_area_room_form_min_width      = '20';
$edit_area_room_form_min_width      = number_format($edit_area_room_form_min_width, 1, '.', '');   // get rid of any commas


?>
form.form_general {margin-top: 2.0em; width: 100%}
.edit_entry     form.form_general {min-width: <?php echo $edit_entry_form_min_width ?>em}
.report         form.form_general {min-width: <?php echo $report_form_min_width ?>em}
.search         form.form_general {min-width: <?php echo $search_form_min_width ?>em}
.edit_area_room form.form_general {min-width: <?php echo $edit_area_room_form_min_width ?>em}
form.form_general#logon       {min-width: <?php echo $logon_form_min_width ?>em}
form.form_general#db_logon    {min-width: <?php echo $db_logon_form_min_width ?>em}
form#edit_room {float: left; width: auto; margin: 0 2em 1em 1em}

.form_general div {float: left; clear: left; width: 100%}
.form_general div div {float: none; clear: none; width: auto}
.form_general div.group {float: left}
.form_general div.group_container {float: left}
.form_general .group_container div.group {clear: left}
.form_general div.group.ampm {width: <?php echo $edit_entry_ampm_width ?>em}
.edit_area_room div.group {clear: none; width: auto}
.edit_area_room div.group#private_override div {clear: left}
.form_general fieldset {width: auto; border: 0; padding-top: 2.0em}
#edit_room fieldset {width: 100%; float: left; padding: 0; margin: 0}
#edit_room fieldset.submit_buttons {margin-top: 1em}

.form_general label {
    display: block; float: left; overflow: hidden;
    min-height: <?php echo $general_label_height ?>em; 
    width: <?php echo $general_left_col_width ?>%; 
    text-align: right; padding-bottom: 1em; font-weight: bold;
}

.edit_entry     .form_general label {
    width: <?php echo $edit_entry_left_col_max_width ?>em;
    max-width: <?php echo $edit_entry_left_col_max_width ?>em;
}

.import         .form_general label {max-width: <?php echo $import_left_col_max_width ?>em}
.report         .form_general label {max-width: <?php echo $report_left_col_max_width ?>em}
.search         .form_general label {max-width: <?php echo $search_left_col_max_width ?>em}
.edit_area_room .form_general label {max-width: <?php echo $edit_area_room_left_col_max_width ?>em; width: <?php echo $edit_area_room_left_col_width ?>em}
#logon                    label {max-width: <?php echo $logon_left_col_max_width ?>em}
#db_logon                 label {max-width: <?php echo $db_logon_left_col_max_width ?>em}

.form_general .group      label {clear: none; width: auto; max-width: none; font-weight: normal; overflow: visible; text-align: left}
.form_general #rep_type .group label {clear: left}
div#rep_type {
    width: auto;
    border-right: 1px solid <?php echo $site_faq_entry_border_color ?>;
    margin-right: 1em;
    margin-bottom: 0.5em;
    padding-right: 1em;
}

fieldset.rep_type_details {clear: none; padding-top: 0}
fieldset.rep_type_details fieldset {padding-top: 0}

.rep_type_details label {text-align: left}

.form_general input {
    display: block; float: left; margin-left: <?php echo $general_gap ?>em; 
    font-family: <?php echo $standard_font_family ?>; font-size: small
}
.edit_entry     .form_general input {width: <?php echo $edit_entry_textarea_width ?>em; margin-right: 1em}
.report         .form_general input {width: <?php echo $report_input_width ?>em}
.search         .form_general input {width: <?php echo $search_input_width ?>em}
.edit_area_room .form_general input {width: <?php echo $edit_area_room_input_width ?>em}
#logon                    input {width: <?php echo $logon_input_width ?>em;}
#db_logon                 input {width: <?php echo $db_logon_input_width ?>em}

.form_general .group input {
  clear: none;
  width: auto;
  margin-right: 0.5em;
}

.form_general input.date {width: 6em}

/* font family and size needs to be the same for input and textarea as their widths are defined in ems */
.form_general textarea {
    display: block; float: left; 
    width: <?php echo $edit_entry_textarea_width ?>em; height: 11em; 
    margin-left: <?php echo $general_gap ?>em; margin-bottom: 0.5em;
    font-family: <?php echo $standard_font_family ?>; font-size: small
}
.form_general select {float: left; margin-left: <?php echo $general_gap ?>em; margin-right: -0.5em; margin-bottom: 0.5em}
.form_general label.radio {font-weight: normal; width: auto}
.form_general input.radio {margin-top: 0.1em; margin-right: 2px; width: auto}
.form_general input.checkbox {width: auto; margin-top: 0.2em}
.edit_area_room .form_general input.checkbox {margin-left: <?php echo $general_gap ?>em}
.edit_area_room .form_general #booking_policies input.text {width: 4em}
.form_general input.submit {display: block; width: auto; float: left; clear: left; margin-top: 1.0em}

div#import_submit     {width: <?php echo $general_left_col_width ?>%; max-width: <?php echo $import_left_col_max_width ?>em}
div#report_submit     {width: <?php echo $general_left_col_width ?>%; max-width: <?php echo $report_left_col_max_width ?>em}
div#search_submit     {width: <?php echo $general_left_col_width ?>%; max-width: <?php echo $search_left_col_max_width ?>em}
div#logon_submit      {width: <?php echo $general_left_col_width ?>%; max-width: <?php echo $logon_left_col_max_width ?>em}
div#db_logon_submit   {width: <?php echo $general_left_col_width ?>%; max-width: <?php echo $db_logon_left_col_max_width ?>em}
#import_submit input, #report_submit input, #search_submit input, #logon_submit input, #db_logon_submit input
    {position: relative; left: 100%; width: auto}
div#edit_area_room_submit_back {float: left; width: <?php echo $edit_area_room_left_col_width ?>em; max-width: <?php echo $edit_area_room_left_col_max_width ?>em}
div#edit_area_room_submit_save {float: left; clear: none; width: auto}
#edit_area_room_submit_back input {float: right}
div#edit_entry_submit_back {float: left; width: <?php echo $general_left_col_width ?>em; max-width: <?php echo $edit_entry_left_col_max_width ?>em}
div#edit_entry_submit_save {float: left; clear: none; width: auto}
#edit_entry_submit_back input {float: right}


.form_general .div_dur_mins input{width: 4.0em}
.form_general .div_time input {width: 2.0em}
.form_general .div_time input.time_hour {text-align: right}
.form_general .div_time input.time_minute {text-align: left; margin-left: 0}
.form_general .div_time span + input {margin-left: 0}
.form_general .div_time span {display: block; float: left; width: 0.5em; text-align: center}
.form_general input#duration {width: 2.0em; text-align: right}
.form_general select#dur_units {margin-right: 1.0em; margin-left: 0.5em}
.form_general div#ad {float: left}
.form_general #ad label {clear: none; text-align: left; font-weight: normal}
.form_general input.all_day, .form_general input#area_def_duration_all_day {width: auto; margin-left: 1em; margin-right: 0.5em}
.form_general select#start_seconds, input#area_def_duration_mins {margin-right: 2em}
.form_general #div_rooms select, .form_general #div_typematch select {float: left; margin-right: 2.0em}
fieldset#rep_info {border-top: 1px solid <?php echo $site_faq_entry_border_color ?>; padding-top: 0.7em}
.form_general input#rep_num_weeks, .form_general input#month_absolute {width: 4em}

.edit_entry span#end_time_error {display: block; float: left; margin-left: 2em; font-weight: normal}
.edit_area_room span.error {display: block; width: 100%; margin-bottom: 0.5em}

/* KTH */
.form_general label.secondary {font-weight: normal; width: auto; max-width: none;}

/* KTH */
div#conflict_check, div#policy_check {float: left; clear: none; 1width: 2em; 1padding: 1em 0.5em; 1cursor: pointer}
div#conflict_check {1margin-left: 3em}
/*KTH Profilfärger*/
div.good {color: #62922E}
div.bad {color: #9D102D}

.form_general table {border-collapse: collapse}
.form_general table, .form_general tr, .form_general th, .form_general td {padding: 0; margin: 0; border: 0}
.form_general th {font-weight: normal; font-style: italic; text-align: left; padding: 0.2em 0 0.2em 1em}


/* ------------ EDIT_ENTRY_HANDLER.PHP ------------------*/
.edit_entry_handler div#submit_buttons {float: left}
.edit_entry_handler #submit_buttons form {float: left; margin: 1em 2em 1em 0}


/* ------------ EDIT_USERS.PHP ------------------*/
<?php
$edit_users_label_height     = '2.0';    // em
$edit_users_label_width      = '10.0';   // em
$edit_users_gap              = '1.0';    // em
$edit_users_input_width      = '10.0';   // em
// This CSS works by using absolute positioning to bring the Delete button up into the main form.
// Logically the HTML for the Delete button is implemented and because you can't nest a form within
// a form it appears as a second form after the main form.    However, to the user it is more logical to
// see it within the main form, which we achieve through CSS.    [Actually it would probably be better
// to have the Delete button in a column on the User List page, just like the Edit button is.  However
// if you put it there you probably also need a confirmation screen, otherwise it is too easy to delete
// users by mistake.    Having it on the edit form at least means that you have to press two buttons to
// delete a user (the Edit button followed by the Delete button)]
?>
div#form_container {width: auto; position: relative; float: left}    /* this is the containing block against which the absolute positioning works */
#form_container input.submit {width: auto; position: absolute; bottom: 2.0em}  /* bring both buttons up          */
form#form_edit_users {width: auto; margin-top: 2.0em}
#form_edit_users fieldset {float: left; width: auto}  
#form_edit_users div {float: left; clear: left; width: auto}
#form_edit_users div#edit_users_input_container {padding-bottom: 4.0em}    /* padding-bottom leaves room for the submit buttons. */
                                                                           /* Apply it to the div because applying it to the     */
                                                                           /* fieldset does not work in all browsers (eg Safari) */
#form_edit_users label{
    display: block; float: left;
    min-height: <?php echo $edit_users_label_height ?>em; 
    width: <?php echo $edit_users_label_width ?>em;  
    text-align: right;
}
#form_edit_users input {
    display: block; float: left;
    width: <?php echo $edit_users_input_width ?>em; 
    margin-left: <?php echo $edit_users_gap ?>em; 
}
#form_edit_users select, #form_edit_users textarea {
    margin-left: <?php echo $edit_users_gap ?>em;
}
#form_edit_users textarea {margin-bottom: 0.5em}

#form_edit_users p {display: block; float: left; clear: left; padding: 0.5em 0 0.7em 0; margin: 0;
                    width: <?php echo $edit_users_label_width + $edit_users_gap + $edit_users_input_width + 5?>em}
#form_edit_users ul {clear: left}
#form_edit_users input.submit {right: 2.0em}                                   /* and put the OK on the right     */
#form_delete_users input.submit {left: 2.0em}                                  /* and put the Delete on the left */
#form_edit_users input.checkbox {width: auto; margin-left: <?php echo $edit_users_gap ?>em}
form.edit_users_error {width: 10em; margin-top: 2.0em}
div#user_list {padding: 2em 0}
form#add_new_user {margin-left: 1em}
#users_table td {text-align: right}
#users_table td div.string {text-align: left}



/* ------------ FUNCTIONS.INC -------------------*/
#logon_box a {display: block; width: 100%; padding-top: 0.3em; padding-bottom: 0.3em}
table#banner {width: 100%; border-spacing: 0; border-collapse: collapse;
    border-color: <?php echo $banner_border_color ?>;
    border-width: <?php echo $banner_border_width ?>px;
    border-style: solid}
#banner td {text-align: center; vertical-align: middle; background-color: <?php echo $banner_back_color ?>;
    border-color: <?php echo $banner_border_color ?>; border-style: solid;
    border-top-width: 0; border-right-width: 0; border-bottom-width: 0; border-left-width: <?php echo $banner_border_cell_width ?>px;
    padding: 6px; color: <?php echo $banner_font_color ?>}
#banner td:first-child {border-left-width: 0}
#banner td#company {font-size: large}
#banner #company div {width: 100%}
#banner a:link    {color: <?php echo $anchor_link_color_banner ?>;    text-decoration: none; font-weight: normal}
#banner a:visited {color: <?php echo $anchor_visited_color_banner ?>; text-decoration: none; font-weight: normal}
#banner a:hover   {color: <?php echo $anchor_hover_color_banner ?>;   text-decoration:underline; font-weight: normal}
/*kth*/
#banner input.date {1width: 6.5em; text-align: center}

<?php
// The rules below are concerned with keeping the date selector in the header a constant width, so
// that the header doesn't jump around when the page is loaded
?>

.js #banner #Form1 select {
  display: none;
}

.js #banner #Form1 span {
  display: inline-block;
  min-width: 7.5em;
}

.js #banner #Form1 input[type=submit] {
  visibility: hidden;
}
/* KTH färgkodning*/
table#colour_key {
    clear: both; float: left; border-spacing: 0; border-collapse: collapse; margin: 0.5em 0;
    width: unset;
}
/* KTH */
#colour_key td {
	width: 7.0em; 
	padding: 2px;
	color: <?php echo $colour_key_font_color ?>;
	border: <?php echo $main_table_cell_border_width ?>px solid <?php echo $main_table_body_h_border_color ?>
}
/* 191003 */
#colour_key .invalid {border: 1px solid #888888 !important;}
#colour_key .I.tentative {border: 1px solid #A3A537 !important;} /*grön =48A537 orange =C9910A gul=A3A537 röd=A54637*/
#colour_key .I.confirmed {border: 1px solid #A54637 !important;}
#colour_key .K {border: 1px solid #C9910A !important;}
#colour_key .B {border: 1px solid #CCCCCC !important;}
#colour_key .S {border: 1px solid #2d9898 !important;} /* KTH-grön(#83982d), ljusblå(#2d9898)*/

#colour_key .confirmed {
	font-weight: normal;
}
/* Slut KTH */
#colour_key td#row_padding {border-right: 0; border-bottom: 0}
/*KTH ingen bredd på input search*/
#header_search input {wdidth: 6.0em}
div#n_outstanding {margin-top: 0.5em}
#banner .outstanding a {color: <?php echo $outstanding_color ?>}

/* ------------ HELP.PHP ------------------------*/
table#version_info {border-spacing: 0; border-collapse: collapse}
#version_info td {padding: 0 1.0em 0 0; vertical-align: bottom}
#version_info td:first-child {text-align: right}


/* ------------ IMPORT.PHP ------------------------*/
.import .form_general fieldset fieldset legend {font-size: small; font-style: italic; font-weight: normal}
div.problem_report {border-bottom: 1px solid <?php echo $site_faq_entry_border_color ?>; margin-top: 1em}

/* ------------ MINCALS.PHP ---------------------*/
div#cals {float: right}
div#cal_last {float: left}
div#cal_this {float: left; margin-left: 1.0em}
div#cal_next {float: left; margin-left: 1.0em}

table.calendar {border-spacing: 0; border-collapse: collapse}
.calendar th {min-width: 2.0em; text-align: center; font-weight: normal; background-color: transparent; color: <?php echo $standard_font_color ?>}
.calendar td {text-align: center; font-size: x-small}
<?php
// set the styling for the "hidden" days in the mini-cals
?>
.calendar th.hidden {background-color: <?php echo $calendar_hidden_color ?>} 
.calendar td.hidden {background-color: <?php echo $calendar_hidden_color ?>; font-weight: bold} 
.calendar a.current {font-weight: bold; color: <?php echo $highlight_font_color ?>}
td#sticky_day {border: 1px dotted <?php echo $highlight_font_color ?>}
td.mincals_week_number { opacity: 0.5; font-size: 60%; }

/* ------------ PENDING.PHP ------------------*/
#pending_list form {
  display: inline-block;
}

#pending_list td.table_container, #pending_list td.sub_table {
  padding: 0;
  border: 0;
  margin: 0;
}

#pending_list .control {
  padding-left: 0;
  padding-right: 0;
  text-align: center;
  color: <?php echo $standard_font_color ?>;
}

.js #pending_list td.control {
  background-color: <?php echo $pending_control_color ?>;
}

#pending_list td:first-child {width: 1.2em}
#pending_list #pending_table td.sub_table {width: auto}
table.admin_table.sub {border-right-width: 0}
table.sub th {background-color: #788D9C}
.js .admin_table table.sub th:first-child {background-color: <?php echo $pending_control_color ?>;
    border-left-color: <?php echo $admin_table_border_color ?>}
#pending_list form {margin: 2px 4px}


/* ------------ REPORT.PHP ----------------------*/
div#div_summary {padding-top: 3em}
#div_summary table {border-spacing: 1px; border-collapse: collapse;
    border-color: <?php echo $report_table_border_color ?>; border-style: solid;
    border-top-width: 1px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 1px}
#div_summary td, #div_summary th {padding: 0.1em 0.2em 0.1em 0.2em;
    border-color: <?php echo $report_table_border_color ?>; border-style: solid;
    border-top-width: 0; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 0}
#div_summary th {background-color: transparent; font-weight: bold; text-align: center}
#div_summary thead tr:nth-child(2) th {font-weight: normal; font-style: italic}
#div_summary th:first-child {text-align: right}
#div_summary tfoot th {text-align: right}
#div_summary td {text-align: right}
#div_summary tbody td:nth-child(even), #div_summary tfoot th:nth-child(even) {border-right-width: 0}
#div_summary td:first-child {font-weight: bold}
p.report_entries {font-weight: bold}
.report .form_general fieldset fieldset {padding-top: 0.5em; padding-bottom: 0.5em}
.report .form_general fieldset fieldset legend {font-size: small; font-style: italic; font-weight: normal}
button#delete_button {float: left; clear: left; margin: 1em 0 3em 0}


/* ------------ SEARCH.PHP ----------------------*/
span#search_str {color: <?php echo $highlight_font_color ?>}
p#nothing_found {font-weight: bold}
div#record_numbers {font-weight: bold}
div#record_nav {font-weight: bold; margin-bottom: 1.0em}

/* ------------ SITE_FAQ ------------------------*/
.help q {font-style: italic}
.help dfn {font-style: normal; font-weight: bold}
#site_faq_contents li a {text-decoration: underline}
div#site_faq_body {margin-top: 2.0em}
#site_faq_body h4 {border-top: 1px solid <?php echo $site_faq_entry_border_color ?>; padding-top: 0.5em; margin-top: 0} 
#site_faq_body div {padding-bottom: 0.5em}
#site_faq_body :target {background-color: <?php echo $help_highlight_color ?>}


/* ------------ TRAILER.INC ---------------------*/
div#trailer {border-top: 1px solid <?php echo $trailer_border_color ?>; 
             border-bottom: 1px solid <?php echo $trailer_border_color ?>; 
             float: left;
             clear: left;
             margin-top: 1.0em; margin-bottom: 1.5em;
             padding-top: 0.3em; padding-bottom: 0.3em}
#trailer div {float: left; width: 100%}
#trailer div.trailer_label {float: left; clear: left; width: 20%; max-width: 9.0em; font-weight: bold}
#trailer div.trailer_links {float: left;              width: 79%}  /* 79 to avoid rounding problems */
.trailer_label span {margin-right: 1.0em}

#trailer span.current {font-weight: bold}
#trailer span.hidden {font-weight: normal; 
    background-color: <?php echo $body_background_color ?>;  /* hack: only necessary for IE6 to prevent blurring with opacity */
    opacity: 0.5}  /* if you change this value, change it in the IE sheets as well */
#trailer .current a {color: <?php echo $highlight_font_color ?>}

div#simple_trailer {clear: both; text-align: center; padding-top: 1.0em; padding-bottom: 2.0em}
#simple_trailer a {padding: 0 1.0em 0 1.0em}


/* ------------ VIEW_ENTRY.PHP ------------------*/
.view_entry #entry td:first-child {text-align: right; font-weight: bold; padding-right: 1.0em}
.view_entry div#view_entry_nav {margin-top: 1.0em}
.view_entry #approve_buttons form {float: left; margin-right: 2em}
.view_entry #approve_buttons legend {font-size: 0}
.view_entry div#returl {margin-top: 1em}
#approve_buttons td {vertical-align: middle; padding-top: 1em}
#approve_buttons td#caption {text-align: left}
#approve_buttons td#note {padding-top: 0}
#approve_buttons td#note form {width: 100%}
#approve_buttons td#note textarea {width: 100%; height: 6em}


/*-------------DataTables-------------------------*/

div.datatable_container {
  float: left;
  width: 100%;
}

div.ColVis_collection {
  float: left;
  width: auto;
}

div.ColVis_collection button.ColVis_Button {
  float: left;
  clear: left;
}

.dataTables_wrapper .dataTables_length {
  clear: both;
}

.dataTables_wrapper .dataTables_filter {
  clear: right;
  margin-bottom: 1em;
}

span.ColVis_radio {
  display: block;
  float: left;
  width: 30px;
}

span.ColVis_title {
  display: block;
  float: left;
  white-space: nowrap;
}

table.dataTable.display tbody tr.odd {
  background-color: #E2E4FF;
}

table.dataTable.display tbody tr.even {
  background-color: white;
}

table.dataTable.display tbody tr.odd > .sorting_1,
table.dataTable.order-column.stripe tbody tr.odd > .sorting_1 {
  background-color: #D3D6FF;
}

table.dataTable.display tbody tr.odd > .sorting_2,
table.dataTable.order-column.stripe tbody tr.odd > .sorting_2 {
  background-color: #DADCFF;
}

table.dataTable.display tbody tr.odd > .sorting_3,
table.dataTable.order-column.stripe tbody tr.odd > .sorting_3 {
  background-color: #E0E2FF;
}

table.dataTable.display tbody tr.even > .sorting_1,
table.dataTable.order-column.stripe tbody tr.even > .sorting_1  {
  background-color: #EAEBFF;
}

table.dataTable.display tbody tr.even > .sorting_2,
table.dataTable.order-column.stripe tbody tr.even > .sorting_2 {
  background-color: #F2F3FF;
}

table.dataTable.display tbody tr.even > .sorting_3,
table.dataTable.order-column.stripe tbody tr.even > .sorting_3 {
  background-color: #F9F9FF;
}

.dataTables_wrapper.no-footer .dataTables_scrollBody {
  border-bottom-width: 0;
}

div.dt-buttons {
  float: right;
  margin-bottom: 0.4em;
}

a.dt-button {
  margin-right: 0;
}


/* ------------ jQuery UI additions -------------*/

.ui-autocomplete {
  max-height: 150px;
  overflow-y: auto;
  /* prevent horizontal scrollbar */
  overflow-x: hidden;
  /* add padding to account for vertical scrollbar */
  padding-right: 20px;
}


#check_tabs {border:0}
div#check_tabs {background-image: none}
.edit_entry #ui-tab-dialog-close {position:absolute; right:0; top:23px}
.edit_entry #ui-tab-dialog-close a {float:none; padding:0}

/* KTH Allt nedan*/

/* 191003 */
body header .container-fluid .container .block.list.links.secondaryMenu {
  flex-grow: 1;
  display: flex;
  justify-content: flex-end;
}

h3 {
    font-size: 1.375rem;
}

img {
    max-width: 100%;
    height: auto;
}
/* 191003 */
#contentwrapper {
    overflow: auto;
	padding: 0px 15px;
}
/* 191003 */
#appheader {
  overflow: auto;
  padding: 0px 15px;
}

#mrbs {
	/*border-top: 1px dotted #B9BBBD;*/
	font-size: 2.0em;
	padding: 15px 26px;
    margin: 0 auto;
    max-width: 1228px;
}
#mrbs a {
    font-weight: normal;
}
.menuwrapper {
  display: flex;
  justify-content: space-between;
}
.menu{
  display: flex;
  flex-direction: row;
  flex: 1;
  font-size: 1.25rem
}
.menu a{
  padding: 1.25rem 1.25rem 0 0;
  text-decoration: none;
}
.menu a:hover{
  color: #000000;
}
#banner {
	  flex:1;
    overflow: visible;
    top: -20px;
    /*position: relative;*/
    /*height: 53px;*/
}
/* 191003 */
#banner div {
    background-color: #fff;
    color: #000;
	/*margin-bottom: 10px;*/
}

#banner a:link, #banner a:visited {
    background-color: #fff;
    border-color: #a2a2a2;
    color: #24A0D8;
}

/* regler visible */	
#bookingrules, #mapimage {
	display: none;
	background-color: #fff;
	1left: 20px;
	1top: 270px;
	float: left;
	width: 97%;
}

#bookingrules.active, #mapimage.active {
	display: block;
}

#mapimage {
	width: 90%;
}

#ruleslink.active,#maplink.active   {
	1background: url('../images/table-sortable-header-desc.gif') no-repeat scroll 100% 50% #DDD;
}

.iinfolink:before {
    content: 'i';
    display: inline-block;
    font-family: sans-serif;
    font-weight: bold;
    text-align: center;
    width: 1.8ex;
    height: 1.8ex;
    font-size: 2.2ex;
    line-height: 1.8ex;
    border-radius: 1.2ex;
    margin-right: 4px;
    padding: 1px;
    color: #24A0D8;
    background: white;
    border: 1px solid #24A0D8;
    text-decoration: none;
    cursor: pointer;
}

.infolink {
	display: block;
	font-size: 0.9em;
    color: #2D72BF;
    font-weight: normal;
    margin: 0px;
    padding: 0.5em 0.5em 0.5em 0.5em;
    background: url('../images/table-sortable-header-asc.gif') no-repeat scroll 100% 50% transparent;
    border: dotted 1px;
    color: #24A0D8;
	float: left;
	width: 50%;
	margin-bottom: 0.5em;
}

.expandable-header {
	font-size: 14px;
	color: #111;
	font-weight: 700;
	1width: 25%;
	margin-right: 20px;
	cursor: pointer;
	float: left;
	clear: none;
}

.expandable {
	1float: right;
}
/* 191003 */
.expandable-header .expandable:after {
	/*content: "+";
	content: 'i';
    display: inline-block;
    font-family: sans-serif;
    font-weight: bold;
    text-align: center;
    width: 18px;
    height: 18px;
    font-size: 15px;
    line-height: 1.8ex;
    border-radius: 1.2ex;
    margin-right: 4px;
	margin-left: 4px;
    padding: 1px;
    color: #fff;
    background: none repeat scroll 0% 0% #24A0D8;
    border: 1px solid #24A0D8;
    text-decoration: none;
    cursor: pointer;*/
    content: '';
    height: 16px;
    width: 16px;
    display: inline-block;
    margin: auto;
    background-image: url(../images/modal-info.svg);
    background-size: contain;
    background-repeat: no-repeat;
}

.expandable-header.active .expandable:after {
	content: "-";
}

/* Datepicker */
.ui-datepicker{ z-index: 9999 !important;}

#datepicker {
	text-align: center;
	font-size: 16px;
	border: none;
	width: 280px;
	cursor: pointer;
	background-image: url("../images/calendarIcon.png");
	background-size: 20px 15px;
	background-repeat: no-repeat;
	background-position: 8% 50%;
}

td.C, img.C {
    background-color: #CACACA !important; /*191003 GRÅ #CACACA alltid blå(#7eddfc) på stängd bokning*/
}

table.dwm_main {
    border-color: #a9a9a9;
    border-width: 1px;
    border-style: solid;
}

.dwm_main .first_last {
	background-color: #24a0d8;
	color: #fff;
}

.dwm_main th {
	height: 40px;
	overflow: hidden;
}
	
.dwm_main th, .dwm_main td.row_labels {
	background-color: #24a0d8;
	border-color: #d2d2d2;
}
.dwm_main th:first-child {
    word-break: normal;
	vertical-align: bottom;
}

.dwm_main th a:link, td.row_labels a:link {
	 font-size: 12px;
}

.dwm_main th a:hover, .row_labels a:hover {
	 text-decoration: none;
}

.dwm_main td {
    height: 40px;
	border-color: #a9a9a9;
}

.dwm_main a, div.celldiv {
    font-size: 12px;
}
/* 191003
#dwm_header li {
	padding: 5px 5px;
	border: 1px dotted;
	margin-top: 5px;
	margin-bottom: 5px;
}
*/
#dwma_header li {
	background-color: #24a0d8 !important;
    background-image: none;
    border-radius: 10px 10px 10px 10px;
    font-size: 14px;
    font-weight: bold;
    font-family: Helvetica;
    padding: 5px;
    margin: 0px;
    background-repeat: repeat-x;
    color: #FFFFFF;
    cursor: pointer;
    border: 1px solid #ffffff;
	
}

#dwma_header li a {
	color: #ffffff;
	text-decoration: none;
}

/* höjden på klickbara bokningar */
<?php 
$slotheight = 40;
for ($i=1; $i<=20; $i++) {
	echo "div.slots" . $i . ", div.slots" . $i . " a {
		max-height: " . $slotheight . "px;
		height: ". $slotheight . "px;
	}\n";
	$slotheight += 40;
}
?>
/* 191003 */

#colour_key td.available {
	border: 1px solid #a9a9a9;
    background-color: #ffffff;
}

#colour_key td {
	border: none;
}

/* Formulär (edit entry)*/
form.form_general {
    width: 100%;
}

.edit_entry form.form_general {
    min-width: 300px;
	margin-top: 0px;
}

.form_general fieldset {
	padding-top: 0px;
}

form {
    margin: 0px auto;
}

.form_general select#start_seconds,.form_general select#end_seconds, input#area_def_duration_mins {
    margin-right: 2em;
    width: 100px;
}

.form_general label {
    width: initial;
	text-align: left;
}
/* 191003 */
div#edit_entry_submit_save,
div#edit_entry_submit_back {
    width: auto;
}

.edit_entry button, .deletebutton {
    margin: 5px 5px 5px 0px;
}

.edit_entry .form_general label {
    padding: 0;
    font-size: 1rem;
    width: 100% !important;
    max-width: 100% !important;
}

/* 191003 */
.edit_entry .form_general select {
    border: 1px solid #e6e6e6;
    background-color: #f6f6f6;
    border-radius: 4px;
    font-size: .875rem;
    font-family: "Open Sans";
    height: 38px;
    width: 100% !important;
    padding: 6px 10px;
    margin: 0 0 15px 0;
}

.edit_entry .form_general input.radio, .edit_entry .form_general input.checkbox {
  width: 23px;
  height: 23px;
}

.edit_entry .form_general input {
    width: 100%;
    border: 1px solid #e6e6e6;
    background-color: #f6f6f6;
    border-radius: 4px;
    font-size: .875rem;
    font-family: "Open Sans";
    height: 38px;
    padding: 6px 10px;
    margin: 0 0 15px 0;
}

.edit_entry .form_general textarea {
    display: block;
    width: 100%;
    height: 150px;
    padding: .375rem .75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #f6f6f6;
    background-clip: padding-box;
    border: 1px solid #e6e6e6;
    border-radius: .25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    margin: 0 0 15px 0;
}
	
.form_general span {	
	margin-left: 1.0em;
}

/*Formulär logon*/
#logon {
	width: 100%;
}

#logon label {
    width: 170px;
    text-align: left;
	max-width: 200px;
}
#logon input {
    width: 110px;
}

#div_type {
	display:none; 
}

div#contents {
	position: relative;
}
/* 191003 */
div.screenonly {
  margin: 0 auto;
	background: #fff;
	/*width: 90.90909091%;*/
	/*max-width: 986px;*/ 
	overflow: auto;
	padding: 0px 0px;
}

div#contents {
	float: none;
	padding: 0px 30px;
	overflow: auto;
  max-width: 1228px;
  margin: 0 auto;
}

div#trailer {
	margin: 5px 10px;
}

#contents .screenonly {
  overflow: auto;
  margin: 0 auto;
	width: 100%;
}

div.date_nav {
    font-weight: bold;
    background: #b0c92b;
    padding: 5px 5px;
    overflow: auto;
    color: #fff;
	background: #1954A6;
}

div.date_now a, div.date_before a ,div.date_after a   {
	color: #fff;
}

.btn {
  white-space: initial;
}

/* 191003 */
.greenbutton  {
    background-color: #B0C92B !important;
    background-image: none;
    border-radius: 10px 10px 10px 10px;
    1height: 42px;
    font-size: 14px;
    font-weight: bold;
    font-family: Helvetica;
    padding: 5px;
    margin: 0px;
	background-repeat: repeat-x;
	color: #FFFFFF;
	cursor: pointer;
	border: 1px solid #ffffff;

}

.greenbutton {
	margin-top: 1.0em;
	font-size: 14px !important;
}

.pinkbutton  {
    background-color: #D85497 !important;
    background-image: none;
    border-radius: 10px 10px 10px 10px;
    1height: 42px;
    font-size: 14px;
    font-weight: bold;
    font-family: Helvetica;
    padding: 5px;
    margin: 0px;
	background-repeat: repeat-x;
	color: #FFFFFF !important;
	cursor: pointer;
	border: 1px solid #ffffff;
	float: left;

}
/* 191003 */
.deletebutton {
    color: #ffffff !important;
}

/*
#adminsettings {
    background-color: #24A0D8 !important;
    background-image: none;
    border-radius: 10px 10px 10px 10px;
    1height: 42px;
    font-size: 14px;
    font-weight: bold;
    font-family: Helvetica;
    padding: 5px;
    margin: 0px;
	background-repeat: repeat-x;
	color: #FFFFFF;
	cursor: pointer;
	border: 1px solid #ffffff;
	width: auto;

}
*/

/*
#adminsettings a:link, #adminsettings a:visited  {
	color: #FFF;
	background-color: #24A0D8;
	text-decoration: none;
	font-weight: bold;
}
*/

#header_search input[type=submit] {
    border: none;
    background-color: #fff !important;
    color: #24A0D8;
    font-weight: normal;
    padding: 0;
    border-radius: 0px;
}

#header_search input[type=submit]:hover {
    text-decoration: underline;
}

.roomname {
	white-space: nowrap;
}

.floatingHeader .roomname {
	1display: none;
}

.capacity {
	display: block; font-size: 12px;color: #1b1b1b
}

.personicon {
	display: inline-block;
    top: 2px;
    position: relative;
    background-image: url("../images/user.png");
    width: 14px;
    height: 14px;
    background-size: 100% 100%;
    background-repeat: no-repeat;
}
/* KTH 20180130 icon för att visa att rum har en skärm*/
.screenicon {
	display: inline-block;
    top: 2px;
    position: relative;
    background-image: url("../images/ic_tv_black_24px.svg");
    width: 14px;
    height: 14px;
    background-size: 100% 100%;
    background-repeat: no-repeat;
}

/* 191003 */
.current {
  color: #fff; 
  /*background-color: #e3e5e3*/
} 

/* Modal dialog box */
.modal {
  position: relative;
  z-index:9999;
}
/* 191003
.modal {
	display: none;
	position: fixed;
	z-index: 9999;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0,0,0);
	background-color: rgba(204, 201, 201, 0.6);
}

.modal-content {
    padding: 0px;
    width: 90%;
    text-align: center;
    background-color: rgba(255, 255, 255, 0.85);
    border-radius: 8px;
    left: 5%;
}

.modalclose {
	margin: 10px;
}
*/
.modal-dialog {
    max-width:1000px !important;
}
.modal-title {
    word-break: break-all;
}
#myModalrules,#myModalmap {
	display: none;
}

.modal-content {
    z-index:9999;
}

.before_after_links {
	float: left;
    width: 100%;
}

.infobox_red {
	padding: 10px; 
	border-color: #E4363E;
	border-style: solid;
	border-width: 2px;
	margin-bottom: 5px;
}

.infobox_orange {
	padding: 10px; 
	border-color: #FAB919;
	border-style: solid;
	border-width: 2px;
	margin-bottom: 5px;
}

.infobox_green {
	padding: 10px; 
	border-color: #B0C92B;
	border-style: solid;
	border-width: 2px;
	margin-bottom: 5px;
}

#extrainfo {
	padding: 10px 0px 10px 0px;
  position: relative;
  font-size: 1.375rem;
}

.alert {
  padding: 1.2rem 2.2rem 1rem 5.4rem;
  color: #000000;
}

.alert-info {
    background-color: #fcf8e3;
    border: 1px solid #faebcc;
}

#logon #NewUserName {
	background-image: url("https://<?php echo $_SERVER['HTTP_HOST']?>/forms/bestall/kth-se.png");
	background-repeat: no-repeat;
	background-position: 95% 50%;
}

#logon #NewUserName, #logon #NewUserPassword {
	margin-right: 0;
	width: 140px;
	border-radius: 8px;
    -moz-border-radius: 8px;
    -webkit-border-radius: 8px;
	border-style: solid;
    border-width: 1px;
    border-color: #ffffff;
    border: 1px solid #ccc;
	-webkit-box-shadow: inset 1px 1px 2px #b9bbbd;
    box-shadow: inset 1px 1px 2px #b9bbbd;
    padding: 5px;
    outline: 0px;
}

#logon label
{
	padding: 8px 0;
}

/* resizable */
/*
.ui-resizable-w {
	background-position: -38px -224px;
	background-image: url("/mrbs/jquery/ui/css/sunny/images/ui-icons_d19405_256x240.png");
	width: 16px;
	height: 16px;
	text-indent: -99999px;
    overflow: hidden;
    background-repeat: no-repeat;
}

.ui-resizable-e {
	background-position: -38px -224px;
	background-image: url("/mrbs/jquery/ui/css/sunny/images/ui-icons_d19405_256x240.png");
	width: 16px;
	height: 16px;
	text-indent: -99999px;
    overflow: hidden;
    background-repeat: no-repeat;
}

*/
/* KTH Alla @media ligger i style.inc*/