package hospital;

import model.Patient;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "ViewPatientsServlet" , urlPatterns = {"/ViewPatientsServlet"})
public class ViewPatientsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ArrayList<Patient> patientList = new ArrayList<>();

        try (Connection con = ConnectionPool.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM patient ORDER BY enteredAt DESC")) {

            while (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("id"));
                p.setPatientId(rs.getString("patientId"));
                p.setName(rs.getString("name"));
                p.setGender(rs.getString("gender"));

                // Convert Date and Timestamp to String
                Date dobDate = rs.getDate("dob");
                p.setDob(dobDate != null ? dobDate.toString() : null);

                p.setContactNumber(rs.getString("contactNumber"));
                p.setEmail(rs.getString("email"));
                p.setAddress(rs.getString("address"));
                p.setBloodGroup(rs.getString("bloodGroup"));
                p.setEmergencyContact(rs.getString("emergencyContact"));
                p.setEnteredBy(rs.getString("enteredBy"));

                Timestamp enteredAtTs = rs.getTimestamp("enteredAt");
                p.setEnteredAt(enteredAtTs != null ? enteredAtTs.toString() : null);

                patientList.add(p);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        request.setAttribute("patients", patientList);

        RequestDispatcher rd = request.getRequestDispatcher("viewPatients.jsp");
        if (rd != null) {
            rd.forward(request, response);
        } else {
            response.getWriter().println("Error: viewPatients.jsp not found.");
        }
    }
}
