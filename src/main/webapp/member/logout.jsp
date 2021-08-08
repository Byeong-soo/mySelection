<%--
  Created by IntelliJ IDEA.
  User: JU
  Date: 2021-08-09
  Time: 오전 2:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    session.invalidate();
    response.sendRedirect("/index.jsp");
%>

