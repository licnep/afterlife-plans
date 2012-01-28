<?php

$__PASSWORD="a9d85869944adf04eeeb8162adf1833f"; //automatically generated
$__FAILSAFE_PERIOD= 10;//48*60*60; //this is in seconds, default is 48h
$__OWNER_EMAIL="lsnpreziosi@gmail.com";

//edit this function to warn you properly. By default it just sends you an email
function warn_me_cause_somebody_thinks_im_dead() {
	mail($GLOBALS['__OWNER_EMAIL'],"WARNING: someone thinks you're dead","if you're not you have 48h to confirm");
}


?>
