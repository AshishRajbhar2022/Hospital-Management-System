<%-- 
    Document   : department
    Created on : 10 Oct, 2025, 7:52:43 PM
    Author     : ashis
--%>

<<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (session != null) ? (String) session.getAttribute("role") : null;
    if (role == null || !"Admin".equalsIgnoreCase(role)) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<html>
<head>
    <title>Add Department</title>
    <style>
        /* Same CSS as branch.jsp for consistency */
        body { font-family: Arial; margin: 0; background-color: #f4f4f4; }
        .navbar { background-color: #333; overflow: hidden; }
        .navbar a { float: left; color: white; padding: 14px 20px; text-decoration: none; font-weight: bold; }
        .navbar a:hover { background-color: #575757; }
        .navbar a.active { background-color: #04AA6D; }
        .form-container { width: 500px; margin: 40px auto; padding: 20px; background: white; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .form-container h2 { text-align: center; }
        .form-container input[type="text"], .form-container input[type="submit"] {
            width: 100%; padding: 10px; margin: 10px 0; box-sizing: border-box;
        }
        .form-container input[type="submit"] {
            background-color: #04AA6D; color: white; border: none; cursor: pointer;
        }
        .form-container input[type="submit"]:hover {
            background-color: #039e63;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="branch.jsp">Add Branch</a>
    <a href="department.jsp" class="active">Add Department</a>
    <a href="linkDepartment.jsp">Link Department</a>
</div>
    
 <% String success = request.getParameter("success"); %>
<% if ("add".equals(success)) { %>
    <div style="color:green; text-align:center; font-weight:bold; margin-top:20px;">
        ✅ Department added successfully.
    </div>
<% } else if ("link".equals(success)) { %>
    <div style="color:green; text-align:center; font-weight:bold; margin-top:20px;">
        ✅ Department linked to branch successfully.
    </div>
<% } %>



<div class="form-container">
    <h2>Add Department</h2>
    <form action="DepartmentMasterServlet" method="post">
        <input type="hidden" name="action" value="addDept" />
        <input type="text" name="deptName" placeholder="Enter Department Name" required />
        <input type="submit" value="Add Department" />
    </form>
</div>
</body>
</html>

