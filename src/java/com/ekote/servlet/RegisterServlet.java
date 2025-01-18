package com.ekote.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("user_name");
        String mail = request.getParameter("user_mail");
        String pass = request.getParameter("user_pass");
        String id = request.getParameter("user_id");
        String role = request.getParameter("user_role");
        String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt(12));  
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/register", "root", "Sambhav@2004");
            String checkEmailQuery = "SELECT * FROM register WHERE mail = ?";
            ps = conn.prepareStatement(checkEmailQuery);
            ps.setString(1, mail);
            rs = ps.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register.jsp?error=duplicate_mail");
                return;
            }
            String sql = "INSERT INTO register (id, name, pass, mail, role) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, name);
            ps.setString(3, hashedPassword);
            ps.setString(4, mail);
            ps.setString(5, role);
            ps.executeUpdate();
            
            response.sendRedirect("register.jsp?success=registration_successful");
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("An error occurred. Please try again later" + e.getMessage());
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
