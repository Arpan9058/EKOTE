<%-- 
    Document   : Dashboard
    Created on : 13-Nov-2024, 12:09:31 pm
    Author     : sambh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-KOTE Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
         body {
            background-color: #f5f5f5;
        }
        .container {
            margin-top: 50px; 
        }
        h4 {
            margin-bottom: 40px; 
            font-weight: bold;
        }
        .btn-large {
            width: 400px; 
            height: 200px; 
            font-size: 30px; 
            border-radius: 5px; 
            transition: background-color 0.3s;
            display: flex; 
            align-items: center; 
            justify-content: center; 
            text-align: center;
            
        }
        .btn-large:hover {
            filter: brightness(90%); 
        }
    </style>
</head>

<body>
            <%@ page session="true" %>
        <%
            
            String role = (String) session.getAttribute("role");
            if (role == null) {
            
                response.sendRedirect("login.jsp?error=not_logged_in");
                return; 
            }
            
        %>


     <%@include file="SideNav.jsp" %>
    <!-- Dashboard Content -->
    <div class="container">
        <h4 class="center-align">E-KOTE Dashboard</h4>
        <br>
        <br>
        <!-- Actionable Shortcuts -->
        <div class="row center-align">
            <div class="col s12 m6">
                <a href="QRCode.jsp" class="btn-large waves-effect waves-light blue">Bar Code Generator</a>
            </div>
            <div class="col s12 m6">
                <a href="inventory_management.jsp" class="btn-large waves-effect waves-light green">Add New Weapon</a>
            </div>
        </div>
        <br>
        <div class="row center-align">
            <div class="col s12 m6">
                <a href="IssueReturn.jsp" class="btn-large waves-effect waves-light amber">Issue/Return Weapon</a>
            </div>
            <div class="col s12 m6">
                <a href="recordBook" class="btn-large waves-effect waves-light red">Record Book</a>
            </div>
        </div>

    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.sidenav').sidenav();
        });
    </script>
</body>

</html>
