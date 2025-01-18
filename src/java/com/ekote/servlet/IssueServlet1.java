package com.ekote.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class IssueServlet1 extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("user_id");
        String uniqueIdentifier = request.getParameter("gun_id"); 
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/register", "root", "Sambhav@2004");
            String userQuery = "SELECT * FROM register WHERE id = ?";
            ps = conn.prepareStatement(userQuery);
            ps.setString(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                String gunQuery = "SELECT * FROM guns_info WHERE unique_identifier = ?";
                ps = conn.prepareStatement(gunQuery);
                ps.setString(1, uniqueIdentifier);
                rs = ps.executeQuery();
                if (rs.next()) {
                    int gunId = rs.getInt("gun_id");
                    String checkIssuedQuery = "SELECT COUNT(*) FROM issue WHERE gun_id = ? AND unique_identifier = ? AND status = 'issued' AND return_date IS NULL";
                    ps = conn.prepareStatement(checkIssuedQuery);
                    ps.setInt(1, gunId);
                    ps.setString(2, uniqueIdentifier);
                    rs = ps.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        response.sendRedirect("IssueReturn.jsp?error=gun_already_issued");
                    } else {
                        String quantityQuery = "SELECT quantity FROM guns WHERE id = ?";
                        ps = conn.prepareStatement(quantityQuery);
                        ps.setInt(1, gunId);
                        rs = ps.executeQuery();
                        if (rs.next() && rs.getInt("quantity") > 0) {
                            String updateGunQuery = "UPDATE guns SET quantity = quantity - 1 WHERE id = ?";
                            ps = conn.prepareStatement(updateGunQuery);
                            ps.setInt(1, gunId);
                            ps.executeUpdate();
                            String insertIssueQuery = "INSERT INTO issue (user_id, gun_id, unique_identifier, issue_date, status) VALUES (?, ?, ?, NOW(), 'issued')";
                            ps = conn.prepareStatement(insertIssueQuery);
                            ps.setString(1, userId);
                            ps.setInt(2, gunId); 
                            ps.setString(3, uniqueIdentifier); 
                            ps.executeUpdate();
                            response.sendRedirect("IssueReturn.jsp?success=gun_issued");
                        } else {
                            response.sendRedirect("IssueReturn.jsp?error=gun_not_available");
                        }
                    }
                } else {
                    response.sendRedirect("IssueReturn.jsp?error=gun_not_found");
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
