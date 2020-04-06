<?php
global $mrbslang;
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
  '<div>Hej!</div>
  </br>
  <div> 
    Avbokad tid!
  </div>
  <div> 
    Bokad av:' . $data['name'] .
  '</div>
  </br>';
  $html_body['content'] .=    
  '<div>' .
    'Bokning ' . date("H:i",$data['start_time']) . ' till ' . date("H:i",$data['end_time']) . ', ' . utf8_encode(strftime("%A %d %B",$data['start_time'])) .
  '</div>
  </br>';
    $html_body['content'] .= '
</body>
</html>
'
;