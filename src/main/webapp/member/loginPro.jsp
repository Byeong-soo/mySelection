<%@ page import="org.apache.catalina.User" %>
<%@ page import="com.google.gson.*" %>


<%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-07-31
  Time: 오전 2:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>


<%
    String id =null;
    String nickname=null;
    String profileimg=null;
    String email=null;
    String age_range=null;
    String gender=null;

    String kakaoUserInfo = request.getParameter("kakaoUser");
System.out.println(kakaoUserInfo);
JsonObject jsonObject = new Gson().fromJson(kakaoUserInfo, JsonObject.class);

    JsonObject object = jsonObject.get("kakao_account").getAsJsonObject();
    JsonElement profile = object.get("profile");


    try {
        id = jsonObject.getAsJsonObject().get("id").toString();
        nickname = profile.getAsJsonObject().get("nickname").toString();
        profileimg = profile.getAsJsonObject().get("thumbnail_image_url").toString();
        email = object.getAsJsonObject().get("email").toString();
        age_range = object.getAsJsonObject().get("age_range").toString();
        gender = object.getAsJsonObject().get("gender").toString();
    } catch (Exception e) {
        e.printStackTrace();
    }

System.out.println(id);
    System.out.println(nickname);
    System.out.println(profileimg);
    System.out.println(email);
    System.out.println(age_range);
    System.out.println(gender);



%>





