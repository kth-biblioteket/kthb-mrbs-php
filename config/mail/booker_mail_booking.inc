<?php
global $mrbslang, $environment;
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

if ($mrbslang == 'sv') {
  setlocale(LC_ALL,"swedish");
}
else {
  setlocale(LC_ALL,"eng");
}

if(stripos(get_campus($data['campus'], $mrbslang), 'zoom')==false) {
  $html_body['content'] .= get_vocab("mail_text");
} else {
  $html_body['content'] .= get_vocab("mail_text_digital");
}

if ($data['campus'] > 0) {
  $html_body['content'] = str_replace("@@place",get_campus($data['campus'], $mrbslang),$html_body['content']);
} else {
  $html_body['content'] = str_replace("@@place",($data['room_number'] != "" ? $data['room_number'] . ". " : "") . $data['room_name'],$html_body['content']);
}
$html_body['content'] = str_replace("@@timedate",date("H:i",$data['start_time']) . ', ' . utf8_encode(strftime("%A %d %B",$data['start_time'])),$html_body['content']);
$html_body['content'] = str_replace("@@linktobooking",'<a style="background-color: #B0C92B;padding: 15px 25px; border-radius: 30px; border: 1px solid #B0C92B; border-image: none; color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-weight: bold;font-size: 16px; text-decoration: none; display: inline-block;" href="https://' . dirname($_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF']) . '/edit_entry.php?id=' . $data["id"] . '&lang=sv">' . 'Gå till din bokning' . '</a>', $html_body['content']);
if($data['area_map']) {
  $html_body['content'] = str_replace("@@map",'<br><br><img src="https://' . dirname($_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF']) . '/' . 'images' .'/' . $data['area_map_image'] .'"></img>', $html_body['content']);
}
$html_body['content'] .= '
</body>
</html>';