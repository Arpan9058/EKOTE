<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gun Information Form</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            /*padding: 20px;*/
        }

        .container {
            width: 50%;
            margin: auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: white;
        }

        .form-container {
            margin-top: 20px;
        }

        table {
            width: 100%;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        input[type="text"], input[type="number"], input[type="date"] {
            width: 100%;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            width: 100%;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <%@include file="SideNav.jsp" %>
    <%
            
            String role = (String) session.getAttribute("role");
            if (role == null) {
            
                response.sendRedirect("login.jsp?error=not_logged_in");
                return; 
            }
            
        %>
<div class="container">
    <h4 class="center-align" style="margin-top: -5px">Gun Information Form</h4>
    <form id="gunForm" method="post" action="" class="form-container">
        <div class="input-field">
            <input type="text" id="gunName" name="gunName" required>
            <label for="gunName">Gun Name</label>
        </div>
        <div class="input-field">
            <input type="text" id="gunModel" name="gunModel" required>
            <label for="gunModel">Gun Model</label>
        </div>
        <div class="input-field">
            <input type="number" id="quantity" name="quantity" min="1" required>
            <label for="quantity">Quantity</label>
        </div>
        <input type="submit" class="btn" value="Generate Table">
    </form>
    <% 
        String gunName = request.getParameter("gunName");
        String gunModel = request.getParameter("gunModel");
        String quantityStr = request.getParameter("quantity");
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/register?useSSL=false&serverTimezone=UTC", "root", "Sambhav@2004");
        String q = "SELECT gi.unique_identifier FROM guns_info gi JOIN guns g ON gi.gun_id = g.id WHERE g.gun_name = ? AND g.model = ? ORDER BY gi.unique_identifier DESC LIMIT 1";
        PreparedStatement ps = conn.prepareStatement(q);
        ps.setString(1, gunName);
        ps.setString(2, gunModel);
        ResultSet rs = ps.executeQuery();
        String Lastid = null;
        int x = 0;
        while(rs.next()){
            Lastid = rs.getString("gi.unique_identifier");
        }
        if(Lastid != null) {
            String[] parts = Lastid.split("_");
            x = Integer.parseInt(parts[2].substring(1)) + 1;
        }
        int quant = 0;
        String s = "Select quantity from guns where gun_name = ? and model = ?";
        PreparedStatement stmt = conn.prepareStatement(s);
        stmt.setString(1, gunName);
        stmt.setString(2, gunModel);
        ResultSet res = stmt.executeQuery();
        if (res.next()) {
            quant = res.getInt("quantity");
        }       
        if (gunName != null && gunModel != null && quantityStr != null && !quantityStr.isEmpty()) {
            int quantity = Integer.parseInt(quantityStr);
            if(quantity<=quant-x){
                out.println("<h5 class='center-align'>Gun Information Table</h5>");
                out.println("<form method='post' action='AddSpecificServlet'>"); 
                out.println("<table class='highlight'>");     
                out.println("<thead><tr><th>Gun Identifier</th><th>Manufactured Date</th><th>Manufactured Place</th></tr></thead>");
                out.println("<tbody>");
                for (int i = 0; i < quantity; i++) {
                    String newIdentifier = gunName + "_" + gunModel + "_X" + String.format("%03d", x + i);
                    out.println("<tr>");
                    out.println("<td>" + newIdentifier + "</td>");
                    out.println("<td><input type='date' name='manufacturedDate" + i + "' class='datepicker' required></td>");
                    out.println("<td><input type='text' name='manufacturedPlace" + i + "' class='validate' required></td>");
                    out.println("</tr>");
                }
                out.println("</tbody>");
                out.println("</table>");
                out.println("<input type='submit' value='Submit Guns Information' class='btn'>");
                out.println("<input type='hidden' name='gunName' value='" + gunName + "'>");
                out.println("<input type='hidden' name='gunModel' value='" + gunModel + "'>");
                out.println("<input type='hidden' name='quantity' value='" + quantityStr + "'>");
                out.println("<input type='hidden' name='last' value='" + x + "'>");
                out.println("</form>");
            }
            else{
                out.println("<h3>Gun Quantity Exceed the Stock</h3>");
            }
        }
    %>

</div>

<!-- Materialize JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
 <script>
         $(document).ready(function() {
            $('.sidenav').sidenav();
        });   
 </script>
</body>
</html>
