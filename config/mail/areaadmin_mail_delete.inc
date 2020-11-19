<?php
global $area, $tbl_entry;
setlocale(LC_ALL,"swedish");
$custom_fields_toshow = array();
$sql = "SELECT entry_field_name,type
        FROM kth_entry_custom_fields
        WHERE area_id = $area
        AND visible = 1
        AND type = 'custom'
        ORDER BY sort_order";
$res = sql_query($sql);
$custom_fields_map = array();
if ($res === FALSE)
{
    trigger_error(sql_error(), E_USER_WARNING);
    fatal_error(FALSE, get_vocab("fatal_db_error"));
}

$css = '';
$css_file = 'css/mrbs-mail.css';
if (file_exists($css_file))
{
    $fh = fopen($css_file, 'r');
    $css = fread($fh, filesize($css_file));
}
$html_body['content'] = '
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title></title>
  <style type="text/css">'
      . $css .
  '</style>
</head>
<body id="mrbs">
  <!--[if mso]>
      <style type="text/css">
          body, table, td, h1, div {font-family: Arial, Helvetica, sans-serif !important;}
      </style>
  <![endif]-->';

  setlocale(LC_ALL,"swedish");
  $html_body['content'] .= 
  '<div> 
    Avbokad tid!
  </div>
  <br>
        <table class="bookingdata">
            <tbody>
                <tr>
                    <th>Namn: </th>
                    <td>' . $data['name'] . '</td>
                </tr>
                <tr>
                    <th>Email: </th>
                    <td>' . $data['create_by'] . '</td>
                </tr>
                <tr>
                    <th>Område: </th>
                    <td>' . get_mail_vocab("mrbs") . '</td>
                </tr>
                <tr>
                    <th>Bokning: </th>
                    <td>' . date("H:i",$data['start_time']) . ' till ' . date("H:i",$data['end_time']) . ', ' . utf8_encode(strftime("%A %d %B",$data['start_time'])) . '</td>
                </tr>
                <tr>
                    <th>Typ: </th>
                    <td>' . get_mail_vocab("type." . $data['type']) . '</td>
                </tr>
                <tr>
                    <th>Plats: </th>';
                if ($data['campus'] > 0) {
$html_body['content'] .=      
                    '<td>'. get_campus($data['campus'], 'sv') . '</td>';
                    } else {
$html_body['content'] .=      
                    '<td>'. $data['room_name'] . '</td>';
                }
$html_body['content'] .=
                '</tr>
                <tr>
                    <th>Handledare: </th>
                    <td>' . get_instructor($data['instructor']) . '</td>
                </tr>
                <tr>
                    <th>Användarens campus: </th>
                    <td>';
                if ($data['my_campus'] > 0) {
$html_body['content'] .= get_kth_campus($data['my_campus'], 'sv');
                    }
$html_body['content'] .=
                    '</td>
                </tr>';
                //Övriga fält
                for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
                {
                    //TODO Bort med hårdkodning
                    if($row['entry_field_name'] != 'campus' && $row['entry_field_name'] != 'instructor' && $row['entry_field_name'] != 'my_campus'){
                        //Hämta typ och konvertera ikryssade checkboxar till "Ja"
                        $type_sql ="SELECT
                            DATA_TYPE 
                            FROM
                            INFORMATION_SCHEMA.COLUMNS 
                            WHERE
                            TABLE_NAME = 'mrbs_entry'
                            AND
                            COLUMN_NAME = '" . $row['entry_field_name'] . "'";
                        $type_res = sql_query($type_sql);
                        $type_row = sql_row($type_res, 0);
                        if($type_row[0] == 'smallint' || $type_row[0] == 'tinyint') {
                            if($data[$row['entry_field_name']] == 1) {
                                $currentfieldvalue = 'Ja';
                            } else {
                                $currentfieldvalue = '';
                            }
                        } else {
                            $currentfieldvalue = $data[$row['entry_field_name']];
                        }
$html_body['content'] .=
                '<tr>
                    <th>' . get_mail_vocab('entry.' . $row['entry_field_name']) . ': </th>
                    <td>' . $currentfieldvalue . '</td>
                </tr>'; 
                    }                   
                }
$html_body['content'] .= 
            '</tbody>
        </table>
</body>
</html>
'
;