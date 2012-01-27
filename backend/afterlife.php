<?php

/*****
CONFIGURATION: (edit these variables for your setup)
******/
$__PASSWORD="password";
$__FAILSAFE_PERIOD= 48*60*60; //this is in seconds, default is 48h


/**
state=="ON":
  someone is trying to activate the dead_man_switch, here's how we react:
  { - this is the first time someone switches the switch on, but maybe we're not really dead, 
	  maybe the person we trusted with the password was not that "trusted", or someone "hacked" the site, 
      so we don't immediately start the procedure, here's what we do:
      { - we save the current timestamp and send an email notification to the supposedly dead person
        - now the person has 48 hours to set the switch off ()
        - when the 48 hours have passed the trustee can press the switch again, 
          and this time the procedure will actually start
      }
   }
state=="OFF":
  this is called by us if we've been informed that the procedure is about to be enabled (within 48h) and 
  we want to stop it cause we're not actually dead
*/
function dead_man_switch($password,$state) {

	//after the first push of the button we set this to the current timestamp
	//if the user is alive and switches the thing off it is set to -1 again
	$timestamp_last_on_txt = file_get_contents(dirname(__FILE__).'/timestamp_last_on.txt'); 
	if (!$timestamp_last_on_txt) return("CAN'T OPEN THE FILE. FIX THE PERMISSIONS OR NOTHING WILL HAPPEN WHEN YOU DIE.");
	$timestamp_last_on = intval($timestamp_last_on_txt);

	//the password is required for any operation:
	if ($password!=$GLOBALS['__PASSWORD']) return("WRONG PASSWORD");

	if ($state=="ON") {
	    //CASE 1: it's the first time the button has been pressed (maybe a joke)
	    if ($timestamp_last_on==-1) {
			$success = file_put_contents(dirname(__FILE__).'/timestamp_last_on.txt',time()); //update the timestamp
			if (!$success) {return("CANNOT WRITE TO FILE. FIX PERMISSIONS NOW.");}
			return("FAILSAFE PERIOD STARTED, COME BACK LATER");	
		} else {
			//CASE 2:
			//the timestamp is not -1, so the button has already been pressed once
			//if more than 48h have passed we actually "start the show"
			if ( (time()-$timestamp_last_on)>$GLOBALS['__FAILSAFE_PERIOD'] ) {
				//oh shit, you're actually dead :( i'm sorry, it's been great knowing you
				//humanity will not forget your contribution, but now let's get this shit started.
				//A great person deserves a great finale
	
				//TODO: run the actual script here
				return("FIREWORKS MAN!");
			} else {
				//48h have not yet passed since the button was first pressed
				return("FAILSAFE PERIOD HAS NOT YET EXPIRED");
			}
		}
	}
	if ($state=="OFF") {
		//pfheew you're not dead yet, that was close
		$success = file_put_contents(dirname(__FILE__).'/timestamp_last_on.txt','-1'); //back to normal, DEFCON 5
		if (!$success) {return("CANNOT WRITE TO FILE. FIX PERMISSIONS NOW.");}
		return("PHFEEEW");
	}
}
?>
