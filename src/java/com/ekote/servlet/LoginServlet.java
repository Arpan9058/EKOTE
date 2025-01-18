package com.ekote.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mail = request.getParameter("user_mail");
        String pass = request.getParameter("user_pass");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/register", "root", "Sambhav@2004");
            String sql = "SELECT pass, id, role FROM register WHERE mail = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, mail);
            rs = ps.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("pass"); // Get the stored password (hashed)
                String role = rs.getString("role"); // Get the user role (admin/user)
                if (BCrypt.checkpw(pass, storedPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user_id", rs.getString("id"));
                    session.setAttribute("role", role); // Store user role
                    if ("admin".equals(role)) {
                        response.sendRedirect("Dashboard.jsp");
                    } else {
                        response.sendRedirect("login.jsp?error=not_admin");
                    }
                } else {
                    response.sendRedirect("login.jsp?error=invalid_credentials");
                }
            } else {
                response.sendRedirect("login.jsp?error=admin_not_found");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=sql_error");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=driver_not_found");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=server_error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
