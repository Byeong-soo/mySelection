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
    String bno = request.getParameter("num").trim();
    String pageNum = request.getParameter("pageNum").trim();
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


    <div class="row container" style="display: flex; justify-content: center">

        <div style="width: 15%;">
            <div style="margin-top: 40%" class="right col s8">
                <div style="display: flex; flex-direction: column;position: fixed">
                    <a id="freeBoardBackPage" class="waves-effect waves-light btn customWhiteBtn"> <i
                            class="large material-icons">arrow_back</i></a>
                </div>
            </div>

        </div>

        <div style="width: 70%;margin: 0 5%;height: auto">
            <div class="col s12" style="height: 100%;">
                <%--제목--%>
                <div class="col s12" style="display: flex">
                    <div class="col s10">
                        <div style=" margin-top: 6%; display: flex;align-items: center">
                            <h4 id="oneFreeBoardSubject" style="margin: 10px 0;"><i class="material-icons"
                                   style="color:#b39ddb;font-size: 1em;">quora</i>
                            </h4>
                        </div>
                        <div>
                    <span id="oneFreeBoardIdDate">

                    </span>
                        </div>
                    </div>
                    <div id="freeBoardLinkDiv" class="col s2" style="display: flex;align-items: flex-end">

                    </div>

                </div>
                <div class="col s12">
                    <hr class="col s12" style="border:1px solid rgb(209,209,209);margin: 2% 0">
                </div>

                <%-- 제목 끝--%>
                <%-- 본문 시작--%>
                <div class="col s12">
                    <div id="viewer">

                    </div>
<%--                    <div class="col s12" style="min-height: 300px">--%>
<%--                        <p id="oneFreeBoardContent"></p>--%>
<%--                    </div>--%>

                    <div id="oneFreeBoardTag" class="col s12" style="display: flex;background-color: rgb(245,245,245); align-items: center">
                        <span>연관 태그 : </span>
                    </div>

                </div>

                <div class="col s12" style="margin-top: 20px">
                    <div class="col s12" style="border: 1px solid lightgray">
                        <h6 id="commentHeader" style="display: flex;align-items:center;"><i class="material-icons" style="color:#b39ddb; padding-right:5px;">mode_comment</i></h6>
                    </div>
                    <div class="col s12 commentDiv" style=" border: 1px solid lightgray">
                        <textarea id="commentTextarea" class="materialize-textarea"
                        placeholder="댓글을 남겨보세요"></textarea>
                        <label for="commentTextarea"></label>
                    </div>
                    <div class="col s12" style="display: flex;justify-content: right;">
                        <a class="waves-effect waves-light btn customPurpleBtn" style="margin: 5px 0;">등록</a>
                    </div>
                </div>

                    <div class="col s12" style="display: flex;justify-content: left;">
                        <h5>자유게시판 글</h5>
                    </div>

                <%--==================================================================================================--%>
                <div class="col 12 freeBoardContents" style="margin-bottom: 30px">
                    <hr class="col s12" style="border:1px solid rgb(209,209,209);margin: 0 0">
                </div>
                <%--==================================================================================================--%>
                <div class="freeBoardFooter">
                    <ul class="pagination center pageNumUl">
                    </ul>
                </div>

            </div>
        </div>

        <div style="width: 15%; ">
            <div class="col s8 left" style="margin-top: 40%">
                <div class="right-side-slider" style="display: flex; flex-direction: column;position: fixed">
                    <a class="waves-effect waves-light btn customWhiteBtn tooltipped"
                       data-tooltip="답글을 달려면 클릭">답 글</a>
                    <a id="oneFreeBoardLikeCount" class="waves-effect waves-light btn customWhiteBtn tooltipped">
                        <i class="large material-icons">favorite_border</i></a>
                    <a id="oneFreeBoardBookMarkCount" class="waves-effect waves-light btn customWhiteBtn tooltipped">
                        <i class="large material-icons">bookmark_border</i></a>
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
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-viewer.js"></script>

<script>
    pageNumValue = <%=pageNum%>;

    $('#boardTab').addClass("active");
    navbarShowOption = true;
    if ($('#boardTab').hasClass("active")) {
        navbarSubMenu.show();
    }

    // 탭 새로고침
    $(document).ready(function () {
        $('.tabs').tabs();
    });

    $('#boardTab').on("click",function () {
        $(this).removeClass("active");
        location.href='/board/freeBoard.jsp'
    })

    getCountFreeBoardList("shape2");

    $('#freeBoardBackPage').on("click", function () {
        location.href = '/board/freeBoard.jsp?pageNum=' + pageNumValue;
    });


    // 게시글 가져오기

    $.ajax({
        url: "/api/freeBoard/one/" + <%=bno%>,
        method: 'GET',
        success: function (data) {
            console.log(typeof data);
            console.log(data);

            setData(data);
        } // success
    });

    function setData(data) {
    $('#oneFreeBoardSubject').append(data.board['subject']);
    // $('#viewer').append(data.board['content']);
    $('#oneFreeBoardIdDate').append(data.board['mid']+ " · " + moment(data.board['regDate']).format('LLL'));
    $('#oneFreeBoardLikeCount').append(data.board['likeCount']);
    $('#oneFreeBoardLikeCount').attr("data-tooltip",data.board['likeCount']+"명이 이글을 좋아합니다!");
    $('#oneFreeBoardBookMarkCount').append(data.board['bookmarkCount']);
    $('#oneFreeBoardBookMarkCount').attr("data-tooltip",data.board['bookmarkCount']+"명이 이글을 북마크 했습니다!");
    $('#commentHeader').append("댓글("+data.board['commentCount']+")");

        const viewer = new toastui.Editor({
            el: document.querySelector('#viewer'),
            initialValue: data.board['content']
        });



    let tag = data.board['tag'];
        console.log(tag)
    let tagList;

        if(tag == null){
            let tagSpan = `<span style="margin-left: 10px">연관태그 없음.</span>`;
            $('#oneFreeBoardTag').append(tagSpan);
        }else if(tag.includes(",")){
        tagList = tag.split(',');
        for(let i=0;i<tagList.length;i++){
            let tagA = ` <a class="btn tagBtn" style="cursor:Default">${tagList[i]}<i class="material-icons" style="padding:0 4px">clear</i></a>`
            $('#oneFreeBoardTag').append(tagA);
        }
    } else{
        let tagA = ` <a class="btn tagBtn" style="cursor:Default">${tag}<i class="material-icons" style="padding:0 4px">clear</i></a>`
        $('#oneFreeBoardTag').append(tagA);
    }


    if("<%=id%>" == data.board['mid']){
        let link = `  <a class="freeBoardLink">수정</a>
                        <a class="freeBoardLink">삭제</a>`
    $('#freeBoardLinkDiv').append(link);
        }
    } // showData

    // 댓글
   let commentInput = $('#commentTextarea');

    if("<%=id%>" == null || "null"){
        commentInput.attr("placeholder","로그인 후 댓글을 남겨보세요!");
    }

</script>

</body>
