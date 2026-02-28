package hospital;

import model.Doctor;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "SaveDoctor", urlPatterns = {"/SaveDoctor"})
public class SaveDoctor extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Doctor doc = new Doctor();
        doc.setName(request.getParameter("name"));
        doc.setSpecialization(request.getParameter("specialization"));
        doc.setPhone(request.getParameter("phone"));
        doc.setDob(request.getParameter("dob"));
        doc.setAddress(request.getParameter("address"));
        doc.setJoinedDate(request.getParameter("joined_date"));
        doc.setEmail(request.getParameter("email"));

        // ✅ New fields
        doc.setBranchId(Integer.parseInt(request.getParameter("branchId")));
        doc.setDepartmentId(Integer.parseInt(request.getParameter("departmentId")));

        if (doc.isDuplicate()) {
            response.sendRedirect("addDoctor.jsp?error=duplicate");
        } else if (doc.save()) {
            response.sendRedirect("addDoctor.jsp?success=true");
        } else {
            response.sendRedirect("addDoctor.jsp?error=saveFailed");
        }
    }
}
