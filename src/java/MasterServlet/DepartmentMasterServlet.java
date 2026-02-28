package MasterServlet;

import MasterModel.DepartmentModel;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "DepartmentMasterServlet", urlPatterns = {"/DepartmentMasterServlet"})
public class DepartmentMasterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            DepartmentModel model = new DepartmentModel();

            if ("addDept".equals(action)) {
                String deptName = req.getParameter("deptName");
                if (deptName == null || deptName.trim().isEmpty()) {
                    res.sendRedirect("department.jsp?error=emptyName");
                    return;
                }
                model.addDepartment(deptName.trim());
                res.sendRedirect("department.jsp?success=add");
                return;
            }

            if ("linkDept".equals(action)) {
                // IDs are string formatted like "BR01" and "DP01"
                String branchId = req.getParameter("branchId");
                String deptId = req.getParameter("deptId");

                if (branchId == null || branchId.trim().isEmpty() || deptId == null || deptId.trim().isEmpty()) {
                    res.sendRedirect("linkDepartment.jsp?error=missingIds");
                    return;
                }

                model.linkToBranch(branchId.trim(), deptId.trim());
                res.sendRedirect("linkDepartment.jsp?success=true");
                return;
            }

            // Unknown action
            res.sendRedirect("department.jsp?error=invalidAction");

        } catch (Exception e) {
            e.printStackTrace();
            // redirect back to the page where action originated when possible
            String actionParam = req.getParameter("action");
            if ("linkDept".equals(actionParam)) {
                res.sendRedirect("linkDepartment.jsp?error=true");
            } else {
                res.sendRedirect("department.jsp?error=true");
            }
        }
    }
}
