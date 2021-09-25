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

<%
    String id = (String) session.getAttribute("id");
    String pageNum = null;
    try {
        pageNum = request.getParameter("pageNum").trim();
    } catch (NullPointerException e) {
        e.printStackTrace();
    }

%>
<html>
<head>
    <jsp:include page="/common/header.jsp"/>
    <title>자유게시판-장바구Needs</title>
</head>

<body>
<%--<jsp:include page="/common/navbar.jsp"/>--%>
<div name="supreme-container">
    <jsp:include page="/common/navbar.jsp"/>

    <div style="background-color: #b39ddb; height: 140px; width: 100%; display:flex; align-items: center">
        <div class="container">
            <h4 style="margin-top:0; padding-top: 20px; color: white">자유게시판</h4>
            <p style="color: white">자유롭게 글을 써보세요</p>
        </div>
    </div>

    <div class="row container" style="display: flex; justify-content: center">

        <div style="width: 70%">
            <div class="row input-field s12" style="height: 48px;">
                <div class="col s10 focusBorderPurple" style="display: flex; flex-direction: row; padding: 5px 5px;">
                    <div class="col s2" style="display:flex; align-items: center;">
                        <i id="searchShape" class="material-icons">search</i>
                        <select id="searchOption" name="type" style="margin: 0; border: 0px">
                            <option value="" disabled selected>--</option>
                            <option value="subject">제목</option>
                            <option value="content">내용</option>
                            <option value="mid">작성자</option>
                        </select>
                    </div>

                    <div class="inputDiv" style="flex: 1">
                        <input id="searchInput" type="text"
                               style="margin-bottom: 0;border: 0px!important;height: 100%;"
                               placeholder="궁금한점을 검색해보세요!">
                        <label for="searchInput"></label>
                    </div>
                </div>
                <div class="col s2" style="height: 100%;border-radius: 5px;">
                    <a id="freeBoardSearchBtn" class="waves-effect waves-customPurple customBtn" style="height: 100%;width: 100%;padding:0;display: flex;
                        justify-content: center;align-items: center;font-size: 18px">
                        <i class="material-icons" style="font-size: 22px">search</i> 검색
                    </a>
                </div>
            </div>


            <div class="row input-field s12" style="height: 48px;">
                <div class="col s10 focusBorderPurple" style="display: flex; padding: 5px 5px; overflow-y: scroll;">
                    <div style="display:flex; align-items: center;">
                        <i class="material-icons">tag</i>
                    </div>
                    <div id="tagDiv" style="display:flex;flex-flow: wrap;align-items: center;margin: 0;padding:0;">

                    </div>
                    <div class="inputDiv" style="flex: 1">
                        <input id="tagInput" type="text"
                               style="margin-bottom: 0;border: 0px!important;height: 100%; "
                               placeholder="태그로 검색해보세요!">
                        <label for="tagInput"></label>
                    </div>
                </div>
                <div class="col s2" style="height: 100%;border-radius: 5px;">
                    <a id="tagReset" class="waves-effect waves-customPurple btn-flat" style="height: 100%;width: 100%;padding:0;display: flex;
                        justify-content: center;align-items: center;font-size: 18px">
                        <i class="material-icons" style="font-size: 22px;">restart_alt</i> 초기화
                    </a>
                </div>
            </div>


            <div class="row" style="margin: 0">
                <div class="freeBoardHeader col s12" style="padding: 0;">
                    <ul class="col s10" style="display: flex">
                        <li class="active"><a class="btn-flat">
                            <svg width="16" xmlns="http://www.w3.org/2000/svg" height="16" viewBox="0 0 16 16">
                                <path fill="#212529" d="M8 10c-1.105 0-2-.895-2-2s.895-2 2-2 2 .895 2 2-.895 2-2 2z"
                                      clip-rule="evenodd"></path>
                            </svg>
                            최신순</a></li>
                        <li><a class="btn-flat">
                            <svg width="16" xmlns="http://www.w3.org/2000/svg" height="16" viewBox="0 0 16 16">
                                <path fill="#212529" d="M8 10c-1.105 0-2-.895-2-2s.895-2 2-2 2 .895 2 2-.895 2-2 2z"
                                      clip-rule="evenodd"></path>
                            </svg>
                            조회수순</a></li>
                        <li><a class="btn-flat">
                            <svg width="16" xmlns="http://www.w3.org/2000/svg" height="16" viewBox="0 0 16 16">
                                <path fill="#212529" d="M8 10c-1.105 0-2-.895-2-2s.895-2 2-2 2 .895 2 2-.895 2-2 2z"
                                      clip-rule="evenodd"></path>
                            </svg>
                            댓글많은순</a></li>
                        <li><a class="btn-flat">
                            <svg width="16" xmlns="http://www.w3.org/2000/svg" height="16" viewBox="0 0 16 16">
                                <path fill="#212529" d="M8 10c-1.105 0-2-.895-2-2s.895-2 2-2 2 .895 2 2-.895 2-2 2z"
                                      clip-rule="evenodd"></path>
                            </svg>
                            좋아요순</a></li>
                    </ul>
                    <a id="freeBoardWrite" class="waves-effect btn customBtn col s2" style="">
                        글쓰기
                    </a>
                </div>
                <hr class="col s12" style="border:1px solid rgb(209,209,209);margin: 0">

            </div>
            <%--==================================================================================================--%>
            <div class="row freeBoardContents">

            </div>
            <%--==================================================================================================--%>
            <div class="freeBoardFooter">
                <ul class="pagination center pageNumUl">
                </ul>
            </div>

        </div>


<%--        <jsp:include page="/common/footer.jsp"/>--%>
    </div>
    <jsp:include page="/common/footer1.jsp"/>
    <jsp:include page="/common/footer.jsp"/>
</div>


<script>

    pageNumValue = <%=pageNum%>;
    // 페이지 들어오면 freeBoard 네브바 액티브
    $('#boardTab').addClass("active");
    navbarShowOption = true;
    if ($('#boardTab').hasClass("active")) {
        navbarSubMenu.show();
    }

    $('#boardTab').on("click",function () {
        $(this).removeClass("active");
        location.href='/board/freeBoard.jsp'
    })


    // 탭 새로고침
    $(document).ready(function () {
        $('.tabs').tabs();
    });

    // 화면 처음 들어올때 목록 생성
    getCountFreeBoardList("shape1");

    // 글쓰기 로그인 여부 (세션에 아이디 없으면 로그인 모달 팝업)
    $('#freeBoardWrite').on('click', function () {
    let userId = "<%=id%>";
        if (userId == "null") {
            console.log("아이디 없음")
            $('#loginModal').modal('open');
        } else {

            location.href="/board/freeBoardWrite.jsp";
        }

    });

    // 해더 부분 분류 액션션
    $('.freeBoardHeader > ul > li').on("click",async function () {
        $('.freeBoardHeader > ul > li').removeClass('active');
        $(this).addClass('active');
        let getOrderType = $(this).children('a').text().trim();
        await changeOrderType(getOrderType);
        getCountFreeBoardList("shape1");
    });





    $('#freeBoardSearchBtn').on("click",function () {
        typeValue = $('#searchOption').val();
        console.log(typeValue)
        keywordValue = $('#searchInput').val();
        console.log(keywordValue)
        getCountFreeBoardList("shape1");
    });
    // $('#searchInput')



    // 태그 초기화 구현
    $('#tagReset').on("click",function () {
        $('#tagDiv').empty();
    });


    $('#searchInput').val("");
    $('.tagInput').val("");



    // 인풋창에서 엔터나 콤마 누르면 태그 생성

    tagInput.on("keydown", function (key) {
        if (key.keyCode == 13 ||key.keyCode == 188) {//키가 13이면 실행 (엔터는 13, 188 콤마)
            key.preventDefault();
            let tagName = tagInput.val();
            if(tagName != ""){
                let tagBox = `<a class="btn tagBtn">${tagName}<i class="material-icons" style="padding-left: 4px;">clear</i>
                </a>`
                $('#tagDiv').append(tagBox);
                $('#tagDiv a').on("click", function () {
                    $(this).remove();
                })
            }
            tagInput.val("");
            if($('#tagDiv').children().length > 1){
                tag = $('#tagDiv a').text().replaceAll("clear","").replaceAll("\n",",").replaceAll(" ","");
            } else {
                tag = $('#tagDiv a').text().replaceAll("clear","").replaceAll("\n","").replaceAll(" ","");
            }
            console.log(tag)
            getCountFreeBoardList("shape1");
        } else if(key.keyCode == 32){
            key.preventDefault();
        }else if(key.keyCode ==8){
            if(tagInput.val() =="" && $('#tagDiv').children().length > 0){
                $('#tagDiv').children().last().remove();
            }
        }
    });

</script>

</body>