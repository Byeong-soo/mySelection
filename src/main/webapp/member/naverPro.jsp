<%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-09-29
  Time: 오후 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/resources/js/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"></script>
</head>
<body>
<script type="text/javascript">



    var naver_id_login = new naver_id_login("psJZfoFjzatCzWZwYVsx", "http://localhost:8180/member/naverPro.jsp");

            function naverSignInCallback() {
                // naver_id_login.getProfileData('프로필항목명');
                // 프로필 항목은 개발가이드를 참고하시기 바랍니다.
                console.log(naver_id_login.getProfileData('email'));
                console.log(naver_id_login.getProfileData('name'));
                console.log(naver_id_login.getProfileData('profile_image'));
                console.log(naver_id_login.getProfileData('birthday'));
                console.log(naver_id_login.getProfileData('nickname'));
                console.log(naver_id_login.getProfileData('gender'));
                console.log(naver_id_login.getProfileData('age'));
            }

            // 네이버 사용자 프로필 조회
            naver_id_login.get_naver_userprofile("naverSignInCallback()");




</script>


</body>
</html>
