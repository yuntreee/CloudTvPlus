<? include "../header.php";?> 
<form id="join" method="get" action="./member_insert.php">  
            <!-- Page content-->
            <section class="py-5">
                <div class="container px-5">
                    <!-- Contact form-->
                    <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
                        <div class="text-center mb-5">
                            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-envelope"></i></div>
                            <h1 class="fw-bolder">회원가입</h1>
                            <p class="lead fw-normal text-muted mb-0">아래 정보를 입력해주세요</p>
                        </div>
                        <div class="row gx-5 justify-content-center">
                            <div class="col-lg-8 col-xl-6">
                                <!-- * * * * * * * * * * * * * * *-->
                                <!-- * * SB Forms Contact Form * *-->
                                <!-- * * * * * * * * * * * * * * *-->
                                <!-- This form is pre-integrated with SB Forms.-->
                                <!-- To make this form functional, sign up at-->
                                <!-- https://startbootstrap.com/solution/contact-forms-->
                                <!-- to get an API token!-->
                                
                                    <!-- Name input-->
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="id" name="id" type="text" placeholder="Enter your name..." data-sb-validations="required" />
                                        <label for="name">ID 입력</label>
                                        <div class="invalid-feedback" data-sb-feedback="name:required">ID를 입력하지 않았습니다.</div>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="passwd" name="passwd" type="password" class="pass" placeholder="Enter your passwd..." data-sb-validations="required" />
                                        <label for="passwd">PW 입력</label>
                                        <div class="invalid-feedback" data-sb-feedback="passwd:required">PW를 입력하지 않았습니다.</div>
                                    </div>        
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="pass_confirm" name="pass_confirm" type="password" class="pass" placeholder="Enter your passwd..." data-sb-validations="required" />
                                        <label for="passwd">PW 확인</label>
                                        <div class="invalid-feedback" data-sb-feedback="passwd:required">PW를 입력하지 않았습니다.</div>
                                    </div>                  
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="name" name="name" type="text" class="nick" placeholder="Enter your nick..." data-sb-validations="required" />
                                        <label for="name">이름 입력</label>
                                        <div class="invalid-feedback" data-sb-feedback="name:required">이름를 입력하지 않았습니다.</div>
                                    </div>              
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="nick" name="nick" type="text" class="nick" placeholder="Enter your nick..." data-sb-validations="required" />
                                        <label for="name">닉네임 입력</label>
                                        <div class="invalid-feedback" data-sb-feedback="name:required">닉네임을 입력하지 않았습니다.</div>
                                    </div>          
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="phone" name="hp"type="tel" placeholder="(123) 456-7890" data-sb-validations="required" />
                                        <label for="phone">모바일 번호</label>
                                        <div class="invalid-feedback" data-sb-feedback="phone:required">모바일 번호를 입력하지 않았습니다..</div>
                                    </div>                                                                                                                                       
                                    <!-- Email address input-->
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="email" name="e-mail" type="email" placeholder="name@example.com" data-sb-validations="required,email" />
                                        <label for="email">이메일 주소</label>
                                        <div class="invalid-feedback" data-sb-feedback="email:required">이메일을 입력하지 않았습니다.</div>
                                        <div class="invalid-feedback" data-sb-feedback="email:email">Email is not valid.</div>
                                    </div>
                                    <!-- Phone number input-->

                                    <!-- Message input-->
                                    <!-- Submit success message-->
                                    <!---->
                                    <!-- This is what your users will see when the form-->
                                    <!-- has successfully submitted-->

                                    <!-- Submit Button-->
                                    <div class="d-grid">
									   <a class="btn btn-primary" onclick="document.getElementById('join').submit()">회원가입</a>
                                       <!-- <input type="submit" value="Submit" class="submit"> -->
                                        <a class="btn btn-outline-primary" onClick="javascript:location.href='../index.php';">돌아가기</a></div>
                                        <!--<a class="btn btn-primary" href="#!">Choose plan</a>
                                        <button  id="submitButton" type="submit" value="submit">회원가입</button>
                                        <button class="btn btn-primary btn-lg disabled" type="button" value="Cancel"  value="submit">back</button>-->
                                    </div>
                                
                            </div>
                        </div>
                    </div>
                    <!-- Contact cards-->
                    <div class="row gx-5 row-cols-2 row-cols-lg-4 py-5">
                        <div class="col">
                            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-chat-dots"></i></div>
                            <div class="h5 mb-2">Chat with us</div>
                            <p class="text-muted mb-0">Chat live with one of our support specialists.</p>
                        </div>
                        <div class="col">
                            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-people"></i></div>
                            <div class="h5">Ask the community</div>
                            <p class="text-muted mb-0">Explore our community forums and communicate with other users.</p>
                        </div>
                        <div class="col">
                            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-question-circle"></i></div>
                            <div class="h5">Support center</div>
                            <p class="text-muted mb-0">Browse FAQ's and support articles to find solutions.</p>
                        </div>
                        <div class="col">
                            <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-telephone"></i></div>
                            <div class="h5">Call us</div>
                            <p class="text-muted mb-0">Call us during normal business hours at (555) 892-9403.</p>
                        </div>
                    </div>
                </div>
            </section>
            </form>            
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
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>
