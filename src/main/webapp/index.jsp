<%@ page import="com.mySelection.repository.ClassificationDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/templates.layout/header.jsp"/>
    <title>장바구needs</title>

</head>

<body>


<!--모달 블러 div 열기 -->
<div name="supreme-container" style="position: relative">

    <%---------------------------------------------------------------------------------------------%>
        <div class="classification container" id="classification">
            <div class="row">
                <div class="classification-dialog  col s8 offset-s2">
                    <div class="classification-content">
                        <%--팝업처리--%>
                        <div class="row " style="margin:0;">
                            <div class="input-field col s3" style="margin-bottom: 0;">
                                <input id="c-first" type="text" class="validate" name="">
                                <label for="c-first">1차 분류</label>
                            </div>
                            <div class="input-field col s3" style="margin-bottom: 0;">
                                <input id="c-second" type="text" class="validate" name="">
                                <label for="c-second">2차 분류</label>
                            </div>
                            <div class="input-field col s3" style="margin-bottom: 0;">
                                <input id="c-third" type="text" class="validate" name="">
                                <label for="c-third">3차 분류</label>
                            </div>
                            <div>
                                <a class="waves-effect waves-light btn" id="classificationAdd">분류 선택하기</a>
                            </div>

                        </div>

                        <hr style="height: 10px; border: 0; box-shadow: 0 10px 10px -10px #bbb inset; width: 100%">

                            <%-- 리스트 들어갈곳--%>
                        <div id="classification-list">

                        </div>


                    </div>
                </div>
            </div>
        </div>
    <%---------------------------------------------------------------------------------------------------------------%>


    <div id="index-banner" class="parallax-container">
        <jsp:include page="/templates.layout/navbar.jsp"/>
        <div class="section no-pad-bot" style="padding-top: 0;">
            <div class="container">
                <br><br>
                <h3 class="header center teal-text text-lighten-2" style=" font-size: 2vw;">원하는 상품의 URL을 입력해보세요</h3>


                <div id="urlBar" class="row" style="position: relative;">
                    <div class="col s8 offset-s2 z-depth-4">
                        <%-- 메뉴 3개--%>
                        <a class="classification-open col s2 " href="#classification" id="classification-opener"
                           style="display:flex; justify-content: center; align-items: center;">
                            <span>분류</span>
                            <span class="material-icons">arrow_drop_down</span></a>
                        <input class="col s8">
                        <a class="classification-open col s2 " href="#!" id=""
                           style="display: flex; justify-content: center; align-items: center;">
                            <span class="material-icons">add_circle_outline</span></a>
                    </div>



                </div>


                <div class="row center">
                    <h5 class="header col s12 light white-text" style="z-index: -1">장바구Needs에서 상품을 한번에 모아서 관리해보세요!</h5>
                </div>
                <br><br>

            </div>
        </div>
        <div class="parallax"><img src="/resources/images/backgroundMain.jpg" alt=""></div>


    </div>


    <div class="container">

        <div class="section">

            <!--   Icon Section   -->
            <div class="row">
                <div class="col s12 m4">
                    <div class="icon-block">
                        <h2 class="center brown-text"><i class="material-icons">flash_on</i></h2>
                        <h5 class="center">Speeds up development</h5>

                        <p class="light">We did most of the heavy lifting for you to provide a default stylings that
                            incorporate our custom components. Additionally, we refined animations and transitions to
                            provide a smoother experience for developers.</p>
                    </div>
                </div>

                <div class="col s12 m4">
                    <div class="icon-block">
                        <h2 class="center brown-text"><i class="material-icons">group</i></h2>
                        <h5 class="center">User Experience Focused</h5>

                        <p class="light">By utilizing elements and principles of Material Design, we were able to create
                            a framework that incorporates components and animations that provide more feedback to users.
                            Additionally, a single underlying responsive system across all platforms allow for a more
                            unified user experience.</p>
                    </div>
                </div>

                <div class="col s12 m4">
                    <div class="icon-block">
                        <h2 class="center brown-text"><i class="material-icons">settings</i></h2>
                        <h5 class="center">Easy to work with</h5>

                        <p class="light">We have provided detailed documentation as well as specific code examples to
                            help new users get started. We are also always open to feedback and can answer any questions
                            a user may have about Materialize.</p>
                    </div>
                </div>
            </div>

        </div>
    </div>


    <div class="parallax-container valign-wrapper">
        <div class="section no-pad-bot">
            <div class="container">
                <div class="row center">
                    <h5 class="header col s12 light">A modern responsive front-end framework based on Material
                        Design</h5>
                </div>
            </div>
        </div>
        <div class="parallax"><img src="/resources/images/background.jpg" alt="Unsplashed background img 2"></div>
    </div>

    <div class="container">
        <div class="section">

            <div class="row">
                <div class="col s12 center">
                    <h3><i class="mdi-content-send brown-text"></i></h3>
                    <h4>Contact Us</h4>
                    <p class="left-align light">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam
                        scelerisque id nunc nec volutpat. Etiam pellentesque tristique arcu, non consequat magna
                        fermentum ac. Cras ut ultricies eros. Maecenas eros justo, ullamcorper a sapien id, viverra
                        ultrices eros. Morbi sem neque, posuere et pretium eget, bibendum sollicitudin lacus. Aliquam
                        eleifend sollicitudin diam, eu mattis nisl maximus sed. Nulla imperdiet semper molestie. Morbi
                        massa odio, condimentum sed ipsum ac, gravida ultrices erat. Nullam eget dignissim mauris, non
                        tristique erat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia
                        Curae;</p>
                </div>
            </div>

        </div>
    </div>


    <div class="parallax-container valign-wrapper">
        <div class="section no-pad-bot">
            <div class="container">
                <div class="row center">
                    <h5 class="header col s12 light">A modern responsive front-end framework based on Material
                        Design</h5>
                </div>
            </div>
        </div>
        <div class="parallax"><img src="/resources/images/backgroundTemp.jpg" alt="Unsplashed background img 3"></div>
    </div>


    <!--모달 블러 div 닫기 -->

</div>

<jsp:include page="/templates.layout/footer.jsp"/>

<script>

    //list 생성

   // let titleCount = 0;

    function createFirstList(response) {
        let titleLength = Object.keys(response).length
        for (let i = 0; i < titleLength; i++) {
            const newText = document.createTextNode(response[i]);
            let newA = document.createElement('a');
            newA.appendChild(newText);
            newA.style.margin = "0px 10px";
            newA.setAttribute("id", "title"+ String(i));
            newA.setAttribute("class","btn");
            console.log("title"+ String(i))
            console.log(document.getElementById("title"+ String(i)));
            document.getElementById('classification-list').appendChild(newA);

            // titleCount = titleLength;
            // return titleCount;
        }
    }

    // // list 삭제
    // function removeFirstList(titleCount) {
    //     for(let i=0; i<titleCount; i++) {
    //         const deleteText = document.getElementById("title"+ String(i));
    //         if(deleteText != null){
    //             deleteText.remove();
    //         }
    //
    //         // document.getElementById('classification-list').removeChild(newDiv);
    //     }
    // }



    //팝업 열기
    $('a#classification-opener').click(function () {
        $.ajax({
            url: '/getList',
            method: 'POST',
            dataType: 'JSON',
            async: false,
            data: {"type" : "L", "large" : null, "middle" : null, "small" : null},
            success: function (response) {
                console.log(response);
                console.log(typeof response);

                createFirstList(response);
            }
        });



        $('#classification').addClass("show");

    });


    // 외부영역 클릭 시 팝업 닫기
    $(document).mouseup(function (e) {
        let LayerPopup = $(".classification");
        if (LayerPopup.has(e.target).length === 0) {
            removeFirstList();
            LayerPopup.removeClass("show");
            first.closest('div.input-field').removeClass('blob');
            second.closest('div.input-field').removeClass('blob');
            third.closest('div.input-field').removeClass('blob');
        }
    });

    let first = $('#c-first');
    let second = $('#c-second');
    let third = $('#c-third');

    let firstValue = first.val();
    let secondValue = second.val();
    let thirdValue = third.val();


    $('#classificationAdd').click(function () {
        if (firstValue == '') {
            first.closest('div.input-field').addClass('blob');
            removeFirstList();
        }
    });

    first.focus(function () {
        first.closest('div.input-field').removeClass('blob');
    });
    first.blur(function () {

    });



</script>


</body>
</html>