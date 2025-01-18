package com.ekote.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/DeleteGunServlet")
public class DeleteGunServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String gunIdParam = request.getParameter("gun_id");
        
        int gunId = Integer.parseInt(gunIdParam);
        String url = "jdbc:mysql://localhost:3306/register?useSSL=false&serverTimezone=UTC";
        String username = "root";
        String password = "Sambhav@2004";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
            String sql = "DELETE FROM guns WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, gunId); 
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Gun deleted successfully.");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Gun not found with ID: " + gunId);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error while deleting gun.");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
