/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import hospital.ConnectionPool;
import java.sql.*;

public class Admin {
    public static boolean validate(String username, String password) {
        boolean result = false;
        try (Connection con = ConnectionPool.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT * FROM admin WHERE username = ? AND password = ?")) {

            ps.setString(1, username);
            ps.setString(2, password); // In production, use hashed password
            ResultSet rs = ps.executeQuery();
            result = rs.next();
            rs.close();
        } catch (Exception e) {
            System.err.println("Admin.validate() error: " + e);
        }
        return result;
    }
}
