<%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-08-03
  Time: 오후 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!-- Modal Trigger -->


<!-- Modal Structure -->
<div class="modal" id="loginModal" style="border-radius: 10px;">
    <div class="row" style="margin: 0px">
        <button class="btn-flat modal-close" style="float: right;">
            <i class="material-icons">clear</i></button>
    </div>
    <form method="post" name="login_frm" id="login_frm" >
        <div class="modal-content" style="margin: 0 40px 30px 40px; padding: 0 20px 0px 20px;">

            <h5 style="text-align: center; margin: 10px 0 10px 0;">로그인</h5>

            <!-- modal body   -->

                <!-- ID input -->
                <div class="input-field col s12">
                    <i class="material-icons prefix">account_circle</i>
                    <input id="loginId" type="text" class="validate" name="id">
                    <label for="loginId">아이디</label>
                </div>

                <div class="input-field col s12">
                    <i class="material-icons prefix">lock_outline</i>
                    <input id="loginPassword" type="password" class="validate customFontSize" name="passwd">
                    <label for="loginPassword">비밀번호</label>
                </div>

            <div class="row" style="margin-bottom: 0;">
                <div class="row right">
                    <label>
                        <input class="filled-in checkbox-pupple" type="checkbox" id="rememberMe" name="rememberMe"/>
                        <span for="rememberMe" style="font-weight: bold; font-size: 13px">로그인 상태 유지</span>
                    </label>
                </div>


            <div class="row left">
                <a href="#!" style="color: #283593; font-weight: bold; font-size: 12px">아이디</a>
                <span style="color: #283593; font-weight: bold">|</span>
                <a href="#!" style="color: #283593; font-weight: bold; font-size: 12px">비밀번호 찾기</a>
            </div>

            </div>

                <div class="row">
                    <a id="modalLoginBtn" type="button" class="btn customBtn waves-effect waves-light col s12" style="margin-bottom: 1vh;">로그인</a>
                    <a type="button" class="btn customBtn waves-effect waves-light col s12" href="/member/join.jsp">회원가입</a>
                </div>




                    <div id="hr-sect">간편 로그인</div>

                    <div class="row" id="socialLogin" style="display: flex;justify-content: space-between">
                        <div>
                        <a href="#!" class="btn" type="submit" id="kakaoLoginBtn"
                           style="background-color:#FEE500; color:#191919;">
                            <img class="img" src="/resources/images/kakaoSymbol.png" alt="">
                            <span>로그인</span>
                        </a>
                        </div>
                        <div id="naver_id_login" style="width: 106.84px; display: none">
                        </div>
                        <div>
                            <a class="btn" id="naverLoginBtn"
                               style="background-color:#03C75A;">
                                <img class="" src="/resources/images/naverSymbol.png" alt="">
                                <span>로그인</span>
                            </a>
                        </div>
                        <div>
                        <a href="#!;" class="btn" type="submit" style="background-color:#FFFFFF; color:black;">
                            <img class="img" src="/resources/images/googleSymbol.png" alt="">
                            <span>로그인</span>
                        </a>

                        </div>
                    </div>


            </div>


    </form>
</div>

<div id="accountDeleteConfirm" class="modal">
    <div class="modal-content">
        <h4>탈퇴하시겠습니까?</h4>
        <p>모든 정보가 삭제됩니다.</p>
    </div>
    <div class="modal-footer">
        <a href="#!" class="modal-close waves-effect waves-green btn-flat">삭제하기</a>
        <a href="#!" class="modal-close waves-effect waves-red btn-flat">취소</a>
    </div>
</div>




