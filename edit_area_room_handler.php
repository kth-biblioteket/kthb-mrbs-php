<?php
// $Id$
/*******************************************
KTH ny fil för att hantera ajax-uppdatering av perioder i admingränssnittet.
*******************************************/
require "defaultincludes.inc";
require_once "mrbs_sql.inc";
require_once "functions_ical.inc";
require_once "functions_table.inc";
require_once "functions.inc";


$ajax = get_form_var('ajax', 'int');
$commit = get_form_var('commit', 'int');
$query = get_form_var('query', 'string');

if ($ajax && !checkAuthorised(TRUE))
{
	exit;
}

// (1) Check the user is authorised for this page
//  ---------------------------------------------
checkAuthorised();

// Also need to know whether they have admin rights
$user = getUserName();
$is_admin = (authGetUserLevel($user) >= 2);

// (2) Get the form variables
// --------------------------

// Get non-standard form variables
$start_time = get_form_var('starttime', 'string');
$end_time = get_form_var('endtime', 'string');
$area_id = get_form_var('areaid', 'string');
$id = get_form_var('id', 'string');


// BACK:  we didn't really want to be here - send them to the returl
if (!empty($back_button))
{
	if (empty($returl))
	{
		$returl = "index.php";
	}
	header("Location: $returl");
	exit();
}

// If this is an Ajax request and we're being asked to commit
if ($ajax && $commit)
{
// PHASE 2 (AREA) - UPDATE THE DATABASE
  // ------------------------------------
    // If everything is OK, update the database
    $assign_array = array();
	 
	if ($query == "insert") {
		if (sql_escape($start_time)!="" && sql_escape($start_time)!= "") {
			$sql = "INSERT INTO kth_periods(start_time, end_time, area_id, entry_start_time) VALUES (";
			$assign_array[] = "'" . sql_escape($start_time) . "'";
			$assign_array[] = "'" . sql_escape($end_time) . "'";
			$assign_array[] = sql_escape($area_id);
			$sql .= implode(",", $assign_array) . ", '12:10')";
		}
	}
	//UPDATE
	if ($query == "update") {
		$sql = "UPDATE kth_periods SET";
		$assign_array[] = "start_time='" . sql_escape($start_time) . "'";
		$assign_array[] = "end_time='" . sql_escape($end_time) . "'";
		$assign_array[] = "area_id='" . sql_escape($area_id) . "'";
		$sql .= implode(",", $assign_array) . ", '12:10')";
	}
	//DELETE
	if ($query == "delete") {
		$sql = "DELETE FROM kth_periods WHERE id=$id";
	}
	if ($sql != "") {
		if (sql_command($sql) < 0) {
			echo $sql;
			echo sql_error();
			echo get_vocab("update_area_failed") . "<br>\n";
			trigger_error(sql_error(), E_USER_WARNING);
			fatal_error(FALSE, get_vocab("fatal_db_error"));
			exit;
		}
	}
	
	//INSERT
	//om en period läggs till.. räkna ut vilken entry_start_time den ska få..från 12:00 och framåt
	//lägg till den i tabellen med 0 som entry time.. sortera tabellen på starttime... uppdatera entry time på alla
	// select * from kth_periods order by start_time; update kth_periods set entry_start_time = 
	if ($query == "insert" || $query == "delete") {
		$res = sql_query("SELECT * FROM kth_periods WHERE area_id=$area_id ORDER BY start_time");
		if (! $res)
		{
			fatal_error(0, get_vocab("error_area") . $area . get_vocab("not_found"));
		}
		if ($res) {
			for ($i = 0; ($periodrows = sql_row_keyed($res, $i)); $i++) {
				$entry_start_time_minutes = date("h:i",strtotime("12:00" . " +" . $i ." minutes"));
				sql_command("UPDATE kth_periods SET entry_start_time = '$entry_start_time_minutes' WHERE start_time = '" .$periodrows['start_time'] . "'");
			}
			sql_free($res);
		}
	}

	// If the database update worked OK return new HTML for periods
	$result = create_period_innerhtml($area_id);
	echo $result;
}
?>