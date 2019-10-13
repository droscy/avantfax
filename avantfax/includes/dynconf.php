#!/usr/bin/php
<?php
/**
 * AvantFAX - "Web 2.0" HylaFAX management
 *
 * PHP 5 only
 *
 * @author		David Mimms <david@avantfax.com>
 * @copyright	2005 - 2007 MENTALBARCODE Software, LLC
 * @copyright	2007 - 2008 iFAX Solutions, Inc.
 * @license		http://www.gnu.org/copyleft/gpl.html GNU/GPL
 */

	require realpath(dirname(__FILE__).DIRECTORY_SEPARATOR.'..'.DIRECTORY_SEPARATOR).'/vendor/autoload.php';
	require realpath(dirname(__FILE__).DIRECTORY_SEPARATOR.'..'.DIRECTORY_SEPARATOR).'/includes/classes.php';
	
	// check for proper arguments
	if ($_SERVER['argc'] == 1) {
		exit($_SERVER['argv'][0]." device CallID1 CallIDn...\n");
	}
	
	$device = $_SERVER['argv'][1];
	
	if (!isset($_SERVER['argv'][2]) || $_SERVER['argv'][2] == "") {
		$callid1 = "EMPTY CALLID";
	} else {
		$callid1 = strip_sipinfo($_SERVER['argv'][2]); // strip any SIP info on caller id
	}

	$dc = new DynamicConfig;
	
	avantfaxlog("dynconf> checking CallID1 $callid1 on device $device");
	
	// lookup CallID1 in DynamicConfig table
	// If exists, reject the call
	if ($dc->lookup($device, $callid1)) {
		avantfaxlog("dynconf> rejecting $callid1 on device $device");
		echo "RejectCall: true\n";
	}
