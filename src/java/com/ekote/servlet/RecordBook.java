package com.ekote.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.ekote.entities.*;
import com.ekote.helper.ConnectionProvider;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/recordBook")
public class RecordBook extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<GunDetails> recordBookList = getRecordBookDetails(); 
        request.setAttribute("recordBookList", recordBookList);  
        RequestDispatcher dispatcher = request.getRequestDispatcher("Logs.jsp");
        dispatcher.forward(request, response);
    }

    private List<GunDetails> getRecordBookDetails() {
    List<GunDetails> recordBookList = new ArrayList<>();
    
    
    String query = "SELECT r.id AS user_id, r.name AS user_name, r.mail AS user_email, r.role AS user_role, "
                 + "gi.unique_identifier AS gun_identifier, g.gun_name, g.model, g.quantity, g.registered_by, "
                 + "gi.manufactured_date, gi.manufactured_place, gi.maintenance_date, "
                 + "gi.next_maintenance_date, i.issue_date, i.return_date, i.status "
                 + "FROM register r "
                 + "JOIN issue i ON r.id = i.user_id "
                 + "JOIN guns g ON g.id = i.gun_id "
                 + "JOIN guns_info gi ON gi.gun_id = g.id "
                 + "WHERE gi.unique_identifier = i.unique_identifier;";  

    try {
        Connection conn = ConnectionProvider.getConnection();
        PreparedStatement stmt = conn.prepareStatement(query);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            GunDetails gunDetails = new GunDetails();
            gunDetails.setGunIdentifier(rs.getString("gun_identifier"));
            gunDetails.setGunName(rs.getString("gun_name"));
            gunDetails.setModel(rs.getString("model"));
//            gunDetails.setQuantity(rs.getInt("quantity"));
            gunDetails.setRegisteredBy(rs.getString("registered_by"));
            gunDetails.setManufacturedDate(rs.getString("manufactured_date"));
            gunDetails.setManufacturedPlace(rs.getString("manufactured_place"));
            gunDetails.setMaintenanceDate(rs.getString("maintenance_date"));
            gunDetails.setNextMaintenanceDate(rs.getString("next_maintenance_date"));
            gunDetails.setIssueDate(rs.getString("issue_date"));
            gunDetails.setReturnDate(rs.getString("return_date"));
            gunDetails.setStatus(rs.getString("status"));
            gunDetails.setUserName(rs.getString("user_name"));
            gunDetails.setUserEmail(rs.getString("user_email"));
            gunDetails.setUserRole(rs.getString("user_role"));

            recordBookList.add(gunDetails);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return recordBookList;
}


}
