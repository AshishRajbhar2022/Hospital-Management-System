<%-- 
    Document   : nurseRegistration
    Created on : 10 Oct, 2025, 7:54:07 PM
    Author     : ashis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String role = (session != null) ? (String) session.getAttribute("role") : null;
    if (role == null || !"Admin".equalsIgnoreCase(role)) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
