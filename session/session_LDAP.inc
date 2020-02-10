<?php
/*****************************************************************************\
*                                                                             *
*   File name       session_LDAP.inc                                           *
*                                                                             *
*   Description     Use PHP built-in sessions handling                        *
*                                                                             *
*   Notes           To use this authentication scheme, set in                 *
*                   config.inc.php:                                           *
*                       $auth["session"]  = "LDAP";                            *
*                                                                             *
*                                                                             *
*   History                                                                   *
*    2003/11/09 JFL Created this file                                         *
*    Remaining history in ChangeLog and CVS logs                              *
*                                                                             *
\*****************************************************************************/

//191003
// $Id$
global $PHP_SELF, $auth;
$page = basename($PHP_SELF, "");
// Get non-standard form variables
$Action = get_form_var('Action', 'string');
$NewUserName = get_form_var('NewUserName', 'string');
$NewUserPassword = get_form_var('NewUserPassword', 'string');
$TargetURL = get_form_var('TargetURL', 'string');
$returl = get_form_var('returl', 'string');
//KTH area
$area = get_form_var('area', 'string');

//191003
$CSRFToken = get_form_var('CSRFToken', 'string');
$auth["method"]="ldap";
//KTH logga ut vid timeout
if (isset($_GET["logout"])) {
	if ($_GET["logout"] == "true") {
		$NewUserName = "";
		$Action = "SetName";
		$TargetURL = $PHP_SELF;
	}
} 	
if (isset($cookie_path_override)) {
	$cookie_path = $cookie_path_override;
} else {
	$cookie_path = $PHP_SELF;
	// Strip off everything after the last '/' in $PHP_SELF
	$cookie_path = preg_replace('/[^\/]*$/', '', $cookie_path);
}

if (!isset($auth["session_php"]["session_expire_time"])) {
	// Default to the behaviour of previous versions of MRBS, use only
	// session cookies - no persistent cookie.
	$auth["session_php"]["session_expire_time"] = 0;
}

//191003 Skilj på olika sessioner
session_name($session_name);  // call before session_set_cookie_params() - see PHP manual
//KTH Inloggning via LDAP(kthid)
//Expire = ??
//session_set_cookie_params($auth["session_php"]["session_expire_time"], $cookie_path);
                          
// Checking the result of session_start() is not very reliable.   Before PHP 5.3.0
// it always returned TRUE.   Even after 5.3.0 it seems to return TRUE even if the
// session_save_path is not writable.  A warning is generated, but session_start()
// still returns TRUE.
if (FALSE === session_start()) {
	trigger_error("MRBS: could not start session", E_USER_WARNING);
	fatal_error(TRUE, "MRBS: server configuration error.", FALSE);
}
//191003 
if ($is_kiosk) {
  if (strpos($page, 'day.php') !== FALSE || strpos($page, 'week.php') !== FALSE) {
    // Unset the session variables
    if (isset($_SESSION))
    {
      $_SESSION = array();
    }
    else
    {
      global $HTTP_SESSION_VARS;
      $HTTP_SESSION_VARS = array();
    }
  }
}	

if (!isset($_SESSION['CSRFToken']))
{
	$_SESSION['CSRFToken'] = md5(uniqid(rand(), TRUE));
	$_SESSION['CSRFToken_time'] = time();
}
// Check to see if we've been inactive for longer than allowed and if so logout
// the user 
if (!empty($auth["session_php"]["inactivity_expire_time"]))
{
  $ajax = get_form_var('ajax', 'int');
  $activity = get_form_var('activity', 'int');
  // KTH. gäller inte för adminusers
  $user = getUserName();
  $is_admin = (authGetUserLevel($user) >= 2);
  if ($is_admin == FALSE && isset($_SESSION) && isset($_SESSION['LastActivity']) && ((time() - $_SESSION['LastActivity']) > $auth["session_php"]["inactivity_expire_time"]))
  {
    if ($ajax) {
      $auth['ajaxlogout'] = "TRUE";
    } else {
      unset($_SESSION["UserName"]);
      unset($_SESSION["full_name"]);
      unset($_SESSION["email_address"]);
      unset($_SESSION["phone_number"]);
      unset($_SESSION['CSRFToken']);
      unset($_SESSION['CSRFToken_time']);
    }
  }
  // Ajax requests don't count as activity, unless it's the special Ajax request used
  // to record client side activity

  if ($activity || !$ajax || !isset($_SESSION['LastActivity']))
  {
    $_SESSION['LastActivity'] = time();
  }
}

/*
  Target of the form with sets the URL argument "Action=SetName".
  Will eventually return to URL argument "TargetURL=whatever".
*/
if (isset($Action) && ($Action == "SetName"))
{
  /* First make sure the password is valid 
  KTH Utloggning hamnar också här (post till Admin.php med NewUserName=""
  */
  //KTH Inloggning via LDAP(kthid) 

  if ($NewUserName == "")
  {
  // Unset the session variables
    if (isset($_SESSION))
    {
    $_SESSION = array();
    }
    else
    {
      global $HTTP_SESSION_VARS;
      $HTTP_SESSION_VARS = array();
    }
  }
  else
  {
    //validera med LDAP
    //kolla mot session token CSRF
    
    if ($CSRFToken != $_SESSION['CSRFToken']) {
      print_header(0, 0, 0, 0, "");
      echo "<p>session CSRFToken not validated</p>\n";
      printLoginForm($TargetURL);
      unset($_SESSION["UserName"]);
      exit();
    }
    
    $response = authValidateUser($NewUserName, $NewUserPassword, false);
    $almavalidate = json_decode($response);
    if ($almavalidate->result == 0)
    {
      print_header(0, 0, 0, 0, "");
      echo "<p>".$almavalidate->message."</p>\n";
      printLoginForm($TargetURL);
      unset($_SESSION["UserName"]);
      exit();
    }
    if (isset($_SESSION))
    {
      $auth['loggedin'] = "TRUE";
      $_SESSION["UserName"] = $almavalidate->primary_id;
      $_SESSION["full_name"] = $almavalidate->full_name;
      $_SESSION["email_address"] = $almavalidate->email_address;
      $_SESSION["phone_number"] = $almavalidate->phone_number;
      $_SESSION["user_group"] = $almavalidate->user_group;
    }
    else
    {
      $auth['loggedin'] = "TRUE";
      global $HTTP_SESSION_VARS;
      $HTTP_SESSION_VARS["UserName"] = $almavalidate->primary_id;//$NewUserName;
      $HTTP_SESSION_VARS["full_name"] = $almavalidate->full_name;//$NewUserName;
      $HTTP_SESSION_VARS["email_address"] = $almavalidate->email_address;
      $HTTP_SESSION_VARS["phone_number"] = $almavalidate->phone_number;
      $HTTP_SESSION_VARS["user_group"] = $almavalidate->user_group;
    }
  }
  // preserve the original $HTTP_REFERER by sending it as a GET parameter
  if (!empty($returl))
  {
    // check to see whether there's a query string already
    if (strpos($TargetURL, '?') === false)
    {
      $TargetURL .= "?returl=" . urlencode($returl);
    }
    else
    {	//KTH
		if (strpos($TargetURL, 'returl') === false) {
			$TargetURL .= "&returl=" . urlencode($returl);
		}
		{
		}
    }
  }
  // Problems have been reported on Windows IIS with session data not being
  // written out without a call to session_write_close()
  session_write_close();
  //kth area
  //header ("Location: $TargetURL?area=$area"); /* Redirect browser to initial page */
  header ("Location: $TargetURL"); /* Redirect browser to initial page */
  
  /* Note HTTP 1.1 mandates an absolute URL. Most modern browsers support relative URLs,
    which allows to work around problems with DNS inconsistencies in the server name.
    Anyway, if the browser cannot redirect automatically, the manual link below will work. */
  print_header(0, 0, 0, 0, "");
  echo "<br>\n";
  echo "<p>Please click <a href=\"".htmlspecialchars($TargetURL)."\">here</a> if you're not redirected automatically to the page you requested.</p>\n";

  // Print footer and exit
  print_footer(TRUE);
}


/*
  Display the login form. Used by two routines below.
  Will eventually return to $TargetURL.
*/
function printLoginForm($TargetURL)
{
  global $PHP_SELF, $HTTP_REFERER;
  global $returl;
?>
<form autocomplete="off" class="form_general" id="logon" method="post" action="<?php echo htmlspecialchars(this_page()) ?>">
  <fieldset>
  <h3><?php echo get_vocab("please_login") ?></h3>
  <?php if (get_vocab("login_info")!="") {?>
	<div style="width:auto" class="infobox_green">
		<?php echo get_vocab("login_info") ?>
	</div>
  <?php }?>
    <div>
      <label for="NewUserName"><?php echo get_vocab("users.name") ?>:</label>
      <input type="text" id="NewUserName" name="NewUserName">
    </div>
    <div>
      <label for="NewUserPassword"><?php echo get_vocab("users.password") ?>:</label>
      <input type="password" id="NewUserPassword" name="NewUserPassword">
    </div>
    <?php
    // We need to preserve the original calling page, so that it's there when we eventually get
    // to the TargetURL (especially if that's edit_entry.php).  If this is the first time through then $HTTP_REFERER holds
    // the original caller.    If this is the second time through we will have stored it in $returl.
    if (!isset($returl))
    {
      $returl = isset($HTTP_REFERER) ? $HTTP_REFERER : "";
    }
    echo "<input type=\"hidden\" name=\"returl\" value=\"" . htmlspecialchars($returl) . "\">\n";
    ?>
    <input type="hidden" name="CSRFToken" value="<?php echo $_SESSION['CSRFToken']; ?>" />
    <input type="hidden" name="TargetURL" value="<?php echo htmlspecialchars($TargetURL) ?>">
    <input type="hidden" name="Action" value="SetName">
	<?php //KTH ?>
    <div id="logon_submit" style="width:100%;max-width:100%">
		<button class="btn btn-secondary" type="button" value=" <?php echo get_vocab('back') ?> " style="clear:none;position:initial;position:static" onclick="javascript:location.href='<?php echo htmlspecialchars($returl) ?>'; return false;"><?php echo get_vocab('back') ?></button>
		<button class="btn btn-success submit default_action" type="submit" value=" <?php echo get_vocab('login') ?> " style="clear:none;position:initial;position:static"><?php echo get_vocab('login') ?></button>
    </div>
  </fieldset>
</form>
<?php
  echo "</div>";  // Close of the contents div
  // Print footer and exit
  print_footer(TRUE);
}

/*
  Target of the form with sets the URL argument "Action=QueryName".
  Will eventually return to URL argument "TargetURL=whatever".
*/

if (isset($Action) && ($Action == "QueryName"))
{
  //KTH area
  print_header(0, 0, 0, $area, "");
  printLoginForm($TargetURL);
  exit();
}

/* authGet()
 * 
 * Request the user name/password
 * 
 * Returns: Nothing
 */
 //KTH area
function authGet($area = 2)
{
  global $PHP_SELF, $QUERY_STRING;
  
  print_header(0, 0, 0, $area, "");
  echo "<p>".get_vocab("norights")."</p>\n";

  $TargetURL = basename($PHP_SELF);
  if (isset($QUERY_STRING))
  {
    $TargetURL = $TargetURL . "?" . $QUERY_STRING;
  }
  printLoginForm($TargetURL);
 
  exit();
}

function getUserName()
{
  //KTH Inloggning via LDAP(kthid)
  global $auth;
  if (isset($_SESSION) && isset($_SESSION["UserName"]) && ($_SESSION["UserName"] !== '')) {
      return $_SESSION["UserName"];
    }
    else {
      global $HTTP_SESSION_VARS;
      if (isset($HTTP_SESSION_VARS["UserName"]) && ($HTTP_SESSION_VARS["UserName"] !== ''))
      {
        return $HTTP_SESSION_VARS["UserName"];
      }
  }
}

//191003
function getFullName()
{
  //KTH Inloggning via LDAP(kthid)
  global $auth;
  if (isset($_SESSION) && isset($_SESSION["full_name"]) && ($_SESSION["full_name"] !== ''))
    {
      return $_SESSION["full_name"];
    }
    else
    {
      global $HTTP_SESSION_VARS;
      if (isset($HTTP_SESSION_VARS["full_name"]) && ($HTTP_SESSION_VARS["full_name"] !== ''))
      {
        return $HTTP_SESSION_VARS["full_name"];
      }
    }
}

//191003
function getEmail()
{
  //KTH Inloggning via LDAP(kthid)
  global $auth;
  if (isset($_SESSION) && isset($_SESSION["email_address"]) && ($_SESSION["email_address"] !== ''))
    {
      return $_SESSION["email_address"];
    }
    else
    {
      global $HTTP_SESSION_VARS;
      if (isset($HTTP_SESSION_VARS["email_address"]) && ($HTTP_SESSION_VARS["email_address"] !== ''))
      {
      return $HTTP_SESSION_VARS["email_address"];
      }
    }
}

//191003
function getPhone()
{
  //KTH Inloggning via LDAP(kthid)
  global $auth;
	if (isset($_SESSION) && isset($_SESSION["phone_number"]) && ($_SESSION["phone_number"] !== ''))
		{
			return $_SESSION["phone_number"];
		}
		else
		{
			global $HTTP_SESSION_VARS;
			if (isset($HTTP_SESSION_VARS["phone_number"]) && ($HTTP_SESSION_VARS["phone_number"] !== ''))
			{
			return $HTTP_SESSION_VARS["phone_number"];
			}
		}
}

//191003
function getUsergroup()
{
  //KTH Inloggning via LDAP(kthid)
  global $auth;
	if (isset($_SESSION) && isset($_SESSION["user_group"]) && ($_SESSION["user_group"] !== ''))
		{
			return $_SESSION["user_group"];
		}
		else
		{
			global $HTTP_SESSION_VARS;
			if (isset($HTTP_SESSION_VARS["user_group"]) && ($HTTP_SESSION_VARS["user_group"] !== ''))
			{
			return $HTTP_SESSION_VARS["user_group"];
			}
		}
}

// Print the logon entry on the top banner.
//KTH area
function PrintLogonBox($area = 2)
{
  //KTH
  //KTH Inloggning via LDAP(kthid)
  //191003
  global $PHP_SELF, $QUERY_STRING, $user_list_link, $day, $month, $year, $is_admin, $auth, $session_name, $app_name;

  $TargetURL = basename($PHP_SELF);
  if (isset($url_base) && ($url_base !== ''))
  {
    $TargetURL = $url_base . '/' . $TargetURL;
  }
  if (isset($QUERY_STRING))
  {
    $TargetURL = $TargetURL . "?" . $QUERY_STRING;
  }
  $user=getUserName();
  
  $full_name=getFullName();
  //KTH
  $userlevel = authGetUserLevel($user);
  if (isset($user))
  {
    // words 'you are xxxx' becomes a link to the
    // report page with only entries created by xxx. Past entries are not
    // displayed but this can be changed
    $search_string = "report.php?from_day=$day&amp;from_month=$month&amp;".
      "from_year=$year&amp;to_day=1&amp;to_month=12&amp;to_year=2030&amp;areamatch=&amp;".
      "roommatch=&amp;namematch=&amp;descrmatch=&amp;summarize=1&amp;sortby=r&amp;display=d&amp;".
      "sumby=d&amp;creatormatch=".urlencode($user); ?>
				<?php 
				//KTH
				if ($userlevel == 2) {
					$user = $user . ", admin";
				}
				if ($userlevel == 3) {
					$user = $user . ", sysadmin";
				}
				?>
        <!--a href="<?php echo "$search_string\" title=\"" . get_vocab('show_my_entries') . "\">" . get_vocab('you_are') . " " . htmlspecialchars($full_name ."(". $user . ")") ?></a-->
        <div style="margin-bottom:10px"><?php echo get_vocab('you_are') . htmlspecialchars($full_name ."(". $user . ")") ?></div>
          <?php //191003?>
          <!--form method="post" action="/tandem/mrbs_login.php?returl=/<?php echo $app_name?>/<?php echo urlencode($TargetURL) ?>&sessionname=<?php echo $session_name?>&logout=true"-->
          <script>
            function logoutfromldap() {
              $.post('logout.php?ldap=true',
                      function(result) {
                      },
              'json');
            }
          </script>
          <form method="post" action="admin.php">
            <input type="hidden" name="TargetURL" value="<?php echo htmlspecialchars($TargetURL) ?>">
            <input type="hidden" name="Action" value="SetName">
            <input type="hidden" name="NewUserName" value="">
            <input type="hidden" name="NewUserPassword" value="">
            <?php //191003?>
            <input class="btn btn-info" type="submit" value=" <?php echo get_vocab('logoff') ?> ">
            <!--input class="btn btn-info" type="button" value=" <?php echo get_vocab('logoff') . "_test" ?> " onclick="javascript:logoutfromldap(); return false;"-->
          </form>
<?php
  }
  else
  {
?>
                <!--a href=""><?php echo get_vocab('unknown_user'); ?></a-->
				        <?php //echo get_vocab('unknown_user'); ?>
                <?php //KTH KTHLDAP
                  //echo "method: " . $auth["method"];
                ?>
                <?php //191003?>
                <form method="post" action="admin.php">
                  <div>
                    <input type="hidden" name="TargetURL" value="<?php echo htmlspecialchars($TargetURL) ?>">
                    <input type="hidden" name="Action" value="QueryName">
                    <?php //KTH area?>
                    <input type="hidden" name="area" value="<?php echo $area?>">
                    <?php //191003?>
                    <input class="btn btn-info" type="submit" value=" <?php echo get_vocab('login') ?> ">
                  </div>
                </form>
<?php
  } 
  if (isset($user_list_link))
  {
    print "<a id=\"user_list_link\" href=\"$user_list_link\">" . get_vocab('user_list') . "</a>\n";
  }
}

