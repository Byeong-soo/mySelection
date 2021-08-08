<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% String id = (String) session.getAttribute("loginId");
    String profileImage = (String) session.getAttribute("profileImage");
    String nickName = (String) session.getAttribute("nickName");
%>
<nav class="white" role="navigation">
    <div class="nav-wrapper container">
        <a id="logo-container" href="/index.jsp" class="brand-logo" style="color: black; display: table">
            <div style="display: table-cell; vertical-align: middle"><img src="/resources/images/myselectionLogo60.png" alt="" style="height: 50px;"></div>
            <span style="margin-left: 7px; display: table-cell; vertical-align: middle;">장바구Needs</span>

        </a>
        <ul class="right hide-on-med-and-down">
            <li><a href="#" style="color: black">Navbar Link</a></li>

            <%
                if (id == null) {
            %>
            <li id="navBtn" style="height: 100%;">
                <div class="btn-group" style="margin-top: 12px">
                    <a class="btn waves-light waves-effect customBtn" id="navLoginBtn">
                        <i class="material-icons ">person</i></a>
                    <a class="btn waves-light waves-effect customBtn" href="/member/join.jsp">
                        <i class="material-icons">person_add</i></a>
                </div>
            </li>
            <%
            } else {
            %>

            <li style="height: 100%;">
                <!-- Dropdown Trigger -->

                <a class='dropdown-trigger' href='#' data-target='dropdown1' style="height: 100%;">
                        <span style="color: gray; margin-right: 10px"><%=nickName%>님</span>
                        <img src="<%=profileImage%>"
                             class="circle responsive-img" alt="" style="height: 50px; vertical-align: middle">
                </a>

                <!-- Dropdown Structure -->
                <ul id='dropdown1' class='dropdown-content'>
                    <li><a href="#!">one</a></li>
                    <li><a href="#!">two</a></li>
                    <li><a href="#!">three</a></li>
                    <li class="divider" tabindex="-1"></li>
                    <li><a href="#!"><i class="material-icons">manage_accounts</i>회원정보 수정</a></li>
                    <li><a id="logout" href="/member/logout.jsp"><i class="material-icons">logout</i>로그아웃</a></li>
                </ul>

            </li>
            <%
                }
            %>

        </ul>

        <ul id="nav-mobile" class="sidenav">
            <li><a href="#">Navbar Link</a></li>

        </ul>
        <a href="#" data-target="nav-mobile" class="sidenav-trigger" style="color: black"><i
                class="material-icons">menu</i></a>
    </div>
</nav>


<%--<!-- Navbar -->--%>
<%--<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">--%>
<%--    <!-- Container wrapper -->--%>
<%--    <div class="container">--%>
<%--        <!-- Navbar brand -->--%>
<%--        <a class="navbar-brand me-2" href="/index.jsp">--%>
<%--            <img--%>
<%--                    src="/resources/images/temp3.png"--%>
<%--                    height="40"--%>
<%--                    alt=""--%>
<%--                    loading="lazy"--%>
<%--                    style="margin-top: -1px;"--%>
<%--            />--%>
<%--        </a>--%>

<%--        <!-- Toggle button -->--%>
<%--        <div class="dropdown me-1">--%>

<%--            <button--%>
<%--                    class="btn btn-primary navbar-toggler"--%>
<%--                    type="button"--%>
<%--                    data-mdb-toggle="collapse"--%>
<%--                    data-mdb-target="#navbarDropDown"--%>
<%--                    aria-controls="navbarDropDown"--%>
<%--                    aria-expanded="false"--%>
<%--                    aria-label="Toggle navigation"--%>
<%--            >--%>
<%--                회원메뉴--%>
<%--            </button>--%>


<%--            <ul class="dropdown-menu" aria-labelledby="dropdownMenuOffset" id="navbarDropDown">--%>
<%--                <li><a class="dropdown-item" href="#">로그인</a></li>--%>
<%--                <li><a class="dropdown-item" href="#">회원가입</a></li>--%>
<%--            </ul>--%>
<%--        </div>--%>

<%--        <!-- Collapsible wrapper -->--%>
<%--        <div class="collapse navbar-collapse justify-content-end" id="navbarButtons">--%>
<%--            &lt;%&ndash;            <!-- Left links -->&ndash;%&gt;--%>
<%--            &lt;%&ndash;            <ul class="navbar-nav me-auto mb-2 mb-lg-0">&ndash;%&gt;--%>
<%--            &lt;%&ndash;                <li class="nav-item">&ndash;%&gt;--%>
<%--            &lt;%&ndash;                    <a class="nav-link" href="#">Dashboard</a>&ndash;%&gt;--%>
<%--            &lt;%&ndash;                </li>&ndash;%&gt;--%>
<%--            &lt;%&ndash;            </ul>&ndash;%&gt;--%>
<%--            &lt;%&ndash;            <!-- Left links -->&ndash;%&gt;--%>

<%--            <div class="d-flex align-items-center">--%>
<%--                <button type="button"--%>
<%--                        class="btn btn-primary btn-rounded px-3 me-2"--%>
<%--                        data-mdb-toggle="modal"--%>
<%--                        data-mdb-target="#loginModal" >--%>
<%--                    로그인--%>
<%--                </button>--%>
<%--                <a type="button" class="btn btn-primary btn-rounded me-3 " href="/member/join.jsp">--%>
<%--                    회원가입--%>
<%--                </a>--%>

<%--            </div>--%>
<%--        </div>--%>
<%--        <!-- Collapsible wrapper -->--%>
<%--    </div>--%>
<%--    <!-- Container wrapper -->--%>
<%--</nav>--%>
<%--<!-- Navbar -->--%>

