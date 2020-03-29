<?php
//copy of file "edit_area_room.php"

require "defaultincludes.inc";
require_once "mrbs_sql.inc";

// Get non-standard form variables
$instructor = get_form_var('instructor', 'string');
$full_name = get_form_var('full_name', 'string');
$instructor_disabled = get_form_var('instructor_disabled', 'string');
$sort_key = get_form_var('sort_key', 'string');
$area_name = get_form_var('area_name', 'string');
$instructor_email = get_form_var('email', 'string');

$change_done = get_form_var('change_done', 'string');
$change_instructor = get_form_var('change_instructor', 'string');
$change_area = get_form_var('change_area', 'string');

// Get the information about the fields in the room table
$fields = sql_field_info('kth_instructors');

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

// Done changing area or room information?
if (isset($change_done))
{
  if (!empty($room)) // Get the area the room is in
  {
    $area = mrbsGetRoomArea($room);
  }
  Header("Location: admin.php?day=$day&month=$month&year=$year&area=$area");
  exit();
}

// Intialise the validation booleans
$valid_email = TRUE;
$valid_full_name = TRUE;

// PHASE 2
// -------
if ($phase == 2)
{
  // Unauthorised users shouldn't normally be able to reach Phase 2, but just in case
  // they have, check again that they are allowed to be here
  if (isset($change_room) || isset($change_area))
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
  if (isset($change_instructor) && !empty($instructor))
  {
    // validate the email addresses
    $valid_email = validate_email_list($instructor_email);
  
    if (FALSE != $valid_email)
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
      // If so, check that the room name is not already used in the area
      // (only do this if you're changing the room name or the area - if you're
      // just editing the other details for an existing room we don't want to reject
      // the edit because the room already exists!)
      // [SQL escaping done by sql_syntax_casesensitive_equals()]
      elseif ( (($new_area != $old_area) || ($room_name != $old_room_name))
              && sql_query1("SELECT COUNT(*)
                               FROM $tbl_room
                              WHERE" . sql_syntax_casesensitive_equals("room_name", $room_name) . "
                                AND area_id=$new_area
                              LIMIT 1") > 0)
      {
        $valid_room_name = FALSE;
      }
      // If everything is still OK, update the databasae
      else
      {
        // Convert booleans into 0/1 (necessary for PostgreSQL)
        $room_disabled = (!empty($room_disabled)) ? 1 : 0;
        $sql = "UPDATE $tbl_room SET ";
        $n_fields = count($fields);
        $assign_array = array();
        foreach ($fields as $field)
        {
          if ($field['name'] != 'id')  // don't do anything with the id field
          {
            switch ($field['name'])
            {
              // first of all deal with the standard MRBS fields
              case 'area_id':
                $assign_array[] = "area_id=$new_area";
                break;
              case 'disabled':
                $assign_array[] = "disabled=$room_disabled";
                break;
              case 'room_name':
                $assign_array[] = "room_name='" . sql_escape($room_name) . "'";
                break;
              case 'sort_key':
                $assign_array[] = "sort_key='" . sql_escape($sort_key) . "'";
                break;
              case 'description':
                $assign_array[] = "description='" . sql_escape($description) . "'";
                break;
              case 'capacity':
                $assign_array[] = "capacity=$capacity";
                break;
              case 'room_admin_email':
                $assign_array[] = "room_admin_email='" . sql_escape($room_admin_email) . "'";
                break;
              case 'custom_html':
                $assign_array[] = "custom_html='" . sql_escape($custom_html) . "'";
                break;
			        case 'custom_html_en': //KTH
                $assign_array[] = "custom_html_en='" . sql_escape($custom_html_en) . "'";
                break;
              case 'extra_info':
                $assign_array[] = "extra_info='" . sql_escape($extra_info) . "'";
                break;
			        case 'extra_info_en': //KTH
                $assign_array[] = "extra_info_en='" . sql_escape($extra_info_en) . "'";
                break;
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
        
        $sql .= implode(",", $assign_array) . " WHERE id=$room";
        if (sql_command($sql) < 0)
        {
          echo get_vocab("update_room_failed") . "<br>\n";
          trigger_error(sql_error(), E_USER_WARNING);
          fatal_error(FALSE, get_vocab("fatal_db_error"));
        }
        // if everything is OK, release the mutex and go back to
        // the admin page (for the new area)
        sql_mutex_unlock("$tbl_area");
        Header("Location: admin.php?day=$day&month=$month&year=$year&area=$new_area");
        exit();
      }
    
      // Release the mutex
      sql_mutex_unlock("$tbl_area");
    }
  }
}

// PHASE 1 - GET THE USER INPUT
// ----------------------------

print_header($day, $month, $year, isset($area) ? $area : "", isset($room) ? $room : "");

if ($is_admin)
{
  // Heading is confusing for non-admins
  echo "<h2>" . get_vocab("editinstructor") . "</h2>\n";
}

// Non-admins will only be allowed to view instructor details, not change them
$disabled = !$is_admin;

// THE INSTRUCTOR FORM
if (isset($change_instructor) && !empty($instructor))
{
  $res = sql_query("SELECT * FROM kth_instructors WHERE id=$instructor LIMIT 1");
  if (! $res)
  {
    fatal_error(0, get_vocab("error_instructor") . $room . get_vocab("not_found"));
  }
  $row = sql_row_keyed($res, 0);
  
  echo "<h2>\n";
  echo ($is_admin) ? get_vocab("editinstructor") : get_vocab("viewinstructor");
  echo "</h2>\n";
  ?>
  <form class="form_general" id="edit_instructor" action="edit_instructor.php" method="post">
    <fieldset class="admin">
    <legend></legend>
  
      <fieldset>
      <legend></legend>
        <span class="error">
           <?php 
           // It's impossible to have more than one of these error messages, so no need to worry
           // about paragraphs or line breaks.
           echo ((FALSE == $valid_email) ? get_vocab('invalid_email') : "");
           echo ((FALSE == $valid_area) ? get_vocab('invalid_area') : "");
           echo ((FALSE == $valid_full_name) ? get_vocab('invalid_full_name') : "");
           ?>
        </span>
      </fieldset>
    
      <fieldset>
      <legend></legend>
      <input type="hidden" name="instructor" value="<?php echo $row["id"]?>">
    
      <?php
      $areas = get_areas($all=TRUE);
      if (empty($areas))
      {
        fatal_error(FALSE, get_vocab('noareas'));  // should not happen
      }
      
      // The area select box
      echo "<div>\n";
      $params = array('label'         => get_vocab("area") . ":",
                      'name'          => 'new_area',
                      'options'       => $areas,
                      'force_assoc'   => TRUE,
                      'value'         => $row['area_id'],
                      'disabled'      => $disabled,
                      'create_hidden' => FALSE);
      generate_select($params);
      echo "<input type=\"hidden\" name=\"old_area\" value=\"" . $row['area_id'] . "\">\n";
      echo "</div>\n";
      
      // First of all deal with the standard MRBS fields
      // Instructor name
      echo "<div>\n";
      $params = array('label'         => get_vocab("name") . ":",
                      'name'          => 'full_name',
                      'value'         => $row['full_name'],
                      'disabled'      => $disabled,
                      'create_hidden' => FALSE);
      generate_input($params);
      echo "<input type=\"hidden\" name=\"old_instructor_name\" value=\"" . htmlspecialchars($row["full_name"]) . "\">\n";
      echo "</div>\n";
      
      // Status (Enabled or Disabled)
      if ($is_admin)
      {
        echo "<div>\n";
        $options = array('0' => get_vocab("enabled"),
                         '1' => get_vocab("disabled"));
        $params = array('label'         => get_vocab("status") . ":",
                        'label_title'   => get_vocab("disabled_instructor_note"),
                        'name'          => 'room_disabled',
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

      // Email
      echo "<div>\n";
      $params = array('label'         => get_vocab("email") . ":",
                      'name'          => 'email',
                      'value'         => $row['email'],
                      'disabled'      => $disabled,
                      'create_hidden' => FALSE);
      generate_input($params);
      echo "</div>\n";
    
      // then look at any user defined fields  
      foreach ($fields as $field)
      {
        if (!in_array($field['full_name'], $standard_fields['instructors']))
        {
          echo "<div>\n";
          $params = array('label'         => get_loc_field_name('kth_instructors', $field['full_name']) . ":",
                          'name'          => VAR_PREFIX . $field['full_name'],
                          'value'         => $row[$field['full_name']],
                          'disabled'      => $disabled,
                          'create_hidden' => FALSE);
          // Output a checkbox if it's a boolean or integer <= 2 bytes (which we will
          // assume are intended to be booleans)
          if (($field['nature'] == 'boolean') || 
              (($field['nature'] == 'integer') && isset($field['length']) && ($field['length'] <= 2)) )
          {
            generate_checkbox($params);
          }
          // Output a textarea if it's a character string longer than the limit for a
          // text input
          elseif (($field['nature'] == 'character') && isset($field['length']) && ($field['length'] > $text_input_max))
          {
            $params['attributes'] = array('rows="4"', 'cols="40"');
            generate_textarea($params);
          }
          // Otherwise output a text input
          else
          {
            generate_input($params);
          }
          echo "</div>\n";
        }
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
        echo "<input class=\"submit default_action\" type=\"submit\" name=\"change_instructor\" value=\"" . get_vocab("change") . "\">\n";
        echo "</div>\n";
      }
      echo "</fieldset>\n";
        
      ?>
    </fieldset>
  </form>

  <?php
}

output_trailer();

