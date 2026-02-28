<%-- 
    Document   : addBranch
    Created on : 9 Oct, 2025, 11:49:12 AM
    Author     : ashis
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (session != null) ? (String) session.getAttribute("role") : null;
    if (role == null || !"Admin".equalsIgnoreCase(role)) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<html>
<head>
    <title>Add Branch</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f4f4f4;
        }
        .navbar {
            background-color: #333;
            overflow: hidden;
        }
        .navbar a {
            float: left;
            display: block;
            color: white;
            padding: 14px 20px;
            text-decoration: none;
            font-weight: bold;
        }
        .navbar a:hover {
            background-color: #575757;
        }
        .navbar a.active {
            background-color: #04AA6D;
        }
        .form-container {
            width: 500px;
            margin: 40px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-container h2 {
            text-align: center;
        }
        .form-container input[type="text"],
        .form-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
        }
        .form-container input[type="submit"] {
            background-color: #04AA6D;
            color: white;
            border: none;
            cursor: pointer;
        }
        .form-container input[type="submit"]:hover {
            background-color: #039e63;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="branch.jsp" class="active">Add Branch</a>
    <a href="department.jsp">Add Department</a>
    <a href="linkDepartment.jsp">Link Department</a>
</div>

<div class="form-container">
    <%
    String success = request.getParameter("success");
    String error = (String) request.getAttribute("errorMessage");
    if ("true".equals(success)) {
%>
    <div style="color: green; font-weight: bold;">Branch added successfully!</div>
<%
    } else if (error != null) {
%>
    <div style="color: red; font-weight: bold;"><%= error %></div>
<%
    }
%>

    <h2>Add Branch</h2>
    <form action="BranchMasterServlet" method="post">
        <input type="text" name="branchName" placeholder="Enter Branch Name" required />
        <input type="submit" value="Add Branch" />
    </form>
</div>
</body>
</html>

