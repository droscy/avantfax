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

	require_once '../check_login.php';
	
	$fax = new ArchiveIn;
	
	if (!$fax->load_fax($_REQUEST['fid'])) {
		exit;
	}
	
	if (!$_SESSION[USERSESSION]->superuser) {
		if (!$fax->user_has_rights($_SESSION[USERSESSION]->uid, $_SESSION[USERSESSION]->get_modemdevs(), $_SESSION[USERSESSION]->get_didrouting(), $_SESSION[USERSESSION]->get_faxcats())) {
			avantfaxlog("archivefax> Access denied to archive fax '".$fax->get_fid()."' by ".$_SESSION[USERSESSION]->username);
			exit;
		}
	}
	
	$fax->set_archivebox($_REQUEST['fid']);
