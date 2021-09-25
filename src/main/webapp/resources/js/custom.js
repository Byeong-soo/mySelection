$('#navLoginBtn').click(function () {
    $('#loginModal').modal('open');
    $('div[name=supreme-container]').addClass('blur');

});

function scrollbarDisappear() {
    $("body::-webkit-scrollbar").css({
        "display" : "none"
    });
    
};

function scrollbarAppear() {
    $("body::-webkit-scrollbar").css({
        "display" : "auto"
    });

};



// $("body").on("mousewheel", function (event) {
//     let wheel = event.originalEvent.wheelDelta;
//     console.log(wheel);
//     if(wheel>0){
//         scrollbarDisappear();
//         console.log("올라간다");
//     } else {
//         scrollbarAppear();
//         console.log("내려간다");
//     }
// });

$(window).scroll(function() {
    $('body').addClass('scrolling');
    clearTimeout($.data(this, 'scrollTimer'));
    $.data(this, 'scrollTimer', setTimeout(function() {
        $('body').removeClass('scrolling');
    }, 250));
});


function addtionalToggle(){
    if($('#additional-info').css('display') == 'none'){
        $('#additional-info').show();
    }else{
        $('#additional-info').hide();
    }
}


    let logout = $("#logout");
    logout.click(function () {
    console.log("di")
});
    // $('#logout').click(function () {
    //     console.log("di")
    //     setTimeout(function () {
    //         M.toast({html: '로그아웃 되었습니다.', classes: 'rounded indigo darken-3 white-text'});
    //     },1000)
    // })


// // 뒤로가기
$('.backPage').on("click", function () {
    window.history.back();

});
