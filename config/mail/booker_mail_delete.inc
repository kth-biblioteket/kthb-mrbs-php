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

if ($mrbslang == 'sv') {
  setlocale(LC_ALL,"swedish");
  $html_body['content'] .=   
  '<div>Hej!</div>
  </br>
  <div>' .
    get_vocab("mail_text_cancel") .
  '</div>
  </br>';
  $html_body['content'] .=    
  '<div>' .
    'Din bokning var från ' . date("H:i",$data['start_time']) . ' till ' . date("H:i",$data['end_time']) . ', ' . utf8_encode(strftime("%A %d %B",$data['start_time'])) .
  '</div>
  </br>';
  $html_body['content'] .=     
  '<div>Vänliga hälsningar</div>
  </br>
  <div>KTH Biblioteket</div>
  <div>08 - 790 70 88</div>
  <div>www.kth.se/biblioteket</div>';
} else {
  setlocale(LC_ALL,"eng");
  $html_body['content'] .=   '
  <div>Hi!</div>
    </br>
  <div>' .
    get_vocab("mail_text_cancel") .
  '</div>
  </br>';
  $html_body['content'] .=    
  '<div>' .
    'Your booking was from ' . date("H:i",$data['start_time']) . ' to ' . date("H:i",$data['end_time']) . ', ' . utf8_encode(strftime("%A %d %B",$data['start_time'])) .
  '</div>
  </br>';
  $html_body['content'] .=   
  '<div>Kind regards</div>
  </br>
  <div>KTH Library</div>
  <div>08 - 790 70 88</div>
  <div>www.kth.se/en/biblioteket</div>';
}
$html_body['content'] .= '
</body>
</html>
'
;