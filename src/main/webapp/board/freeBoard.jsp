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
                        <input id="searchInput" type="text" class="validate"
                               style="margin-bottom: 0;border: 0px!important;height: 100%;"
                               placeholder="궁금한점을 검색해보세요!">
                        <label for="searchInput"></label>
                    </div>
                </div>
                <div class="col s2" style="height: 100%;border-radius: 5px;">
                    <a class="waves-effect waves-customPurple customBtn" style="height: 100%;width: 100%;padding:0;display: flex;
                        justify-content: center;align-items: center;font-size: 18px">
                        <i class="material-icons" style="font-size: 22px">search</i> 검색
                    </a>
                </div>
            </div>


            <div class="row input-field s12" style="height: 48px;">
                <div class="col s10 focusBorderPurple" style="display: flex; padding: 5px 5px; overflow-y: scroll;">
                    <div style="display:flex; align-items: center;">
                        <i id="tagShape" class="material-icons">tag</i>
                    </div>
                    <div id="tagDiv" style="display:flex;flex-flow: wrap;align-items: center;margin: 0;padding:0;">

                    </div>
                    <div class="inputDiv" style="flex: 1">
                        <input id="tagInput" type="text" class="validate"
                               style="margin-bottom: 0;border: 0px!important;height: 100%; "
                               placeholder="태그로 검색해보세요!">
                        <label for="tagInput"></label>
                    </div>
                </div>
                <div class="col s2" style="height: 100%;border-radius: 5px;">
                    <a id="tagReset" class="waves-effect waves-customPurple btn-flat" style="height: 100%;width: 100%;padding:0;display: flex;
                        justify-content: center;align-items: center;font-size: 18px">
                        <i class="material-icons" style="font-size: 22px">restart_alt</i> 초기화
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
            <div id="freeBoardContents" class="row">

            </div>
            <%--==================================================================================================--%>
            <div id="freeBoardFooter">
                <ul id="pageNumUl" class="pagination center">
                </ul>
            </div>

        </div>


<%--        <jsp:include page="/common/footer.jsp"/>--%>
    </div>
    <jsp:include page="/common/footer1.jsp"/>
    <jsp:include page="/common/footer.jsp"/>
</div>


<script>

    let pageNumValue = null;
    let amountValue = null;
    let typeValue = null;
    let keywordValue = null;
    let orderType = "re_ref";


    let tagInput = $('#tagInput');

    let pageNumUl = $('#pageNumUl');

    //푸터 정의
    let contentsOption = $('.freeBoardHeader ul li');

    // 페이지 들어오면 freeBoard 네브바 액티브
    $('#boardTab').addClass("active");
    navbarShowOption = true;
    if ($('#boardTab').hasClass("active")) {
        navbarSubMenu.show();
    }

    // 탭 새로고침
    $(document).ready(function () {
        $('.tabs').tabs();
    });

    // 화면 처음 들어올때 목록 생성
    getCountFreeBoardList();

    // 글쓰기 로그인 여부 (세션에 아이디 없으면 로그인 모달 팝업)
    $('#freeBoardWrite').on('click', function () {
    let userId = "<%=id%>";
        if (userId == "null") {
            console.log("아이디 없음")
            $('#loginModal').modal('open');
        } else {
            console.log("엘스문")
            location.href="freeBoardSelect.jsp";
        }

    });

    // 해더 부분 분류 액션션
    $('.freeBoardHeader > ul > li').on("click",async function () {
        $('.freeBoardHeader > ul > li').removeClass('active');
        $(this).addClass('active');
        let getOrderType = $(this).children('a').text().trim();
        await changeOrderType(getOrderType);
        getCountFreeBoardList();
    });

    function changeOrderType(getOrderType) {
        console.log("리스트 타입에 들어옴")
        if(getOrderType == "최신순"){
            orderType = "re_ref"
        } else if(getOrderType == "조회수순") {
            orderType = "readcount"
        } else if(getOrderType == "댓글많은순"){
            orderType = "comment_count"
        } else if(getOrderType == "좋아요순"){
            orderType = "like_count"
        }
        pageNumValue = 1;
    }


    // 인풋창에서 엔터나 콤마 누르면 태그 생성
    tagInput.on("keydown", function (key) {
        if (key.keyCode == 13) {//키가 13이면 실행 (엔터는 13)
            let tagName = tagInput.val();
            let tagBox = `<a class="btn" style="margin: 5px 4px;padding: 0 8px!important;display: flex;align-items: center;height:20px;">${tagName}
                <i class="material-icons" style="padding-left: 4px">clear</i>
                </a>`
            $('#tagDiv').append(tagBox);
            $('#tagDiv a').on("click", function () {
                $(this).remove();
            })


            // createTag(tagName);
            tagInput.val("");
        }
    });

    function createTag(tagName) {
        let newA = document.createElement("a");
        let newI = document.createElement("i");
        let text = document.createTextNode(tagName);
        let textX = document.createTextNode("clear");

        newA.setAttribute("class", "btn");
        newA.style.display = "flex";
        newA.style.margin = "0 4px";
        newA.style.padding = "0 8px";
        newA.appendChild(text);
        newA.appendChild(newI);

        newI.setAttribute("class", "material-icons");
        newI.style.paddingLeft = "4px";
        newI.appendChild(textX);

        document.getElementById("tagDiv").appendChild(newA);
    }

    // 태그 초기화 구현
    $('#tagReset').on("click",function () {
        $('#tagDiv').empty();
    });




    // 게시판 글 몇일전 구현
    function timeForToday(value) {
        const today = new Date();
        const timeValue = new Date(value);

        const betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
        if (betweenTime < 1) return '방금전';
        if (betweenTime < 60) {
            return `${betweenTime}분전`;
        }

        const betweenTimeHour = Math.floor(betweenTime / 60);
        if (betweenTimeHour < 24) {
            return `${betweenTimeHour}시간전`;
        }

        const betweenTimeDay = Math.floor(betweenTime / 60 / 24);
        if (betweenTimeDay < 365) {
            return `${betweenTimeDay}일전`;
        }

        return `${Math.floor(betweenTimeDay / 365)}년전`;
    }

    //  게시판 글 create

    function createFreeBoardContent(boardList) {
        removeFreeBoardList();


        for (let i = 0; i < boardList.length; i++) {

            let content =
                `
                <div class="col s12" id="content${i}"  style=" border-bottom: 1px solid lightgray">
                    <div class="col s12" style="display: flex; padding: 20px 0px">
                        <div class="col s10" style="padding:0">
                            <div class="row" style="margin:0">
                                <div class="col s12">
                                    <h6 style="font-size:20px; font-weight:bold; margin-top:0">${boardList[i]['subject']}</h6>
                                </div>
                                <div class="col s12">
                                    <p>${boardList[i]['content']}</p>
                                </div>
                                 <div id="tagInContent" class="col s12" style="display:flex; height:20px; margin:9px 0px">
                                    <a class="btn" style="display: flex;margin: 0px 4px;padding: 0 8px!important; height:100%; justify-content:center;align-items:center;">
                                    여기는되나<i class="material-icons" style="padding-left: 4px">clear</i></a>
                                </div>
                                <div class="col s12">
                                    <span>${boardList[i]['mid']} · ${timeForToday(boardList[i]['regDate'])} · 조회수 : ${boardList[i]['readCount']}</span>
                                </div>
                            </div>
                        </div>
                         <div class="col s2" style="display:flex; align-items: center; justify-content:center;">
                            <div>
                                <div style="display:flex;">
                                    <i class="material-icons" style="color:rgb(140,140,140); padding-right:5px;;">comment</i>
                                    <span style="font-weight:bold;">${boardList[i]['commentCount']}</span>
                                </div>
                                <div style="display:flex;">
                                    <i class="material-icons" style="color:rgb(140,140,140); padding-right:5px;">favorite</i>
                                    <span style="font-weight:bold;">${boardList[i]['likeCount']}</span>
                                </div>
                            </div>
                         </div>
                    </div>
                </div>`

            $('#freeBoardContents').append(content);

            $('#content' + i).hover(function () {
                $(this).css('cursor', 'pointer');
                $(this).css('backgroundColor', 'rgb(245,245,245)');
            }, function () {
                $(this).css('cursor', '');
                $(this).css('backgroundColor', 'rgb(255,255,255)');
            })

        }

    }

    function createFreeBoardPageNum(pageDTO) {
        removeFreeBoardPageNum();

        let pageNumPre = `<li id="pageNumPre" class="disabled">
                        <a href="#!"><i class="material-icons">chevron_left</i></a></li>`
            pageNumUl.append(pageNumPre);


        for (let i = pageDTO["startPage"]; i <= pageDTO["endPage"]; i++) {
            let pageNum = `<li id="pageNum${i}" class="${(pageDTO.cri["pageNum"] == i)? "active" : ""}">
            <a href="#!">${i}</a></li>`
            pageNumUl.append(pageNum);

            // 버튼 눌렀을때 페이지 변경 이벤트
            $('#pageNum'+i).on('click',function (e) {
                e.preventDefault();
                setBoardValue(i);
                getCountFreeBoardList();
                $('html,body').scrollTop(0);
            });
        }
        let pageNumNext = `<li id="pageNumNext" class=""><a href="#!"><i class="material-icons">chevron_right</i></a></li>`
            pageNumUl.append(pageNumNext);
        $('#pageNumNext').on("click",function (e) {
            e.preventDefault();
           setBoardValue(pageDTO["endPage"]+1);
           getCountFreeBoardList();
        });
    }


    function getCountFreeBoardList() {

        let boardValue = JSON.stringify({
            pageNum: pageNumValue,
            amount: amountValue,
            type: typeValue,
            keyword: keywordValue,
            orderType: orderType
        })
        $.ajax({
            url: "/api/freeBoard/" + boardValue,
            type: "get",
            contentType: 'application/json; charset=UTF-8',
            success: function (result) {
                console.log(result)
                createFreeBoardContent(result.boardList);
                createFreeBoardPageNum(result.pageDTO);
            }
        });
    }


    function removeFreeBoardList() {
        let contentsCount = $('#freeBoardContents').children().length;
        if (contentsCount > 0) {
            for (let i = 0; i < contentsCount; i++) {
                $('#content' + i).remove();
            }
        }
    }

    function removeFreeBoardPageNum() {
        $('#pageNumUl').empty();
    }
    function setBoardValue(i) {
        pageNumValue = i;
            // ($('#searchInput').val() == "")? null:$('#searchInput').val();
    }



</script>

</body>