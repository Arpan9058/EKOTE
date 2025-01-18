<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Generate QR Code</title>
    <!-- Materialize CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .container {
            margin-top: 50px;
        }
        .card-panel {
            padding: 30px;
            text-align: center;
        }
        .input-field input {
            border-bottom: 2px solid #26a69a;
        }
        h5 {
            font-weight: bold;
            color: #26a69a;
        }
        .btn {
            background-color: #26a69a;
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
        <div class="row">
            <div class="col s12 m6 offset-m3">
                <!-- Card panel for the form -->
                <div class="card-panel">
                    <h5>Generate QR Code</h5>
                    <form action="${pageContext.request.contextPath}/qrcodeserv" method="get">
                        <div class="input-field">
                            <input type="text" name="gun_id" id="gun_id" required>
                            <label for="gun_id">Enter Unique Identifier : </label>
                        </div>
                        <div>
                            <button type="submit" class="btn waves-effect waves-light">Generate QR Code</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Materialize JS -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    
    
    <script>
    $(document).ready(function() {
            $('.sidenav').sidenav();
        });
    function showSuccess() {
            var urlparam = new URLSearchParams(window.location.search);
            var error = urlparam.get('error');
            if(error === "gun_not_found"){
                alert("Gun not Found");
            }
        }
window.onload = function() {
    showSuccess();
};
</script>
</body>
</html>
