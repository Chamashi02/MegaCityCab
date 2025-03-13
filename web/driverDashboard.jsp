<%@ page import="java.util.List, models.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Dashboard</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid black; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>Driver Dashboard</h2>
    
    <% if (error != null) { %>
        <p style="color: red;"><%= error %></p>
    <% } else if (bookings == null || bookings.isEmpty()) { %>
        <p>No trips assigned to you.</p>
    <% } else { %>
        <table>
            <tr>
                <th>Booking ID</th>
                <th>Pickup Location</th>
                <th>Dropoff Location</th>
                <th>Pickup Time</th>
                <th>Status</th>
            </tr>
            <% for (Booking booking : bookings) { %>
                <tr>
                    <td><%= booking.getBookingId() %></td>
                    <td><%= booking.getPickupLocation() %></td>
                    <td><%= booking.getDropoffLocation() %></td>
                    <td><%= booking.getPickupTime() %></td>
                    <td><%= booking.getStatus() %></td>
                </tr>
            <% } %>
        </table>
    <% } %>
</body>
</html>
