<%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-08-03
  Time: 오후 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    String nickName = (String) session.getAttribute("nickName");
%>
<!-- Modal Structure -->
<div class="modal" id="loginModal" style="border-radius: 10px;">
    <div class="row" style="margin: 0px">
        <button class="btn-flat modal-close" style="float: right;">
            <i class="material-icons">clear</i></button>
    </div>
    <form method="post" name="login_frm" id="login_frm">
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
                <a id="modalLoginBtn" type="button" class="btn customBtn waves-effect waves-light col s12"
                   style="margin-bottom: 1vh;">로그인</a>
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
                <div id="naver_id_login" style="display: none">
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


<%--채팅버튼--%>
<div class="fixed-action-btn">
    <a id="chatBtn" class="btn-floating btn-large" style="background-color:#b39ddb ">
        <i class="large material-icons">chat_bubble_outline</i>
    </a>
</div>


<%--채팅 모달--%>

<div class="chat-modal-main" id="chat-popup">
    <div class="chat-modal-header">
        <div style="flex: 1;">
            <span style="font-weight: 500;font-size: 20px">장바구Needs</span>
        </div>
        <div class="chat-modal-header-option">
            <i id="chat-modal-close" class="material-icons">clear</i>
        </div>
    </div>
    <div class="chat-modal-body" style="margin: 10px">
        <div id="chatBox" class="chat-area" style="overflow: scroll; height: 450px">
        </div>
    </div>
    <div class="chat-modal-footer">
        <div style="flex: 1">
            <textarea id="chatTextarea" class="materialize-textarea"></textarea>
            <label for="chatTextarea"></label>
        </div>
        <div>
            <a id="chatSendBtn" class="btn customPurpleBtn">보내기</a>
        </div>

    </div>
</div>

<script src="/resources/js/jquery-3.6.0.js"></script>
<script>


    let webSocket;
    let nickname = "<%=nickName%>";


    $('#chatBtn').on("click", function () {

        if (nickname == null || nickname == "null") {
            alert("로그인 후 채팅을 이용해보세요");
            return false;
        }

        $('#chat-popup').addClass("show");
        console.log("clickehoa");

        connect(); // 웹소켓 객체생성하여 웹소켓 서버와 접속 후 소켓이벤트 연결하기
        addWinEvt(); // 브라우저에 beforeunload, unload 이벤트 연결하기
    })


    function connect() {
        var url = 'ws://' + location.host + '/simpleChat';

        // 웹소켓 서버에 연결하기
        webSocket = new WebSocket(url);

        // 소켓이벤트 연결하기 (총 4가지: open, message, close, error)
        webSocket.onopen = onOpen;  // 서버와 연결된 후 호출됨
        webSocket.onclose = onClose; // 서버와 연결이 끊긴 후 호출됨
        webSocket.onmessage = onMessage; // 서버로부터 메시지를 받으면 호출됨
    } // connect


    function onOpen(event) {
        let chatValue = JSON.stringify({
            type: "noMessage",
            content: nickname + "님이 입장하셨습니다."
        })
        webSocket.send(chatValue);
        scrollDown();
    } // onOpen

    function onClose(event) {
        $('div#chatBox').append('<div class="chat-message">채팅방과 연결이 끊어졌습니다.</div>');
        scrollDown();
    } // onClose

    function onMessage(event) {
        console.log(event); // string
        console.log(event.data)
        let jsonValue = JSON.parse(event.data)
        let nick = jsonValue['nickname'];


        if (jsonValue['type'] == "message") {


            if (nick == nickname) {
                let myChat = `
        <div class="chat-message-outline">
            <div>
                <div style="display:flex;justify-content:right;padding:5px;">
                    <div style="display:flex;align-items:flex-end;">
                    <span style="font-size:11px;margin-right:5px;">${jsonValue['date']}</span>
                    <div>
                    <div class="balloon" style="white-space:normal;">
                    <span style="margin-bottom:5px;padding:5px;font-size:15px">${jsonValue['content']}</span>
                    </div>
                </div>
            </div>
        </div>`
                $('div#chatBox').append(myChat);
            } else {
                let otherChat = `
        <div class="chat-message-outline">
            <div>
                <div >
                <span>${jsonValue['nickname']}</span>
                </div>
                <div style="display:flex;justify-content:left;padding:5px;">
                    <div class="balloonOther" style="white-space:normal;">
                    <span style="margin-bottom:5px;padding:5px;font-size:15px">${jsonValue['content']}</span>
                    </div>
                    <div style="display:flex;align-items:flex-end;">
                    <span style="font-size:11px;margin-right:5px;">${jsonValue['date']}</span>
                    <div>
                </div>
            </div>
        </div>`

                $('div#chatBox').append(otherChat);
            }

        }else{
            let alert = `
            <div style="display: flex;justify-content: center">
            <span style="background-color: rgb(219,219,219)">${jsonValue['content']}</span>
            </div>
            `


            $('div#chatBox').append(alert);
        }
        scrollDown();

    } // onMessage


    // 채팅방 연결끊기 버튼 클릭시
    function disconnect() {
        if (webSocket == null) {
            return;

        }

        let chatValue = JSON.stringify({
            type: "noMessage",
            content: nickname + "님이 퇴장하셨습니다."
        })
        webSocket.send(chatValue);
        webSocket.close();
        webSocket = null;
    } // disconnect


    // 채팅내용을 서버에 전송하기
    function send() {
        let str = $('#chatTextarea').val();
        if (str == "" || str == null) {
            alert("메세지를 입력해주세요")
            return false;
        }


        let date = new Date();
        date = moment(date).format('LT');

        let chatValue = JSON.stringify({
            type: "message",
            nickname: nickname,
            content: str,
            date: date
        })

        webSocket.send(chatValue);

        $('#chatTextarea').val('');
        $('#chatTextarea').focus();
    } // send


    // 채팅 스크롤바를 하단으로 이동시키기
    function scrollDown() {
        //ta.scrollTop = ta.scrollHeight;

        let scrollHeight = $('div#chatBox')[0].scrollHeight;

        $('div#chatBox').scrollTop(scrollHeight);
    } // scrollDown


    // beforeunload, unload 이벤트 연결
    function addWinEvt() {
        // 브라우저에 현재 화면이 unload 되기 이전에 발생되는 이벤트
        window.addEventListener('beforeunload', function (event) {
            var dialogText = 'Dialog text here';
            // 크롬은 이벤트 객체에 returnValue 속성에 텍스트값 설정이 필요함
            event.returnValue = dialogText;
            return dialogText;
        });

        // 브라우저에 기존 화면이 다른 화면으로 완전히 unload 되면 발생되는 이벤트
        window.addEventListener('unload', function () {
            disconnect();
        });

    } // addWinEvt


    // 팝업 열기


    $('#chat-modal-close').on("click", function () {
        $('#chat-popup').removeClass("show");
        disconnect();
    })


    // 전송버튼 클릭시, 채팅내용을 서버에 전송하기
    $('#chatSendBtn').on('click', function () {
        send();
    });

    // 채팅입력 글상자에서 엔터키 누를시, 채팅내용을 서버에 전송하기
    $('#chatTextarea').on('keyup', function (event) {
        if (event.keyCode == 13) { // 엔터키(13)를 누르면
            send();
        }
    });


</script>