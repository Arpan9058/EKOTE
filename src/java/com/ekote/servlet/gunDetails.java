package com.ekote.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.*;
import java.io.*;
import java.sql.*;
import com.ekote.entities.GunDetails;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/gunDetails")
public class gunDetails extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uniqueIdentifier = request.getParameter("id");  
        List<GunDetails> gunDetailsList = getGunDetails(uniqueIdentifier);  
        request.setAttribute("gunDetailsList", gunDetailsList);  
        RequestDispatcher dispatcher = request.getRequestDispatcher("gunInfo.jsp");  
        dispatcher.forward(request, response);
    }

    private List<GunDetails> getGunDetails(String uniqueIdentifier) {
        List<GunDetails> gunDetailsList = new ArrayList<>();
        String query = "SELECT r.name, r.mail, r.role, g.gun_name, g.model, g.quantity, g.registered_by, "
                     + "gi.maintenance_date, gi.next_maintenance_date, i.issue_date, i.return_date, i.status "
                     + "FROM register r "
                     + "JOIN issue i ON r.id = i.user_id "
                     + "JOIN guns g ON g.id = i.gun_id "
                     + "JOIN guns_info gi ON gi.gun_id = g.id "
                     + "WHERE gi.unique_identifier = ?";  
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/register", "root", "Sambhav@2004");
            stmt = conn.prepareStatement(query);
            stmt.setString(1, uniqueIdentifier);  
            rs = stmt.executeQuery();
            while (rs.next()) {
                GunDetails gunDetails = new GunDetails();
                gunDetails.setGunIdentifier(uniqueIdentifier);
                gunDetails.setGunName(rs.getString("gun_name"));
                gunDetails.setModel(rs.getString("model"));
                gunDetails.setQuantity(rs.getInt("quantity"));
                gunDetails.setRegisteredBy(rs.getString("registered_by"));
                gunDetails.setMaintenanceDate(rs.getString("maintenance_date"));
                gunDetails.setNextMaintenanceDate(rs.getString("next_maintenance_date"));
                gunDetails.setIssueDate(rs.getString("issue_date"));
                gunDetails.setReturnDate(rs.getString("return_date"));
                gunDetails.setStatus(rs.getString("status"));
                gunDetails.setUserName(rs.getString("name"));
                gunDetails.setUserEmail(rs.getString("mail"));
                gunDetails.setUserRole(rs.getString("role"));
                gunDetailsList.add(gunDetails); 
            }
        } catch (Exception e) {
            e.printStackTrace();  
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();  // Handle cleanup exceptions
            }
        }

        return gunDetailsList;  // Return the list of gun details
    }
}
