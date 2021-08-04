<%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-07-28
  Time: 오후 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!-- Modal 블러때문에 푸터에 보냄-->
<jsp:include page="/templates.layout/loginModal.jsp"/>

<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/init.js"></script>
<script src="/resources/js/materialize.js"></script>


<%--구글 api 사용을 위한 스크립트--%>
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>

<%--카카오 SDK--%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="/resources/js/kakaoLogin.js"></script>


<script>
    $('#temp').click(function () {
        $('#loginModal').modal('open');
        $('#supreme-container').addClass('blur');

    });


</script>