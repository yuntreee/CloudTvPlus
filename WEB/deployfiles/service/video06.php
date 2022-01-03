<?php
	//session_start();
  include "../header.php"; 
  ?>   
  
<style>
        body{
            margin: 0;
            padding: 0;
        }
        #video{
            width: 100%;
            height: 100vh;
        }
</style>
    <link href="https://vjs.zencdn.net/7.10.2/video-js.css" rel="stylesheet" />  
            <!-- Page Content-->
            <section class="py-5">
                <div class="container px-5 my-5">

                    <!--
                    <div class="row gx-5">
                        <div class="col-12"><img class="img-fluid rounded-3 mb-5" src="https://dummyimage.com/1300x700/343a40/6c757d" alt="..." /></div>
                        
                    </div>
                    -->
                    <video id=video width=100% class="video-js" controls>
                        <source src="https://d3oidsehp8d4ws.cloudfront.net/HLS/test_720.m3u8" type="application/x-mpegURL">
                    </video>                                       
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-6">
                            <div class="text-center mb-5">
                                <h1 class="fw-bolder"><br>'꿈빛 파티시엘' #shorts</h1>
                                <p class="lead fw-normal text-muted mb-0">SNS에서 유행했던 '꿈빛 파티시엘 챌린지' / 원곡자 아이유의 NG shorts </p>
                            </div>
                        </div>
                    </div>                    
                </div>
            </section>
        </main>
        <!-- Footer-->
        <footer class="bg-dark py-4 mt-auto">
            <div class="container px-5">
                <div class="row align-items-center justify-content-between flex-column flex-sm-row">
                    <div class="col-auto"><div class="small m-0 text-white">Copyright &copy; Your Website 2021</div></div>
                    <div class="col-auto">
                        <a class="link-light small" href="#!">Privacy</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Terms</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Contact</a>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="https://vjs.zencdn.net/7.8.2/video.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/videojs-contrib-hls/5.15.0/videojs-contrib-hls.min.js"></script>
        <script>
            var player = videojs('video');
        // player.play();
        </script>        
    </body>
</html>
