<?php
require_once "config.inc.php";
require_once "functions.inc";
global $cas_server;
// Timezone
date_default_timezone_set("Europe/Stockholm");

if (!empty($_GET["formlanguage"])) {
	$formlanguage = $_GET["formlanguage"];
} else {
	$formlanguage = "en";
}
if (!empty($_GET["returl"])) {
	$returl = $_GET["returl"];
} else {
	$returl = "/";
}
$returl = str_replace('&','ampersand',$returl);

//191003
//Egna sessionnames per app från config.inc
if(isset($session_name)) {
	$sessionname = $session_name;
	session_name($sessionname);
}

session_start();

//210519 OpenID Connect framework(myits)
require_once($_SERVER['DOCUMENT_ROOT'] .  '/myits/vendor/autoload.php');

use Its\Sso\OpenIDConnectClient;
use Its\Sso\OpenIDConnectClientException;

try {
	$oidc = new OpenIDConnectClient(
		$kth_auth_endpoint,
		$kth_client_id,
		$kth_client_secret
	);

	$oidc->addScope('openid email profile');
  
	// remove this if in production mode
	$oidc->setVerifyHost(false);
	$oidc->setVerifyPeer(false);

	$oidc->setRedirectURL(html_entity_decode("https://" . $_SERVER['HTTP_HOST'] . "/" . $app_name . "/mrbs_login.php?sessionname=" . $sessionname . "&formlanguage=" . $formlanguage . "&returl=" . $returl)); // must be the same as you registered

	//Skickar vidare till login på KTH om användaren inte redan är inloggad
	$oidc->authenticate();
	//Vid redan inloggad exekveras koden nedan 

	//id_token innehåller den användarinfo tjänsten prenumererar på(här används kthid)
	$_SESSION['id_token'] = $oidc->getIdToken();
	$userinfo = decodeJWT($_SESSION['id_token'], 1);
	$_SESSION['kth_id'] = $userinfo->kthid;

	//finns ett kthid så startas applikationen
	if(isset($_SESSION['kth_id']) && $_SESSION['kth_id'] != "") {
		$userid = $_SESSION['kth_id']  ;
		$returl = str_replace('ampersand','&',$returl);
		header("location: " . $returl);
	}
  
} catch (OpenIDConnectClientException $e) {
	echo $e->getMessage();
}


?>
