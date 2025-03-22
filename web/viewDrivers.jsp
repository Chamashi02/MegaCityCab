<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Driver" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>View Drivers</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .body-wrap {
            margin-left: 17%;
            margin-top: 1rem;
        }
        .table-responsive {
            margin-left: 25px;
            margin-right: 25px;
        }

        #authorizationModal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-container {
            background: white;
            width: 400px;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.3s ease-in-out;
            position: relative;
        }

        .close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 24px;
            color: #aaa;
            cursor: pointer;
        }

        .close:hover {
            color: black;
        }

        input[type="text"], input[type="password"], input[type="email"] {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            padding: 10px;
            background: green;
            color: white;
            border: none;
            cursor: pointer;
            width: 100%;
            border-radius: 4px;
        }

        input[type="submit"]:hover {
            background: darkgreen;
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="sidebar.jsp" />
    <div class="body-wrap">
        <h2 class="mb-4 ms-4 text-left">Drivers List</h2>
        
        <div class="table-responsive">
            <table class="table table-bordered table-striped text-center">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>License</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Availability</th>
                        <th>Cab</th>
                        <th>Model</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Driver> driverList = (List<Driver>) request.getAttribute("driverList");
                       if (driverList != null && !driverList.isEmpty()) {
                           for (Driver driver : driverList) { %>
                    <tr>
                        <td><%= driver.getDriverId() %></td>
                        <td><%= driver.getName() %></td>
                        <td><%= driver.getLicenseNumber() %></td>
                        <td><%= driver.getPhoneNumber() %></td>
                        <td><%= driver.getAddress() %></td>
                        <td><span class="badge bg-info text-dark"><%= driver.getStatus() %></span></td>
                        <td><%= (driver.getCabNumber() != null) ? driver.getCabNumber() : "Not Assigned" %></td>
                        <td><%= (driver.getCabModel() != null) ? driver.getCabModel() : "Not Assigned" %></td>
                        <td>
                            <% if (!driver.isAuthorized()) { %>
                                <button class="btn btn-warning" onclick="openAuthorizationForm('<%= driver.getDriverId() %>', '<%= driver.getName() %>', '<%= driver.getPhoneNumber() %>', '<%= driver.getAddress() %>')">Authorize</button>
                            <% } else { %>
                                <span class="badge bg-success">Authorized</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="9" class="text-center">No drivers found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Modal for Authorization -->
        <div id="authorizationModal">
            <div class="modal-container">
                <span class="close" onclick="closeAuthorizationForm()">&times;</span>
                <h2>Authorize Driver</h2>
                <form action="AuthorizeDriverServlet" method="post">
                    <input type="hidden" id="driverId" name="driverId">

                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" required readonly>

                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>

                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>

                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>

                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone" required readonly>

                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" required readonly>

                    <label for="nic">NIC</label>
                    <input type="text" id="nic" name="nic" required>

                    <input type="submit" value="Authorize">
                </form>
            </div>
        </div>
    </div>

    <script>
        function openAuthorizationForm(driverId, name, phone, address) {
            console.log("Opening modal for driver:", driverId); 
            $('#driverId').val(driverId);
            $('#name').val(name);
            $('#phone').val(phone);
            $('#address').val(address);

            setTimeout(() => $('#username').focus(), 100);

            $('#authorizationModal').fadeIn(); 
        }

        function closeAuthorizationForm() {
            console.log("Closing modal");
            $('#authorizationModal').fadeOut();
        }

        // To Ensure modal does not show on page load
        $(document).ready(function () {
            $('#authorizationModal').hide(); 
        });

        $(document).mouseup(function(e) {
            var modal = $(".modal-container");
            if (!modal.is(e.target) && modal.has(e.target).length === 0) {
                closeAuthorizationForm();
            }
        });

    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
