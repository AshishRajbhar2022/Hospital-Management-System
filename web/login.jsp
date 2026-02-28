<%-- 
    Document   : login
    Created on : 15 Sep, 2025, 2:32:36 PM
    Author     : ashis
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>HospitalMultispeciality Login</title>
    <style>
        body, html {
    height: 100%;
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #e9f5f3; /* soft hospital-like background */
    display: flex;
    align-items: center;
    justify-content: center;
}

.login-box {
    background: #ffffff;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    text-align: center;
    width: 320px;
}

.login-box h2 {
    margin-bottom: 20px;
    font-size: 22px;
    color: #00695c; /* deep teal for healthcare */
}

.login-box input {
    width: 100%;
    padding: 10px;
    margin: 8px 0;
    border: 1px solid #b2dfdb;
    border-radius: 5px;
    font-size: 14px;
    background-color: #f9f9f9;
}

.login-box input:focus {
    border-color: #26a69a;
    outline: none;
    box-shadow: 0 0 4px rgba(38,166,154,0.3);
}

.login-box input[type="submit"] {
    background-color: #26a69a; /* teal button */
    color: #fff;
    font-weight: bold;
    cursor: pointer;
    border: none;
    transition: background-color 0.3s ease;
}

.login-box input[type="submit"]:hover {
    background-color: #00796b; /* darker teal on hover */
}

.login-box a {
    display: block;
    margin-top: 10px;
    font-size: 13px;
    color: #00796b;
    text-decoration: none;
}

.login-box a:hover {
    text-decoration: underline;
}

.error {
    color: #d32f2f; /* medical red for errors */
    margin-top: 10px;
    font-size: 14px;
}

@media (max-width: 600px) {
    .login-box {
        width: 90%;
        padding: 20px;
    }
}

    </style>
</head>
<body>

    <div class="login-box">
        <h2>Login Form</h2>
        <form method="post" action="LoginServlet">
            <input type="text" name="username" placeholder="User name" required /><br/>
            <input type="password" name="password" placeholder="Password" required /><br/>
            <input type="submit" value="Login" />
        </form>
        <a href="forgotPassword.jsp">Forget password? Click Here</a>
        <a href="register.jsp">Don't have an account? Click Here</a>
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>
    </div>

</body>
</html>
