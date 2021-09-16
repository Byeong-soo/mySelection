
$('#kakaoLoginBtn').on('click',function () {
    kakaoLogin();
})

function kakaoLogin() {
    Kakao.init('1eb4fdb2f65844ce3f085d53719d708c');
    Kakao.Auth.login({
        success: function (response) {
            Kakao.API.request({
                url: '/v2/user/me',
                data : {
                    property_keys: ["kakao_account.email","kakao_account.age","kakao_account.gender","kakao_account.profile"]
                },
                success: function (response) {
                    const kakao = JSON.stringify(response);

                    $.ajax({
                        url: "/api/member/kakaoLogin",
                        type: "post",
                        data: kakao,
                        contentType: 'application/json; charset=UTF-8',
                        success: function (result) {
                            if (result.result) {
                                location.href="/index.jsp";
                            } else{
                                alert("회원정보를 확인해주세요")
                            }
                        }
                    });


                },
                fail: function (error) {

                },
            })
        },
        fail: function (error) {
            console.log(error)
        },
    })
}

function kakaoLoginProcess() {
    
}

$('#modalLoginBtn').on('click',function (e) {
    e.preventDefault();
    pushLoginBtn();
})

function pushLoginBtn() {
    let id = $('#loginId').val();
    let passwd = $('#loginPassword').val();
    let rememberMe = $('#rememberMe').prop("checked");


    let loginValue = JSON.stringify({
        id: id,
        passwd:passwd,
        rememberMe:rememberMe
    })

    if(id.length == 0) {
        alert("아이디를 입력해주세요");
        return;
    }
    if(passwd.length == 0) {
        alert("비밀번호를 입력해주세요");
        return;
    }

    $.ajax({
        url: "/api/member/login",
        type: "post",
        data: loginValue,
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {
            if (result.result) {
                location.href="/index.jsp";
            } else{
                alert("회원정보를 확인해주세요")
            }
        }
    });

}

// 회원정보 수정

$('#modifyJoin').on('click',function () {

});


$('#navbarSubMenuUl li').addClass('right');
let navbarMenu = $('#navbarMenu');
let navbarSubMenu = $('#navbarSubMenu');
let navbar = $('.nav-extended');
let navbarShowOption = false;

navbarMenu.hover(function () {
    navbarSubMenu.slideDown(200);
});
navbar.hover(function () {

},function () {
    if(!navbarShowOption){
        navbarSubMenu.slideUp(200);
    }
});

navbarMenu.on('click',function () {
    if(navbarShowOption){
        navbarShowOption = false;
    } else {
        navbarShowOption = true;
    }


});

