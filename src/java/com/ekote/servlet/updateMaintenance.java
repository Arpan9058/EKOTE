/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ekote.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.*;
import java.sql.*;

/**
 *
 * @author sambh
 */
public class updateMaintenance extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String gun_id = request.getParameter("gun_id");
        String freq = request.getParameter("maintenance_freq");
        int frequency = Integer.parseInt(freq);
        
//        Date main = Date.valueOf(date);
//        Date nextmain = Date.valueOf(nextdate);
        Connection con = null;
        PreparedStatement ps= null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/register", "root", "Sambhav@2004");
            String p = "SELECT manufactured_date from guns_info where unique_identifier = ?";
            ps = con.prepareStatement(p);
            ps.setString(1,gun_id);
            ResultSet rs = ps.executeQuery();
            Date currentMaintenanceDate = null;
            if (rs.next()) {
                currentMaintenanceDate = rs.getDate("manufactured_date");
            }
            LocalDate maintenanceDate = currentMaintenanceDate.toLocalDate();
            LocalDate nextMaintenanceDate = maintenanceDate.plusMonths(frequency);
            String updateQuery = "UPDATE guns_info SET maintenance_date = ?, next_maintenance_date = ?, maintenance_freq = ? WHERE unique_identifier = ?";
            ps = con.prepareStatement(updateQuery);
            ps.setDate(1, Date.valueOf(maintenanceDate)); 
            ps.setDate(2, Date.valueOf(nextMaintenanceDate)); 
            ps.setInt(3, frequency);
            ps.setString(4, gun_id);
            int rows = ps.executeUpdate();
            if(rows>0){
            response.sendRedirect("Maintenance.jsp?success=Details_added");
            }
            else 
            response.sendRedirect("Maintenance.jsp?error=failed");
            
        }catch(Exception E){
            E.printStackTrace();
            response.getWriter().println("Database Error: " + E.getMessage());
//            response.sendRedirect("Maintenance.jsp?error=server_error");
        }
        finally{
            if(ps!=null)
                try{
                ps.close();
                }catch(SQLException e){
                    e.printStackTrace();
                }
            if(con!= null)
                try{
                con.close();
                }catch(SQLException e){
                    e.printStackTrace();
                }
        }
        
    }

}
