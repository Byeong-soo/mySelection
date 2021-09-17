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

    <div style="background-color: #b39ddb; height: 140px; width: 100%; display:flex; align-items: center">
        <div class="container">
            <h4 style="margin-top:0; padding-top: 20px; color: white">자유게시판</h4>
            <p style="color: white">자유롭게 글을 써보세요</p>
        </div>
    </div>

    <div class="row container" style="display: flex; justify-content: center">

        <div style="width: 70%">
            <div class="row input-field s12" style="height: 48px;">
                <div id="tagInputDiv" class="col s10">
                    <i class="material-icons prefix">tag</i>
                    <input id="tagInput" type="text" class="validate" style="margin-bottom: 0;border: 0px!important;"
                           placeholder="태그로 검색해보세요!">
                    <label for="tagInput"></label>
                </div>
                <div class="col s2" style="height: 100%;border-radius: 5px;">
                    <a class="waves-effect waves-customPurple btn-flat" style="height: 100%;width: 100%;padding:0;display: flex;
                        justify-content: center;align-items: center;font-size: 18px">
                        <i class="material-icons" style="font-size: 22px">restart_alt</i> 초기화
                    </a>
                </div>
            </div>


            <div class="row" style="margin: 0">
                <div class="freeBoardHeader col s12" style="padding: 0">
                    <ul class="col s10" style="display: flex">
                        <li><a class="btn-flat">
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
                    <a id="freeBoardWrite" class="waves-effect btn customBtn col s2">
                        글쓰기
                    </a>
                </div>
                <hr class="col s12" style="border:1px solid rgb(209,209,209);margin: 0">

                <%--==================================================================================================--%>


                <%--==================================================================================================--%>
            </div>

            <div id="freeBoardContents" class="row">

            </div>

        </div>


        <jsp:include page="/common/footer.jsp"/>
    </div>
</div>


<script>
    // 페이지 들어오면 freeBoard 네브바 액티브
    let lists = navbarSubMenu.children("ul").children("li");
    navbarShowOption = true;
    lists.last().addClass("active");
    if (lists.hasClass("active")) {
        navbarSubMenu.show();
    }

    // let tagInput = $('#tagInput');
    // tagInput.focus(function () {
    //     tagInput.closest('div').css('border','1px #b39ddb solid')
    // });

    // 글쓰기 로그인 여부


    $('#freeBoardWrite').on('click', function () {

        // if(userId == null) {
        //     console.log("아이디 없음")
        //     $('#loginModal').modal('open');
        // }

        getCountFreeBoardList();
    });


    //  게시판 글 create

    function createFreeBoardContent(result) {
        removeFreeBoardList();

        for (let i = 0; i < result.length; i++) {
            let test =
                `
                <div class="col s12" id="content${i}">
                    <div class="col s12" style="display: flex; padding: 20px 0px">
                        <div class="col s10" style="padding:0">
                            <div class="row" style="margin:0">
                                <div class="col s12">
                                    <h6 style="font-size:20px; font-weight:bold; margin-top:0">${result[i]['subject']}</h6>
                                </div>
                                <div class="col s12">
                                    <p>${result[i]['content']}</p>
                                </div>
                                <div class="col s12">
                                    <span>${result[i]['mid']} · ${result[i]['regDate']} · 조회수 : ${result[i]['readCount']}</span>
                                </div>
                            </div>
                        </div>
                         <div class="col s2" style="display:flex; align-items: center; justify-content:center;">
                            <div>
                                <div style="display:flex;">
                                    <i class="material-icons" style="color:rgb(140,140,140); padding-right:5px;;">comment</i>
                                    <span style="font-weight:bold;">${result[i]['num']}</span>
                                </div>
                                <div style="display:flex;">
                                    <i class="material-icons" style="color:rgb(140,140,140); padding-right:5px;">favorite</i>
                                    <span style="font-weight:bold;">${result[i]['num']}</span>
                                </div>
                            </div>
                         </div>
                    </div>
                      <hr class="col s12" style="border:1px solid rgb(209,209,209);margin: 0">
                </div>`

            $('#freeBoardContents').append(test);

            $('#content'+i).hover(function () {
                $(this).css('cursor','pointer');
                $(this).css('backgroundColor','rgb(245,245,245)');
            },function () {
                $(this).css('cursor','');
                $(this).css('backgroundColor','rgb(255,255,255)');
            })

        }

    }

    function getCountFreeBoardList() {
        $.ajax({
            url: "/api/freeBoard/",
            type: "get",
            contentType: 'application/json; charset=UTF-8',
            success: function (result) {
                createFreeBoardContent(result);
                console.log(result[0]['mid'])
                console.log(result)
                console.log(typeof result[0]['mid'])
                console.log(result.length);
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

</script>

</body>
</html>
