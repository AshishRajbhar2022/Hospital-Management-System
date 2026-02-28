<%@ page import="MasterModel.BranchModel, MasterModel.DepartmentModel" %>
<%@ page import="java.util.*" %>
<%
    BranchModel branchModel = new BranchModel();
    DepartmentModel deptModel = new DepartmentModel();
    Map<String, String> branches = branchModel.getAllBranches();
    Map<String, String> departments = deptModel.getAllDepartments();
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Link Department</title>
    <style>
        * { box-sizing: border-box; }

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

        .navbar a {
            background-color: transparent;
            color: white;
            padding: 12px 20px;
            margin: 0 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.25s ease;
            text-decoration: none;
        }

        .navbar a:hover { border-bottom: 2px solid #ffffff; transform: scale(1.03); }
        .navbar a.active { border-bottom: 2px solid #ffffff; }

        .container {
            max-width: 920px;
            margin: 30px auto;
            padding: 0 16px;
        }

        .success-message {
            background-color: #d1e7dd;
            color: #0f5132;
            padding: 12px 20px;
            margin: 20px auto 0;
            max-width: 600px;
            border-radius: 8px;
            text-align: center;
            font-weight: 600;
            box-shadow: 0 4px 8px rgba(0,0,0,0.06);
            animation: fadeIn 0.45s ease-in-out;
        }

        .form-container {
            background-color: #ffffff;
            padding: 30px;
            margin: 24px auto;
            max-width: 600px;
            border-radius: 16px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.08);
            animation: fadeIn 0.5s ease-in-out;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 18px;
            font-size: 22px;
            color: #333;
        }

        .form-container label {
            display: block;
            margin-top: 16px;
            font-weight: 600;
            color: #444;
        }

        .form-container select,
        .form-container input[type="submit"] {
            width: 100%;
            padding: 12px 14px;
            margin-top: 8px;
            border-radius: 10px;
            border: 1px solid #d0d7de;
            font-size: 16px;
            transition: border-color 0.25s ease, box-shadow 0.25s ease, transform 0.15s ease;
            background-clip: padding-box;
            appearance: none;
        }

        .form-container select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 8px rgba(13,110,253,0.12);
            outline: none;
            transform: translateY(-1px);
        }

        .form-container input[type="submit"] {
            background: linear-gradient(180deg,#0d6efd,#0b5ed7);
            color: #fff;
            border: none;
            margin-top: 22px;
            cursor: pointer;
            font-weight: 700;
        }

        .form-container input[type="submit"]:hover {
            filter: brightness(0.95);
            transform: translateY(-2px) scale(1.01);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(18px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInUp {
            from { opacity: 0; transform: translateY(18px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Slide-in animation for dropdowns when page loads */
        .form-container select {
            animation: slideInUp 0.45s ease-in-out both;
        }

        /* small screens */
        @media (max-width:600px) {
            .navbar { flex-direction: column; align-items: center; }
            .navbar a { margin: 8px 0; width: 90%; text-align: center; }
            .form-container { margin: 20px 10px; padding: 20px; }
        }

        /* Toast hide animation */
        .fade-out {
            animation: fadeOut 0.6s forwards;
        }
        @keyframes fadeOut {
            to { opacity: 0; transform: translateY(-8px); height: 0; margin: 0; padding: 0; }
        }
    </style>
    <script>
        // Auto-hide success message after 3 seconds
        function hideSuccess() {
            var el = document.getElementById('successBox');
            if (!el) return;
            setTimeout(function() {
                el.classList.add('fade-out');
            }, 3000);
        }

        // Small enhancement: add slide-in class on focus to re-trigger animation
        document.addEventListener('DOMContentLoaded', function() {
            hideSuccess();
            var selects = document.querySelectorAll('.form-container select');
            selects.forEach(function(s) {
                s.addEventListener('focus', function() {
                    s.style.animation = 'none';
                    void s.offsetWidth;
                    s.style.animation = 'slideInUp 0.35s ease-in-out both';
                });
            });
        });
    </script>
</head>
<body>
    <div class="navbar">
        <a href="branch.jsp">Add Branch</a>
        <a href="department.jsp">Add Department</a>
        <a href="linkDepartment.jsp" class="active">Link Department</a>
    </div>

    <div class="container">
        <% if ("true".equals(success)) { %>
            <div id="successBox" class="success-message">Department linked successfully</div>
        <% } %>

        <div class="form-container">
            <h2>Link Department to Branch</h2>
            <form action="DepartmentMasterServlet" method="post">
                <input type="hidden" name="action" value="linkDept" />

                <label for="branchId">Select Branch</label>
                <select id="branchId" name="branchId" required>
                    <option value="" disabled selected>-- Choose branch --</option>
                    <% for (Map.Entry<String, String> entry : branches.entrySet()) { %>
                        <option value="<%= entry.getKey() %>"><%= entry.getValue() %></option>
                    <% } %>
                </select>

                <label for="deptId">Select Department</label>
                <select id="deptId" name="deptId" required>
                    <option value="" disabled selected>-- Choose department --</option>
                    <% for (Map.Entry<String, String> entry : departments.entrySet()) { %>
                        <option value="<%= entry.getKey() %>"><%= entry.getValue() %></option>
                    <% } %>
                </select>

                <input type="submit" value="Link Department" />
            </form>
        </div>
    </div>
</body>
</html>
