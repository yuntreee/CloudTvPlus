<?php
include "../session.php";
session_start();

if(! $_GET['userid'] ){
    echo("<script>window.alert('아이디를 입력하세요.');
             history.go(-1);</script>");exit;}

include "dbconn_read.php";

$sql = "select * from member where id='".$_GET['userid']."' and pass='".$_GET['passwd']."'";
$result = mysqli_query($connect, $sql);
$num_match = mysqli_num_rows($result);

if(! $num_match){
    echo("<script>window.alert('입력 정보가 틀렸습니다.');
             history.go(-1);</script>");
}else{
    $row = mysqli_fetch_array($result);
    mysqli_close();
    $_SESSION['userid'] = $row[id];
    $_SESSION['username'] = $row[name];
    $_SESSION['usernick'] = $row[nick];
    $_SESSION['hp'] = $row[mphone];
    $_SESSION['e-mail'] = $row[email];
    $_SESSION['regist_day'] = $row[regist_day];
    $_SESSION['member_grade'] = $row[member_grade];

    echo("<script>window.alert('로그인 성공');
           location.href = '../index.php';</script>");
}
?>