<%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-07-28
  Time: 오후 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!-- Modal 블러때문에 푸터에 보냄-->
<div
        class="modal"
        id="loginModal"
        tabindex="-1"
        aria-labelledby="loginModalLabel"
        aria-hidden="true"

>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content"
             style="margin: 40px;">
            <div class="modal-header mx-5">
                <h5 class="modal-title fw-bold">로그인</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-mdb-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>


            <div class="modal-body mx-5">
                <form method="post"  name="login_frm" action="/member/loginPro.jsp" >
                <div class="row justify-content-center m-auto">


                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <input type="text" id="loginId" class="form-control"/>
                        <label class="form-label" for="loginId">아이디</label>
                    </div>

                    <!-- Password input -->
                    <div class="form-outline mb-4">
                        <input type="password" id="loginPassword" class="form-control"/>
                        <label class="form-label" for="loginPassword">비밀번호</label>
                    </div>


                    <!-- 2 column grid layout for inline styling -->
                    <div class="row mb-4">
                        <div class="col d-flex justify-content-center">
                            <!-- Checkbox -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="form1Example3"
                                />
                                <label class="form-check-label" for="form1Example3">
                                    로그인 유지
                                </label>
                            </div>
                        </div>

                        <div class="col text-center">
                            <!-- Simple link -->
                            <a href="#!">비밀번호 찾기</a>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block fw-bold"
                            style="background-color: rgb(192,186,246); font-size: 1rem; ">로그인
                    </button>
                    <button type="button" class="btn btn-secondary btn-block mb-2 fw-bold"
                            style="background-color: rgb(192,186,246);  font-size: 1rem; ">회원가입
                    </button>


                </div>

                <div id="hr-sect">간편 로그인</div>

                <%--            <div class="modal-footer mx-5">--%>

                <div>
                    <a class="btn btn-primary mb-3 w-100" style="background-color:#FEE500;
                                                        color:#191919 "
                       href= javascript:kakaoLogin();
<%--                               javascript:kakaoLogin();--%>
                       role="button"
                    >

                        <%--                    javascript:kakaoLogin()--%>
                        <div class="row">
                            <div class="col-2 pt-1"><img src="/resources/images/kakaoSymbol.png"
                                                         style="width: 100%; object-fit: cover;" alt=""></div>
                            <div class="col-9 align-content-center justify-content-center fw-bold"
                                 style=" font-size: 1rem; ">카카오로 로그인하기

                                <input hidden="text" name="kakaoUser" id="kakaoUser"/>

                            </div>

                        </div>

                    </a>
                </div>


                <div>
                    <a class="btn btn-primary mb-3 w-100" style="background-color:#03C75A;" href="#!" role="button">

                        <div class="row">
                            <div class="col-2"><img src="/resources/images/naverSymbol.png"
                                                    style="width: 100%; object-fit: cover;" alt=""></div>
                            <div class="col-9 align-content-center justify-content-center fw-bold"
                                 style="font-size:1rem; ">네이버로 로그인하기
                            </div>
                        </div>
                    </a>
                </div>

                <div>
                    <a class="btn btn-primary mb-3 w-100" style="background-color:#ffffff; color: black;" href="#!"
                       role="button">

                        <div class="row">
                            <div class="col-2"><img src="/resources/images/googleSymbol.png"
                                                    style="width: 100%; object-fit: cover;  " alt=""></div>
                            <div class="col-9 align-content-center justify-content-center fw-bold"
                                 style=" font-size: 1rem; ">구글로 로그인하기
                            </div>
                        </div>
                    </a>
                </div>

                </form>
                <%--            </div>--%>
            </div>
        </div>
    </div>
</div>


<script src="/resources/js/jquery-3.6.0.js"></script>
<!-- boot -->
<script src="/resources/js/mdb.min.js"></script>



<%--구글 api 사용을 위한 스크립트--%>
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>

<%--카카오 SDK--%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="/resources/js/kakaoLogin.js"></script>


