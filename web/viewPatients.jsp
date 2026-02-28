<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, hospital.ConnectionPool" %>
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
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
        }

        .navbar {
            background-color: #333;
            overflow: hidden;
        }

        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
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

        .table-container {
            width: 95%;
            margin: 40px auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        h2 {
            text-align: center;
            margin-top: 40px;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="addPatient.jsp">Add Patient</a>
    <a href="addDoctor.jsp">Add Doctor</a>
    <a href="viewPatients.jsp" class="active">View Patients</a>
    <a href="logout.jsp">Logout</a>
</div>

<!-- Patient List Table -->
<div class="table-container">
    <h2>Patient List</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Patient ID</th>
            <th>Name</th>
            <th>Gender</th>
            <th>DOB</th>
            <th>Contact Number</th>
            <th>Email</th>
            <th>Address</th>
            <th>Blood Group</th>
            <th>Emergency Contact</th>
            <th>Entered By</th>
            <th>Entered At</th>
        </tr>
        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                con = ConnectionPool.getConnection();
                stmt = con.createStatement();
                rs = stmt.executeQuery("SELECT * FROM patient ORDER BY enteredAt DESC");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("patientId") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("gender") %></td>
            <td><%= rs.getDate("dob") %></td>
            <td><%= rs.getString("contactNumber") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("address") %></td>
            <td><%= rs.getString("bloodGroup") %></td>
            <td><%= rs.getString("emergencyContact") %></td>
            <td><%= rs.getString("enteredBy") %></td>
            <td><%= rs.getTimestamp("enteredAt") %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='12'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception ignored) {}
                if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
                if (con != null) try { con.close(); } catch (Exception ignored) {}
            }
        %>
    </table>
</div>

</body>
</html>
