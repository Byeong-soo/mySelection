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
    <form method="post" name="login_frm" id="loginFild" action="/member/loginPro.jsp">
        <div class="modal-content" style="margin: 0 40px; padding: 0 20px 0px 20px;">

            <h5 style="text-align: center; margin: 10px 0 10px 0;">로그인</h5>


            <!-- modal body   -->

                <!-- ID input -->
                <div class="input-field col s12">
                    <i class="material-icons prefix">account_circle</i>
                    <input id="loginId" type="text" class="validate">
                    <label for="loginId">아이디</label>
                </div>

                <div class="input-field col s12">
                    <i class="material-icons prefix">lock_outline</i>
                    <input id="loginPassword" type="password" class="validate customFontSize">
                    <label for="loginPassword">비밀번호</label>
                </div>

                <div class="row right">
                    <label>
                        <input class="filled-in checkbox-pupple" type="checkbox" id="rememberMe"/>
                        <span for="rememberMe" style="font-weight: bold; font-size: 13px">로그인 상태 유지</span>
                    </label>
                </div>


<%--            <div class="row center">--%>
<%--                <a href="#!" style="color: #283593; font-weight: bold">아이디 찾기</a>--%>
<%--                <span style="color: #283593; font-weight: bold">/</span>--%>
<%--                <a href="#!" style="color: #283593; font-weight: bold">비밀번호 찾기</a>--%>
<%--            </div>--%>

                <div class="row">
                    <a type="submit" class="btn customBtn waves-effect waves-light col s12" style="margin-bottom: 1vh;">로그인</a>
                    <a type="button" class="btn customBtn waves-effect waves-light col s12">회원가입</a>
                </div>




                    <div id="hr-sect">간편 로그인</div>

                    <div class="row" id="socialLogin">
                        <a href="javascript:kakaoLogin();" class="btn" type="submit"
                           style="background-color:#FEE500; color:#191919;">
                            <img class="" src="/resources/images/kakaoSymbol.png" alt="">
                            <span>로그인</span>
                        </a>
                        <input hidden="text" name="kakaoUser" id="kakaoUser"/>

                        <a href="#!;" class="btn" type="submit" style="background-color:#03C75A;">
                            <img class="" src="/resources/images/naverSymbol.png" alt="">
                            <span>로그인</span>
                        </a>
                        <input hidden="text" name="naverUser" id="naverUser"/>

                        <a href="#!;" class="btn" type="submit" style="background-color:#FFFFFF; color:black;">
                            <img class="" src="/resources/images/googleSymbol.png" alt="">
                            <span>로그인</span>
                        </a>
                        <input hidden="text" name="googleUser" id="googleUser"/>
                    </div>


            </div>


    </form>
</div>


