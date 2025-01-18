/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ekote.servlet;
import com.ekote.entities.Gun;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.*;
import com.google.gson.Gson;
/**
 *
 * @author sambh
 */
//@WebServlet("/DisplayInventoryServlet")
public class DisplayInventoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Gun> gunList = new ArrayList<>();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/register?useSSL=false&serverTimezone=UTC", "root", "Sambhav@2004");
            String sql = "SELECT * FROM guns";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Gun gun = new Gun();
                    gun.setId(rs.getInt("id"));
                    gun.setGunName(rs.getString("gun_name"));
                    gun.setModel(rs.getString("model"));
                    gun.setQuantity(rs.getInt("quantity"));
                    gun.setRegisteredBy(rs.getString("registered_by"));
                    gunList.add(gun);
                }
            }
             String json = new Gson().toJson(gunList);
            response.setContentType("application/json");
            response.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace();
           response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching inventory");
        }
    }
}
