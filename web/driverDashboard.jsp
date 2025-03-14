<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="models.Booking" %>
<%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Driver Dashboard</title>
    
    <!-- Bootstrap CDN -->
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
    <jsp:include page="driverSidebar.jsp" />

    <div class="body-wrap">
        <h2 class="mb-4 ms-4 text-left">Driver Dashboard</h2>

        <div class="container">
            <% if (error != null) { %>
                <div class="alert alert-danger" role="alert"><%= error %></div>
            <% } else if (bookings == null || bookings.isEmpty()) { %>
                <div class="alert alert-warning" role="alert">No trips assigned to you.</div>
            <% } else { %>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped text-center">
                        <thead class="table-dark">
                            <tr>
                                <th>Booking ID</th>
                                <th>Pickup Location</th>
                                <th>Dropoff Location</th>
                                <th>Pickup Time</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Booking booking : bookings) { %>
                                <tr>
                                    <td><%= booking.getBookingId() %></td>
                                    <td><%= booking.getPickupLocation() %></td>
                                    <td><%= booking.getDropoffLocation() %></td>
                                    <td><%= booking.getPickupTime() %></td>
                                    <td>
                                        <span class="badge 
                                            <%= "Confirmed".equals(booking.getStatus()) ? "bg-success" : 
                                                "Completed".equals(booking.getStatus()) ? "bg-primary" : "bg-warning" %>">
                                            <%= booking.getStatus() %>
                                        </span>
                                    </td>
                                    <td>
                                        <% if ("Confirmed".equals(booking.getStatus())) { %>
                                            <form action="UpdateBookingStatusServlet" method="post" class="d-inline">
                                                <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                                <input type="hidden" name="status" value="Completed">
                                                <button type="submit" class="btn btn-primary btn-sm">
                                                    <i class="fas fa-check"></i> Mark as Completed
                                                </button>
                                            </form>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
