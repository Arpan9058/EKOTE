<%@ page import="java.util.List" %>
<%@ page import="com.ekote.entities.GunDetails" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gun Information</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <style>
        body {
            padding: 20px;
        }
        .section-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .card-content h4 {
            margin-bottom: 10px;
        }
        .table-wrapper {
            margin-top: 20px;
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
        .container {
            max-width: 90%;
            margin: 0 auto;
        }
        .user-details {
            margin-top: 20px;
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

    <div class="container">
        <h1 class="section-header">Gun Information</h1>
        
        <% 
            List<GunDetails> arr = (List<GunDetails>) request.getAttribute("gunDetailsList");
            if(arr != null && !arr.isEmpty()){
                GunDetails last = arr.get(arr.size() - 1);
        %>

        <div class="user-details">
            <h3 class="center">Current/Last User Details</h3>
            <div class="card-content">
                <h4><strong>Gun Details:</strong></h4>
                <h5><strong>Unique Identifier: <%= last.getGunIdentifier() %></strong></h5>
                <p><strong>Gun Name:</strong> <%= last.getGunName() %></p>   
                <!--<p><strong>Quantity:</strong> <%= last.getQuantity() %></p>-->   
                <p><strong>Maintenance Date:</strong> <%= last.getMaintenanceDate() %></p>   
                <p><strong>Next Maintenance Date:</strong> <%= last.getNextMaintenanceDate() %></p>   
                <p><strong>Issue Date:</strong> <%= last.getIssueDate() %></p>   
                <p><strong>Return Date:</strong> <%= last.getReturnDate() %></p>   
                <p><strong>Status:</strong> <%= last.getStatus() %></p>   
                
                <h4><strong>User Details:</strong></h4>
                <p><strong>Name:</strong> <%= last.getUserName() %></p>   
                <p><strong>Email:</strong> <%= last.getUserEmail() %></p>   
                <p><strong>Role:</strong> <%= last.getUserRole() %></p>
            </div>
        </div>
        
        <% } else { %>
            <p class="center-align">Gun Data Not Found</p>
        <% } %>

        <!-- Table for listing all gun details -->
        <div class="table-wrapper">
            <table class="striped highlight responsive-table">
                <thead>
                    <tr>
                        <h4 class="center"><strong>Past Records</strong></h4>
                        <th>Gun Name</th>
                        <th>Model</th>
                        <!--<th>Quantity</th>-->
                        <th>Registered By</th>
                        <th>Maintenance Date</th>
                        <th>Next Maintenance</th>
                        <th>Issue Date</th>
                        <th>Return Date</th>
                        <th>Status</th>
                        <th>User Name</th>
                        <th>User Email</th>
                        <th>User Role</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<GunDetails> gunDetailsList = (List<GunDetails>) request.getAttribute("gunDetailsList");
                        if (gunDetailsList != null && !gunDetailsList.isEmpty()) {
                            for (GunDetails gunDetails : gunDetailsList) {
                    %>
                    <tr>
                        <td><%= gunDetails.getGunName() %></td>
                        <td><%= gunDetails.getModel() %></td>
                        <!--<td><%= gunDetails.getQuantity() %></td>-->
                        <td><%= gunDetails.getRegisteredBy() %></td>
                        <td><%= gunDetails.getMaintenanceDate() %></td>
                        <td><%= gunDetails.getNextMaintenanceDate() %></td>
                        <td><%= gunDetails.getIssueDate() %></td>
                        <td><%= gunDetails.getReturnDate() %></td>
                        <td><%= gunDetails.getStatus() %></td>
                        <td><%= gunDetails.getUserName() %></td>
                        <td><%= gunDetails.getUserEmail() %></td>
                        <td><%= gunDetails.getUserRole() %></td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr><td colspan="12" class="center-align">No data found.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div> <!-- .container -->

    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script>
        // Initialize Materialize components if needed
        M.AutoInit();
    </script>
</body>
</html>
