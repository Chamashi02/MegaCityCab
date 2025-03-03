<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Cab" %>
<%@ page import="models.Driver" %>
<%@ page import="dao.DriverDAO" %>
<%@ page import="dao.CabDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View Cabs</title>
        <link rel="stylesheet" href="css/style.css">
        <script>
            function openPopup(cabId) {
                document.getElementById("cabId").value = cabId;
                document.getElementById("driverPopup").style.display = "block";
            }
            function closePopup() {
                document.getElementById("driverPopup").style.display = "none";
            }
        </script>
    </head>
    <body>
        <h2>Cabs List</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Cab Number</th>
                    <th>Model</th>
                    <th>Cab Type</th>
                    <th>Capacity</th>
                    <th>Status</th>
                    <th>Driver</th>
                    <th>Assign/Unassign Driver</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Cab> cabList = (List<Cab>) request.getAttribute("cabList");
                    if (cabList != null && !cabList.isEmpty()) {
                        for (Cab cab : cabList) {
                %>
                <% 
                    DriverDAO driverDAO = new DriverDAO(); // Create an instance of DriverDAO
                %>
                <tr>
                    <td><%= cab.getCabId() %></td>
                    <td><%= cab.getCabNumber() %></td>
                    <td><%= cab.getModel() %></td>
                    <td><%= cab.getCabType() %></td>
                    <td><%= cab.getCapacity() %></td>
                    <td><%= cab.getStatus() %></td>
                    <td>
                        <%= (cab.getDriverId() != null) ? driverDAO.getDriverById(cab.getDriverId()).getName() : "Unassigned" %>
                    </td>

                    <td>
                        <% if (cab.getDriverId() == null) { %>
                            <button onclick="openPopup(<%= cab.getCabId() %>)">Assign Driver</button>
                        <% } else { %>
                            <form action="UnassignDriverServlet" method="post" style="display:inline;">
                                <input type="hidden" name="cabId" value="<%= cab.getCabId() %>">
                                <input type="hidden" name="driverId" value="<%= cab.getDriverId() %>">
                                <button type="submit">Unassign Driver</button>
                            </form>
                        <% } %>
                    </td>

                </tr>
                <% 
                        }
                    } else {
                %>
                <tr>
                    <td colspan="8">No cabs found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Driver Selection Popup -->
        <div id="driverPopup" class="popup">
            <div class="popup-content">
                <span class="close" onclick="closePopup()">&times;</span>
                <h3>Select Driver</h3>
                <form action="AssignDriverServlet" method="post">
                    <input type="hidden" id="cabId" name="cabId">
                    <select name="driverId" required>
                        <%
                            DriverDAO driverDAO = new DriverDAO();
                            List<Driver> availableDrivers = driverDAO.getAvailableDrivers();
                            for (Driver driver : availableDrivers) {
                        %>
                        <option value="<%= driver.getDriverId() %>"><%= driver.getName() %></option>
                        <% } %>
                    </select>
                    <button type="submit">Assign</button>
                </form>
            </div>
        </div>

        <style>
            .popup { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
                     background: white; padding: 20px; border: 1px solid black; }
            .popup-content { text-align: center; }
            .close { cursor: pointer; float: right; font-size: 20px; }
        </style>
    </body>
</html>
