<?php 
	include "session.php";
	session_start();
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Modern Business - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="../assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="../css/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
    </head>
    <body class="d-flex flex-column h-100">
        <main class="flex-shrink-0">
            <!-- Navigation-->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container px-5">
                <a class="navbar-brand" href="index.php"><h2>구름 TV+</h2></a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <li class="nav-item"><a class="nav-link" href="/index.php">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="/service/service.php">Service</a></li>
                            
                            <li class="nav-item"><a class="nav-link" href="/pricing.php">Pricing</a></li>
        <?php 
			if(! $_SESSION['userid'])
			{
        ?>                          
							<li class="nav-item"><a class="nav-link" href="/join/join.php">회원가입</a></li>
							<li class="nav-item"><a class="nav-link" href="/login/login.php">로그인</a></li>
        <?php 
			} else {
		?>     
                            <li class="nav-item"><a class="nav-link" href="/login/logout.php">로그아웃</a></li>
        <?php } ?>    
                        </ul>
                    </div>
                </div>
            </nav>
            <!-- Header-->
