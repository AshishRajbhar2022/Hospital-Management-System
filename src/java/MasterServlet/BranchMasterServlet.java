package MasterServlet;

import MasterModel.BranchModel;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "BranchMasterServlet", urlPatterns = {"/BranchMasterServlet"})
public class BranchMasterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String branchName = req.getParameter("branchName");

        try {
            new BranchModel().addBranch(branchName);
            res.sendRedirect("addBranch.jsp?success=true");
        } catch (Exception e) {
            // Show error directly on addBranch.jsp
            req.setAttribute("errorMessage", "Error adding branch: " + e.getMessage());
            RequestDispatcher rd = req.getRequestDispatcher("addBranch.jsp");
            rd.forward(req, res);
        }
    }
}
