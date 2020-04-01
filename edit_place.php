<?php
//copy of file "edit_area_room.php"

require "defaultincludes.inc";
require_once "mrbs_sql.inc";

// Get non-standard form variables
$phase = get_form_var('phase', 'int');
$new_area = get_form_var('new_area', 'int');
$old_area = get_form_var('old_area', 'int');
$new_room = get_form_var('new_room', 'int');
$old_room = get_form_var('old_room', 'int');
$place = get_form_var('place', 'string');
$name = get_form_var('name', 'string');
$place_disabled = get_form_var('place_disabled', 'string');
$sort_key = get_form_var('sort_key', 'string');
$old_name = get_form_var('old_name', 'string');
$area_name = get_form_var('area_name', 'string');
$room_id = get_form_var('room_id', 'int');

$change_done = get_form_var('change_done', 'string');
$change_place = get_form_var('change_place', 'string');
$change_area = get_form_var('change_area', 'string');

// Get the information about the fields in the places table
$fields = sql_field_info('kth_places');

// Get any user defined form variables
foreach($fields as $field)
{
  switch($field['nature'])
  {
    case 'character':
      $type = 'string';
      break;
    case 'integer':
      $type = 'int';
      break;
    // We can only really deal with the types above at the moment
    default:
      $type = 'string';
      break;
  }
  $var = VAR_PREFIX . $field['name'];
  $$var = get_form_var($var, $type);
  if (($type == 'int') && ($$var === ''))
  {
    unset($$var);
  }
}

// Check the user is authorised for this page
checkAuthorised();

// Also need to know whether they have admin rights
$user = getUserName();
$required_level = (isset($max_level) ? $max_level : 2);
$is_admin = (authGetUserLevel($user) >= $required_level);

// Done changing place information?
if (isset($change_done))
{
  if (!empty($room_id)) // Get the area the instructor is in
  {
    $area = mrbsGetRoomArea($room_id);
  }
  Header("Location: admin.php?day=$day&month=$month&year=$year&area=$area");
  exit();
}

// Intialise the validation booleans
$valid_name_en = TRUE;
$valid_name = TRUE;
$valid_room_id = TRUE;

// PHASE 2
// -------
if ($phase == 2)
{
  // Unauthorised users shouldn't normally be able to reach Phase 2, but just in case
  // they have, check again that they are allowed to be here
  if (isset($change_place))
  {
    if (!$is_admin)
    {
      showAccessDenied($day, $month, $year, $area, "");
      exit();
    }
  }
  
  require_once "functions_mail.inc";

  // PHASE 2 (INSTRUCTOR) - UPDATE THE DATABASE
  // ------------------------------------
  if($environment == 'development') {
    error_log("change_place: " . $change_place);
    error_log("place: " . $place);
  }
  if (isset($change_place) && !empty($place))
  {
      
      // Acquire a mutex to lock out others who might be deleting the new area
      if (!sql_mutex_lock("$tbl_area"))
      {
        fatal_error(TRUE, get_vocab("failed_to_acquire"));
      }
      // Check the new area still exists
      if (sql_query1("SELECT COUNT(*) FROM $tbl_area WHERE id=$new_area LIMIT 1") < 1)
      {
        $valid_area = FALSE;
      }
      // If so
      // check that the place name is not already used in the room
      // (only do this if you're changing the instructor name or the room - if you're
      // just editing the other details for an existing place we don't want to reject
      // the edit because the place already exists!)
      // [SQL escaping done by sql_syntax_casesensitive_equals()]
      elseif ( (($new_room != $old_room) || ($name != $old_name))
              && sql_query1("SELECT COUNT(*)
                               FROM kth_places
                              WHERE" . sql_syntax_casesensitive_equals("full_name", $full_name) . "
                                AND room_id=$new_room
                              LIMIT 1") > 0)
      {
        $valid_name = FALSE;
      }
      // If everything is still OK, update the databasae
      else
      {
        // Convert booleans into 0/1 (necessary for PostgreSQL)
        $place_disabled = (!empty($place_disabled)) ? 1 : 0;
        $sql = "UPDATE kth_places SET ";
        $n_fields = count($fields);
        $assign_array = array();
        foreach ($fields as $field)
        {
          if ($field['name'] != 'id')  // don't do anything with the id field
          {
            switch ($field['name'])
            {
              // first of all deal with the standard MRBS fields
              case 'room_id':
                $assign_array[] = "room_id=$new_room";
                break;
              case 'disabled':
                $assign_array[] = "disabled=$place_disabled";
                break;
              case 'full_name':
                $assign_array[] = "name='" . sql_escape($name) . "'";
                break;
              case 'sort_key':
                $assign_array[] = "sort_key='" . sql_escape($sort_key) . "'";
                break;
              /*name_en??
              case 'email':
                $assign_array[] = "email='" . sql_escape($instructor_email) . "'";
                break;
                */
              // then look at any user defined fields
              default:
                $var = VAR_PREFIX . $field['name'];
                switch ($field['nature'])
                {
                  case 'integer':
                    if (!isset($$var) || ($$var === ''))
                    {
                      // Try and set it to NULL when we can because there will be cases when we
                      // want to distinguish between NULL and 0 - especially when the field
                      // is a genuine integer.
                      $$var = ($field['is_nullable']) ? 'NULL' : 0;
                    }
                    break;
                  default:
                    $$var = "'" . sql_escape($$var) . "'";
                    break;
                }
                $assign_array[] = sql_quote($field['name']) . "=" . $$var;
                break;
            }
          }
        }
        
        $sql .= implode(",", $assign_array) . " WHERE id=$place";
        if($environment == 'development') {
          error_log($sql);
        }
        if (sql_command($sql) < 0)
        {
          echo get_vocab("update_place_failed") . "<br>\n";
          trigger_error(sql_error(), E_USER_WARNING);
          fatal_error(FALSE, get_vocab("fatal_db_error"));
        }
        // if everything is OK, release the mutex and go back to
        // the admin page (for the new area)
        sql_mutex_unlock("$tbl_area");
        Header("Location: admin.php?day=$day&month=$month&year=$year&room=$new_room");
        exit();
      }
    
      // Release the mutex
      sql_mutex_unlock("$tbl_area");
  }
}

// PHASE 1 - GET THE USER INPUT
// ----------------------------

print_header($day, $month, $year, isset($area) ? $area : "", isset($room) ? $room : "");

if ($is_admin)
{
  // Heading is confusing for non-admins
  echo "<h2>" . get_vocab("editplace") . "</h2>\n";
}

// Non-admins will only be allowed to view instructor details, not change them
$disabled = !$is_admin;

// THE INSTRUCTOR FORM
if (isset($change_place) && !empty($place))
{
  $res = sql_query("SELECT * FROM kth_places WHERE id=$place LIMIT 1");
  if (! $res)
  {
    fatal_error(0, get_vocab("error_place") . $room . get_vocab("not_found"));
  }
  $row = sql_row_keyed($res, 0);

  ?>
  <form class="form_general" id="edit_place" action="edit_place.php" method="post">
    <fieldset class="admin">
    <legend></legend>
  
      <fieldset>
      <legend></legend>
        <span class="error">
           <?php 
           // It's impossible to have more than one of these error messages, so no need to worry
           // about paragraphs or line breaks.
           echo ((FALSE == $valid_room) ? get_vocab('invalid_area') : "");
           echo ((FALSE == $valid_name) ? get_vocab('invalid_name') : "");
           ?>
        </span>
      </fieldset>
    
      <fieldset>
      <legend></legend>
      <input type="hidden" name="place" value="<?php echo $row["id"]?>">
    
      <?php
      $areas = get_areas($all=TRUE);
      if (empty($areas))
      {
        fatal_error(FALSE, get_vocab('noareas'));  // should not happen
      }
      
      // The area select box ROOM???
      echo "<div>\n";
      /*
      $params = array('label'         => get_vocab("area") . ":",
                      'name'          => 'new_area',
                      'options'       => $areas,
                      'force_assoc'   => TRUE,
                      'value'         => $row['area_id'],
                      'disabled'      => $disabled,
                      'create_hidden' => FALSE);
      generate_select($params);
      */
      echo "<input type=\"hidden\" name=\"old_room\" value=\"" . $row['room_id'] . "\">\n";
      echo "</div>\n";
      
      // First of all deal with the standard MRBS fields
      // Place name
      echo "<div>\n";
      $params = array('label'         => get_vocab("name") . ":",
                      'name'          => 'name',
                      'value'         => $row['name'],
                      'disabled'      => $disabled,
                      'create_hidden' => FALSE);
      generate_input($params);
      echo "<input type=\"hidden\" name=\"old_name\" value=\"" . htmlspecialchars($row["name"]) . "\">\n";
      echo "</div>\n";
      
      // Status (Enabled or Disabled)
      if ($is_admin)
      {
        echo "<div>\n";
        $options = array('0' => get_vocab("enabled"),
                         '1' => get_vocab("disabled"));
        $params = array('label'         => get_vocab("status") . ":",
                        'label_title'   => get_vocab("disabled_place_note"),
                        'name'          => 'place_disabled',
                        'value'         => ($row['disabled']) ? '1' : '0',
                        'options'       => $options,
                        'force_assoc'   => TRUE,
                        'disabled'      => $disabled,
                        'create_hidden' => FALSE);
        generate_radio_group($params);
        echo "</div>\n";
      }

      // Sort key
      if ($is_admin)
      {
        echo "<div>\n";
        $params = array('label'         => get_vocab("sort_key") . ":",
                        'label_title'   => get_vocab("sort_key_note"),
                        'name'          => 'sort_key',
                        'value'         => $row['sort_key'],
                        'disabled'      => $disabled,
                        'create_hidden' => FALSE);
        generate_input($params);
        echo "</div>\n";
      }

      echo "</fieldset>\n";
    
      // Submit and Back buttons (Submit only if they're an admin)  
      echo "<fieldset class=\"submit_buttons\">\n";
      echo "<legend></legend>\n";
      echo "<div id=\"edit_area_room_submit_back\">\n";
      echo "<input class=\"submit\" type=\"submit\" name=\"change_done\" value=\"" . get_vocab("backadmin") . "\">\n";
      echo "</div>\n";
      if ($is_admin)
      { 
        echo "<div id=\"edit_area_room_submit_save\">\n";
        echo "<input type=\"hidden\" name=\"phase\" value=\"2\">";
        echo "<input class=\"submit default_action\" type=\"submit\" name=\"change_place\" value=\"" . get_vocab("change") . "\">\n";
        echo "</div>\n";
      }
      echo "</fieldset>\n";
        
      ?>
    </fieldset>
  </form>

  <?php
}

output_trailer();

