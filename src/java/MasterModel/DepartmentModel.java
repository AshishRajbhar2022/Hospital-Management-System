package MasterModel;

import hospital.ConnectionPool;
import java.sql.*;
import java.util.*;

public class DepartmentModel {

    // Generate next department ID like DP01, DP02, ...
    private String generateDepartmentId() throws SQLException {
        String sql = "SELECT MAX(CAST(SUBSTRING(id, 3) AS UNSIGNED)) FROM department";
        try (Connection conn = ConnectionPool.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int max = rs.getInt(1);
                int next = (rs.wasNull()) ? 1 : (max + 1);
                return String.format("DP%02d", next);
            } else {
                return "DP01";
            }
        }
    }

    // Add department with generated string ID (DP01-style)
    public void addDepartment(String name) throws SQLException {
        String id = generateDepartmentId();
        String sql = "INSERT INTO department (id, name) VALUES (?, ?)";
        try (Connection conn = ConnectionPool.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setString(2, name);
            ps.executeUpdate();
        }
    }

    // Link department to branch using string IDs
    public void linkToBranch(String branchId, String deptId) throws SQLException {
        String sql = "INSERT INTO branch_department (branch_id, department_id) VALUES (?, ?)";
        try (Connection conn = ConnectionPool.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, branchId);
            ps.setString(2, deptId);
            ps.executeUpdate();
        }
    }

    // Return all departments as Map<id, name>
    public Map<String, String> getAllDepartments() throws SQLException {
        Map<String, String> departments = new LinkedHashMap<>();
        String sql = "SELECT id, name FROM department ORDER BY id ASC";
        try (Connection conn = ConnectionPool.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                departments.put(rs.getString("id"), rs.getString("name"));
            }
        }
        return departments;
    }

    // Return departments linked to a branch as a list of maps (id and name)
    public List<Map<String, Object>> getDepartmentsByBranchAsJson(String branchId) throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT d.id, d.name FROM department d JOIN branch_department bd ON d.id = bd.department_id WHERE bd.branch_id = ?";
        try (Connection conn = ConnectionPool.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, branchId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> dept = new HashMap<>();
                    dept.put("id", rs.getString("id"));
                    dept.put("name", rs.getString("name"));
                    list.add(dept);
                }
            }
        }
        return list;
    }
}
