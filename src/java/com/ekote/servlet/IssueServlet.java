package com.ekote.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class IssueServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("user_id");
        String gunId = request.getParameter("gun_id");
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/register", "root", "Sambhav@2004");
            String p = "SELECT * FROM register WHERE id = ?";
            ps = conn.prepareStatement(p);
            ps.setString(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                String q = "SELECT * FROM guns WHERE id = ?";
                ps = conn.prepareStatement(q);
                ps.setString(1, gunId);
                rs = ps.executeQuery();
                if (rs.next() && rs.getInt("quantity") > 0) {
                    String updateGunQuery = "UPDATE guns SET quantity = quantity - 1 WHERE id = ?";
                    ps = conn.prepareStatement(updateGunQuery);
                    ps.setString(1, gunId);
                    ps.executeUpdate();
                    String insertIssueQuery = "INSERT INTO issue (user_id, gun_id) VALUES (?, ?)";
                    ps = conn.prepareStatement(insertIssueQuery);
                    ps.setString(1, userId);
                    ps.setString(2, gunId);
                    ps.executeUpdate();
                    response.sendRedirect("inventory_management.jsp?success=gun_issued");
                } else {
                    response.sendRedirect("IssueReturn.jsp?error=gun_not_available");
                }
            } else {
                response.sendRedirect("IssueReturn.jsp?error=user_not_found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("IssueReturn.jsp?error=server_error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
