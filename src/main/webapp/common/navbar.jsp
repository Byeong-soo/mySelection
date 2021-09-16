<%@ page contentType="text/html;charset=UTF-8" language="java" %>

   <% String id = (String) session.getAttribute("id");
    String profileImage = (String) session.getAttribute("profileImage");
    String nickName = (String) session.getAttribute("nickName");
%>
<%-- role="navigation"--%>

<nav class="white nav-extended">
    <div class="nav-wrapper container">
        <a id="logo-container" href="/index.jsp" class="brand-logo" style="color: black; display: table">
            <div style="display: table-cell; vertical-align: middle"><img src="/resources/images/myselectionLogo60.png"
                                                                          alt="" style="height: 50px;"></div>
            <span style="margin-left: 7px; display: table-cell; vertical-align: middle;">장바구Needs</span>
        </a>
<%--모바일--%>
        <a href="#" data-target="mobile-demo" class="sidenav-trigger"><i class="material-icons" style="color: black">menu</i></a>
        <ul id="nav-mobile" class="right hide-on-med-and-down">
            <li><a href="#" style="color: black" id="navbarMenu"><i class="large material-icons" style="font-size: 30px;">menu</i></a></li>

            <%
                if (id == null) {
            %>
            <li id="navBtn">
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

            <li>
                <!-- Dropdown Trigger -->

                <a class='dropdown-trigger' href='#' data-target='dropdown1'>
                    <span style="color: gray; margin-right: 10px"><%=nickName%>님</span>
                    <img src="<%
                    if(profileImage != null){
                         if(profileImage.startsWith("http")){
                            %><%=profileImage%><%
                        } else{%>
                            /common/display.jsp?fileName=<%=profileImage%>
                        <%}%>
                    <%}%>"

                         class="circle responsive-img" alt="" style="height: 50px; vertical-align: middle">
                </a>

                <!-- Dropdown Structure -->
                <ul id='dropdown1' class='dropdown-content'>
                    <li><a href="#!">one</a></li>
                    <li><a href="#!">two</a></li>
                    <li><a href="#!">three</a></li>
                    <li class="divider" tabindex="-1"></li>
                    <li><a href="/member/modify.jsp" id="modifyJoin"><i class="material-icons">manage_accounts</i>회원정보 수정</a></li>
                    <li><a id="logout" href="/member/logout.jsp"><i class="material-icons">logout</i>로그아웃</a></li>
                </ul>

            </li>
            <%
                }
            %>

        </ul>
        <%--모바일 끝--%>

    </div>
    <div id="navbarSubMenu" class="nav-content container" style="display: none">
        <ul id="navbarSubMenuUl" class="tabs tabs-transparent" style="padding-right: 6.7vw">
            <li class="tab"><a href="#!"  style="color: black;">장바구니</a></li>
            <li class="tab"><a class="active" style="color: black;">QNA</a></li>
        </ul>
    </div>
</nav>

<ul class="sidenav" id="mobile-demo">
    <li><a href="sass.html">Sass</a></li>
    <li><a href="badges.html">Components</a></li>
    <li><a href="collapsible.html">JavaScript</a></li>
</ul>


<%--<ul id="nav-mobile" class="sidenav">--%>
<%--    <li><a href="#">Navbar Link</a></li>--%>

<%--</ul>--%>
<%--<a href="#" data-target="nav-mobile" class="sidenav-trigger" style="color: black"><i--%>
<%--        class="material-icons">menu</i></a>--%>
