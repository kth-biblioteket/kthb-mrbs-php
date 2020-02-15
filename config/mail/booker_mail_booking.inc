<?php
global $mrbslang;
if ($mrbslang == 'sv') {
  $html_body['content'] =   
  '<div>Hej!</div>
  </br>
  <div>' .
    get_vocab("mail_text") .
  '</div>
  </br>';
  if ($data['campus'] > 0) {
  $html_body['content'] .=      
  '<div>
    Plats: '. get_campus($data['campus']) .
  '</div>';
  } else {
  $html_body['content'] .=      
  '<div>
    Plats: '. $data['room_name'] .
  '</div>';
  }
  $html_body['content'] .=    
  '</br>
  <div>' .
    'Din bokning är från ' . date("H:i",$data['start_time']) . ' till ' . date("H:i",$data['end_time']) . ', ' . date("l d F",$data['start_time']) .
  '</div>
  </br>
  <div>Denna länk leder till din bokning, där du kan avboka eller ändra den vid behov.</div>
  </br>
  <div>
    <table border="0" cellspacing="0" cellpadding="0">
      <tbody>
        <tr>
          <td align="center" style="border-radius: 30px;" bgcolor="#B0C92B">
            <a style="padding: 15px 25px; border-radius: 30px; border: 1px solid #B0C92B; border-image: none; color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-weight: bold;font-size: 16px; text-decoration: none; display: inline-block;" href="https://' . dirname($_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF']) . '/edit_entry.php?id=' . $data["id"] . '&lang=sv">' . 'Gå till din bokning' . '</a>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  </br>';
if($data['area_map']) {
$html_body['content'] .= 
  '<div><img src="https://' . dirname($_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF']) . '/' . 'images' .'/' . $data['area_map_image'] .'"></img></div>
  </br>';
}
$html_body['content'] .=     
  '<div>Vänliga hälsningar</div>
  </br>
  <div>KTH Biblioteket</div>
  <div>08 - 790 70 88</div>
  <div>www.kth.se/biblioteket</div>';
} else {
  $html_body['content'] =   '
  <div>Hi!</div>
    </br>
  <div>' .
    get_vocab("mail_text") .
  '</div>
  </br>';
if ($data['campus'] > 0) {
$html_body['content'] .=      
  '<div>
    Location: '. get_campus($data['campus']) .
  '</div>';
} else {
$html_body['content'] .=      
  '<div>
    Location: '. $data['room_name'] .
  '</div>';
  }
$html_body['content'] .=    
  '</br>
  <div>' .
    'Your booking is from ' . date("H:i",$data['start_time']) . ' to ' . date("H:i",$data['end_time']) . ', ' . date("l d F",$data['start_time']) .
  '</div>
  </br>
  <div>This link leads to your booking where you can change or cancel it if needed.</div>
  </br>
  <div>
    <table border="0" cellspacing="0" cellpadding="0">
      <tbody>
        <tr>
          <td align="center" style="border-radius: 30px;" bgcolor="#B0C92B">
            <a style="padding: 15px 25px; border-radius: 30px; border: 1px solid #B0C92B; border-image: none; color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 16px; font-weight: bold;text-decoration: none; display: inline-block;" href="https://' . dirname($_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF']) . '/edit_entry.php?id=' . $data["id"] . '&lang=en">' . 'Go to your booking' . '</a>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  </br>';
if($data['area_map']) {
$html_body['content'] .= 
  '<div>
    <img src="https://' . dirname($_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF']) . '/' . 'images' .'/' . $data['area_map_image'] .'"></img>
  </div>
  </br>';
}
$html_body['content'] .=   
  '<div>Kind regards</div>
  </br>
  <div>KTH Library</div>
  <div>08 - 790 70 88</div>
  <div>www.kth.se/en/biblioteket</div>';
}