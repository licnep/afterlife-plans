<?php
include(dirname(__FILE__).'/config.php');

if (isset($_GET['password'])) {
	require_once(dirname(__FILE__).'/../../backend/afterlife.php');
	$status = dead_man_switch($_GET['password'],"ON");
}

if ( dead_man_timestamp()==-1 ) {
	//switch not yet activated
	$__message = $GLOBALS['DEAD_MESSAGE_MAIN'];
} else {
	if (time()<when_can_i_confirm()) {
		//we're in the failsafe period
		$__message = $GLOBALS['FILESAFE_PERIOD_MESSAGE'];		
	} else {
		//failsafe period ended. We can now finally confirm the death
		$__message = $GLOBALS['YOU_CAN_NOW_CONFIRM_MESSAGE'];		
	}
}

if ($status=="FOLDER DECRYPTED") {
	//run the script and redirect
	header('location: ../../decrypted/pandoras_box/');
}
if ($status=="WRONG PASSWORD") {
	//run the script and redirect
	$__message .=  "<br/><br/>WRONG PASSWORD";
}
?>
<html>
	<body style="text-align:center">
		<form method="GET">
			Password: <input type="password" name="password" value="" />
			<input type="submit" />
		</form>
		<div id="message">
			<?php echo($__message); ?>
		</div>
	</body>
</html>
