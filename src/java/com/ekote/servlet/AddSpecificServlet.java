package com.ekote.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;

public class AddSpecificServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {        
        String gunName = request.getParameter("gunName");
        String gunModel = request.getParameter("gunModel");
        String quantityStr = request.getParameter("quantity");
        int last = Integer.parseInt(request.getParameter("last"));

        if (gunName == null || gunModel == null || quantityStr == null || gunName.isEmpty() || gunModel.isEmpty() || quantityStr.isEmpty()) {
            response.getWriter().println("Error: Gun name, model, or quantity is missing.");
            return;
        }

        int quantity = Integer.parseInt(quantityStr);

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/register", "root", "Sambhav@2004")) {

            String getGunIdQuery = "SELECT id FROM guns WHERE gun_name = ? AND model = ?";
            try (PreparedStatement ps = conn.prepareStatement(getGunIdQuery)) {
                ps.setString(1, gunName);
                ps.setString(2, gunModel);
                ResultSet rs = ps.executeQuery();

                if (!rs.next()) {
                    response.getWriter().println("Error: Gun with the specified name and model not found.");
                    return;
                }

                int gunId = rs.getInt("id");

                for (int i = 0; i < quantity; i++) {
                    String uniqueIdentifier = gunName + "_" + gunModel + "_X" + String.format("%03d", last + i);
                    String manufacturedDate = request.getParameter("manufacturedDate" + i);
                    String manufacturedPlace = request.getParameter("manufacturedPlace" + i);
//                    String maintenanceDate = request.getParameter("maintenanceDate" + i);

                    String insertQuery = "INSERT INTO guns_info (unique_identifier, gun_id, manufactured_date, manufactured_place) VALUES (?, ?, ?, ?)";

                    try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
                        stmt.setString(1, uniqueIdentifier);
                        stmt.setInt(2, gunId);
                        stmt.setDate(3, Date.valueOf(manufacturedDate));
                        stmt.setString(4, manufacturedPlace);
//                        stmt.setDate(5, Date.valueOf(maintenanceDate));

                        stmt.executeUpdate();
                    }
                }
                response.getWriter().println("Gun information successfully added.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());
        }
    }
}
