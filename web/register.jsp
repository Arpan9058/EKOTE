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
<body onload="showSuccessAlert()">
    <%@include file="normalnav.jsp" %>
    <div class="row">
        <div class="col s12 m6 offset-m3"> <!-- Centered column -->
            <div class="card">
                <div class="card-content black-text">
                    <h4 style="text-align: center; margin-bottom: -10px">Register</h4>
                </div>
                <div class="card-content">
                    <form action='RegisterServlet' method='post'>
                        <div class="form-field">
                            <input type="text" name="user_name" placeholder="Enter Name" required/>
                        </div>
                        <div class="form-field">
                            <input type="email" name="user_mail" placeholder="Enter E-mail" required/>
                        </div>
                        <div class="form-field">
                            <input type="password" name="user_pass" placeholder="Enter Password" required/>
                        </div>
                        <div class="form-field">
                            <input type="text" name="user_id" placeholder="Enter ID Card No." required/>
                        </div>
                     
                        <div class="form-field">
                            <div class="input-field">
                                <select name="user_role" required>
                                    <option value="" disabled selected>Select Role</option>
                                    <option value="admin">admin</option>
                                    <option value="user">user</option>
                                </select>
                                
                            </div>
                        </div>
                        <div class="form-field">
                            <button type="submit" class="btn">Register</button>
                            <button type="reset" class="btn">Reset</button>
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
        // Function to display the success alert if the query parameter "success" is present
        function showSuccessAlert() {
            var urlParams = new URLSearchParams(window.location.search);
            var successMessage = urlParams.get('success'); // Get the 'success' parameter from URL
            var errorMessage = urlParams.get('error');

            if (successMessage === 'registration_successful') {
                alert('Registration successful! You can now log in.');
            }else if (errorMessage === 'duplicate_mail') {
            alert('Email is already Registered');
        }
        }
    </script>
</body>
</html>
