/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daoEmployees;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String url = "jdbc:sqlserver://LAPTOP-VLMO1SNL\\LOCPTCE171503:1433;databaseName=swpgr6;encrypt=false;trustServerCertificate=true;";
            String username = "sa";
            String password = "CE171503";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }

    }
}
