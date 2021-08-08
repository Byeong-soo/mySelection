<%@ page import="org.apache.catalina.User" %>
<%@ page import="com.google.gson.*" %>
<%@ page import="com.mySelection.repository.MemberDAO" %>
<%@ page import="com.mySelection.domain.MemberVO" %>
<%@ page import="java.sql.Timestamp" %>


<%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-07-31
  Time: 오전 2:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>

<jsp:useBean id="memberVO" class="com.mySelection.domain.MemberVO"/>
<%
    String id =null;
    String nickName=null;
    String profileImage=null;
    String email=null;
    String age_range=null;
    String gender=null;

    String kakaoUserInfo = request.getParameter("kakaoUser");

JsonObject jsonObject = new Gson().fromJson(kakaoUserInfo, JsonObject.class);

    JsonObject object = jsonObject.get("kakao_account").getAsJsonObject();
    JsonElement profile = object.get("profile");


    try {
        id = jsonObject.getAsJsonObject().get("id").toString().replace("\"", "");
        nickName = profile.getAsJsonObject().get("nickname").toString().replace("\"", "");
        profileImage = profile.getAsJsonObject().get("thumbnail_image_url").toString().replace("\"", "");
        email = object.getAsJsonObject().get("email").toString().replace("\"", "");
        age_range = object.getAsJsonObject().get("age_range").toString().replace("\"", "");
        gender = object.getAsJsonObject().get("gender").toString().replace("\"", "");
        gender = gender.substring(0,0);
    } catch (Exception e) {
        e.printStackTrace();
    }

        MemberDAO memberDAO = MemberDAO.getInstance();
        int count = memberDAO.getCheckById(id);

        if(count != 1) { // 가입

            memberVO.setId(id);
            memberVO.setEmail(email);
//            memberVO.setNickname(nickname);
//            memberVO.setProfileimg(profileimg);
            memberVO.setAgeRange(age_range);
            memberVO.setGender(gender);
            memberVO.setRecvEmail("N");
            memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));
            memberVO.setJoinType("K");
        }
    memberDAO.insert(memberVO);

    session.setAttribute("loginId", id);
    session.setAttribute("profileImage", profileImage);
    session.setAttribute("nickName", nickName);

    response.sendRedirect("/index.jsp");
%>





