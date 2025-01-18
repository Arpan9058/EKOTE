/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ekote.servlet;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import com.ekote.helper.ConnectionProvider;
/**
 *
 * @author sambh
 */
@WebServlet("/qrcodeserv")
public class QRcodeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String gunId = request.getParameter("gun_id"); 
        String qrCodeContent = request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/EKOTE1/gunDetails?id=" + gunId;
            if (!isGunIdValid(gunId)) {
         
                response.sendRedirect("QRCode.jsp?error=gun_not_found");
                return;
            }
        response.setContentType("image/png");
        OutputStream os = response.getOutputStream();
        os.write(getQRCodeImage(qrCodeContent, 400, 400));
        os.flush();
        os.close();
    }
        private boolean isGunIdValid(String gunId) {
    String query = "SELECT * FROM guns_info WHERE unique_identifier = ?";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/register", "root", "Sambhav@2004");
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, gunId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
                } catch (Exception e) {
              e.printStackTrace();
            }
            return false; 
        }

    private byte[] getQRCodeImage(String text, int width, int height) {
        try {
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix matrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(matrix, "PNG", outputStream);
            return outputStream.toByteArray();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
