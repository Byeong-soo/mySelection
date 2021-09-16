<%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-08-09
  Time: 오전 2:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    session.invalidate(); // 초기화. 모두 삭제

// 쿠키값 가져오기

        Cookie[] cookies = request.getCookies();
// 특정 쿠키 삭제하기(브라우저가 삭제하도록 유효기간 0초로 설정해서 보내기)
        if (cookies != null) {

            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("id")) {
                    cookie.setMaxAge(0); // 쿠키 유효기간 0초 설정(삭제 의도)
                    cookie.setPath("/");
                    response.addCookie(cookie); // 응답객체에 추가하기
                }
                if (cookie.getName().equals("profileImage")) {
                    cookie.setMaxAge(0); // 쿠키 유효기간 0초 설정(삭제 의도)
                    cookie.setPath("/");
                    response.addCookie(cookie); // 응답객체에 추가하기
                }
                if (cookie.getName().equals("nickName")) {
                    cookie.setMaxAge(0); // 쿠키 유효기간 0초 설정(삭제 의도)
                    cookie.setPath("/");
                    response.addCookie(cookie); // 응답객체에 추가하기
                }
            }
        }
        response.sendRedirect("/index.jsp");
%>