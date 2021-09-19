<%@ page import="com.mySelection.repository.MemberDAO" %><%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-08-01
  Time: 오후 6:49
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = (String) session.getAttribute("id");

%>

<html>
<head>
    <jsp:include page="/common/header.jsp"/>
    <title>회원가입</title>
</head>

<body>
<%--<jsp:include page="/common/navbar.jsp"/>--%>
<div name="supreme-container">
    <jsp:include page="/common/navbar.jsp"/>
    <!--navbar-->

    <!--navbar-->

    <!-- Page Layout -->
    <div class="row container">

        <!-- left menu area -->

        <!-- end of left menu area -->

        <div class="row center" style="width: 450px">
            <!-- Teal page content  -->

            <div class="row" style="margin-top: 4vh">
                <h5 class="center">회원가입</h5>
            </div>

            <div class="divider" style="margin: 30px 0;"></div>

            <%-- 인풋 시작--%>
            <form action="/member/joinPro.jsp" method="POST" id="singUpForm" name="singUpForm">
                <%--  폼 시작--%>
                <div class="valign-wrapper">
                    <div class="input-field col s12 m12 l12" style="display: table-cell; vertical-align: middle;">
                        <input id="id" type="text" name="id" data-length="20">
                        <label for="id">아이디</label>
                        <span class="helper-text left-align" data-error="" data-success=""></span>
                    </div>

                </div>


                <div class="valign-wrapper">
                    <div class="input-field col s12">
                        <input id="passwd" type="password" class="validate" name="passwd">
                        <label for="passwd">비밀번호</label>
                        <span class="helper-text left-align" data-error="" data-success=""></span>
                    </div>
                </div>

                <div class="valign-wrapper">
                    <div class="input-field col s12">
                        <input id="passwd2" type="password" class="validate">
                        <label for="passwd2">비밀번호 재확인</label>
                        <span class="helper-text left-align" data-error="" data-success=""></span>
                    </div>
                </div>

                <div class="valign-wrapper">
                    <div class="input-field col s8 m8 l8" style="display: table-cell; vertical-align: middle;">
                        <input id="email" type="email" class="validate" name="email">
                        <label for="email">이메일</label>
                        <span class="helper-text left-align" data-error="wrong" data-success="right"></span>
                    </div>

                    <div class="col s4 m4 l4" style="display: table-cell!important; vertical-align: middle!important;">
                        <button type="button" class="btn-small waves-effect waves-light customBtn" id="btnEmailDupChk"
                                style="vertical-align: middle; bottom:20px">본인확인
                        </button>
                    </div>
                </div>


                <%-- 추가정보 토글--%>
                <div style="margin-top: 30px">
                    <button class="btn small customBtn waves-light waves-effect" id="div-title-toggle" type="button"
                            onclick="addtionalToggle()">상세정보
                        <span>입력하기</span></button>

                    <div id="additional-info" style="display: none">

                        <div class="valign-wrapper">
                            <div class="input-field col s12">
                                <input id="nickname" type="text" class="validate" name="nickname">
                                <label for="nickname">이름</label>
                            </div>
                        </div>


                        <div class="valign-wrapper center-align input-field file-field ">
                            <div class="file-path-wrapper col s8 m8 l8"
                                 style="display: table-cell; vertical-align: middle;">
                                <input id="profileImage" type="text" class="file-path validate" name="profileImage">
                            </div>

                            <div class="col s4 m4 l4"
                                 style="display: table-cell!important; vertical-align: middle!important;">
                                <button type="button center-align" class="btn-small waves-effect waves-light customBtn"
                                        id="temp1"
                                        style="width: 86px; height: 32.39px; font-size: 12px; padding: 0 4px;
                                        text-align: center; line-height: 32.39px;"><input type="file">
                                    <span> 프로필 사진</span>
                                </button>
                            </div>
                        </div>


                        <div class="valign-wrapper">
                            <div class="input-field col s12">
                                <input type="text" id="birthday" class="datepicker" name="birthday">
                                <label for="birthday">생일</label>
                            </div>
                        </div>


                        <div class="valign-wrapper">
                            <div class="input-field col s12">

                                    <select name="gender">
                                        <option value="N">선택안함</option>
                                        <option value="M">남자</option>
                                        <option value="W">여자</option>
                                    </select>

                                <label>성별</label>
                            </div>
                        </div>

                        <p class="row center">
                            알림 이메일 수신 : &nbsp;&nbsp;
                            <label>
                                <input name="receiveEmail" value="Y" type="radio"/>
                                <span>예</span>
                            </label>
                            &nbsp;&nbsp;
                            <label>
                                <input name="receiveEmail" value="N" type="radio" checked/>
                                <span>아니오</span>
                            </label>
                        </p>

                    </div>
                </div>
                <br>

                <button class="btn btn-block waves-effect waves-light customBtn" style="width: 100%" type="button"
                        id="singUpBtn">회원가입
                </button>

                <div>&nbsp;&nbsp;
                    <button class="btn btn-block waves-effect waves-light customBtn" style="width: 100%" type="reset">
                        초기화
                    </button>
                </div>


                <%--    private String profileimg;--%>
                <%--    private String recvEmail;--%>


            </form>

        </div>
        <jsp:include page="/common/footer.jsp"/>
    </div>
</div>


<script>
    // submit 조건
    let SignUpCheckId = false;
    let SignUpCheckPasswd = false;
    let SignUpCheckAgainPasswd = false;
    let SignUpCheckEmail = false;

    // -----------------------------  id 중복확인 + 입력 제한

    $('#id').blur(function () {
        let id = $('#id');
        let idValue = $('#id').val();
        let idType = /^[A-Za-z0-9+]{4,12}$/;
        let $span = id.closest('div.input-field').find('span.helper-text');

        if (idValue == '') {
            SignUpCheckId = false;
            $span.html('')
            passwd2.removeClass('valid');
            passwd2.removeClass('invalid');
            return;
        } else {
            if (idType.test(idValue)) { // 형식에 맞음
                //DB와 대조

                $.ajax({
                    url: "/api/member/dupCheck/" + idValue,
                    type: "GET",
                    success: function (result) {
                       if (result == 1) {
                           SignUpCheckId = false;
                           $span.html('사용중인 아이디입니다.').css('color', 'red');
                           id.removeClass('valid').addClass('invalid');
                       } else {
                           SignUpCheckId = true;
                           $span.html('좋은 아이디네요').css('color', 'green');
                           id.removeClass('invalid').addClass('valid');
                       }
                    }
                });

            } else {
                // 정규식에 맞지않는 형식
                SignUpCheckId = false;
                $span.html('영문과 숫자만으로 4~12글자로 입력해주세요.').css('color', 'red');
                id.removeClass('valid').addClass('invalid');
                return;
            }
        }

    });

    //------------------------------------비밀번호------------------------------------
    console.log("<%=id%>")
    if("<%=id%>" !="null"){
        location.href="/index.jsp"
    }


    let passwd1 = $('#passwd')
    let passwd2 = $('#passwd2')


    // 비밀번호 확인 정규식
    let passType = /^[a-zA-Z0-9~!@#$%^&*(_+|<>?:{}]{6,16}$/;
    let passType2 = /(.)\1{3,}/


    let checkPassTypeKeyup = function () {
        let passwdValue1 = passwd1.val();
        let $span = passwd1.closest('div.input-field').find('span.helper-text');
        if (passwdValue1 != '') { // 빈칸 아닐때
            if (passType.test(passwdValue1)) { // 타입 1 통과
                if (passType2.test(passwdValue1)) {
                    SignUpCheckPasswd = false;
                    console.log(("연속된 문자 사용 금지"))
                    $span.html('연속된문자를 4자연속 쓰시면 안됩니다.').css('color', 'red');
                    passwd1.removeClass('valid').addClass('invalid');
                } else {
                    // 성공 표시
                    SignUpCheckPasswd = true;
                    $span.html('좋은 비밀번호네요').css('color', 'green');
                    passwd1.removeClass('invalid').addClass('valid');
                }

            } else { // 타입 1 불통
                SignUpCheckPasswd = false;
                $span.html('비밀번호는 6~16사이로 작성해주세요').css('color', 'red');
                passwd1.removeClass('valid').addClass('invalid');
            }
        } else { // 빈칸일때
            SignUpCheckPasswd = false;
            $span.html('')
            passwd2.removeClass('valid');
            passwd2.removeClass('invalid');
        }
    } // checkPassTypeKeyup

    // 패스워드 1 이벤트에 추가

    passwd1.on('focus', function () {
        window.addEventListener('keyup', checkPassTypeKeyup);
        console.log('포커스인')
    });

    passwd1.on('focusout', function () {
        window.removeEventListener('keyup', checkPassTypeKeyup);
        console.log('포커스아웃')
    });


    // 키업안에서 돌아가는 메소드 키 업될때마다 일치불일치 확인
    let checkPassSameKeyup = function () {
        let passwdValue1 = passwd1.val();
        let passwdValue2 = passwd2.val();
        console.log(passwdValue1);
        console.log(passwdValue2);
        let $span = passwd2.closest('div.input-field').find('span.helper-text');
        if (passwdValue2 != '') { // 내용 있을때
            if (passwdValue1 == passwdValue2) { // 비번일치
                SignUpCheckAgainPasswd = true;
                $span.html('비밀번호 일치함').css('color', 'green');
                passwd2.removeClass('invalid').addClass('valid');
            } else { // 불일치
                SignUpCheckAgainPasswd = false;
                $span.html('비밀번호 불일치함').css('color', 'red');
                passwd2.removeClass('valid').addClass('invalid');
            }
        } else { // 확인란 공백
            SignUpCheckAgainPasswd = false;
            $span.html('')
            passwd2.removeClass('valid');
            passwd2.removeClass('invalid');
        }
    };

    // 비밀번호 조건 확인


    // 비밀번호 일치 확인 밑 일치확인
    // 포커스 있을때 이벤트
    passwd2.on('focus', function () {
        console.log("포커스 확인")
        console.log("시작")
        window.addEventListener('keyup', checkPassSameKeyup);
    })
    // 포커스나가면 삭제
    passwd2.on('focusout', function () {
        // 키다운 감지해서 비교
        console.log("빠져나감")
        window.removeEventListener("keyup", checkPassSameKeyup);
    });


    // ----------------------------이메일 형식 확인---------------------------------------

    let email = $('#email')
    let emailType = /^[0-9a-zA-Z]([-_]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

    let checkEmailTypeKeyup = function () {
        let emailValue = email.val();
        if (emailValue != '') { // 빈칸 아닐때
            if (emailType.test(emailValue)) { // 타입 1 통과
                SignUpCheckEmail = true;
                // 성공 표시
                console.log("passType1.test(passwdValue1) = " + emailType.test(emailValue))
                console.log("passType1.exec(passwdValue1) = " + emailType.exec(emailValue))
                console.log("input = " + emailValue)

            } else { // 타입 1 불통
                // 숫자 문자 길이 안내
                SignUpCheckEmail = false;
                console.log("passType1.exec(passwdValue1) = " + emailType.exec(emailValue))
                console.log("타입1 불통")
            }
        } else { // 빈칸일때
            SignUpCheckEmail = false;
            console.log("빈칸")
        }
    } // checkEmailTypeKeyup

    // email 이벤트에 추가

    email.on('focus', function () {
        console.log("포커스 확인")
        console.log("시작")
        window.addEventListener('keyup', checkEmailTypeKeyup);
    })
    // 포커스나가면 삭제
    email.on('focusout', function () {
        // 키다운 감지해서 비교
        console.log("빠져나감")
        window.removeEventListener("keyup", checkEmailTypeKeyup);
    });


    $('#singUpForm input').keydown(function (event) {
        if (event.keyCode === 13) {
            event.preventDefault();
        }

    });


    // ------------------------- 회원가입 버튼 작동------------

    $('#singUpBtn').on('click', function () {
        if(!SignUpCheckId ) {
            M.toast({html: '아이디를 확인해주세요', classes: 'rounded red darken-2 white-text'});
            return;
        }
        if(!SignUpCheckPasswd ) {
            M.toast({html: '비밀번호를 확인해주세요', classes: 'rounded  red darken-2 white-text'});
            return;
        }
        if(!SignUpCheckAgainPasswd ) {
            M.toast({html: '비밀번호를 일치를 확인해주세요', classes: 'rounded  red darken-2 white-text'});
            return;
        }
        if(!SignUpCheckEmail) {
            M.toast({html: '이메일을 확인해주세요', classes: 'rounded red darken-2 white-text'});
            return;
        }



        let obj = $('form#singUpForm').serializeObject();
        let strJson = JSON.stringify(obj);


        $.ajax({
            url: '/api/member/join',
            method: 'POST',
            data: strJson,
            contentType: 'application/json; charset=UTF-8',
            success: function (data) {
                console.log(data);

                if (data.result == true) {
                    alert('회원가입 성공!');
                    location.href="/index.jsp";

                }
            } // success
        });


    });


</script>

</body>
</html>
