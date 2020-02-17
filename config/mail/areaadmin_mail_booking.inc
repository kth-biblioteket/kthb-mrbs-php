<?php
global $area, $tbl_entry;
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
    <div id="contents">
        <h1>Ny bokning</h1>
        <div>
            <table border="0" cellspacing="0" cellpadding="0">
                <tbody>
                    <tr>
                    <td align="center" style="border-radius: 30px;" bgcolor="#B0C92B">
                        <a style="padding: 15px 25px; border-radius: 30px; border: 1px solid #B0C92B; border-image: none; color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-weight: bold;font-size: 16px; text-decoration: none; display: inline-block;" href="https://' . dirname($_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF']) . '/edit_entry.php?id=' . $data["id"] . '&lang=sv">' . 'To booking' . '</a>
                    </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <table>
            <tbody>
                <tr>
                    <td>Namn: </td>
                    <td>' . $data['name'] . '</td>
                </tr>
                <tr>
                    <td>Område: </td>
                    <td>' . get_vocab("mrbs") . '</td>
                </tr>
                <tr>
                    <td>Bokning: </td>
                    <td>' . date("H:i",$data['start_time']) . ' till ' . date("H:i",$data['end_time']) . ', ' . date("l d F",$data['start_time']) . '</td>
                </tr>
                <tr>
                    <td>Typ: </td>
                    <td>' . get_type_vocab($data['type']) . '</td>
                </tr>
                <tr>
                    <td>Bokad av: </td>
                    <td>' . $data['create_by'] . '</td>
                </tr>';
                for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
                {
$html_body['content'] .=
                '<tr>
                    <td>' . get_loc_field_name($tbl_entry, $row['entry_field_name']) . ': </td>
                    <td>' . $data[$row['entry_field_name']] . '</td>
                </tr>';                    
                }
$html_body['content'] .= 
            '</tbody>
        </table>';
        for ($i = 0; ($row = sql_row_keyed($res, $i)); $i++)
        {
$html_body['content'] .=
        '<div>
            <span>' . get_loc_field_name($tbl_entry, $row['entry_field_name']) . ': </span>
            <span>' . $data[$row['entry_field_name']] . '</span>
        </div>';                    
        }
$html_body['content'] .=
    '</div>
</body>
</html>
'
;