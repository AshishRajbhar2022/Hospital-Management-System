package model;

import hospital.ConnectionPool;
import java.sql.*;

public class Doctor {
    private int id;
    private String name;
    private String specialization;
    private String phone;
    private String dob;
    private String address;
    private String joinedDate;
    private String email;
    private int branchId;       // ✅ NEW
    private int departmentId;   // ✅ NEW

    // Constructors
    public Doctor() {}

    public Doctor(String name, String specialization, String phone, String dob, String address,
                  String joinedDate, String email, int branchId, int departmentId) {
        this.name = name;
        this.specialization = specialization;
        this.phone = phone;
        this.dob = dob;
        this.address = address;
        this.joinedDate = joinedDate;
        this.email = email;
        this.branchId = branchId;
        this.departmentId = departmentId;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getJoinedDate() { return joinedDate; }
    public void setJoinedDate(String joinedDate) { this.joinedDate = joinedDate; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getBranchId() { return branchId; }
    public void setBranchId(int branchId) { this.branchId = branchId; }

    public int getDepartmentId() { return departmentId; }
    public void setDepartmentId(int departmentId) { this.departmentId = departmentId; }

    // ✅ Check for duplicate doctor by email or phone
    public boolean isDuplicate() {
        boolean exists = false;
        try (Connection conn = ConnectionPool.getConnection()) {
            String sql = "SELECT id FROM doctors WHERE email = ? OR phone = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, this.email);
            stmt.setString(2, this.phone);
            ResultSet rs = stmt.executeQuery();
            exists = rs.next();
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.err.println("Error checking duplicate: " + e.getMessage());
        }
        return exists;
    }

    // ✅ Save doctor to database
    public boolean save() {
        boolean success = false;
        try (Connection conn = ConnectionPool.getConnection()) {
            String sql = "INSERT INTO doctors (name, specialization, phone, dob, address, joined_date, email, branch_id, department_id) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, this.name);
            stmt.setString(2, this.specialization);
            stmt.setString(3, this.phone);
            stmt.setDate(4, Date.valueOf(this.dob));
            stmt.setString(5, this.address);
            stmt.setDate(6, Date.valueOf(this.joinedDate));
            stmt.setString(7, this.email);
            stmt.setInt(8, this.branchId);
            stmt.setInt(9, this.departmentId);
            success = stmt.executeUpdate() > 0;
            stmt.close();
        } catch (Exception e) {
            System.err.println("Error saving doctor: " + e.getMessage());
        }
        return success;
    }
}
