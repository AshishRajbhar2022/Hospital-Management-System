<%-- 
    Document   : addDoctor
    Created on : 15 Sep, 2025, 2:38:26 PM
    Author     : ashis
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    if (username == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Doctor</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
    <h2>Add Doctor</h2>
    <form action="AddDoctorServlet" method="post">
        Name:<br/>
        <input type="text" name="name" required><br/><br/>
        Specialization:<br/>
        <input type="text" name="specialization" required><br/><br/>
        <input type="submit" value="Add Doctor" class="button" />
    </form>
</body>
</html>
