<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registration Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
   <style>
        .card {
            max-width: 400px; 
            margin: 50px auto; 
            border-radius: 15px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.3);
           
        }
        .card-title {
            text-align: center;
            margin-bottom: 20px; 
        }
        .form-field {
            margin-bottom: 15px; 
        }
    </style>
</head>
<body>
    <%@include file="normalnav.jsp" %>
    <div class="row">
        <div class="col s12 m6 offset-m3"> <!-- Centered column -->
            <div class="card">
                <div class="card-content black-text">
                    <h4 style="text-align: center">Login</h4>
                </div>
                <div class="card-content">
                    <form action='LoginServlet' method='post'>
                        <div class="form-field" style="margin-top:-30px">
                            <input type="email" name="user_mail" placeholder="Enter E-mail" required/>
                        </div>
                        <div class="form-field">
                            <input type="password" name="user_pass" placeholder="Enter Password" required/>
                        </div>
                        <div class="form-field" style="justify-content: center; display:flex">
                            <button type="submit" class="btn">login</button>
                        </div>
                        <div style="display: flex; justify-content: center; align-items: center;">
                            <a href="register.jsp">signup</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script>
        $(document).ready(function(){
            $('select').formSelect();
        });
        function showError() {
            var urlparam = new URLSearchParams(window.location.search);
            var errormessage = urlparam.get('error');

            // Check if there's an error message in the URL
            if (errormessage === "not_admin") {
                alert("User cannot login to the portal");
            } else if (errormessage === "invalid_credentials") {
                alert("Invalid credentials. Please try again.");
            } else if (errormessage === "admin_not_found") {
                alert("Admin not found. Please register first.");
            } else if (errormessage === "sql_error") {
                alert("A server error occurred. Please try again later.");
            } else if (errormessage === "driver_not_found") {
                alert("Database driver not found. Please contact support.");
            }
        }

// Ensure the function is called when the page has loaded
window.onload = function() {
    showError();
};
    </script>
</body>
</html>
