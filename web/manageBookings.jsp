<%@page import="java.util.List"%>
<%@page import="dao.BookingDAO"%>
<%@page import="dao.CabDAO"%>
<%@page import="models.Booking"%>
<%@page import="models.Cab"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Bookings</title>
    
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        /* Adjust body to accommodate sidebar */
        .body-wrap {
            margin-left: 17%;
            margin-top: 1rem;
        }
        .table-responsive{
            margin-left: 25px;
            margin-right: 25px;
        }
    </style>
</head>
<body class="bg-light">
    <jsp:include page="sidebar.jsp" />
    <div class="body-wrap">
        <h2 class="mb-4 ms-4 text-left">Manage Bookings</h2>
        
        <div class="table-responsive">
            <table class="table table-bordered table-striped text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Booking ID</th>
                        <th>User ID</th>
                        <th>Pickup Location</th>
                        <th>Dropoff Location</th>
                        <th>Pickup Time</th>
                        <th>Status</th>
                        <th>Price (LKR)</th>
                        <th>Distance (km)</th>
                        <th>Cab Type</th>
                        <th>Cab ID</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Booking> bookings = BookingDAO.getAllBookings();
                       if (bookings != null && !bookings.isEmpty()) {
                           for (Booking booking : bookings) { %>
                    <tr>
                        <td><%= booking.getBookingId() %></td>
                        <td><%= booking.getUserId() %></td>
                        <td><%= booking.getPickupLocation() %></td>
                        <td><%= booking.getDropoffLocation() %></td>
                        <td><%= booking.getPickupTime() %></td>
                        <td><span class="badge bg-info text-dark"><%= booking.getStatus() %></span></td>
                        <td><%= booking.getEstimatedFare() %></td>
                        <td><%= booking.getDistance() %></td>
                        <td><%= booking.getCabType() %></td>
                        <td><%= booking.getCabId() == null ? "Unassigned" : booking.getCabId() %>
                        <% if (booking.getCabId() == null) { %>
                            <button onclick="openPopup(<%= booking.getBookingId() %>)" class="btn btn-warning btn-sm">Assign Cab</button>
                            <% } %>
                        </td>
                        <td>
                            <form action="AssignCabServlet" method="post" class="d-inline">
                                <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                <button type="submit" name="action" value="confirm" class="btn btn-success btn-sm">Confirm</button>
                            </form>
                            <form action="AssignCabServlet" method="post" class="d-inline">
                                <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                <button type="submit" name="action" value="cancel" class="btn btn-danger btn-sm">Cancel</button>
                            </form>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="11" class="text-center">No bookings available.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Cab Assignment Modal -->
    <div id="cabPopup" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Select Cab for Booking</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="AssignCabServlet" method="post">
                        <input type="hidden" id="bookingId" name="bookingId">
                        <div class="mb-3">
                            <label for="cabId" class="form-label">Choose a Cab:</label>
                            <select name="cabId" id="cabId" class="form-select" required>
                                <% List<Cab> availableCabs = new CabDAO().getAllCabs();
                                   for (Cab cab : availableCabs) { %>
                                <option value="<%= cab.getCabId() %>"><%= cab.getCabNumber() %> - <%= cab.getModel() %></option>
                                <% } %>
                            </select>
                        </div>
                        <button type="submit" name="action" value="assignCab" class="btn btn-primary">Assign Cab</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openPopup(bookingId) {
            document.getElementById("bookingId").value = bookingId;
            var myModal = new bootstrap.Modal(document.getElementById('cabPopup'));
            myModal.show();
        }
    </script>
</body>
</html>
