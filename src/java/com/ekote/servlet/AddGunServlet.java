package com.ekote.servlet;

import java.sql.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddGunServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String gunName = request.getParameter("gun_name");
        String model = request.getParameter("model");
        String quantityStr = request.getParameter("quantity");
        String registeredBy = request.getParameter("registered_by");
        String operation = request.getParameter("operation"); 
        int quantity = 0;
        try {
            quantity = Integer.parseInt(quantityStr); 
        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Invalid quantity format\"}");
            return;
        }
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/register?useSSL=false&serverTimezone=UTC", 
                "root", "Sambhav@2004"
            );
            String checkSql = "SELECT * FROM guns WHERE gun_name = ? AND model = ?";
            PreparedStatement psCheck = conn.prepareStatement(checkSql);
            psCheck.setString(1, gunName);
            psCheck.setString(2, model);
            ResultSet rs = psCheck.executeQuery();
            if (rs.next()) {
                int currentQuantity = rs.getInt("quantity");
                int updatedQuantity = (operation.equals("subtract")) ? currentQuantity - quantity : currentQuantity + quantity;
                if (updatedQuantity < 0) {
                    response.setContentType("application/json");
                    response.getWriter().write("{\"status\":\"error\", \"message\":\"Not enough guns in inventory to subtract\"}");
                    return;
                }
                String updateSql = "UPDATE guns SET quantity = ? WHERE gun_name = ? AND model = ?";
                PreparedStatement psUpdate = conn.prepareStatement(updateSql);
                psUpdate.setInt(1, updatedQuantity);
                psUpdate.setString(2, gunName);
                psUpdate.setString(3, model);
                psUpdate.executeUpdate();
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\", \"message\":\"Gun quantity updated successfully!\"}");
            } else {
                String insertSql = "INSERT INTO guns (gun_name, model, quantity, registered_by) VALUES (?, ?, ?, ?)";
                PreparedStatement psInsert = conn.prepareStatement(insertSql);
                psInsert.setString(1, gunName);
                psInsert.setString(2, model);
                psInsert.setInt(3, quantity);
                psInsert.setString(4, registeredBy);
                psInsert.executeUpdate();
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\", \"message\":\"Gun added to inventory!\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
    }
}
