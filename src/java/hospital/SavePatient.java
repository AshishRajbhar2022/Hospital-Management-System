package hospital;

import model.Patient;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.IOException;

@WebServlet(name = "SavePatient", urlPatterns = {"/SavePatient"})
public class SavePatient extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = session.getAttribute("username").toString();
        String patientId = Patient.getNewPatientCode();

        String name = trim(request.getParameter("name"));
        String gender = trim(request.getParameter("gender"));
        String dob = trim(request.getParameter("dob")); // expects yyyy-MM-dd
        String contactNumber = trim(request.getParameter("contactNumber"));
        String email = trim(request.getParameter("email"));
        String address = trim(request.getParameter("address"));
        String bloodGroup = trim(request.getParameter("bloodGroup"));
        String emergencyContact = trim(request.getParameter("emergencyContact"));
        String visitType = trim(request.getParameter("visitType"));
        String departmentId = trim(request.getParameter("departmentId"));
        String branchId = trim(request.getParameter("branchId"));

        if (name.isEmpty() || visitType.isEmpty() || branchId.isEmpty() || departmentId.isEmpty()) {
            response.sendRedirect("addPatient.jsp?success=false");
            return;
        }

        Patient p = new Patient();
        p.setPatientId(patientId);
        p.setName(name);
        p.setGender(gender);
        p.setDob(dob);
        p.setContactNumber(contactNumber);
        p.setEmail(email);
        p.setAddress(address);
        p.setBloodGroup(bloodGroup);
        p.setEmergencyContact(emergencyContact);
        p.setVisitType(visitType);
        p.setDepartment(departmentId);
        p.setBranchId(branchId);
        p.setEnteredBy(username);

        System.out.println("SavePatient: attempting to save -> " + p);

        boolean saved = Patient.savePatient(p);

        System.out.println("SavePatient: save result -> " + saved);

        if (saved) {
            request.setAttribute("patient", p);
            RequestDispatcher rd = request.getRequestDispatcher("printBill.jsp");
            rd.forward(request, response);
        } else {
            response.sendRedirect("addPatient.jsp?success=false");
        }
    }

    private String trim(String value) {
        return (value != null) ? value.trim() : "";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles saving patient details and forwards to bill";
    }
}
