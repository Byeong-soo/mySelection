
Kakao.init('1eb4fdb2f65844ce3f085d53719d708c');
console.log(Kakao.isInitialized());
function aboutLogin() {
    Kakao.Auth.login({
        success: function (response) {
            Kakao.API.request({
                url: '/v2/user/me',
                data : {
                    property_keys: ["kakao_account.email","kakao_account.age","kakao_account.gender","kakao_account.profile"]
                },
                success: function (response) {
                    console.log(response)
                    const kakao = JSON.stringify(response);
                    $('#kakaoUser').val(kakao);
                    login_frm.action='/member/kakaoPro.jsp';
                    document.login_frm.submit();
                },
                fail: function (error) {
                    console.log(error)
                },
            })
        },
        fail: function (error) {
            console.log(error)
        },
    })
}


function pushLoginBtn() {
    let id = $('#loginId').val();
    let passwd = $('#loginPassword').val();
    let rememberMe = $('#rememberMe').prop("checked");


    let loginValue = JSON.stringify({
        id: id,
        passwd:passwd,
        rememberMe:rememberMe
    })

    $.ajax({
        url: "/api/member/login",
        type: "post",
        data: loginValue,
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {
            if (result == 1) {
                window.location.reload();
            } else if (result == 0){
                alert("회원정보를 확인해주세요")
            }
        }
    });




    // let loginPro = window.open("","loginPro",'width=1,height=1');
   // let login_frm = document.login_frm;
   // login_frm.action = "/member/loginPro.jsp";
   // login_frm.target = "loginPro";
   // login_frm.submit();
}