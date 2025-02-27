<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Support</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 900px;
            /*margin-top: 50px;*/
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h4 {
            text-align: center;
            color: #4CAF50;
        }
        .section {
            margin-bottom: 30px;
        }
        .section h5 {
            color: #4CAF50;
        }
        .faq-item {
            margin-bottom: 20px;
        }
        .contact-info {
            background-color: #4CAF50;
            color: white;
            padding: 20px;
            border-radius: 5px;
        }
        .contact-info a {
            color: white;
            text-decoration: none;
        }
        footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 10px;
            margin-top: 40px;
        }
    </style>
</head>
<body>
     <%@include file="SideNav.jsp" %>
    <div class="container">
        <h4>Help & Support</h4>
        <p>Welcome to our Help & Support page! Here you’ll find quick answers to common questions and useful information to help you get the most out of the platform.</p>

        <div class="section">
            <h5>Frequently Asked Questions</h5>
            <div class="faq-item">
                <p><strong>1. I can’t log in, what should I do?</strong></p>
                <ul>
                    <li>Double-check your email and password. If they’re correct and you’re still unable to log in, please reach out to us at <strong>support@example.com</strong> for assistance.</li>
                </ul>
            </div>
            <div class="faq-item">
                <p><strong>2. How to Add a Maintenance Record for a Gun?</strong></p>
                <ul>
                    <li>Log in and go to the <a href="<%= request.getContextPath() %>/Maintenance.jsp">Maintenance Page</a>.</li>
                    <li>Select the Gun ID, enter the maintenance date and next maintenance date, then click <strong>Add Record</strong>.</li>
                </ul>
            </div>
            <div class="faq-item">
                <p><strong>3. How to Scan a QR Code for Gun Details?</strong></p>
                <ul>
                    <li>Use any QR code scanner to scan the QR Code attached to the gun.</li>
                    <li>Scan the code to view detailed information about the gun, including its maintenance history.</li>
                </ul>
            </div>
        </div>
        <div class="section">
            <h5>Contact Support</h5>
            <div class="contact-info">
                <p>For further assistance, contact our support team:</p>
                <ul>
                    <li><strong>Email:</strong> <a href="mailto:sambhav9058@gmail.com">sambhav9058@gmail.com</a></li>
                    <li><strong>Phone:</strong> +91 98706 02507</li>
                    <li>We’re here to help during business hours (9 AM - 6 PM, Monday to Friday).</li>
                </ul>
            </div>
        </div>
    </div>
    
    

</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
<script>
     $(document).ready(function() {
            $('.sidenav').sidenav();
        }); 
</script>
</html>
