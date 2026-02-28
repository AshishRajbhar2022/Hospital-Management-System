/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hospital;

import model.Patient;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
        
@WebServlet(name = "SearchPatientServlet" , urlPatterns = {"/SearchPatientServlet"})
public class SearchPatientServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String patientId = request.getParameter("patientId");
        Patient patient = null;

        try (Connection con = ConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM patient WHERE patientId = ?")) {

            ps.setString(1, patientId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                patient = new Patient();
                patient.setId(rs.getInt("id"));
                patient.setPatientId(rs.getString("patientId"));
                patient.setName(rs.getString("name"));
                patient.setGender(rs.getString("gender"));
                patient.setDob(rs.getDate("dob") != null ? rs.getDate("dob").toString() : null);
                patient.setContactNumber(rs.getString("contactNumber"));
                patient.setEmail(rs.getString("email"));
                patient.setAddress(rs.getString("address"));
                patient.setBloodGroup(rs.getString("bloodGroup"));
                patient.setEmergencyContact(rs.getString("emergencyContact"));
                patient.setEnteredBy(rs.getString("enteredBy"));
                patient.setEnteredAt(rs.getTimestamp("enteredAt") != null ? rs.getTimestamp("enteredAt").toString() : null);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Error fetching patient: " + e.getMessage());
        }

        request.setAttribute("patient", patient);
        RequestDispatcher rd = request.getRequestDispatcher("searchResult.jsp");
        rd.forward(request, response);
    }
}
