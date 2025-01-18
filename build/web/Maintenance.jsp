<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Maintenance Record</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            background-color: #f4f4f4;
        }
        .container {
            margin-top: 50px;
        }
        .card-panel {
            padding: 30px;
        }
        .input-field input:focus {
            border-bottom: 1px solid #26a69a;
        }
        .card-title {
            color: #26a69a;
            font-weight: bold;
        }
    </style>
</head>
<body>
        <%
            
            String role = (String) session.getAttribute("role");
            if (role == null) {
            
                response.sendRedirect("login.jsp?error=not_logged_in");
                return; 
            }
            
        %>
        <%@include file="SideNav.jsp" %>
    <div class="container">
        <!-- Card to display the maintenance form -->
        <div class="card">
            <div class="card-content">
                <span class="card-title center-align">Add Maintenance Record</span>

                <!-- Maintenance Form -->
                <form action="updateMaintenance" method="post">
                    <div class="input-field">
                        <label for="gun_id">Unique Identifier:</label>
                        <input type="text" id="gun_id" name="gun_id" required>
                    </div>
<!--                    <div class="input-field">
                        <input type="date" id="maintenance_date" name="maintenance_date" required>
                        <label for="maintenance_date">Maintenance Date:</label>
                    </div>-->
                    <div class="input-field">
                        <input type="text" id="maintenance_freq" name="maintenance_freq" required>
                        <label for="maintenance_freq">Maintenance Freq:</label>
                    </div>

<!--                    <div class="input-field">
                        <input type="date" id="next_maintenance_date" name="next_maintenance_date" required>    
                        <label for="next_maintenance_date">Next Maintenance Date:</label>
                    </div>-->

                    <button type="submit" class="btn waves-effect waves-light teal">Add Maintenance Record</button>
                </form>
            </div>
        </div>
    </div>

    
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<script>
    $(document).ready(function() {
            $('.sidenav').sidenav();
        });
    function showSuccess() {
            var urlparam = new URLSearchParams(window.location.search);
            var success = urlparam.get('success');
            var error = urlparam.get('error');
            if (success === "Details_added") {
                alert("Details Addded Successfully!!!");
            } else if(error ==="failed"){
                alert("ERROR Gun Not Found");
            }
            else if(error === "server_error"){
                alert("Server Error");
            }
        }
window.onload = function() {
    showSuccess();
};
</script>
</html>
