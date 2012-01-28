<?php
require_once(dirname(__FILE__).'/../../backend/afterlife.php');

$DEAD_MESSAGE_MAIN = "Enter your password to confirm that ________ is dead.";

$FILESAFE_PERIOD_MESSAGE = "__________ has been notified, so that if he's still alive he can cancel the procedure. The filesafe period ends on ". date("D, d M Y H:i:s", when_can_i_confirm()). ". Please come back after that day and re-enter the password to confirm the death and start the procedure." ;

$YOU_CAN_NOW_CONFIRM_MESSAGE = "The failsafe period has expired and _________ hasn't replied. Please insert your password and confirm his death."

?>
