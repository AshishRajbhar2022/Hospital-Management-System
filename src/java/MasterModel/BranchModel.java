package MasterModel;

import hospital.ConnectionPool;
import java.sql.*;
import java.util.*;

public class BranchModel {

    // Generate next branch ID like BR01, BR02, BR03...
    private String generateBranchId() throws SQLException {
        try (Connection conn = ConnectionPool.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT MAX(CAST(SUBSTRING(id, 3) AS UNSIGNED)) FROM branch");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int nextId = rs.getInt(1) + 1;
                return String.format("BR%02d", nextId); // BR01, BR02, BR10...
            } else {
                return "BR01";
            }
        }
    }

    // Add branch with formatted ID
    public void addBranch(String name) throws SQLException {
        String id = generateBranchId();

        try (Connection conn = ConnectionPool.getConnection();
             PreparedStatement ps = conn.prepareStatement("INSERT INTO branch (id, name) VALUES (?, ?)")) {
            ps.setString(1, id);
            ps.setString(2, name);
            ps.executeUpdate();
        }
    }

    // Retrieve all branches
    public Map<String, String> getAllBranches() throws SQLException {
        Map<String, String> branches = new LinkedHashMap<>();

        try (Connection conn = ConnectionPool.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT id, name FROM branch ORDER BY id ASC");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                branches.put(rs.getString("id"), rs.getString("name"));
            }
        }

        return branches;
    }
}
