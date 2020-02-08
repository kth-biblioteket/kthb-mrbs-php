<?php

// $Id$


// Print the page header
function print_theme_header($day, $month, $year, $area, $room) {
	global $mrbs_company, $mrbs_company_logo, $mrbs_company_url, $mrbs_company_more_info, $search_str, $locale_warning;
	global $tbl_entry, $tbl_room, $tbl_area;
	global $PHP_SELF, $HTTP_HOST, $QUERY_STRING;
	global $view_week_number, $weekstarts, $times_along_top, $periods, $enable_periods;
	global $auth, $max_level;
	global $default_language_tokens, $disable_automatic_language_changing, $override_locale;
	global $select_options;
	global $ajax_refresh_rate;
	global $main_table_cell_border_width, $main_cell_height;
	global $timetohighlight;
	//KTH
	global $mrbslang;
	//191003
	global $session_name, $app_name, $kth_www, $is_kiosk;
  
	$page = basename($PHP_SELF, ".php");
	$user = getUserName();

	if(!isset($user)) {
		if($auth["method"] == "kthcas") {
			header("location: mrbs_login.php?returl=/" . $app_name . "/" . urlencode($TargetURL) . "&sessionname=" . $session_name );
			exit;
		}
		if($auth["method"] == "ldap") {

		}
		if($auth["method"] == "alma") {

		}
	}
	$is_admin = (authGetUserLevel($user) >= $max_level);
	//KTH
	$userlevel = authGetUserLevel($user);
	// Need to set the timezone before we can use date()
	get_area_settings($area);

	// If we dont know the right date then make it up 
	if (!$day) {
		$day   = date("d");
	}
	if (!$month) {
		$month = date("m");
	}
	if (!$year) {
		$year  = date("Y");
	}
	if (!isset($search_str)) {
		$search_str = "";
	}
	http_headers();
	echo DOCTYPE;
	$default_view = get_default_view($area); //KTH
	switch ($default_view) {
		case "month":
			$redirect_str = "month.php";
			break;
		case "week":
			$redirect_str = "week.php";
			break;
		case 2:
			$redirect_str = "month.php";
			break;
		case 1:
			$redirect_str = "week.php";
			break;
		case 0:
			$redirect_str = "day.php";
			break;
		default:
			$redirect_str = "day.php";
	}
?>

<html>
	<head>
		<meta charset="<?php echo get_charset(); ?>">
		<?php 
			//KTH 
			//Responsivt + no cache
		?>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="cache-control" content="max-age=0" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
		<meta http-equiv="pragma" content="no-cache" />
		<title><?php echo get_vocab("mrbs") ?></title>
		<?php
			require_once "style.inc";
			require_once "js.inc";
		?>
  
	</head>
	<?php
	// Put the filename in as a class to aid styling.   
	// (Use a class rather than id to avoid specificity problems)
	echo "<body class=\"non_js ".htmlspecialchars($page)."\">\n";
    // Add a class of "js" so that we know if we're using JavaScript or not
    // and remove the non_js class (it's sometimes useful to know that we're
    // not running JavaScript)
	?>
	<script type="text/javascript">
		//<![CDATA[
		$('body').addClass('js').removeClass('non_js');
		//]]>
    </script>
	<!--KTH Sandbox 191003 -->
    <div style="border: 1px solid red" class="screenonly">

<?php
	if (!empty($locale_warning)) {
		echo "[Warning: ".$locale_warning."]";
	}
?>
<?php //KTH?>
	<div style="color:red;font-size:10px;text-align:center;">!!! SANDBOX !!!</div>
	<!-- 191003 -->
	<?php //KTH KTHCAS 191003
	/*
        echo "<div style=\"float:right;text-align: right;width: 100%\" >";
        if ($userlevel > 2) {
          echo "<a style=\"float:right;text-align: right;width:unset\" href=\"admin.php\">" . get_vocab("settings") . "</a>\n";
          echo "<span style=\"float:right;text-align: right;padding-top: 0.3em;padding-bottom: 0.3em;\"> | </span>";
		}
		*/
    ?>
	<header>
    <div class="container-fluid">
    	<div class="container">      
			<div class="header-container__top">
				<figure class="block figure defaultTheme mainLogo" data-cid="1.77257" lang="sv-SE">
					<a href="<?php echo (!$is_kiosk ? $kth_www : "#");?>">
						<img class="figure-img img-fluid" src="https://<?php echo $_SERVER['HTTP_HOST']?>/images/KTH_Logotyp.svg" alt="KTH:s logotyp" height="70" width="70">
					</a>
				</figure>
				<h1 class="block siteName" data-cid="1.260060">
		<?php
		//KTH
		//Byta språk
		if(isset($_COOKIE["mrbslang"])) {
			if(isset($mrbslang)) {
				$switchlanguage = $mrbslang;
			} else {
				$switchlanguage = $_COOKIE["mrbslang"];
			}
		}
		$myURL = $_SERVER["REQUEST_URI"];
		//rensa bort
		$myURL = str_replace("&lang=en", "", $myURL);
		$myURL = str_replace("&lang=sv", "", $myURL);
		$myURL = str_replace("?lang=en", "", $myURL);
		$myURL = str_replace("?lang=sv", "", $myURL);
		if (isset($switchlanguage)) {
			$pos = strpos($myURL, "?");
			if ($pos === false) {
				$urlchar = "?";
			} else {
				$urlchar = "&";
			}
		} 
		?>
		<?php //191003 KTH-sidhuvud ?>
		<?php if ($switchlanguage != "en") { ?>
			<a data-cid="1.260060" href="<?php echo (!$is_kiosk ? $kth_www ."/biblioteket" : "#");?>">KTH Biblioteket</a>
		<?php } else {?>
			<a data-cid="1.260060" href="<?php echo (!$is_kiosk ? $kth_www ."/en/biblioteket" : "#");?>">KTH Library</a>
		<?php }?>
				</h1>
				<div class="block list links secondaryMenu" data-cid="1.864801" lang="sv-SE">
					<ul>
					<?php if ($switchlanguage != "en") { ?>
						<li><a href="<?php echo $myURL . $urlchar . "lang=en"?>" hreflang=""><?php echo get_vocab("changelanguage")?></a>
						</li>
					<?php } else {?>
						<li><a href="<?php echo $myURL . $urlchar . "lang=sv"?>" hreflang=""><?php echo get_vocab("changelanguage")?></a>
						</li>
					<?php }?>
					</ul>
				</div>
			</div><!-- slut container__top-->
			<div class="menuwrapper">
				<div class="menu">
					<?php if ($switchlanguage != "en") { ?>
						<a href="<?php echo $redirect_str . "?area=$area"?>"> <?php echo get_vocab("homelink")?></a>
					<?php } else {?>
						<a href="<?php echo $redirect_str . "?area=$area"?>"> <?php echo get_vocab("homelink")?></a>
					<?php }?>
					<?php if (!$is_kiosk) {?>
						<?php if ($switchlanguage != "en") { ?>
							<a class="hide-small" href="search.php?datatable=1&area=<?php echo $area?>"><?php echo get_vocab("mybookings")?></a>
							<!--a class="nav-link null true" href="<?php echo $kth_www?>/utbildning"> Utbildning</a-->
						<?php } else {?>
							<a class="hide-small" href="search.php?datatable=1&area=<?php echo $area?>"><?php echo get_vocab("mybookings")?></a>
							<!--a class="nav-link null true" href="<?php echo $kth_www?>/en/studies"> Studies</a-->
						<?php }?>
						<?php if ($is_admin) { ?>
							<?php if ($switchlanguage != "en") { ?>
								<a class="hide-small" href="admin.php"><?php echo get_vocab("settings")?></a>
								<!--a class="nav-link null true" href="<?php echo $kth_www?>/forskning"> Forskning</a-->
							<?php } else {?>
								<a class="hide-small" href="admin.php"><?php echo get_vocab("settings")?></a>
								<!--a class="nav-link null true" href="<?php echo $kth_www?>/en/forskning"> Research</a-->
							<?php }?>
						<?php }?>
					<?php }?>
				</div>
				<div id="banner">
					<?php
					// Provide a link to the list of bookings awaiting approval
					// (if there are any enabled areas where we require bookings to be approved)

					$approval_somewhere = some_area('approval_enabled', TRUE);
					if ($approval_somewhere && (authGetUserLevel($user) >= 1)) {
						$sql_approval_enabled = some_area_predicate('approval_enabled');
						// Find out how many bookings are awaiting approval
						// (but only for areas where approval is required)
						$sql = "SELECT COUNT(*)
								FROM $tbl_entry E, $tbl_room R, $tbl_area A
								WHERE (status&" . STATUS_AWAITING_APPROVAL . " != 0)
								AND E.room_id = R.id
								AND R.area_id = A.id
								AND R.disabled = 0
								AND A.disabled = 0
								AND $sql_approval_enabled";
						if (!$is_admin) {
							// Ordinary users can only see their own
							$sql .= " AND create_by='" . sql_escape($user) . "'";
						}
						$n_outstanding = sql_query1($sql);
						if ($n_outstanding < 0) {
							trigger_error(sql_error(), E_USER_WARNING);
							fatal_error(FALSE, get_vocab("fatal_db_error"));
						}
						echo "<div id=\"n_outstanding\"" . (($n_outstanding > 0) ? " class=\"outstanding\"" : '') . ">\n";
						echo "<a href=\"pending.php?day=$day&amp;month=$month&amp;year=$year&amp;area=$area" . ((!empty($room)) ? "&amp;room=$room" : "") . "\">$n_outstanding " . get_vocab("outstanding") . "</a>\n";
						echo "</div>\n";
					}
					?>
					<?php
					$query_str = "day=$day&amp;month=$month&amp;year=$year";
					if (!empty($area)) {
						$query_str .= "&amp;area=$area";
					} else {
						//KTH 2018 default area om det saknas som parameter
						$area = 2;
					}
					if (!empty($room)) {
						$query_str .= "&amp;room=$room";
					}
					?>
					<?php
					// For session protocols that define their own logon box...
					if (function_exists('PrintLogonBox')) {
						if ($is_kiosk) {
							echo "<div id=\"sessionlabel\" style=\"display:none;float:right;width: 100%;text-align: right;\" >Tid kvar: <span id=\"activitytimer\"></span></div>";
						} else {
							echo "<div style=\"float:none;width: 100%;text-align: right;\" id=\"logon_box\">\n";
							//KTH area
							PrintLogonBox($area); 
							echo "</div>\n";
						}
						
					}
					?>
					<?php //KTH Mina bokningar?>
						<form id="header_search" method="get" action="search.php">
							<div>
								<input type="hidden" name="advanced" value="0">
								<input type="hidden" name="datatable" value="0">
								<input type="hidden" name="search_str" value="<?php //echo htmlspecialchars($search_str) ?>">
								<input type="hidden" name="day"        value="<?php //echo $day        ?>">
								<input type="hidden" name="month"      value="<?php //echo $month      ?>">
								<input type="hidden" name="year"       value="<?php //echo $year       ?>">
								<input type="hidden" name="area"       value="<?php echo $area ?>">
							</div>
						</form>
				</div><?php //slut banner ?>
			</div> <!-- Slut containter bottom-->
		</div> <!-- Slut container-->
	</div> <!-- Slut container fluid-->
    <div id="gradientBorder"></div>
	</header>
	<div id="appheader">
		<?php//191003?>
		<div id="mrbs">
			<h1><?php echo get_vocab("mrbs") ?></h1>
		</div>
	</div><?php //slut mrbs + banner ?>
<div id="contentwrapper">	
	<div id="contents">
<?php
} //end of print_theme_header()