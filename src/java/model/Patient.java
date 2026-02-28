package model;

import hospital.ConnectionPool;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class Patient {

    private int id;
    private String patientId;
    private String name;
    private String gender;
    private String dob; // yyyy-MM-dd
    private String contactNumber;
    private String email;
    private String address;
    private String bloodGroup;
    private String emergencyContact;
    private String enteredBy;
    private String enteredAt;
    private String visitType;
    private String department; // stores department id (department_id)
    private String branchId;   // stores branch id (branch_id)

    public Patient(String patientId, String name, String gender, String dob, String contactNumber, String email,
                   String address, String bloodGroup, String emergencyContact, String visitType,
                   String department, String branchId, String enteredBy) {
        this.patientId = patientId;
        this.name = name;
        this.gender = gender;
        this.dob = dob;
        this.contactNumber = contactNumber;
        this.email = email;
        this.address = address;
        this.bloodGroup = bloodGroup;
        this.emergencyContact = emergencyContact;
        this.visitType = visitType;
        this.department = department;
        this.branchId = branchId;
        this.enteredBy = enteredBy;
    }

    public Patient() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getPatientId() { return patientId; }
    public void setPatientId(String patientId) { this.patientId = patientId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getBloodGroup() { return bloodGroup; }
    public void setBloodGroup(String bloodGroup) { this.bloodGroup = bloodGroup; }

    public String getEmergencyContact() { return emergencyContact; }
    public void setEmergencyContact(String emergencyContact) { this.emergencyContact = emergencyContact; }

    public String getEnteredBy() { return enteredBy; }
    public void setEnteredBy(String enteredBy) { this.enteredBy = enteredBy; }

    public String getEnteredAt() { return enteredAt; }
    public void setEnteredAt(String enteredAt) { this.enteredAt = enteredAt; }

    public String getVisitType() { return visitType; }
    public void setVisitType(String visitType) { this.visitType = visitType; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getBranchId() { return branchId; }
    public void setBranchId(String branchId) { this.branchId = branchId; }

    public String getFormattedEnteredAt() {
        if (enteredAt == null || enteredAt.isEmpty()) return "";
        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = inputFormat.parse(enteredAt);
            SimpleDateFormat outputFormat = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
            return outputFormat.format(date);
        } catch (Exception e) {
            return enteredAt;
        }
    }

    public int getAge() {
        try {
            if (dob == null || dob.isEmpty()) return 0;
            java.time.LocalDate birth = java.time.LocalDate.parse(dob); // expects yyyy-MM-dd
            return java.time.Period.between(birth, java.time.LocalDate.now()).getYears();
        } catch (Exception e) {
            return 0;
        }
    }

    @Override
    public String toString() {
        return "Patient[" + patientId + ", " + name + ", dept:" + department + ", branch:" + branchId + "]";
    }

    public static synchronized String getNewPatientCode() {
        String code = "PAT0001";
        String sql = "SELECT MAX(CAST(SUBSTRING(patientId, 4) AS UNSIGNED)) FROM patient WHERE patientId LIKE 'PAT%'";
        try (Connection con = ConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            int next = 1;
            if (rs.next()) {
                int max = rs.getInt(1);
                if (!rs.wasNull()) next = max + 1;
            }
            code = "PAT" + String.format("%04d", next);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in getNewPatientCode(): " + e.getMessage());
        }
        return code;
    }

    public static boolean savePatient(Patient p) {
        boolean status = false;
        String sql = "INSERT INTO patient (patientId, name, gender, dob, contactNumber, email, address, bloodGroup, emergencyContact, enteredBy, enteredAt, visitType, department_id, branch_id) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ?, ?)";
        try (Connection con = ConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getPatientId());
            ps.setString(2, p.getName());
            ps.setString(3, p.getGender());

            if (p.getDob() != null && !p.getDob().isEmpty()) {
                try {
                    ps.setDate(4, java.sql.Date.valueOf(p.getDob())); // expects yyyy-MM-dd
                } catch (IllegalArgumentException ex) {
                    ps.setNull(4, java.sql.Types.DATE);
                }
            } else {
                ps.setNull(4, java.sql.Types.DATE);
            }

            ps.setString(5, p.getContactNumber());
            ps.setString(6, p.getEmail());
            ps.setString(7, p.getAddress());
            ps.setString(8, p.getBloodGroup());
            ps.setString(9, p.getEmergencyContact());
            ps.setString(10, p.getEnteredBy());
            ps.setString(11, p.getVisitType());
            ps.setString(12, p.getDepartment()); // department_id
            ps.setString(13, p.getBranchId());   // branch_id

            status = ps.executeUpdate() == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL Error in savePatient(): " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in savePatient(): " + e.getMessage());
        }
        return status;
    }

    public static ArrayList<Patient> getPatientList(String keyword) {
        ArrayList<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM patient WHERE name LIKE ? OR patientId LIKE ? ORDER BY name";
        try (Connection con = ConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String search = "%" + (keyword == null ? "" : keyword) + "%";
            ps.setString(1, search);
            ps.setString(2, search);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Patient p = new Patient();
                    p.setId(rs.getInt("sno"));
                    p.setPatientId(rs.getString("patientId"));
                    p.setName(rs.getString("name"));
                    p.setGender(rs.getString("gender"));
                    Date dobDate = rs.getDate("dob");
                    p.setDob(dobDate != null ? dobDate.toString() : null);
                    p.setContactNumber(rs.getString("contactNumber"));
                    p.setEmail(rs.getString("email"));
                    p.setAddress(rs.getString("address"));
                    p.setBloodGroup(rs.getString("bloodGroup"));
                    p.setEmergencyContact(rs.getString("emergencyContact"));
                    p.setEnteredBy(rs.getString("enteredBy"));
                    p.setEnteredAt(rs.getString("enteredAt"));
                    p.setVisitType(rs.getString("visitType"));
                    p.setDepartment(rs.getString("department_id"));
                    p.setBranchId(rs.getString("branch_id"));
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in getPatientList(): " + e.getMessage());
        }
        return list;
    }

    public static Patient getPatientDetails(int sno) {
        Patient p = null;
        String sql = "SELECT * FROM patient WHERE sno = ?";
        try (Connection con = ConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, sno);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Patient();
                    p.setId(rs.getInt("sno"));
                    p.setPatientId(rs.getString("patientId"));
                    p.setName(rs.getString("name"));
                    p.setGender(rs.getString("gender"));
                    Date dobDate = rs.getDate("dob");
                    p.setDob(dobDate != null ? dobDate.toString() : null);
                    p.setContactNumber(rs.getString("contactNumber"));
                    p.setEmail(rs.getString("email"));
                    p.setAddress(rs.getString("address"));
                    p.setBloodGroup(rs.getString("bloodGroup"));
                    p.setEmergencyContact(rs.getString("emergencyContact"));
                    p.setEnteredBy(rs.getString("enteredBy"));
                    p.setEnteredAt(rs.getString("enteredAt"));
                    p.setVisitType(rs.getString("visitType"));
                    p.setDepartment(rs.getString("department_id"));
                    p.setBranchId(rs.getString("branch_id"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error in getPatientDetails(): " + e.getMessage());
        }
        return p;
    }
}
