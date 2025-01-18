package com.ekote.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class ReturnServlet extends HttpServlet {
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
            String userCheckQuery = "SELECT * FROM register WHERE id = ?";
            ps = conn.prepareStatement(userCheckQuery);
            ps.setString(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                String checkIssuedGunQuery = "SELECT id FROM issue WHERE user_id = ? AND unique_identifier = ? AND status = 'issued' ORDER BY issue_date DESC LIMIT 1";
                ps = conn.prepareStatement(checkIssuedGunQuery);
                ps.setString(1, userId);
                ps.setString(2, uniqueIdentifier); 
                rs = ps.executeQuery();
                if (rs.next()) {
                    int issueId = rs.getInt("id");
                    String updateIssueQuery = "UPDATE issue SET return_date = NOW(), status = 'returned' WHERE id = ?";
                    ps = conn.prepareStatement(updateIssueQuery);
                    ps.setInt(1, issueId);
                    int rowsUpdated = ps.executeUpdate();
                    if (rowsUpdated > 0) {
                        String getGunIdQuery = "SELECT gun_id FROM guns_info WHERE unique_identifier = ?";
                        ps = conn.prepareStatement(getGunIdQuery);
                        ps.setString(1, uniqueIdentifier);
                        rs = ps.executeQuery();
                        if (rs.next()) {
                            int gunId = rs.getInt("gun_id");
                            String updateGunQuery = "UPDATE guns SET quantity = quantity + 1 WHERE id = ?";
                            ps = conn.prepareStatement(updateGunQuery);
                            ps.setInt(1, gunId);
                            ps.executeUpdate();
                            response.sendRedirect("inventory_management.jsp?success=gun_returned");
                        } else {
                            response.sendRedirect("IssueReturn.jsp?error=gun_not_found");
                        }
                    } else {
                        response.sendRedirect("IssueReturn.jsp?error=unable_to_update_issue");
                    }
                } else {
                    response.sendRedirect("IssueReturn.jsp?error=gun_not_issued");
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
