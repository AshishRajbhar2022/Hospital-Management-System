<%-- 
    Document   : printBill
    Created on : 8 Oct, 2025, 10:39:00 PM
    Author     : ashis
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Patient" %>
<%
    Patient p = (Patient) request.getAttribute("patient");
    String currentDate = new java.text.SimpleDateFormat("dd MMMM yyyy").format(new Date());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Registration Bill</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 40px;
        }

        .bill-container {
            max-width: 700px;
            margin: auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .header img {
            height: 60px;
        }

        .header h3 {
            margin: 5px 0;
            color: #2c3e50;
        }

        .header p {
            margin: 0;
            font-size: 14px;
            color: #555;
        }

        .date {
            text-align: right;
            font-size: 14px;
            color: #555;
            margin-bottom: 10px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            text-align: left;
            padding: 12px 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #ecf0f1;
            color: #34495e;
            font-weight: 600;
        }

        td {
            color: #2c3e50;
        }

        .signature {
            text-align: right;
            margin-top: 40px;
            font-style: italic;
            color: #333;
        }

        .print-btn {
            text-align: center;
            margin-top: 30px;
        }

        .print-btn button {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .print-btn button:hover {
            background-color: #2980b9;
        }

        @media print {
            .print-btn { display: none; }
            body { background: white; padding: 0; }
        }
    </style>
</head>
<body>
    <div class="bill-container">
        <div class="header">
            <img src="hospital-logo.png" alt="Hospital Logo" />
            <h3>Shri Ram Hospital, Varanasi</h3>
            <p>Patient Registration Receipt</p>
        </div>
        <div class="date">Date: <%= currentDate %></div>
        <h2>Patient Registration Bill</h2>
        <table>
            <tr><th>Patient ID</th><td><%= p.getPatientId() %></td></tr>
            <tr><th>Name</th><td><%= p.getName() %></td></tr>
            <tr><th>Gender</th><td><%= p.getGender() %></td></tr>
            <tr><th>Date of Birth</th><td><%= p.getDob() %></td></tr>
            <tr><th>Age</th><td><%= p.getAge() %> years</td></tr>
            <tr><th>Contact</th><td><%= p.getContactNumber() %></td></tr>
            <tr><th>Email</th><td><%= p.getEmail() %></td></tr>
            <tr><th>Address</th><td><%= p.getAddress() %></td></tr>
            <tr><th>Blood Group</th><td><%= p.getBloodGroup() %></td></tr>
            <tr><th>Emergency Contact</th><td><%= p.getEmergencyContact() %></td></tr>
            <tr><th>Visit Type</th><td><%= p.getVisitType() %></td></tr>
            <tr><th>Department</th><td><%= p.getDepartment() %></td></tr>
            <tr><th>Registered On</th><td><%= p.getFormattedEnteredAt() %></td></tr>
        </table>
        <div class="signature">
            Authorized Signature<br/>
            ______________________
        </div>
        <div class="print-btn">
            <button onclick="window.print()">🖨️ Print Bill</button>
        </div>
    </div>
</body>
</html>

