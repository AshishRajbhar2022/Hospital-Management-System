<%-- 
    Document   : viewPatients
    Created on : 15 Sep, 2025, 2:39:36 PM
    Author     : ashis
--%>

<%@ page import="java.sql.*,hospital.ConnectionPool" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Patients</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
    <h2>Patient List</h2>
    <table border="1" style="margin:auto;">
        <tr>
            <th>ID</th><th>Name</th><th>Age</th><th>Gender</th><th>Disease</th>
        </tr>
        <%
            try (Connection con = ConnectionPool.getConnection()) {
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM patients");
                while(rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getInt("age") %></td>
            <td><%= rs.getString("gender") %></td>
            <td><%= rs.getString("disease") %></td>
        </tr>
        <% 
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
</body>
</html>
