<%-- 
    Document   : index
    Created on : 10 Oct, 2025, 11:38:55 PM
    Author     : Ashish
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Hospital Dashboard</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #f8f9fa, #e3f2fd);
            color: #212529;
        }

        .header {
            background-color: #0d6efd;
            color: white;
            padding: 25px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .welcome {
            margin-top: 10px;
            font-size: 16px;
            color: #f8f9fa;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin: 60px auto;
            max-width: 900px;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            animation: fadeIn 0.5s ease-in-out;
        }

        .btn {
            background-color: #0d6efd;
            color: white;
            padding: 14px 28px;
            text-decoration: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: bold;
            border: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        .btn:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
        }

        .btn.logout {
            background-color: #dc3545;
        }

        .btn.logout:hover {
            background-color: #c82333;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .container {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 80%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Hospital Management System Dashboard</h1>
        <div class="welcome">
            Welcome, <%= username %> | Role: <%= role %> |
            <a href="logout.jsp" class="btn logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <% if ("Patient".equalsIgnoreCase(role) || "Admin".equalsIgnoreCase(role)) { %>
            <a href="addPatient.jsp" class="btn">Online Registration</a>
        <% } %>

        <% if ("Admin".equalsIgnoreCase(role)) { %>
            <a href="addPatient.jsp" class="btn">Offline Registration</a>
            <a href="adminLogin.jsp" class="btn">Admin Panel</a>
        <% } %>
    </div>
</body>
</html>
