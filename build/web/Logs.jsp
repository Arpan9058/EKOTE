<%@ page import="java.util.List" %>
<%@ page import="com.ekote.entities.GunDetails" %>
<%@ page session="true" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Record Book</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .container {
            max-width: 90%;
            margin: 0 auto;
            padding-top: 20px;
        }
        .table th, .table td {
            padding: 15px;
            text-align: center;
        }
        .table th {
            background-color: #00796b;
            color: white;
        }
        .table td {
            background-color: #f1f1f1;
        }
        .table-wrapper {
            margin-top: 20px;
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
        <h1 class="center-align">Gun Record Book</h1>
    <div class="table-wrapper">
        <table class="striped highlight responsive-table">
            <thead>
                <tr>
                    <th>Gun Identifier</th> <!-- Add Gun Identifier Column -->
                    <th>User Name</th>
                    <th>User Email</th>
                    <th>User Role</th>
                    <th>Gun Name</th>
                    <th>Model</th>
                    <!--<th>Quantity</th>-->
                    <th>Registered By</th>
                    <th>Manufactured Date</th>
                    <th>Manufactured Place</th>
                    <th>Issue Date</th>
                    <th>Return Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<GunDetails> recordBookList = (List<GunDetails>) request.getAttribute("recordBookList");
                    if (recordBookList != null && !recordBookList.isEmpty()) {
                        for (GunDetails gunDetails : recordBookList) {
                %>
                <tr>
                    <!-- Display the Gun Identifier -->
                    <td><%= gunDetails.getGunIdentifier() %></td> 
                    <td><%= gunDetails.getUserName() %></td>
                    <td><%= gunDetails.getUserEmail() %></td>
                    <td><%= gunDetails.getUserRole() %></td>
                    <td><%= gunDetails.getGunName() %></td>
                    <td><%= gunDetails.getModel() %></td>
                    <!--<td><%= gunDetails.getQuantity() %></td>-->
                    <td><%= gunDetails.getRegisteredBy() %></td>
                    <td><%= gunDetails.getManufacturedDate() %></td> 
                    <td><%= gunDetails.getManufacturedPlace() %></td> 
                    <td><%= gunDetails.getIssueDate() %></td>
                    <td><%= gunDetails.getReturnDate() %></td>
                    <td><%= gunDetails.getStatus() %></td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr><td colspan="12" class="center-align">No records found.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script>
        // Initialize Materialize components if needed
        M.AutoInit();
    </script>
</body>
</html>
