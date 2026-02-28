<%-- 
    Document   : addPatient
    Created on : 15 Sep, 2025, 2:36:56 PM
    Author     : ashis
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="MasterModel.BranchModel" %>
<%@ page import="java.util.*" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    BranchModel branchModel = new BranchModel();
    Map<String, String> branches = branchModel.getAllBranches();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register New Patient</title>
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

        .form-container input,
        .form-container textarea,
        .form-container select {
            width: 100%;
            padding: 8px;
            margin: 6px 0 12px;
            box-sizing: border-box;
        }

        .form-container input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        .form-container input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        function loadDepartments(branchId) {
            fetch('getDepartments.jsp?branchId=' + branchId)
                .then(response => response.json())
                .then(data => {
                    const dropdown = document.getElementById('departmentDropdown');
                    dropdown.innerHTML = '<option value="">Select Department</option>';
                    data.forEach(dept => {
                        const opt = document.createElement('option');
                        opt.value = dept.id;
                        opt.text = dept.name;
                        dropdown.appendChild(opt);
                    });
                });
        }
    </script>
</head>
<body>

<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="addPatient.jsp" class="active">Add Patient</a>
    <a href="addDoctor.jsp">Add Doctor</a>
    <a href="viewPatients.jsp">View Patients</a>
    <a href="logout.jsp">Logout</a>
</div>

<%
    String success = request.getParameter("success");
    if ("true".equals(success)) {
%>
    <div style="text-align:center; color:green; font-weight:bold;">
        ✅ Patient added successfully. You can add another patient below.
    </div>
<%
    }
%>

<div class="form-container">
    <h2>Patient Registration</h2>
    <form action="SavePatient" method="post">
        <input type="hidden" name="A" value="1" />

        <input type="text" name="name" placeholder="Full Name" required />
        <select name="gender" required>
            <option value="">Select Gender</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select>
        <input type="date" name="dob" placeholder="Date of Birth" required />
        <input type="text" name="contactNumber" placeholder="Contact Number" required />
        <input type="email" name="email" placeholder="Email Address" />
        <textarea name="address" placeholder="Residential Address" rows="3"></textarea>
        <input type="text" name="bloodGroup" placeholder="Blood Group" />
        <input type="text" name="emergencyContact" placeholder="Emergency Contact Number" />

        <select name="visitType" required>
            <option value="">Select Visit Type</option>
            <option value="OPD">OPD</option>
            <option value="Emergency">Emergency</option>
            <option value="Follow-up">Follow-up</option>
        </select>

        <select name="branchId" onchange="loadDepartments(this.value)" required>
            <option value="">Select Branch</option>
            <% for (Map.Entry<String, String> entry : branches.entrySet()) { %>
                <option value="<%= entry.getKey() %>"><%= entry.getValue() %></option>
            <% } %>
        </select>

        <select name="departmentId" id="departmentDropdown" required>
            <option value="">Select Department</option>
            <% for (Map.Entry<String, String> entry : branches.entrySet()) { %>
                <option value="<%= entry.getKey() %>"><%= entry.getValue() %></option>
            <% } %>
        </select>

        <input type="submit" value="Register Patient" />
    </form>
</div>
</body>
</html>




