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
                    <a id="" class="freeBoardBackPage waves-effect waves-light btn customWhiteBtn"> <i
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
                    <div id="freeBoardLinkDiv" class="col s2"
                         style="display: flex;align-items: flex-end; justify-content: right">

                    </div>

                </div>
                <div class="col s12">
                    <hr class="col s12" style="border:1px solid rgb(209,209,209);margin: 2% 0">
                </div>

                <%-- 제목 끝--%>
                <%-- 본문 시작--%>
                <div class="col s12">
                    <div id="freeBoardAttachDiv" style="display: flex;justify-content: right; position: relative">


                        <div class="custom-modal-content" id="modal-content">
                            <ul class="list" style="margin: 0">

                            </ul>
                        </div>

                    </div>


                    <div id="viewer" style="min-height: 200px">
                    </div>
                    <%--                    <div class="col s12" style="min-height: 300px">--%>
                    <%--                        <p id="oneFreeBoardContent"></p>--%>
                    <%--                    </div>--%>

                    <div id="oneFreeBoardTag" class="col s12"
                         style="display: flex;background-color: rgb(245,245,245); align-items: center">
                        <span>연관 태그 : </span>
                    </div>

                </div>

                <div class="col s12" style="margin-top: 20px">
                    <div class="col s12" style="border: 1px solid lightgray;border-bottom: 0px">
                        <h6 id="commentHeader" style="display: flex;align-items:center;">
                            <i class="material-icons" style="color:#b39ddb; padding-right:5px;">mode_comment</i>
                            <span id="commentCount"></span>
                        </h6>
                    </div>
                    <%-- 댓글--%>

                    <div id="commentList" class="col s12 commentDiv"
                         style=" border-right: 1px solid lightgray;border-left: 1px solid lightgray;">

                    </div>


                    <div class="col s12 commentDiv" style=" border: 1px solid lightgray">
                        <textarea id="commentTextarea" class="materialize-textarea"
                                  placeholder="댓글을 남겨보세요"></textarea>
                        <label for="commentTextarea"></label>
                    </div>
                    <div class="col s12" style="display:flex;justify-content:center;position:relative;min-height: 50px">
                        <div style="display: flex;align-items: center">
                            <ul class="pagination center commentPageNum">
                            </ul>
                        </div>
                        <div class="commentWriteBtnDiv" style="position: absolute;">
                            <a id="commentWriteBtn" class="waves-effect waves-light btn customPurpleBtn"
                               style="margin: 5px 0;width: 70px">등록</a>
                        </div>
                    </div>
                </div>

                <div class="col s12">
                    <h5>자유게시판 글</h5>
                </div>

                <%--==================================================================================================--%>
                <div class="col 12 freeBoardContents" style="margin-bottom: 30px;display: block;width: 100%">
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
                    <a id="oneFreeBoardReply" class="waves-effect waves-light btn customWhiteBtn tooltipped"
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

    // 댓글 데이터 받아오기(정의)

    let commentPageNumValue = null;
    let bno = "<%=bno%>";


    $('#boardTab').addClass("active");
    navbarShowOption = true;
    if ($('#boardTab').hasClass("active")) {
        navbarSubMenu.show();
    }

    // 탭 새로고침
    $(document).ready(function () {
        $('.tabs').tabs();
    });

    $('#boardTab').on("click", function () {
        $(this).removeClass("active");
        location.href = '/board/freeBoard.jsp'
    })

    getCountFreeBoardList("shape2");

    // $('.freeBoardBackPage').on("click", function () {
    //     location.href = '/board/freeBoard.jsp?pageNum=' + pageNumValue;
    // });


    // 게시글 가져오기

    $.ajax({
        url: "/api/freeBoard/one/" + <%=bno%>,
        method: 'GET',
        success: function (data) {
            console.log("데이터")
            console.log(data);

            setData(data);
            addEventReplay(data);
        } // success
    });


    // 외부영역 클릭 시 팝업 닫기
    $(document).mouseup(function (e) {
        let LayerPopup = $(".custom-modal-content");
        if (LayerPopup.has(e.target).length === 0) {
            LayerPopup.removeClass("show");
        }
    });

    // 댓글
    let commentInput = $('#commentTextarea');

    if ("<%=id%>" == null || "null") {
        commentInput.attr("placeholder", "로그인 후 댓글을 남겨보세요!");
    }


    // 게시판글 하나 보이기.

    function setData(data) {
        $('#oneFreeBoardSubject').append(data.board['subject']);
        // $('#viewer').append(data.board['content']);
        $('#oneFreeBoardIdDate').append(data.board['nickname'] + " · " + moment(data.board['regDate']).format('LLL'));
        $('#oneFreeBoardLikeCount').append(data.board['likeCount']);
        $('#oneFreeBoardLikeCount').attr("data-tooltip", data.board['likeCount'] + "명이 이글을 좋아합니다!");
        $('#oneFreeBoardBookMarkCount').append(data.board['bookmarkCount']);
        $('#oneFreeBoardBookMarkCount').attr("data-tooltip", data.board['bookmarkCount'] + "명이 이글을 북마크 했습니다!");
        $('#commentCount').append("댓글(" + data.board['commentCount'] + ")");


        const viewer = new toastui.Editor({
            el: document.querySelector('#viewer'),
            min_height: "400px",
            initialValue: data.board['content']
        });


        let tag = data.board['tag'];
        let tagList;

        if (tag == null || tag == "") {
            let tagSpan = `<span style="margin-left: 10px">연관태그 없음.</span>`;
            $('#oneFreeBoardTag').append(tagSpan);
        } else if (tag.includes(",")) {
            tagList = tag.split(',');
            for (let i = 0; i < tagList.length; i++) {
                let tagA = ` <a class="btn tagBtn" style="cursor:Default">${tagList[i]}<i class="material-icons" style="padding:0 4px">clear</i></a>`
                $('#oneFreeBoardTag').append(tagA);
            }
        } else {
            let tagA = ` <a class="btn tagBtn" style="cursor:Default">${tag}<i class="material-icons" style="padding:0 4px">clear</i></a>`
            $('#oneFreeBoardTag').append(tagA);
        }


        if ("<%=id%>" == data.board['mid']) {
            let link = `  <a id="freeBoardModifyBtn" class="freeBoardLink">수정</a>
                        <a id="freeBoardDeleteBtn" class="freeBoardLink">삭제</a>`
            $('#freeBoardLinkDiv').append(link);

            $('#freeBoardModifyBtn').on("click", function () {
                location.href = "/board/freeBoardModify.jsp?num=" + data.board['num'] + "&pageNum=" + pageNumValue;
            })

            $('#freeBoardDeleteBtn').on("click", function () {
                $.ajax({
                    url: '/api/freeBoard/' + "<%=bno%>",
                    method: 'DELETE',
                    success: function (data) {
                        console.log(typeof data);
                        console.log(data);

                        if (data.result == 'success') {
                            alert("<%=bno%>" + '번 글 삭제 성공!');
                            location.replace('/board/freeBoard.jsp?pageNum=' + pageNumValue);
                        }
                    }
                });
            })
        }

        // 첨부파일
        if (data.attachList.length > 0) {
            let tamp = `<div id="freeBoardAttachNum" style="cursor: pointer;display: flex;align-items: center">
                            <i class="material-icons">folder_open</i><span>첨부파일${data.attachList.length}</span>
                        </div>`


            $('#freeBoardAttachDiv').append(tamp);
            $('#attachListModal').focusout(function () {
                $('#attachListModal').hide();
            })

            $('#freeBoardAttachNum').on('click', function () {
                $('#modal-content').addClass("show");
            });

            for (let i = 0; i < data.attachList.length; i++) {
                let list = ` <li class="attachListFileItem" style="display: flex;justify-content: space-between">
                                    <div class="file_name">
                                        <span>${data.attachList[i]['filename']}</span>
                                    </div>
                                    <div class="file_download" id="file_download${i}" style="padding-left:20px">
                                        <span>내 pc저장</span>
                                    </div>
                                </li>`

                $('#modal-content ul').append(list);
                $('#file_download' + i).on("click", function () {
                    let fileCallPath = data.attachList[i]['uploadpath'] + '/' + data.attachList[i]['filename'];
                    console.log(fileCallPath)
                    location.href = "/common/download.jsp?fileName=" + fileCallPath;
                })
            }

        }


    } // showData

    //    댓글 인서트 클릭

    $('#commentWriteBtn').on("click", function () {
        let commentContent = $('#commentTextarea').val();
        let id = "<%=id%>";

        if (id == null || id == "null") {
            alert("로그인후 댓글을 남겨보세요");
            return false;
        }

        if (commentContent == "") {
            alert("댓글 내용을 적어주세요");
            return false;
        }

        let commentDataJson = JSON.stringify({
            mid: id,
            bno: "<%=bno%>",
            content: commentContent
        });
        console.log(commentDataJson)

        $.ajax({
            url: '/api/comment/new',
            //enctype: 'multipart/form-data',
            method: 'POST',
            data: commentDataJson,
            contentType: 'application/json; charset=UTF-8',
            success: function (data) {
                console.log(data);
                if (data.result == 'success') {
                    $('#commentTextarea').val("")
                    getComment();
                    $('#commentCount').empty();
                    $('#commentCount').append("댓글(" + data.totalCount + ")");
                }

            } // success
        });

    })


    function getComment() {

        let commentValue = JSON.stringify({
            commentPageNum: commentPageNumValue,
            amount: 5,
            bno: bno
        })

        $.ajax({
            url: '/api/comment/' + commentValue,
            method: 'GET',
            contentType: 'application/json; charset=UTF-8',
            success: function (data) {
                console.log(data);
                $('#commentList').empty();
                createComment(data);
                createCommentPageNum(data.commentPageDTO);
            }
        });
    }


    function createComment(data) {
        let comment = data.commentList;
        if (comment) {


            for (let i = 0; i < comment.length; i++) {
                let commentContent = `
                    <div id="commentReLev${i}">
                        <div class="col s12" style="padding: 5px 0; border-top: 1px solid lightgray;display: flex; justify-content: space-between;align-items: center">
                            <div>
                                <span id="commentArrow${i}" style="font-weight: 500">${comment[i]['nickname']}</span>
                            </div>
                            <div style="position: relative;">
                                <i id="comment-optionBtn${i}" class="material-icons" style="color:rgb(192,192,192);cursor:pointer;">more_vert</i>
                                <div class="custom-modal-content" id="comment-option${i}">

                                </div>
                            </div>
                        </div>
                        <div id="comment_content${i}">
                            <p>${comment[i]['content']}</p>
                        </div>
                        <div style="display: flex;margin-bottom:15px;">
                            <span style="font-size: 12px">${moment(comment[i]['regDate']).format('LLL')}</span>
                            <span id="replyComment${i}" style="margin-left: 10px;font-size: 12px;cursor: pointer;">답글쓰기</span>
                        </div>
                        <div id="replyCommentTextareaDiv${i}" style="border:1px solid lightgray;display: none;margin-bottom:15px;">
                        </div>
                    <div>`

                $('#commentList').append(commentContent);


                //댓글답글 달기
                $('#replyComment' + i).on("click", function () {

                    if("<%=id%>" == null || "<%=id%>" == "null"){
                        alert("로그인후 댓글을 달아주세요")
                        return false;
                    }

                    let replyTextarea = `   <div>
                                            <textarea id="replyCommentTextarea${i}" class="materialize-textarea"></textarea>
                                            <label for="replyCommentTextarea${i}"></label>
                                            </div>
                                            <div style="display: flex;justify-content: right">
                                                <a id="replyCommentCancel${i}" class="waves-effect waves-light btn customWhiteBtn"
                                                style="margin: 5px 5px;">취소</a>
                                                <a id="replyCommentConfirm${i}" class="waves-effect waves-light btn customPurpleBtn"
                                                style="margin: 5px 5px;">등록</a>
                                            </div>
                                     `
                    $('#replyCommentTextareaDiv'+i).append(replyTextarea);


                    if($('#replyCommentTextareaDiv'+i).css("display")=="block"){
                        $('#replyCommentTextareaDiv'+i).empty();
                        $('#replyCommentTextareaDiv'+i).hide();
                    }else{
                        $('#replyCommentTextareaDiv'+i).show();
                        $('#replyCommentTextarea'+i).focus();
                    }

                $('#replyCommentCancel'+i).on("click",function () {
                    $('#replyCommentTextareaDiv'+i).empty();
                    $('#replyCommentTextareaDiv'+i).hide();
                });

                $('#replyCommentConfirm'+i).on("click",function () {

                    let replayCommentContent = $('#replyCommentTextarea'+i).val();
                    let id = "<%=id%>";

                    if (commentContent == "") {
                        alert("댓글 내용을 적어주세요");
                        return false;
                    }

                    let replyCommentDataJson = JSON.stringify({
                        mid: id,
                        bno: "<%=bno%>",
                        num: comment[i]['num'],
                        reRef:comment[i]['reRef'],
                        reLev:comment[i]['reLev'],
                        reSeq:comment[i]['reSeq'],
                        content: replayCommentContent
                    });

                    $.ajax({
                        url: '/api/comment/reply',
                        method: 'POST',
                        data: replyCommentDataJson,
                        contentType: 'application/json; charset=UTF-8',
                        success: function (data) {
                            if (data.result == 'success') {
                                $('#commentTextarea').val("")
                                $('#replyCommentTextarea'+i).val("");
                                $('#replyCommentTextareaDiv'+i).empty();
                                $('#replyCommentTextareaDiv'+i).hide();
                                getComment();
                                $('#commentCount').empty();
                                $('#commentCount').append("댓글(" + data.totalCount + ")");
                            }

                        } // success
                    });

                });
                    
                    
                }) //댓글답글 달기 끝

                let value = comment[i]['reLev'];
                if (value > 0) {
                    $('#commentReLev' + i).addClass("boardContent" + value);
                    $('.boardContent' + value).css("padding-left", value * 20);
                    $('#commentArrow' + i).prepend(`<span class="material-icons">subdirectory_arrow_right</span>`);
                }


                if ("<%=id%>" == comment[i]['mid']) {

                    let commentOptions = `<ul class="list" style="margin: 0;display:flex; justify-content:center; flex-direction:column;">
                                        <li>
                                            <div class="comment-options modify${i}">
                                                <span>수 정</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="comment-options delete${i}">
                                                <span>삭 제</span>
                                            </div>
                                        </li>
                                    </ul>`

                    $('#comment-option' + i).append(commentOptions);
                    $('#comment-optionBtn' + i).on('click', function () {
                        $('#comment-option' + i).addClass("show");
                    });

                    $('.comment-options.delete' + i).on("click", function () {
                        $.ajax({
                            url: '/api/comment/' + comment[i]['num'],
                            method: 'DELETE',
                            success: function (data) {
                                if (data.result == 'success') {
                                    alert("댓글이 삭제되었습니다.");
                                    console.log(data)
                                    $('#commentCount').empty();
                                    $('#commentCount').append("댓글(" + data.totalCount + ")");
                                    getComment();
                                }
                            }
                        });
                    });

                    $('.comment-options.modify' + i).on("click", function () {
                        $('#comment-option' + i).removeClass("show");
                        let modifyShape = `
                            <div>
                                <textarea id="modifyCommentTextarea" class="materialize-textarea"></textarea>
                                <label for="modifyCommentTextarea"></label>
                            </div>
                            <div style="display: flex;justify-content: right">
                                <a id="commentModifyCancel" class="waves-effect waves-light btn customWhiteBtn"
                               style="margin: 5px 5px;">취소</a>
                                 <a id="commentModifyConfirm" class="waves-effect waves-light btn customPurpleBtn"
                               style="margin: 5px 5px;">수정</a>
                            </div>
                        `
                        $('#comment_content' + i).empty();
                        $('#comment_content' + i).append(modifyShape);
                        $('#modifyCommentTextarea').val(comment[i]['content']);
                        $('#modifyCommentTextarea').focus();

                        $('#commentModifyCancel').on("click", function () {
                            $('#comment_content' + i).empty();
                            $('#comment_content' + i).append(`<p>${comment[i]['content']}</p>`);

                        })

                        $('#commentModifyConfirm').on("click", function () {
                            let modifyCommentContent = $('#modifyCommentTextarea').val();

                            $.ajax({
                                url: '/api/comment/' + comment[i]['num'],
                                //enctype: 'multipart/form-data',
                                method: 'PUT',
                                data: JSON.stringify({modifyCommentContent: modifyCommentContent}),
                                contentType: 'application/json;charset=UTF-8',
                                success: function (data) {
                                    console.log(data);

                                    if (data.result == 'success') {
                                        getComment();
                                    }

                                } // success
                            });


                        })


                    });

                } // if

            } //for
        }
    }

    let commentPageNumUl = $('.commentPageNum');

    function createCommentPageNum(pageDTO) {
        if (pageDTO) {


            commentPageNumUl.empty();
            let isPrev = (pageDTO["prev"] == true) ? "" : "disabled";
            let pageNumPre = `<li id = "pageNumPre" class = "${isPrev}" ><a href = "#!" ><i class = "material-icons">chevron_left</i></a ></li>`

            commentPageNumUl.append(pageNumPre);

            $('#pageNumPre').on("click", function (e) {
                if (isPrev == "") {
                    e.preventDefault();
                    setBoardValue(pageDTO["startPage"] - 1);
                    getComment();
                } else {
                    e.preventDefault();
                }

            });


            for (let i = pageDTO["startPage"]; i <= pageDTO["endPage"]; i++) {
                let pageNum = `<li id="commentPageNum${i}" class="${(pageDTO.cri["pageNum"] == i) ? "active" : ""}">
            <a href="#!">${i}</a></li>`

                commentPageNumUl.append(pageNum);


                // 버튼 눌렀을때 페이지 변경 이벤트
                $('#commentPageNum' + i).on('click', function (e) {
                    console.log("클릭")
                    e.preventDefault();
                    commentPageNumValue = i;
                    getComment();
                });
            }

            let isNext = (pageDTO["next"] == true) ? "" : "disabled";
            let pageNumNext = `<li id="pageNumNext" class="${isNext}"><a href="#!"><i class="material-icons">chevron_right</i></a></li>`

            commentPageNumUl.append(pageNumNext);

            $('#pageNumNext').on("click", function (e) {
                if (isNext == "") {
                    e.preventDefault();
                    setBoardValue(pageDTO["endPage"] + 1);
                    getComment();
                } else {
                    e.preventDefault();
                }
            });
        }
    }

    getComment();

    //    답글 쓰기
    function addEventReplay(data) {
        $('#oneFreeBoardReply').on("click", function () {
            location.href = "/board/freeBoardReply.jsp?num=" + data.board['num'] + "&pageNum=" + pageNumValue +
                "&reLev=" + data.board['reLev'] + "&reRef=" + data.board['reRef'] + "&reSeq=" + data.board['reSeq'];
        });
    }


</script>

</body>
