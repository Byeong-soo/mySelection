<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.mySelection.repository.MemberDAO" %><%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-08-05
  Time: 오후 5:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- MemberVO 객체 준비 --%>
<jsp:useBean id="memberVO" class="com.mySelection.domain.MemberVO"/>

<%-- 사용자 입력값 가져오기 -> MemberVO 객체에 저장하기 --%>
<jsp:setProperty property="*" name="memberVO"/>
<% memberVO.setRegDate(new Timestamp(System.currentTimeMillis()));
   memberVO.setJoinType("J");
    String id = memberVO.getId();
    String birthday = memberVO.getBirthday();
    String profileimage = memberVO.getProfileImage();
    String nickname = memberVO.getNickname();
    String basicImage = "/resources/images/profileImages/basicProfile.png";

    if(profileimage == null) {
        memberVO.setProfileImage(basicImage);
    }

    if(nickname == null) {
        memberVO.setNickname(id);
    }


    if(birthday != null) {
        birthday = birthday.replace("-", ""); // 하이픈 문자열을 빈문자열로 대체
        memberVO.setBirthday(birthday);
        int birthYear =Integer.parseInt(birthday.substring(0,3));
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        int age = year-birthYear;
        int age_range = age%10;
        memberVO.setAgeRange(age_range+"0대");
    } else {
        memberVO.setAgeRange("null");
    }

    System.out.println(memberVO);
   MemberDAO memberDAO = MemberDAO.getInstance();
    memberDAO.insert(memberVO);

%>

<script>
    alert("회원가입 완료");
    location.replace('/index.jsp');

</script>

