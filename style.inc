<?php
// $Id$

global $using_rtl, $refresh_rate, $custom_css_url, $PHP_SELF;

if (DEBUG)
{
  ?>
  <link href="jquery/ui/css/jquery-ui.structure.css" rel="stylesheet" type="text/css">
  <link href="jquery/ui/css/sunny/jquery-ui.theme.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/jquery.dataTables.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/buttons.dataTables.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/fixedColumns.dataTables.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/colReorder.dataTables.css" rel="stylesheet" type="text/css">
  <?php
}
else
{
  ?>
  <link href="jquery/ui/css/jquery-ui.structure.min.css" rel="stylesheet" type="text/css">
  <link href="jquery/ui/css/sunny/jquery-ui.theme.min.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/buttons.dataTables.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/fixedColumns.dataTables.min.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/colReorder.dataTables.css" rel="stylesheet" type="text/css">
  <?php
}
?>
    <!-- 191003-->
	<link type="text/css" href="https://<?php echo $_SERVER['HTTP_HOST']?>/kthstyle/kth.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    
	<link rel="stylesheet" href="css/mrbs.css.php" type="text/css">
	
    <?php
    if ($using_rtl)
    {
      ?>
      <link rel="stylesheet" href="css/mrbs-rtl.css.php" type="text/css">
      <?php
    }
    ?>
    <link rel="stylesheet" media="print" href="css/mrbs-print.css.php" type="text/css">
    <!--[if IE]>
    <link rel="stylesheet" href="css/mrbs-ie.css" type="text/css">
    <![endif]-->
    <?php
    if ($using_rtl)
    {
      ?>
      <!--[if IE]>
      <link rel="stylesheet" href="css/mrbs-ie-rtl.css" type="text/css">
      <![endif]-->
      <?php
    }
    ?>
    <!--[if IE 8]>
    <link rel="stylesheet" href="css/mrbs-ie8.css" type="text/css">
    <![endif]-->
    <!--[if lte IE 8]>
    <link rel="stylesheet" href="css/mrbs-ielte8.css" type="text/css">
    <![endif]-->
    <!--[if lte IE 7]>
    <link rel="stylesheet" href="css/mrbs-ielte7.css.php" type="text/css">
    <![endif]-->
    <!--[if lte IE 6]>
    <link rel="stylesheet" href="css/mrbs-ielte6.css" type="text/css">
    <![endif]-->
    <?php
    if (isset($custom_css_url))
    {
      ?>
      <link rel="stylesheet" href="<?php echo $custom_css_url ?>" type="text/css">
      <?php
    }
    ?>
    <meta name="robots" content="noindex, nofollow">
<?php
if (($refresh_rate != 0) && preg_match("/(day|week|month)\.php/", $PHP_SELF))
{
  // If we're using JavaScript and on the day or week pages we'll do the refresh by 
  // getting a new table using Ajax requests, which means we only have to download
  // the table not the whole page each time
  $ajax_capable = preg_match("/(day|week)\.php/", $PHP_SELF);
  echo ($ajax_capable) ? "<noscript>\n" : '';
  echo "<meta http-equiv=\"Refresh\" content=\"$refresh_rate\">\n";
  echo ($ajax_capable) ? "</noscript>\n" : '';
}

//KTH Styling beroende på vilken vy som är aktuell
$default_view = get_default_view($area);
$times_along_top = get_times_along_top($area);
echo "<style> 
	@media only screen and (max-width: 1400px) {
		.modal-content {
			1width: 65%;
		}
	}
	@media only screen and (max-width: 1200px) {
		.modal-content {
			1width: 80%;
		}
	}	
	@media only screen and (max-width: 992px) {	
		/* 191003 */
		#banner {
			width: 100%;
			top: 0px;
		}
		#mrbs, #contentwrapper{
			padding: 15px 0px;
		}
		div#contents {
			padding: 0px 15px;
		}
	}
	@media only screen and (max-width: 950px) {	
	.infolink, #bookingrules {
		width: 97%;
	}
	.expandable-header {
		1width: 40%;
	}
	.roomnumber, .roomname {
		display: inline-block;
	}
	.dwm_main th a, .row_labels a {
		font-size: 10px;
	}
	.capacity {display: inline;}
	.modal-content {
		1width: 70%;
	}
	body .container, 
	body .container-fluid,
	#appheader,
	div#contents {
		padding: 0 5px;
	}
	";
	if ($times_along_top == sTRUE) { //om tiderna är på toppen så rotera inte(testar att låta de rotera också)
	} else {
		if(strpos($PHP_SELF, "day.php")===FALSE) { //Rotera rubriker om tiderna är på sidan och sidan som visas är "day" och defaultview är "day"
			if (strpos($PHP_SELF, "week.php")===FALSE) { //Rotera inte om det är veckovy och tiderna är på sidan 
				if ($default_view == 0) {//0=day, 1=week, 2=month
					echo ".dwm_main th {
						position: relative;
						height: 40px;
					}
					.dwm_main th a, .dwm_main th span {
						transform: rotate(-90deg) translate(0px, 2px);
						-ms-transform: rotate(-90deg) translate(0px, 2px);
						-webkit-transform: rotate(-90deg) translate(0px, 2px);
						width: 40px;
						position: absolute;
						top: 20px;
						left: -24px;
						height: 0px;
					}";
				}
			} else {
			
			}
		} else {
			if ($default_view == 0) {//0=day, 1=week, 2=month
				echo ".dwm_main th {
					position: relative;
					1height: 140px;
					height: 170px;
					white-space: nowrap;
				}
				.dwm_main .floatingHeader th {
					position: relative;
					1height: 140px;
					1height: 100px;
					white-space: nowrap;
				}
				.dwm_main th a, .dwm_main th span {
					transform: rotate(-90deg) translate(0px, 2px);
					-ms-transform: rotate(-90deg) translate(0px, 2px);
					-webkit-transform: rotate(-90deg) translate(0px, 2px);
					1width: 140px;
					width: 170px;
					position: absolute;
					1top: 70px;
					1left: -70px;
					top: 85px;
					left: -90px;
					height: 0px;
				}";
			}
		}
	}
	echo "#banner td {
		float: left;
		width: 100%;
		border-left-width: 0px;
		padding: 0px;
	}
	#banner td:first-child {
		border-left-width: 0px;
	}
	
	div.screenonly {
	  width: 100%; 
	}
	
	div#contents{}
	div.trailer{}
}";
echo "@media only screen and (max-width: 600px) {";
	echo ".edit_entry .form_general label {
		width: 8em;
		max-width: 8em;
	}
	.dwm_main td {
		word-break: break-all;
		word-break: break-word;
	}
	.roomname {
		white-space: normal;
	}
	.expandable-header {
		1width: 97%;
	}
	.modal-content {
		1width: 85%;
	}
	#myModalrules ul {
		width: 85%;
	}
	/* 191003 */
	#banner {
		padding-top: 5px;
	}
	.menu {
		font-size: 1.1rem;
	}
	.menuwrapper {
		flex-direction: column-reverse;
	}

	h1 {
		font-size: 1.75rem;
	}
	
	";
	echo "}";
	echo "</style>";
