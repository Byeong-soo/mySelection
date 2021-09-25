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

        <div style="width: 10%;">
            <div style="margin-top: 40%" class="right col s8">
                <div style="display: flex; flex-direction: column;position: fixed">
                    <a id="freeBoardBackPage" class="waves-effect waves-light btn customWhiteBtn"> <i
                            class="large material-icons">arrow_back</i></a>
                </div>
            </div>

        </div>

        <div style="width: 80%;">
            <div class="col s12">
                <div style="display: flex;justify-content: space-between;align-items: center;margin-top: 2%">
                    <h5>자유게시판 글쓰기</h5>
                    <a id="freeBoardWriteBtn" class="waves-effect waves-light btn customPurpleBtn"
                       style="padding: 0 4%">등록</a>
                </div>
                <hr>
                <div class="focusBorderPurple" style="border: 2px solid rgb(240,240,240);height:auto">
                    <div class="inputDiv">
                        <input id="freeBoardWriteSubject" type="text"
                               style="margin-bottom: 0;border: 0px!important;"
                               placeholder="제목을 입력해주세요">
                        <label for="freeBoardWriteSubject"></label>
                    </div>
                </div>


                    <div class="focusBorderPurple" style="display: flex;overflow-y: scroll;border: 2px solid rgb(240,240,240);height:auto;margin-top: 1%">
                        <div style="display:flex; align-items: center;">
                            <i class="material-icons">tag</i>
                        </div>
                        <div id="freeBoardWriteTagDiv" style="display:flex;flex-flow: wrap;align-items: center;margin: 0;padding:0;">

                        </div>
                        <div class="inputDiv" style="flex: 1">
                            <input id="freeBoardWriteTag" type="text" class="validate"
                                   style="margin-bottom: 0;border: 0px!important;"
                                   placeholder="태그를 추가해보세요">
                            <label for="freeBoardWriteTag"></label>
                        </div>
                    </div>

                <%--텍스트 에디터--%>
                <div id="editor" style="margin-top: 1%">
                </div>
                <%--텍스트 에디터--%>
                <div id="addFileList" style="display: flex; flex-direction: column;">
                    <div style="display:none; align-items: center">
                        <div class="file-field input-field block-add-file col s4"
                             style="display: flex;margin: 0;padding: 0">
                            <div class="file-path-wrapper col s12" style="padding: 0">
                                <input id="firstFilePath" class="file-path validate" type="text">
                            </div>
                            <div class="col s0">
                                <span></span>
                                <input id="firstFileBtn" type="file">
                            </div>
                        </div>
                        <i class="material-icons clear" style="color: red;cursor: pointer">clear</i>
                    </div>
                    <div style="display: none;align-items: center">
                        <div class="file-field input-field block-add-file col s4"
                             style="display: flex;margin: 0;padding: 0">
                            <div class="file-path-wrapper col s12" style="padding: 0">
                                <input id="secondFilePath" class="file-path validate" type="text">
                            </div>
                            <div class="col s0">
                                <span></span>
                                <input id="secondFileBtn" type="file">
                            </div>
                        </div>
                        <i class="material-icons clear" style="color: red;cursor: pointer">clear</i>
                    </div>
                    <div style="display: none;align-items: center;">
                        <div class="file-field input-field block-add-file col s4"
                             style="display: flex;margin: 0;padding: 0">
                            <div class="file-path-wrapper col s12" style="padding: 0">
                                <input id="thirdFilePath" class="file-path validate" type="text">
                            </div>
                            <div class="col s0">
                                <span></span>
                                <input id="thirdFileBtn" type="file">
                            </div>
                        </div>
                        <i class="material-icons clear" style="color: red;cursor: pointer">clear</i>
                    </div>

                </div>


            </div>
        </div>

        <div style="width: 10%; ">
            <div class="col s8 left" style="margin-top: 40%">
                <div class="right-side-slider" style="display: flex; flex-direction: column;position: fixed">
                    <%--                    <a class="waves-effect waves-light btn customWhiteBtn tooltipped"--%>
                    <%--                       data-tooltip="답글을 달려면 클릭">답 글</a>--%>
                    <%--                    <a id="oneFreeBoardLikeCount" class="waves-effect waves-light btn customWhiteBtn tooltipped">--%>
                    <%--                        <i class="large material-icons">favorite_border</i></a>--%>
                    <%--                    <a id="oneFreeBoardBookMarkCount" class="waves-effect waves-light btn customWhiteBtn tooltipped">--%>
                    <%--                        <i class="large material-icons">bookmark_border</i></a>--%>
                    <%--                    <a class="waves-effect waves-light btn customWhiteBtn">--%>
                    <%--                        <i class="large material-icons">share</i>공유</a>--%>

                </div>
            </div>

        </div>


        <%--        <jsp:include page="/common/footer.jsp"/>--%>
    </div>
    <jsp:include page="/common/footer1.jsp"/>
    <jsp:include page="/common/footer.jsp"/>
</div>


<script>

    $("#firstFilePath").change(function () {
        if ($(this)) {
            $('#firstFilePath').parents("div").eq(2).css("display", "flex");
        } else {
            $('#firstFilePath').parents("div").eq(2).css("display", "none");
        }
    });

    $("#secondFilePath").change(function () {
        if ($(this)) {
            $('#secondFilePath').parents("div").eq(2).css("display", "flex");
        } else {
            $('#secondFilePath').parents("div").eq(2).css("display", "none");
        }
    });

    $("#thirdFilePath").change(function () {
        if ($(this)) {
            $('#thirdFilePath').parents("div").eq(2).css("display", "flex");
        } else {
            $('#thirdFilePath').parents("div").eq(2).css("display", "none");
        }
    });


    $('#addFileList i').on("click", function () {
        $(this).closest("div").css("display", "none");
        let path = $(this).closest("div").children("div").children("div").eq(0).children("input");
        path.val("");
    })


    function createLastButton() {
        const button = document.createElement('button');
        button.className = 'toastui-editor-toolbar-icons last';
        button.style.backgroundImage = 'none';
        button.style.margin = '0';
        button.innerHTML = `<i class="material-icons" style="color: rgb(85,85,85)">note_add</i>`;
        button.addEventListener('click', () => {
            if ($('#firstFilePath').val() == "") {
                $('#firstFileBtn').click();
                return false;
            }
            if ($('#secondFilePath').val() == "") {
                $('#secondFileBtn').click();
                return false;
            }
            if ($('#thirdFilePath').val() == "") {
                $('#thirdFileBtn').click();
                return false;
            }

            alert("첨부파일은 세개까지 가능합니다.")
        });

        return button;
    }

    const {Editor} = toastui;
    const {colorSyntax} = Editor.plugin;


    const editor = new Editor({
        el: document.querySelector('#editor'),
        height: '400px',
        initialEditType: 'wysiwyg',
        previewStyle: 'vertical',
        placeholder: '장바구니에 오신걸 환영합니다. \r\n내용을 입력해주세요!',
        language: 'ko',
        plugins: [colorSyntax],
        toolbarItems: [
            ['heading', 'bold', 'italic', 'strike'],
            ['hr', 'quote'],
            ['ul', 'ol', 'task', 'indent', 'outdent'],
            ['table', 'image', 'link', {
                el: createLastButton(),
                tooltip: '파일첨부'
            }],
            ['code', 'codeblock'],

        ]
    });



    $('#freeBoardWriteBtn').on("click", function () {

        let subject = $('#freeBoardWriteSubject').val();
        let content = editor.getHTML();
        let tag =  getTageValue();

        console.log(subject);
        console.log(content);
        console.log(tag);

        // let freeBoardWriteData = JSON.stringify({
        //     mid: userID,
        //     subject: subject,
        //     content: content,
        //     file: file,
        //     tag: tagValue,
        // });
        //
        // $.ajax({
        //     url: '/api/boards/new',
        //     //enctype: 'multipart/form-data',
        //     method: 'POST',
        //     data: formData,
        //     processData: false, // 파일전송시 false 설정 필수!
        //     contentType: false, // 파일전송시 false 설정 필수!
        //     success: function (data) {
        //         console.log(data);
        //
        //         if (data.result == 'success') {
        //             alert('새로운 글쓰기 성공!');
        //         }
        //
        //     } // success
        // });

    });

    let writeTagInput = $('#freeBoardWriteTag');
    writeTagInput.on("keydown", function (key) {
        if (key.keyCode == 13 ||key.keyCode == 188) {//키가 13이면 실행 (엔터는 13, 188 콤마)
            key.preventDefault();
            let tagName = writeTagInput.val();
            if(tagName != ""){
                let tagBox = `<a class="btn tagBtn">${tagName}<i class="material-icons" style="padding-left: 4px;">clear</i>
                </a>`
                $('#freeBoardWriteTagDiv').append(tagBox);
                $('#freeBoardWriteTagDiv a').on("click", function () {
                    $(this).remove();
                })
            }
            writeTagInput.val("");

        } else if(key.keyCode == 32){
            key.preventDefault();
        } else if(key.keyCode ==8){
            if(writeTagInput.val() =="" && $('#freeBoardWriteTagDiv').children().length > 0){
                console.log();
                $('#freeBoardWriteTagDiv').children().last().remove();
            }
        }
    });

    function getTageValue() {
        let tag;
        if($('#freeBoardWriteTagDiv').children().length > 1){
            tag = $('#freeBoardWriteTagDiv a').text().replaceAll("clear","").replaceAll("\n",",").replaceAll(" ","");
        } else {
            tag = $('#freeBoardWriteTagDiv a').text().replaceAll("clear","").replaceAll("\n","").replaceAll(" ","");
        }
        return tag;
    }

</script>

</body>
