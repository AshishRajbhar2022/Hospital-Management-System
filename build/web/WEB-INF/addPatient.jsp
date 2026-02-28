<%-- 
    Document   : addPatient
    Created on : 15 Sep, 2025, 2:36:56 PM
    Author     : ashis
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Patient</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
    <h2>Add Patient</h2>
    <form action="AddPatientServlet" method="post">
        Name:<br/>
        <input type="text" name="name" required><br/><br/>
        Age:<br/>
        <input type="number" name="age" required><br/><br/>
        Gender:<br/>
        <select name="gender">
            <option>Male</option>
            <option>Female</option>
        </select><br/><br/>
        Disease:<br/>
        <input type="text" name="disease" required><br/><br/>
        <input type="submit" value="Add Patient" class="button" />
    </form>
</body>
</html>

