<%@ page contentType="text/html; charset=UTF-8" %>
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
    <title>Admin Dashboard</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #f8f9fa, #e3f2fd);
        }

        .navbar {
            display: flex;
            justify-content: center;
            background-color: #0d6efd;
            padding: 15px 0;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar button {
            background-color: transparent;
            color: white;
            border: none;
            padding: 12px 20px;
            margin: 0 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .navbar button:hover {
            border-bottom: 2px solid #ffffff;
            transform: scale(1.05);
        }

        .section {
            padding: 30px;
            animation: fadeIn 0.5s ease-in-out;
            background-color: #ffffff;
            margin: 20px auto;
            max-width: 900px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            display: none;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .navbar {
                flex-direction: column;
                align-items: center;
            }

            .navbar button {
                margin: 8px 0;
                width: 80%;
            }

            .section {
                margin: 10px;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <button onclick="showSection('branch')">Branch</button>
        <button onclick="showSection('department')">Department</button>
        <button onclick="showSection('doctor')">Doctor Registration</button>
        <button onclick="showSection('nurse')">Nurse Registration</button>
    </div>

    <div class="section" id="branch">
        <jsp:include page="addBranch.jsp" />
    </div>
    <div class="section" id="department">
        <jsp:include page="department.jsp" />
    </div>
    <div class="section" id="doctor">
        <jsp:include page="addDoctor.jsp" />
    </div>
    <div class="section" id="nurse">
        <jsp:include page="nurseRegistration.jsp" />
    </div>

    <script>
        function showSection(sectionId) {
            document.querySelectorAll('.section').forEach(sec => sec.style.display = 'none');
            document.getElementById(sectionId).style.display = 'block';
        }

        // Optional: Show default section on load
        document.addEventListener('DOMContentLoaded', () => {
            showSection('branch');
        });
    </script>
</body>
</html>
