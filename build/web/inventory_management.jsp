<%@ page import="java.util.List" %>
<%@ page import="com.ekote.entities.Gun" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
    <div class="container">
        <h4 class="center-align">Add New Gun</h4>
        <!-- Form to Add or Subtract Gun Entry -->
        <form id="addGunForm" method="post">
            <div class="input-field">
                <input type="text" name="gun_name" id="gun_name" required>
                <label for="gun_name">Gun Name</label>
            </div>
            <div class="input-field">
                <input type="text" name="model" id="model" required>
                <label for="model">Model</label>
            </div>
            <div class="input-field">
                <input type="number" name="quantity" id="quantity" required>
                <label for="quantity">Quantity</label>
            </div>
            <div class="input-field">
                <input type="text" name="registered_by" id="registered_by" required>
                <label for="registered_by">Registered By</label>
            </div>
            <div class="input-field">
                <select name="operation" id="operation">
                    <option value="add" selected>Add</option>
                    <option value="subtract">Subtract</option>
                </select>
                <label for="operation">Operation</label>
            </div>
            <button type="submit" class="btn blue">Update Inventory</button>
            <button type="reset" class="btn red">Reset</button>
        </form>

        <hr>
        <h5>Guns Stock :</h5>
        <table id="inventoryTable" class="striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>Gun Name</th>
            <th>Model</th>
            <th>Quantity</th>
            <th>Registered By</th>
        </tr>
    </thead>
    <tbody>
        
    </tbody>
</table>

    </div>

    <!-- Materialize JS -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    <script>
    $(document).ready(function() {
            $('.sidenav').sidenav();
        });    
    $(document).ready(function(){
            M.updateTextFields();
            $(document).ready(function(){
    $('select').formSelect();
  });
            loadInventory();
            $("#addGunForm").submit(function(event) {
                event.preventDefault(); 
                var formData = $(this).serialize(); 
                $.ajax({
                    url: "AddGunServlet", 
                    method: "POST",
                    data: formData,
                    success: function(response) {
                        M.toast({html: 'Inventory updated successfully!', classes: 'green'});
                        loadInventory();
                    },
                    error: function() {
                        M.toast({html: 'Error updating inventory.', classes: 'red'});
                    }
                });
            });
        });
        function deleteGun(gunId) {
    if (confirm("Are you sure you want to delete this gun from inventory?")) {
        $.ajax({
            url: "DeleteGunServlet", 
            method: "POST",
            data: { gun_id: gunId }, 
            success: function(response) {
                M.toast({html: 'Gun deleted successfully!', classes: 'green'});
                loadInventory(); 
            },
            error: function() {
                M.toast({html: 'Error deleting gun from inventory.', classes: 'red'});
            }
        });
    }
}

        
        function loadInventory() {
            $.ajax({
                url: "DisplayInventoryServlet", 
                method: "GET",
                dataType: "json",
                success: function(data) {
                    var tableBody = $("#inventoryTable tbody");
                    tableBody.empty(); 
                if (data.length > 0) {
                        data.forEach(function(gun) {
                            var row = "<tr>" +
                                "<td>" + gun.id + "</td>" +
                                "<td>" + gun.gunName + "</td>" +
                                "<td>" + gun.model + "</td>" +
                                "<td>" + gun.quantity + "</td>" +
                                "<td>" + gun.registeredBy + "</td>" +
                                "<td><button class='btn red' onclick='deleteGun(" + gun.id + ")'>Delete</button></td>" +
                     
                            "</tr>";
                            tableBody.append(row); 
                        });
                    } else {
                        tableBody.append("<tr><td colspan='5'>No guns available in the inventory</td></tr>");
                    }
                },
                error: function() {
                    M.toast({html: 'Failed to load inventory.', classes: 'red'});
                }
            });
            
        }
        function showSuccess() {
            var urlparam = new URLSearchParams(window.location.search);
            var success = urlparam.get('success');
            if (success === "gun_issued") {
                alert("Gun Issued Successfully!!!");
            } else if(success ==="gun_returned"){
                alert("Gun Returned Successfully!!!");
            }
        }
window.onload = function() {
    showSuccess();
};
    </script>
</body>
</html>
