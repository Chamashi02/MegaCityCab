<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Driver" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>View Drivers</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        .body-wrap {
            margin-left: 17%;
            margin-top: 1rem;
        }
        .table-responsive {
            margin-left: 25px;
            margin-right: 25px;
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
                        <th>License Number</th>
                        <th>Phone Number</th>
                        <th>Address</th>
                        <th>Status</th>
                        <th>Cab Number</th>
                        <th>Cab Model</th>
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
                        <td><button type="submit" name="action" value="confirm" class="btn btn-success btn-sm">Authorize</button></td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="8" class="text-center">No drivers found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
