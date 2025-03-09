<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Cab" %>
<%@ page import="models.Driver" %>
<%@ page import="dao.DriverDAO" %>
<%@ page import="dao.CabDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>View Cabs</title>
    
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
    <jsp:include page="sidebar.jsp" />
    <div class="body-wrap">
        <h2 class="mb-4 ms-4 text-left">Cabs List</h2>
        
        <div class="table-responsive">
            <table class="table table-bordered table-striped text-center">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Cab Number</th>
                        <th>Model</th>
                        <th>Cab Type</th>
                        <th>Capacity</th>
                        <th>Status</th>
                        <th>Driver</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Cab> cabList = (List<Cab>) request.getAttribute("cabList");
                        DriverDAO driverDAO = new DriverDAO();
                        if (cabList != null && !cabList.isEmpty()) {
                            for (Cab cab : cabList) {
                    %>
                    <tr>
                        <td><%= cab.getCabId() %></td>
                        <td><%= cab.getCabNumber() %></td>
                        <td><%= cab.getModel() %></td>
                        <td><%= cab.getCabType() %></td>
                        <td><%= cab.getCapacity() %></td>
                        <td><span class="badge bg-info text-dark"><%= cab.getStatus() %></span></td>
                        <td><%= (cab.getDriverId() != null) ? driverDAO.getDriverById(cab.getDriverId()).getName() : "Unassigned" %></td>
                        <td>
                            <% if (cab.getDriverId() == null) { %>
                                <button onclick="openPopup(<%= cab.getCabId() %>)" class="btn btn-warning btn-sm">Assign Driver</button>
                            <% } else { %>
                                <form action="UnassignDriverServlet" method="post" class="d-inline">
                                    <input type="hidden" name="cabId" value="<%= cab.getCabId() %>">
                                    <input type="hidden" name="driverId" value="<%= cab.getDriverId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">Unassign</button>
                                </form>
                            <% } %>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="8" class="text-center">No cabs found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Driver Assignment Modal -->
    <div id="driverPopup" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Select Driver for Cab</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="AssignDriverServlet" method="post">
                        <input type="hidden" id="cabId" name="cabId">
                        <div class="mb-3">
                            <label for="driverId" class="form-label">Choose a Driver:</label>
                            <select name="driverId" id="driverId" class="form-select" required>
                                <% List<Driver> availableDrivers = driverDAO.getAvailableDrivers();
                                   for (Driver driver : availableDrivers) { %>
                                <option value="<%= driver.getDriverId() %>"><%= driver.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Assign Driver</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openPopup(cabId) {
            document.getElementById("cabId").value = cabId;
            var myModal = new bootstrap.Modal(document.getElementById('driverPopup'));
            myModal.show();
        }
    </script>
</body>
</html>
