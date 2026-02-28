/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hospital;

import java.sql.Connection;
import java.sql.DriverManager;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ConnectionPool {

    public static Connection getConnection() {
        Connection con = null;
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/hospitalDB");
            con = ds.getConnection();
        } catch (Exception e) {
            System.err.println("JNDI connection failed, trying fallback: " + e.getMessage());
            con = getNewDBConnection();
        }
        return con;
    }

    public static Connection getNewDBConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_db", "root", "ashish@2022");
        } catch (Exception e) {
            System.err.println("Fallback connection failed: " + e.getMessage());
        }
        return con;
    }
}
