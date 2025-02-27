<%@page import="com.ekote.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-KOTE</title>

    <!-- Materialize CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- Inline styles -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        
        nav {
            background-color: #4CAF50 !important;
        }

        .brand-logo {
            font-size: 2rem;
            font-weight: bold;
            color: white;
            text-transform: uppercase;
        }

        .nav-wrapper {
            padding: 0 20px;
        }

        .nav-wrapper a {
            color: white !important;
        }

        
        .parallax-container {
            height: 400px;
            position: relative;
        }

        .parallax img {
            object-fit: cover;
            height: 100%;
            width: 100%;
        }

        
        .card {
            margin: 30px 0;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }

        .card:hover {
            transform: translateY(-10px);
        }

        .card-content {
            padding: 30px;
        }

        .card-title {
            text-align: center;
            margin-bottom: 20px;
            font-size: 2rem;
            font-weight: bold;
            color: #333;
        }

        .card h6, .card p {
            font-size: 1rem;
            line-height: 1.6;
            color: #555;
        }

        .form-field input, .form-field select {
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #ddd;
            width: 100%;
            margin-bottom: 20px;
            font-size: 1.1rem;
        }

        .form-field input:focus {
            border: 1px solid #4CAF50;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        /* Buttons Styling */
        .btn {
            width: 100%;
            height: 7vh;
            background-color: #4CAF50;
            font-size: 1.1rem;
            padding: 12px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #45a049;
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }

        /* Footer Styling */
        .footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 20px 0;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
        }

        .footer a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        /* About Section Styling */
        .about-section {
            padding: 50px 0;
            background: linear-gradient(to right, #e8f5e9, #dcedc8);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
            margin-top: 40px;
        }

        .about-section .card-content {
            padding: 40px;
        }

        /* Miscellaneous Styles */
        .center-align {
            text-align: center;
        }

        /* Responsive Design */
        @media screen and (max-width: 600px) {
            .card {
                margin: 20px 0;
            }
            .footer {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>

    <!-- Navbar -->
<!--    <nav>
        <div class="nav-wrapper">
            <a href="index.jsp" class="brand-logo">E-KOTE</a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li><a href="#login">Login</a></li>
                <li><a href="register.jsp">Register</a></li>
                <li><a href="#about-us"><span class="fa fa-address-card-o"></span>&nbsp;About Us</a></li>
                <li><a href=""><span class="fa fa-phone"></span>&nbsp;Helpline & Support</a></li>
            </ul>
        </div>
    </nav>-->
<%@include file="normalnav.jsp" %>
    <!-- Parallax Section -->
    <div class="parallax-container">
        <div class="parallax"><img src="img/02.jpg" alt="Hero Image"></div>
    </div>

    <!-- Welcome Section -->
    <div class="container">
        <div class="row">
            <div class="col s12 m8 offset-m2">
                <div class="card">
                    <div class="card-content">
                        <h3 class="card-title">Welcome to E-KOTE</h3>
                        <h6>The advanced weapon management solution designed specifically for the Indian Defence Force Services.</h6>
                        <p>E-KOTE leverages cutting-edge barcode technology to ensure precise tracking, enhanced security, and efficient management of weapon inventories. Our platform automates and streamlines the entire process, providing an effortless way to issue, return, and monitor weapons with unparalleled accuracy and control.</p>
                        <p><strong>Why E-KOTE?</strong></p>
                        <ul>
                            <li><strong>Accurate Tracking:</strong> Easily track each weapon's history with date and time stamps. Scan the barcode to retrieve real-time data on any weapon.</li>
                            <li><strong>Enhanced Security:</strong> Automates record-keeping, ensuring only authorized personnel can access weapons, enhancing accountability.</li>
                            <li><strong>Efficient Management:</strong> Streamlines administrative tasks, allowing personnel to focus on their duties while the system handles issuance, returns, and maintenance scheduling.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- About Us Section -->
    <section id="about-us" class="about-section">
        <div class="container">
            <div class="row">
                <div class="col s12">
                    <div class="card">
                        <div class="card-content">
                            <h3 class="card-title">About Us</h3>
                            <h5>Who We Are:</h5>
                            <p>At E-KOTE, we believe in enhancing the efficiency and security of weapon management systems. Our barcode-based tracking system enables real-time monitoring, ensuring accurate inventory and the highest levels of accountability.</p>
                            <h5>Mission:</h5>
                            <p>Our mission is to replace outdated manual record-keeping processes with a modern, automated system that tracks weapons, their usage, maintenance, and history. Through this innovative approach, we aim to reduce errors and provide a robust, secure weapon management system.</p>
                            <h5>Vision:</h5>
                            <p>Our vision is to revolutionize the weapon management system in defense services by providing a secure and transparent way to manage every weapon issued, cleaned, or maintained within the defense infrastructure.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Login Form Section -->
    <section id="login" class="about-section">
    <div class="container">
        <div class="row">
            <div class="col s12 m6 offset-m3">
                <div class="card">
                    <div class="card-content">
                        <h4 class="center-align">Login</h4>
                        <form action="LoginServlet" method="post">
                            <div class="form-field">
                                <input type="email" name="user_mail" placeholder="Enter E-mail" required/>
                            </div>
                            <div class="form-field">
                                <input type="password" name="user_pass" placeholder="Enter Password" required/>
                            </div>
                            <div class="form-field">
                                <button type="submit" class="btn">Login</button>
                            </div>
                            
                            <div class="center-align">
                                <a href="register.jsp">Don't have an account? Sign up</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </section>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2024 E-KOTE. All Rights Reserved.</p>
        <p><a href="privacy.jsp">Privacy Policy</a> | <a href="terms.jsp">Terms & Conditions</a></p>
    </div>

    <!-- Materialize JS and Custom Script -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script>
        $(document).ready(function(){
            $('.parallax').parallax();
            $('select').formSelect();
        });
    </script>

</body>
</html>
