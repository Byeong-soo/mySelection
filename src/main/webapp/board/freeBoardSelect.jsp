<%@ page import="com.mySelection.repository.MemberDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.mySelection.domain.Criteria" %>
<%@ page import="com.mySelection.repository.BoardDAO" %>
<%@ page import="com.mySelection.domain.PageDTO" %>
<%@ page import="com.mySelection.domain.BoardVO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-08-01
  Time: 오후 6:49
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <jsp:include page="/common/header.jsp"/>
    <title>자유게시판-장바구Needs</title>
</head>

<body>
<%--<jsp:include page="/common/navbar.jsp"/>--%>
<div name="supreme-container">
    <jsp:include page="/common/navbar.jsp"/>


    <div class="row container" style="display: flex; justify-content: center">

        <div style="width: 15%">
            <div style="margin-top: 40%" class="right col s8">
                <div style="display: flex; flex-direction: column;">
                    <a class="waves-effect waves-light btn customWhiteBtn"> <i
                            class="large material-icons">arrow_back</i></a>
                </div>
            </div>

        </div>
        <div style="width: 70%;margin: 0 5%">

            <div class="row col s12">
                <%--제목--%>
                <div class="col s12">
                    <div style=" margin-top: 6%; display: flex;align-items: center">
                        <h4><i class="material-icons" style="color:#b39ddb;font-size: 1em;margin-right: 5px">quora</i>제목입니당
                        </h4>
                    </div>
                    <div>
                    <span>
                pumkin08 · 2021.09.08
                    </span>
                    </div>
                    <hr class="col s12" style="border:1px solid rgb(209,209,209);margin: 2% 0">
                </div>
                <%--                제목 끝--%>
                <%--                본문 시작--%>
                <div class="col s12">
                    <div class="col s12">
                        <p>본문입니다.</p>
                    </div>

                    <div class="col s12" style="background-color: rgb(240,240,240)">
                        <span>연관 태그</span>
                    </div>
                </div>
            </div>
        </div>
        <div style="width: 15%">
            <div class="col s8 left" style="margin-top: 40%">
                <div class="right-side-slider" style="display: flex; flex-direction: column;">
                    <a class="waves-effect waves-light btn customWhiteBtn tooltipped"
                       data-tooltip="답글을 달려면 클릭">답 글</a>
                    <a class="waves-effect waves-light btn customWhiteBtn tooltipped"
                       data-tooltip="0명이 이글을 좋아합니다!">
                        <i class="large material-icons">favorite_border</i>0</a>
                    <a class="waves-effect waves-light btn customWhiteBtn tooltipped"
                       data-tooltip="0명이 이글을 북마크 했습니다!">
                        <i class="large material-icons">bookmark_border</i>0</a>
                    <a class="waves-effect waves-light btn customWhiteBtn">
                        <i class="large material-icons">share</i>공유</a>

                </div>
            </div>

        </div>


        <%--        <jsp:include page="/common/footer.jsp"/>--%>
    </div>
    <jsp:include page="/common/footer1.jsp"/>
    <jsp:include page="/common/footer.jsp"/>
</div>


<script>

    $('#boardTab').addClass("active");
    navbarShowOption = true;
    if ($('#boardTab').hasClass("active")) {
        navbarSubMenu.show();
    }

    // 탭 새로고침
    $(document).ready(function () {
        $('.tabs').tabs();
    });


</script>

</body>