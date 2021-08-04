
Kakao.init('1eb4fdb2f65844ce3f085d53719d708c');
console.log(Kakao.isInitialized());
function kakaoLogin() {
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