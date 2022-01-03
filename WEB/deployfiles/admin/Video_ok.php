<?php

session_start();
$value = '업로드 완료되었습니다.';
$REGIST_DAY = date("Y-m-d (H:i)");
include "../login/dbconn_write.php";

$VIDEO_SEQ = $_POST['VIDEO_SEQ'];
$VIDEO_NAME = $_POST['VIDEO_NAME'];
$VIDEO_FILE = $_POST['VIDEO_FILE'];
$VIDEO_SUBJECT = $_POST['VIDEO_SUBJECT'];	
$VIDEO_ADMIN = $_POST['VIDEO_ADMIN'];	
$VIDEO_GROUP = $_POST['VIDEO_GROUP'];	



$sql = "insert into Video (VIDEO_SEQ , VIDEO_GROUP , VIDEO_NAME , VIDEO_SUBJECT , VIDEO_FILE , VIDEO_ADMIN , REGIST_DAY)";
$sql .= "values ('$VIDEO_SEQ ', '$VIDEO_GROUP ', '$VIDEO_NAME ', '$VIDEO_SUBJECT ', '$VIDEO_FILE ','admin','$REGIST_DAY')";
	
mysqli_query($connect, $sql);
mysqli_close();
	
//echo "<h2>파일 정보</h2>
//<ul>
//<li>sql: $sql</li>
//<li>VIDEO_GROUP: $VIDEO_GROUP</li>
//</ul>";	
echo "<script>alert('{$value}');</script>";
echo "<script>location.href='./Video.php'</script>";
?>


