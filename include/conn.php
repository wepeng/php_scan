<?php
	session_start();
	include "config.php";
	$db = mysql_pconnect($_config['db']['dbhost'], $_config['db']['dbuser'],  $_config['db']['dbpw']);
	mysql_select_db($_config['db']['name']);
	mysql_query("set names ".$_config['db']['dbcharset']); 
?>