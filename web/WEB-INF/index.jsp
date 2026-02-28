<%-- 
    Document   : index
    Created on : 15 Sep, 2025, 2:35:51 PM
    Author     : ashis
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Hospital Dashboard</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
    <div class="header">
        <h1>Welcome to Hospital Management System</h1>
        <div class="welcome">
            Welcome, <%= username %> | Role: <%= role %> | <a href="logout.jsp" class="btn">Logout</a>
        </div>
    </div>

    <div class="container">
        <a href="addPatient.jsp" class="btn">Add Patient</a>
        <% if ("admin".equals(role)) { %>
            <a href="addDoctor.jsp" class="btn">Add Doctor</a>
        <% } %>
        <a href="viewPatients.jsp" class="btn">View Patients</a>
    </div>
</body>
</html>
