<%@page import="java.util.List"%>
<%@page import="dao.BookingDAO"%>
<%@page import="models.Booking"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Bookings</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4b400;
            color: white;
        }
        .action-btn {
            padding: 5px 10px;
            margin: 5px;
            cursor: pointer;
        }
        .confirm { background-color: #4CAF50; color: white; }
        .cancel { background-color: #f44336; color: white; }
    </style>
</head>
<body>

<h2>Manage Bookings</h2>

<table>
    <tr>
        <th>Booking ID</th>
        <th>User ID</th>
        <th>Cab Type</th>
        <th>Pickup Location</th>
        <th>Dropoff Location</th>
        <th>Pickup Time</th>
        <th>Status</th>
        <th>Cab ID</th>
        <th>Price (LKR)</th>
        <th>Distance (km)</th>
        <th>Actions</th>
    </tr>
    <%
        List<Booking> bookings = BookingDAO.getAllBookings();
        if (bookings != null && !bookings.isEmpty()) {
            for (Booking booking : bookings) {
    %>
        <tr>
            <td><%= booking.getBookingId() %></td>
            <td><%= booking.getUserId() %></td>
            <td><%= booking.getCabType() %></td>
            <td><%= booking.getPickupLocation() %></td>
            <td><%= booking.getDropoffLocation() %></td>
            <td><%= booking.getPickupTime() %></td>
            <td><%= booking.getStatus() %></td>
            <td><%= "Unassigned" %></td>
            <td><%= booking.getEstimatedFare() %></td>
            <td><%= booking.getDistance() %></td>
            <td>
                <form action="BookingServlet" method="post" style="display:inline;">
                    <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                    <button type="submit" name="action" value="confirm" class="action-btn confirm">Confirm</button>
                </form>
                <form action="BookingServlet" method="post" style="display:inline;">
                    <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                    <button type="submit" name="action" value="cancel" class="action-btn cancel">Cancel</button>
                </form>
            </td>
        </tr>
    <%
            }
        } else {
            out.println("<tr><td colspan='11'>No bookings available.</td></tr>");
        }
    %>
</table>

</body>
</html>
