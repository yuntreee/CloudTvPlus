<?php 
    include "session.php";
	session_start();
	header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
	header("Cache-Control: post-check=0, pre-check=0", false);
	header("Pragma: no-cache");
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
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="css/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
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
                            <li class="nav-item"><a class="nav-link" href="./index.php">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="./service/service.php">Service</a></li>
                            
                            <li class="nav-item"><a class="nav-link" href="./pricing.php">Pricing</a></li>
                            <!--<li class="nav-item"><a class="nav-link" href="./faq.php">FAQ</a></li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Blog</a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                                    <li><a class="dropdown-item" href="blog-home.php">Blog Home</a></li>
                                    <li><a class="dropdown-item" href="blog-post.php">Blog Post</a></li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" id="navbarDropdownPortfolio" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Portfolio</a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownPortfolio">
                                    <li><a class="dropdown-item" href="portfolio-overview.php">Portfolio Overview</a></li>
                                    <li><a class="dropdown-item" href="portfolio-item.php">Portfolio Item</a></li>
                                </ul>
                            </li>-->
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
<       <?php } ?>    
                        </ul>
                    </div>
                </div>
            </nav>
            <!-- Header-->      
            <header class="bg-dark py-5">
                <div class="container px-5">
                    <div class="row gx-5 align-items-center justify-content-center">
                        <div class="col-lg-8 col-xl-7 col-xxl-6">
                            <div class="my-5 text-center text-xl-start">
                                <h1 class="display-5 fw-bolder text-white mb-2">전 세계 유튜브 트랜딩<br> 1위를 유지 중</h1>
                                <p class="lead fw-normal text-white-50 mb-4">슈퍼참치는 대한민국 보이 그룹 방탄소년단의 멤버인 진이 자신의 생일인 12월 4일에 맞춰 발매한 비공식 솔로곡</p>
                                <div class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
                                    <a class="btn btn-primary btn-lg px-4 me-sm-3" href="/service/video01.php">지금 시청하기</a>
                                    <a class="btn btn-outline-light btn-lg px-4" href="/service/service.php">더 보기</a>

                                </div>
                            </div>
                        </div>
                        <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center"><img class="img-fluid rounded-3 my-5" src="/icon/Thumnail.png" alt="..." /></div>
                    </div>
                </div>
            </header>      
            <!-- Features section-->
            <section class="py-5" id="features">
                <div class="container px-5 my-5">
                    <div class="row gx-5">
                        <!--<div class="col-lg-4 mb-5 mb-lg-0"><h2 class="fs-12 fw-bolder mb-0">We make changes in life by delivering resonations to the world with music and innovating industries.</h2></div>-->
                        <div class="col-lg-4 mb-5 mb-lg-0"><h2 class="fs-8 fw-bolder mb-0">음악으로 세상에 울림을 전하고 산업을 혁신하여 삶의 변화를 만들어 갑니다.</h2></div>
                        <div class="col-lg-8">
                            <div class="row gx-5 row-cols-1 row-cols-md-2">
                                <div class="col mb-5 h-100">
                                    <!--<div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><img class="" src="/icon/subscription.png"></div>-->
                                    <!--<div class="feature text-white rounded-3 mb-3 ml-24"><img class="" src="/icon/subscription.png"></div>-->
                                    <div><img class="" src="/icon/subscription2.png"></div>
                                    <h2 class="h5">구독경제 실현</h2>
                                    <p class="mb-0">구독 상품은 온라인 동영상 서비스(OTT)는 다양한 분야와 손을 잡고 구독경제 실현에 앞장서고 있다.</p>
                                </div>
                                <div class="col mb-5 h-100">
                                    <!--<div class="feature text-white rounded-3 mb-3 ml-24"><img class="" src="/icon/videocontents.png"></div>-->
                                    <div><img class="" src="/icon/videocontents2.png"></div>
                                    <h2 class="h5">파급력 있는 영상 콘텐츠</h2>
                                    <p class="mb-0">전세계 영상 콘텐츠 소비자들과 함께 아이디어와 기술력으로 펼쳐질 스트리밍 산업의 성장이 기대된다</p>
                                </div>
                                <div class="col mb-5 mb-md-0 h-100">
                                    <!--<div class="feature text-white rounded-3 mb-3 ml-24"><img class="" src="/icon/stars.png"></div>-->
                                    <div><img class="" src="/icon/stars2.png"></div>
                                    <h2 class="h5">스타들의 팬덤 플랫폼</h2>
                                    <p class="mb-0">그동안 다른 팬덤 플랫폼이 제공하지 못했던 다양한 기능과 스타 콘텐츠를 제공한다. </p>
                                </div>
                                <div class="col h-100">
                                    <!--<div class="feature text-white rounded-3 mb-3 ml-24"><img class="" src="/icon/participatory.png"></div>-->
                                    <div><img class="" src="/icon/participatory2.png"></div>
                                    <h2 class="h5">참여형 팬덤 플랫폼</h2>
                                    <p class="mb-0">팬덤 형성을 위한 다양한 형태의 참여형 이벤트도 꾸준히 진행하여 팬덤 형성을 기대한다.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Testimonial section-->
            <div class="py-5 bg-light">
                <div class="container px-5 my-5">
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-10 col-xl-7">
                            <div class="text-center">
                                <div class="fs-4 mb-4 fst-italic">"We make changes in life by delivering resonations to the world with music and innovating industries."</div>
                                <div class="d-flex align-items-center justify-content-center">
                                    <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                    <div class="fw-bold">
                                        Tom Ato
                                        <span class="fw-bold text-primary mx-1">/</span>
                                        CEO, Cloud TV ++
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Blog preview section-->
            <section class="py-5">
                <div class="container px-5 my-5">
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-8 col-xl-6">
                            <div class="text-center">
                                <h2 class="fw-bolder">From our Service</h2>
                                <p class="lead fw-normal text-muted mb-5">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Eaque fugit ratione dicta mollitia. Officiis ad.</p>
                            </div>
                        </div>
                    </div>
                    <div class="row gx-5">
                         <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0" >								
                                <img class="card-img-top"  src="../data/211201.jpg" alt="..." />
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">VLOG</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="/service/video01.php"><div class="h5 card-title mb-3">[BANGTAN BOMB] The Bangtan Choir - BTS (방탄소년단)</div></a>
                                    <p class="card-text mb-0">방탄소년단 광고촬영 현장에서 일어난 일/ 뷔를 노래하게만든 그 곡은?</p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="./icon/BANGTANTV.jpg" alt="..." />
                                            <div class="small">
                                                <div class="fw-bold">BANGTANTV</div>
                                                <div class="text-muted">March 12, 2021 &middot; 6 min read</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top"  src="../data/211202.jpg" alt="..." />
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">Live</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="/service/video01.php"><div class="h5 card-title mb-3">[IU TV] 투어를 마친 아이유의 진짜 속마음은?</div></a>
                                    <p class="card-text mb-0">아시아투어를 마친 아이유/ 공연에 대한 아이유의 솔직담백한 소감, 그리고 뒷이야기</p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="./icon/iu.jpg" alt="..." />
                                            <div class="small">
                                                <div class="fw-bold">이지금 [IU Official]</div>
                                                <div class="text-muted">March 23, 2021 &middot; 4 min read</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top" src="../data/211203.jpg" alt="..." />
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">Live</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="/service/video01.php"><div class="h5 card-title mb-3">LIVE ON UNPLUGGED 'Love Affair'</div></a>
                                    <p class="card-text mb-0">프리미엄 음악콘서트 LIVE ON UNPLUGGED / 임창정의 명곡 Love Affair 라이브무대</p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="./icon/soju.jpg" alt="..." />
                                            <div class="small">
                                                <div class="fw-bold">임창정</div>
                                                <div class="text-muted">April 2, 2021 &middot; 10 min read</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Call to action-->
                    <aside class="bg-primary bg-gradient rounded-3 p-4 p-sm-5 mt-5">
                        <div class="d-flex align-items-center justify-content-between flex-column flex-xl-row text-center text-xl-start">
                            <div class="mb-4 mb-xl-0">
                                <div class="fs-3 fw-bold text-white">New products, delivered to you.</div>
                                <div class="text-white-50">Sign up for our newsletter for the latest updates.</div>
                            </div>
                            <div class="ms-xl-4">
                                <div class="input-group mb-2">
                                    <input class="form-control" type="text" placeholder="Email address..." aria-label="Email address..." aria-describedby="button-newsletter" />
                                    <button class="btn btn-outline-light" id="button-newsletter" type="button">Sign up</button>
                                </div>
                                <div class="small text-white-50">We care about privacy, and will never share your data.</div>
                            </div>
                        </div>
                    </aside>
                </div>
            </section>
        </main>
        <!-- Footer-->
        <footer class="bg-dark py-4 mt-auto">
            <div class="container px-5">
                <div class="row align-items-center justify-content-between flex-column flex-sm-row">
                    <div class="col-auto"><div class="small m-0 text-white">Copyright &copy; Your Website 2021</div></div>
                    <div class="col-auto">
                       <!-- <a class="link-light small" href="#!">Privacy</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Terms</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Contact</a>-->                    
                        <?php
                        $urlRoot="http://169.254.169.254/latest/meta-data/";
                        //<span class="text-white mx-1">&middot;</span>
                        //<a class="link-light small" href="#!">Contact</a>                        
                        echo "<div><tr>
                                <td class='contxt'>
                                    <b class='link-light small'>Availability Zone : </b>
                                </td>
                                <td><span class='link-light small'>" . file_get_contents($urlRoot . 'placement/availability-zone') . "</span>
                                </td>
                             </tr></div>";
                        echo "<div><tr><td class='contxt'><b class='link-light small'>InstanceId : </b></td><td><span class='link-light small'>" . file_get_contents($urlRoot . 'instance-id') . "</span></td></tr></div>";
                            ?>                                         
                    </div>
                </div>
            </div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
