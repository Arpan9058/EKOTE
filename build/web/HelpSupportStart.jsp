<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Support</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
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
            margin-top: 50px;
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
    </style>
</head>
<body>
     <%@include file="normalnav.jsp" %>
    <div class="container">
        <h4>Help & Support</h4>
        <p>Welcome to our Help & Support page! Here you’ll find quick answers to common questions and useful information to help you get the most out of the platform.</p>

        <!-- Getting Started Section -->
        <div class="section">
            <h5>Frequently Asked Questions (FAQ)</h5>
            <div class="faq-item">
                <p><strong>1. How to Register an Account?</strong></p>
                <ul>
                    <li>Go to the <a href="<%= request.getContextPath() %>/register.jsp">Registration Page</a>.</li>
                    <li>Enter your email, password, name, and role.</li>
                    <li>Click <strong>Submit</strong> to create your account. You’ll be ready to start using the platform!</li>
                </ul>
            </div>
            <div class="faq-item">
                <p><strong>2. How to Log In?</strong></p>
                <ul>
                    <li>Go to the <a href="<%= request.getContextPath() %>/login.jsp">Login Page</a>.</li>
                    <li>Enter your email and password.</li>
                    <li>Click <strong>Log In</strong> to access your account.</li>
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

    <!-- Materialize JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>
