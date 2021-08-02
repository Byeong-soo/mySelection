<%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-08-01
  Time: 오후 6:49
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/templates.layout/header.jsp"/>
    <title>회원가입</title>
</head>
<body>
<div class="supreme-container">
    <!--navbar-->
    <jsp:include page="/templates.layout/navbar.jsp"/>
    <!--navbar-->


    <%--    <div id="intro" class="bg-image shadow-2-strong">--%>
<%--    <div class="mask d-flex align-items-center h-100">--%>
        <%--        style="background-color: rgba(0, 0, 0, 0.8);"--%>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-6 col-md-8">


                    <form class="bg-white  rounded-5 p-5">

                        <div class="mb-4 text-center">
                            <h2>회원가입</h2>
                        </div>

                        <!-- id input -->

                        <div class="form-outline py-1 mb-4">
                            <input type="text" id="id" class="form-control"/>
                            <label class="form-label" for="id">아이디</label>
                        </div>

                        <!-- Password input -->
                        <div class="form-outline py-1 mb-4">
                            <input type="password" id="passwd" class="form-control"/>
                            <label class="form-label" for="passwd">비밀번호</label>
                        </div>

                        <!-- PasswordCheck input -->
                        <div class="form-outline py-1 mb-4">
                            <input type="password" id="passwordcheck" class="form-control"/>
                            <label class="form-label" for="passwordcheck">비밀번호 확인</label>
                        </div>

                        <!-- nickname -->
                        <div class="form-outline py-1 mb-4">
                            <input type="text" id="nickname" class="form-control"/>
                            <label class="form-label" for="nickname">이름(닉네임)</label>
                        </div>

                        <!-- birthday -->
                        <div class="form mb-4">
                            <input type="date" id="birthday" class="form-control py-2"/>
                            <label class="form-label" for="birthday">생년월일</label>
                        </div>

                        <div class="form-outline date-picker">
                            <input type="text" class="form-control" id="exampleDatepicker1">
                            <label for="exampleDatepicker1" class="form-label">Example label</label>
                        </div>
                        <script>
                            var options = {
                                format: 'dd-mm-yyyy'
                            }
                            var myDatepicker = new mdb.Datepicker(document.getElementById('myDatepicker'), options)
                        </script>



                        <!-- gender -->

                        <div class="btn-group d-flex mb-4">
                            <input type="radio" class="btn-check mx-4" name="options" id="option1" autocomplete="off"
                                   checked/>
                            <label class="btn btn-secondary" for="option1">선택안함</label>

                            <input type="radio" class="btn-check " name="options" id="option2" autocomplete="off"/>
                            <label class="btn btn-secondary"  for="option2">남자</label>

                            <input type="radio" class="btn-check" name="options" id="option3" autocomplete="off"/>
                            <label class="btn btn-secondary " for="option3">여자</label>
                        </div>

                        <!-- Email input -->
                        <div class="form-outline py-1 mb-4">
                            <input type="email" id="email" class="form-control"/>
                            <label class="form-label" for="email">이메일</label>
                        </div>


                            <p class="form-check-inline">이메일 수신 여부 :


                        <div class="form-check form-check-inline">

                            <input
                                    class="form-check-input"
                                    type="radio"
                                    name="inlineRadioOptions"
                                    id="inlineRadio1"
                                    value="option1"
                            />
                            <label class="form-check-label" for="inlineRadio1">네</label>
                        </div>

                        <div class="form-check form-check-inline">
                            <input
                                    class="form-check-input"
                                    type="radio"
                                    name="inlineRadioOptions"
                                    id="inlineRadio2"
                                    value="option2"
                                    checked
                            />
                            <label class="form-check-label" for="inlineRadio2">아니요</label>
                        </div>

                        </p>

                        <!-- Submit button -->
                        <button type="submit" class="btn btn-primary btn-block">회원가입</button>
                        <button type="reset" class="btn btn-danger btn-block">초기화</button>

                    </form>
                </div>
            </div>
        </div>
<%--    </div>--%>
    <%--    </div>--%>
    <!-- Background image -->


</div>
<jsp:include page="/templates.layout/footer.jsp"/>

</body>
</html>
