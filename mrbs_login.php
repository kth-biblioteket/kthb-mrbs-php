<?php
require_once "config.inc.php";
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
//Egna sessionnames per app
if(isset($_GET['sessionname'])) {
	$sessionname_in_url = "sessionname=" . $_GET['sessionname'];
	$sessionname = $_GET['sessionname'];
	session_name($sessionname);
}
	

$_SERVER['HTTP_X_FORWARDED_HOST'] = $_SERVER['HTTP_HOST'];
$_SERVER['REQUEST_URI']=html_entity_decode("/" . $app_name . "/mrbs_login.php?sessionname=" . $sessionname . "&formlanguage=" . $formlanguage . "&returl=" . $returl);

/*
require_once $_SERVER['DOCUMENT_ROOT'] . '/CAS/CAS.php';

// Uncomment to enable debugging
//phpCAS::setDebug($_SERVER['DOCUMENT_ROOT'] . '/CAS/cas.log');

phpCAS::client(CAS_VERSION_2_0,$cas_server,443,'', false);
phpCAS::setNoCasServerValidation();
phpCAS::forceAuthentication();
$casUser = phpCAS::getUser();

if($casUser) {
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}
	$_SESSION['kth_id']  	= $casUser ; 	// $kthid->user_name;
	$userid 				= $_SESSION['kth_id']  ;
	$returl = str_replace('ampersand','&',$returl);
	header("location: " . $returl);
}
*/


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
 
    $oidc->setRedirectURL("https://" . $_SERVER['HTTP_HOST'] . "/" . $app_name); // must be the same as you registered
    $oidc->addScope('openid email'); //must be the same as you registered
    
    // remove this if in production mode
    $oidc->setVerifyHost(false);
    $oidc->setVerifyPeer(false);
	
    $oidc->authenticate(); //call the main function of SSO login
    $_SESSION['id_token'] = $oidc->getIdToken(); // must be save for check session dan logout proccess
	$kthUser = $oidc->requestUserInfo(); // this will return user information from SSO database
	if($kthUser) {
		if (session_status() == PHP_SESSION_NONE) {
			session_start();
		}
		$_SESSION['kth_id'] = $kthUser->email;
		$userid = $_SESSION['kth_id']  ;
	}
    
} catch (OpenIDConnectClientException $e) {
    echo $e->getMessage();
}

?>
