<%-- 
    Document   : addDoctor
    Created on : 27 Sep, 2025, 10:45 AM
    Author     : ashis
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="MasterModel.BranchModel" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.LocalDate" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    BranchModel branchModel = new BranchModel();
    Map<String, String> branches = branchModel.getAllBranches();
%>
<%
    String role = (session != null) ? (String) session.getAttribute("role") : null;
    if (role == null || !"Admin".equalsIgnoreCase(role)) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register New Doctor</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background-color: #f4f4f4; }
        .navbar { background-color: #333; overflow: hidden; }
        .navbar a { float: left; display: block; color: white; padding: 14px 20px; text-decoration: none; font-weight: bold; }
        .navbar a:hover { background-color: #575757; }
        .navbar a.active { background-color: #04AA6D; }
        .form-container { width: 500px; margin: 40px auto; padding: 20px; background-color: white; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .form-container h2 { text-align: center; }
        .form-container input, .form-container textarea, .form-container select {
            width: 100%; padding: 8px; margin: 6px 0 12px; box-sizing: border-box;
        }
        .form-container input[type="submit"] {
            background-color: #4CAF50; color: white; border: none; cursor: pointer;
        }
        .form-container input[type="submit"]:hover {
            background-color: #45a049;
        }
        .message { text-align: center; font-weight: bold; margin-top: 20px; }
        .success { color: green; }
        .error { color: red; }
    </style>
    <script>
        function validateDoctorForm() {
            const form = document.forms["doctorForm"];
            const phone = form["phone"].value.trim();
            const email = form["email"].value.trim();
            const phoneRegex = /^[0-9]{10,17}$/;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!phoneRegex.test(phone)) {
                alert("Please enter a valid phone number (10–17 digits).");
                return false;
            }
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }
            return true;
        }

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
    <a href="addPatient.jsp">Add Patient</a>
    <a href="viewPatients.jsp">View Patients</a>
    <a href="addDoctor.jsp" class="active">Add Doctor</a>
    <a href="viewDoctors.jsp">View Doctors</a>
    <a href="logout.jsp">Logout</a>
</div>

<%
    String success = request.getParameter("success");
    String error = request.getParameter("error");
    if ("true".equals(success)) {
%>
    <div class="message success">
        ✅ Doctor added successfully. You can add another doctor below.
    </div>
<%
    } else if ("duplicate".equals(error)) {
%>
    <div class="message error">
        ⚠️ A doctor with this email or phone number already exists.
    </div>
<%
    }
%>

<div class="form-container">
    <h2>Doctor Registration</h2>
    <form name="doctorForm" action="SaveDoctor" method="post" onsubmit="return validateDoctorForm()">
        <input type="text" name="name" placeholder="Enter full name (e.g., Dr. A. Sharma)" required />
        <input type="text" name="specialization" placeholder="Specialization (e.g., Cardiology)" required />
        <input type="text" name="phone" placeholder="Phone number (10–17 digits)" required />
        <input type="date" name="dob" placeholder="Date of birth (YYYY-MM-DD)" required />
        <textarea name="address" placeholder="Full residential address" rows="3" required></textarea>

        <label for="joined_date">Joining Date</label>
        <input type="date" name="joined_date" id="joined_date" 
               value="<%= LocalDate.now() %>" 
               max="<%= LocalDate.now() %>" required />

        <input type="email" name="email" placeholder="Valid email address (e.g., doctor@example.com)" required />

        <select name="branchId" onchange="loadDepartments(this.value)" required>
            <option value="">Select Branch</option>
            <% for (Map.Entry<String, String> entry : branches.entrySet()) { %>
                <option value="<%= entry.getKey() %>"><%= entry.getValue() %></option>
            <% } %>
        </select>

        <select name="departmentId" id="departmentDropdown" required>
            <option value="">Select Department</option>
        </select>

        <input type="submit" value="Register Doctor" />
    </form>
</div>

</body>
</html>
