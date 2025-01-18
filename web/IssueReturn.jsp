<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Issue Gun</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
        <h1 class="center-align">Issue And Return Gun</h1>

        <!-- Form to search user by ID -->
        <div class="card-panel">
            <form action="IssueReturn.jsp" method="get" class="col s12">
                <div class="input-field">
                    <label for="user_id">Enter User ID:</label>
                    <input type="text" name="user_id" required>
                </div>
                <button type="submit" class="btn waves-effect waves-light">Search User</button>
            </form>
        </div>

        <% 
            String userId = request.getParameter("user_id");
            if (userId != null) {
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String dbUrl = "jdbc:mysql://localhost:3306/register?useSSL=false&serverTimezone=UTC";
                    con = DriverManager.getConnection(dbUrl, "root", "Sambhav@2004");
                    String userQuery = "SELECT id, name, mail FROM register WHERE id = ?";
                    ps = con.prepareStatement(userQuery);
                    ps.setString(1, userId);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        String name = rs.getString("name");
                        String mail = rs.getString("mail");
        %>

        <div class="card">
            <div class="card-content">
                <span class="card-title">User Details</span>
                <p><strong>Name:</strong> <%= name %></p>
                <p><strong>Email:</strong> <%= mail %></p>
            </div>
        </div>

        <!-- Form to issue the gun -->
        <div class="card">
            <div class="card-content">
                <span class="card-title">Issue Gun</span>
                <form action="IssueServlet1" method="post">
                    <div class="input-field">
                        <input type="text" name="gun_id" required>
                        <label for="gun_id">Enter Unique Identifier Issue:</label>
                    </div>
                    <input type="hidden" name="user_id" value="<%= userId %>">
                    <button type="submit" class="btn waves-effect waves-light">Issue Gun</button>
                </form>
            </div>
        </div>

        <!-- Form to return the gun -->
        <div class="card">
            <div class="card-content">
                <span class="card-title">Return Gun</span>
                <form action="ReturnServlet" method="post">
                    <div class="input-field">
                        <input type="text" name="gun_id" required>
                        <label for="gun_id">Enter Unique Identifier to Return:</label>
                    </div>
                    <input type="hidden" name="user_id" value="<%= userId %>">
                    <button type="submit" class="btn waves-effect waves-light">Return Gun</button>
                </form>
            </div>
        </div>

        <% 
                    } else {
                        out.println("<p>User not found.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div> <!-- End of container -->

    <!-- Success/Error message handling -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script>
         $(document).ready(function() {
            $('.sidenav').sidenav();
        });   
        function showSuccess() {
            var urlparam = new URLSearchParams(window.location.search);
            var error = urlparam.get('error');
            if (error === "gun_not_found") {
                alert("Input Gun is not found in stock");
            } 
            else if (error === "user_not_found"){
                alert("User not Found");
            }   
            else if (error === "server_error"){
                alert("Server Error please try after Some time");
            } else if (error === "gun_not_available"){
                alert("Gun is not available at this time");
            }
            else if(error === "gun_already_issued"){
                alert("Gun already Issued");
            }
        }

        window.onload = function() {
            showSuccess();
        };
    </script>
</body>
</html>
