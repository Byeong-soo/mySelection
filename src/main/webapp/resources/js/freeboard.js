let pageNumValue = null;
let amountValue = null;
let typeValue = null;
let keywordValue = null;
let tag = null;
let orderType = "re_ref";


let tagInput = $('#tagInput');

let pageNumUl = $('.pageNumUl');

//푸터 정의
let contentsOption = $('.freeBoardHeader ul li');


function changeOrderType(getOrderType) {
    console.log("리스트 타입에 들어옴")
    if (getOrderType == "최신순") {
        orderType = "re_ref"
    } else if (getOrderType == "조회수순") {
        orderType = "readcount"
    } else if (getOrderType == "댓글많은순") {
        orderType = "comment_count"
    } else if (getOrderType == "좋아요순") {
        orderType = "like_count"
    }
    pageNumValue = 1;
}


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

// 게사판 목록 형식

//  게시판 글 create

function createFreeBoardContent(boardList, pageDTO, listShape) {
    removeFreeBoardList();

    if (boardList != null) {


        for (let i = 0; i < boardList.length; i++) {

            let content;


            if (listShape == "shape1") {
                const extractTextPattern = /(<([^>]+)>)/gi;
                let boardContent = boardList[i]['content'];
                boardContent = boardContent.replace(extractTextPattern,"");

                content =
                    `
                <div class="col s12" id="content${i}"  style=" border-bottom: 1px solid lightgray;">
                    <div class="col s12" style="display: flex; padding: 20px 0px">
                        <div class="col s10" style="padding:0">
                            <div class="row" style="margin:0">
                                <div class="col s12">
                                    <h6 style="font-size:20px; font-weight:bold; margin-top:0">${boardList[i]['subject']}</h6>
                                </div>
                                <div class="col s12" style=" max-height: 100px;overflow:hidden;text-overflow: ellipsis;white-space: nowrap;">
                                  ${boardContent}
                                </div>
                                 <div id="tagInContent${i}" class="col s12" style="display:flex; height:20px; margin:9px 0px">
                            
                                   
                                </div>
                                <div class="col s12">
                                    <span>${boardList[i]['mid']} · ${timeForToday(boardList[i]['regDate'])} · 조회수 : ${boardList[i]['readCount']}</span>
                                </div>
                            </div>
                        </div>
                         <div class="col s2" style="display:flex; align-items: center; justify-content:center;">
                            <div> 
                                <div style="display:flex;">
                                    <i class="material-icons" style="color:rgb(140,140,140); padding-right:5px;;">mode_comment</i>
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
            } else {

                content =
                    `<div class="col s12" id="content${i}"  style=" border-bottom: 1px solid lightgray; padding: 0;">
                    <div class="col s12" style=" padding: 10px 0px">
                        <div class="col s8" style="padding:0">
                           <h6 style="font-size:14px; font-weight:bold; margin:0">${boardList[i]['subject']}</h6>
                        </div>
                        <div class="col s4">
                           <span>${boardList[i]['mid']} · ${timeForToday(boardList[i]['regDate'])} · 조회수 : ${boardList[i]['readCount']}</span>
                        </div>
                    </div>
                </div>`


            }
            $('.freeBoardContents').append(content);

            // 태그 성성후 붙이기
            let tag = boardList[i]['tag'];
            let tagList = null;
            if (tag == null || tag =="") {
            } else {
                tagList = tag.split(",");
                for (let j = 0; j < tagList.length; j++) {
                    let tagA = ` <a class="btn tagBtn">${tagList[j]}<i class="material-icons" style="padding-left: 4px">clear</i></a>`
                    $('#tagInContent' + i).append(tagA);
                }
            }


            $('#content' + i).hover(function () {
                $(this).css('cursor', 'pointer');
                $(this).css('backgroundColor', 'rgb(245,245,245)');
            }, function () {
                $(this).css('cursor', '');
                $(this).css('backgroundColor', 'rgb(255,255,255)');
            })

            $('#content' + i).on("click", function () {
                let num = boardList[i]['num'];
                let pageNum = pageDTO.cri["pageNum"];
                location.href = '/board/freeBoardSelect.jsp?num=' + num + '&pageNum=' + pageNum;
                console.log(pageNum)
                console.log(num)
            })

        }
    }
}

function createFreeBoardPageNum(pageDTO, listShape) {
    removeFreeBoardPageNum();
    let isPrev = (pageDTO["prev"] == true) ? "" : "disabled";
    let pageNumPre = `<li id = "pageNumPre" class = "${isPrev}" ><a href = "#!" ><i class = "material-icons">chevron_left</i></a ></li>`
    pageNumUl.append(pageNumPre);
    $('#pageNumPre').on("click", function (e) {
        if (isPrev == "") {
            e.preventDefault();
            setBoardValue(pageDTO["startPage"] - 1);
            getCountFreeBoardList(listShape);
        } else {
            e.preventDefault();
        }

    });


    for (let i = pageDTO["startPage"]; i <= pageDTO["endPage"]; i++) {
        let pageNum = `<li id="pageNum${i}" class="${(pageDTO.cri["pageNum"] == i) ? "active" : ""}">
            <a href="#!">${i}</a></li>`
        pageNumUl.append(pageNum);


        // 버튼 눌렀을때 페이지 변경 이벤트
        $('#pageNum' + i).on('click', function (e) {
            e.preventDefault();
            setBoardValue(i);
            getCountFreeBoardList(listShape);
            if (listShape == "shape1") {
                $('html,body').scrollTop(0);
            }
        });
    }
    let isNext = (pageDTO["next"] == true) ? "" : "disabled";
    let pageNumNext = `<li id="pageNumNext" class="${isNext}"><a href="#!"><i class="material-icons">chevron_right</i></a></li>`
    pageNumUl.append(pageNumNext);
    $('#pageNumNext').on("click", function (e) {
        if (isNext == "") {
            e.preventDefault();
            setBoardValue(pageDTO["endPage"] + 1);
            getCountFreeBoardList(listShape);
        } else {
            e.preventDefault();
        }
    });
}


function getCountFreeBoardList(listShape) {

    let boardValue = JSON.stringify({
        pageNum: pageNumValue,
        amount: amountValue,
        type: typeValue,
        keyword: keywordValue,
        orderType: orderType,
        tag: tag
    })
    $.ajax({
        url: "/api/freeBoard/" + boardValue,
        type: "get",
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {
            console.log(result)
            createFreeBoardContent(result.boardList, result.pageDTO, listShape);
            createFreeBoardPageNum(result.pageDTO, listShape);
        }
    });
}


function removeFreeBoardList() {
    let contentsCount = $('.freeBoardContents').children().length;
    if (contentsCount > 0) {
        for (let i = 0; i < contentsCount; i++) {
            $('#content' + i).remove();
        }
    }
}

function removeFreeBoardPageNum() {
    pageNumUl.empty();
}

function setBoardValue(i) {
    pageNumValue = i;
    // ($('#searchInput').val() == "")? null:$('#searchInput').val();
}

$('.freeBoardBackPage').on("click", function () {
    location.href = '/board/freeBoard.jsp?pageNum=' + pageNumValue;
});
