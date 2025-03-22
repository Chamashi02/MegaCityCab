<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="dao.BookingDAO"%>
<%@page import="dao.CabDAO"%>
<%@page import="models.Booking"%>
<%@page import="models.Cab"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    CabDAO cabDAO = new CabDAO();
    HashMap<String, List<Cab>> availableCabsByType = cabDAO.getAvailableCabsByType();
    request.setAttribute("availableCabsByType", availableCabsByType);
%>

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
        
        <!-- Tab Navigation -->
        <ul class="nav nav-tabs" id="bookingTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button" role="tab">Pending</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="confirmed-tab" data-bs-toggle="tab" data-bs-target="#confirmed" type="button" role="tab">Confirmed</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="completed-tab" data-bs-toggle="tab" data-bs-target="#completed" type="button" role="tab">Completed</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="cancelled-tab" data-bs-toggle="tab" data-bs-target="#cancelled" type="button" role="tab">Cancelled</button>
            </li>
        </ul>
        
        <div class="tab-content" id="bookingTabsContent">
            <% List<Booking> bookings = BookingDAO.getAllBookings(); %>
            
            <% String[] statuses = {"Pending", "Confirmed", "Completed", "Cancelled"};
               String[] colors = {"warning", "success", "primary", "danger"};
               for (int i = 0; i < statuses.length; i++) { %>
            <div class="tab-pane fade <%= i == 0 ? "show active" : "" %>" id="<%= statuses[i].toLowerCase() %>" role="tabpanel">
                <div class="table-responsive mt-3">
                    <table class="table table-bordered table-striped text-center">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>User</th>
                                <th>Trip details</th>
                                <th>Pickup Time</th>
                                <th>Distance</th>
                                <th>Fare</th>
                                <th>Cab type</th>
                                <th>Cab ID</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Booking booking : bookings) { 
                                if (statuses[i].equals(booking.getStatus())) { %>
                            <tr>
                                <td><%= booking.getBookingId() %></td>
                                <td><%= booking.getUserId() %></td>
                                <td style="text-align: left;">
                                    <strong>Pickup:</strong> <%= booking.getPickupLocation() %><br>
                                    <strong>Dropoff:</strong> <%= booking.getDropoffLocation() %>
                                </td>
                                <td><%= booking.getPickupTime() %></td>
                                <td><%= booking.getDistance() %> km</td>
                                <td>Rs. <%= booking.getEstimatedFare() %></td>
                                <td><%= booking.getCabType() %></td>
                                <td>
                                    <% if (booking.getCabId() == null && (statuses[i].equals("Cancelled") || statuses[i].equals("Completed"))) { %>
                                        <span class="badge bg-<%= colors[i] %>"><%= statuses[i] %></span> 
                                    <% } else if (booking.getCabId() == null) { %>
                                        <button onclick="openPopup(<%= booking.getBookingId() %>, '<%= booking.getCabType() %>')" class="btn btn-warning btn-sm">Assign</button>
                                    <% } else { %>
                                        <%= booking.getCabId() %>
                                    <% } %>
                                </td>
                                <td><span class="badge bg-<%= colors[i] %>"><%= statuses[i] %></span></td>
                                <td>
                                    <% if (statuses[i].equals("Pending")) { %>
                                        <form action="AssignCabServlet" method="post" class="d-inline" onsubmit="return checkCabAssigned(<%= booking.getBookingId() %>)">
                                            <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                            <button type="submit" name="action" value="confirm" class="btn btn-success btn-sm">Confirm</button>
                                        </form>
                                        <form action="AssignCabServlet" method="post" class="d-inline">
                                            <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                            <button type="submit" name="action" value="cancel" class="btn btn-danger btn-sm">Cancel</button>
                                        </form>
                                    <% } %>
                                </td>
                            </tr>
                            <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>
            <% } %>
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
                                <option value="">Select a cab</option>
                            </select>
                        </div>

                        <button type="submit" name="action" value="assignCab" class="btn btn-primary">Assign Cab</button>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var availableCabsByType = {
            "Sedan": [
                <% for (Cab cab : availableCabsByType.get("Sedan")) { %>
                    { "cabId": "<%= cab.getCabId() %>", "cabNumber": "<%= cab.getCabNumber() %>", "model": "<%= cab.getModel() %>" },
                <% } %>
            ],
            "Mini": [
                <% for (Cab cab : availableCabsByType.get("Mini")) { %>
                    { "cabId": "<%= cab.getCabId() %>", "cabNumber": "<%= cab.getCabNumber() %>", "model": "<%= cab.getModel() %>" },
                <% } %>
            ],
            "SUV": [
                <% for (Cab cab : availableCabsByType.get("SUV")) { %>
                    { "cabId": "<%= cab.getCabId() %>", "cabNumber": "<%= cab.getCabNumber() %>", "model": "<%= cab.getModel() %>" },
                <% } %>
            ]
        };

        function openPopup(bookingId, cabType) {
            document.getElementById("bookingId").value = bookingId;
            var cabDropdown = document.getElementById("cabId");

            cabDropdown.innerHTML = '<option value="">Select a cab</option>';

            if (availableCabsByType[cabType]) {
                availableCabsByType[cabType].forEach(function(cab) {
                    var option = document.createElement("option");
                    option.value = cab.cabId;
                    option.textContent = cab.cabNumber + " - " + cab.model;
                    cabDropdown.appendChild(option);
                });
            }

            var myModal = new bootstrap.Modal(document.getElementById('cabPopup'));
            myModal.show();
        }

        
        function checkCabAssigned(bookingId) {
            var cabCell = document.querySelector("tr td button[onclick='openPopup(" + bookingId + ")']");
            if (cabCell) {
                alert("Please assign a cab before confirming the booking.");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
