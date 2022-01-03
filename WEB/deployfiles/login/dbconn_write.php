<?php
include "db_sdk.php";

$mysql_hostname = getenv('DB_write');
$mysql_username = $secrets[ 'db_name' ];
$mysql_password = $secrets[ 'db_password' ];
$mysql_database = 'cloud_db';


$connect = mysqli_connect($mysql_hostname, $mysql_username, $mysql_password, $mysql_database);
	
mysqli_select_db($connect, $mysql_database) or die('DB connection ERROR');
mysqli_query($connect, "set session character_set_connection=utf8;");
mysqli_query($connect, "set session character_set_results=utf8;");
mysqli_query($connect, "set session character_set_client=utf8;");
?>
