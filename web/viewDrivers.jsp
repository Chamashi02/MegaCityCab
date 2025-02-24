<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Driver" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>View Drivers</title>
</head>
<body>
    <h2>Driver List</h2>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>License Number</th>
                <th>Phone Number</th>
                <th>Address</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Driver> driverList = (List<Driver>) request.getAttribute("driverList");
                if (driverList != null && !driverList.isEmpty()) {
                    for (Driver driver : driverList) {
            %>
            <tr>
                <td><%= driver.getDriverId() %></td>
                <td><%= driver.getName() %></td>
                <td><%= driver.getLicenseNumber() %></td>
                <td><%= driver.getPhoneNumber() %></td>
                <td><%= driver.getAddress() %></td>
                <td><%= driver.getStatus() %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="6">No drivers found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>