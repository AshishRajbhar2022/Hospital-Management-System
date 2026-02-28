<%-- 
    Document   : searchResult
    Created on : 24 Sep, 2025, 11:05:00 AM
    Author     : ashis
--%>

<%@ page import="model.Patient" %>
<%
    Patient p = (Patient) request.getAttribute("patient");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Search Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
            background-color: #fff;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        p {
            text-align: center;
            font-size: 18px;
            color: red;
        }
    </style>
</head>
<body>
    <h2>Search Result</h2>
    <% if (error != null) { %>
        <p><%= error %></p>
    <% } else if (p != null) { %>
        <table>
            <tr><th>ID</th><td><%= p.getId() %></td></tr>
            <tr><th>Patient ID</th><td><%= p.getPatientId() %></td></tr>
            <tr><th>Name</th><td><%= p.getName() %></td></tr>
            <tr><th>Gender</th><td><%= p.getGender() %></td></tr>
            <tr><th>DOB</th><td><%= p.getDob() %></td></tr>
            <tr><th>Contact</th><td><%= p.getContactNumber() %></td></tr>
            <tr><th>Email</th><td><%= p.getEmail() %></td></tr>
            <tr><th>Address</th><td><%= p.getAddress() %></td></tr>
            <tr><th>Blood Group</th><td><%= p.getBloodGroup() %></td></tr>
            <tr><th>Emergency Contact</th><td><%= p.getEmergencyContact() %></td></tr>
            <tr><th>Entered By</th><td><%= p.getEnteredBy() %></td></tr>
            <tr><th>Entered At</th><td><%= p.getEnteredAt() %></td></tr>
        </table>
    <% } else { %>
        <p>No patient found with that ID.</p>
    <% } %>
</body>
</html>

