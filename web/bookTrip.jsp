<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.LocationDAO" %>
<%@ page import="models.Location" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Request a Cab</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                text-align: center;
            }
            .container {
                width: 50%;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px gray;
            }
            input, select, button {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
            }
            .result {
                margin-top: 20px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Request a Cab</h2>
            <form action="BookingServlet" method="post">
                <label>Select Cab Type:</label>
                <select name="cabType" id="cabType" onchange="calculateFare()">
                    <option value="Sedan">Sedan</option>
                    <option value="Mini">Mini</option>
                    <option value="SUV">SUV</option>
                </select>

                <label>Pickup Location:</label>
                <select name="pickupLocation" id="pickupLocation" onchange="calculateFare()">
                    <%
                        List<Location> locations = LocationDAO.getAllLocations();
                        for (Location location : locations) {
                    %>
                        <option value="<%= location.getName() %>"><%= location.getName() %></option>
                    <%
                        }
                    %>
                </select>

                <label>Drop-off Location:</label>
                <select name="dropoffLocation" id="dropoffLocation" onchange="calculateFare()">
                    <%
                        for (Location location : locations) {
                    %>
                        <option value="<%= location.getName() %>"><%= location.getName() %></option>
                    <%
                        }
                    %>
                </select>

                <label>Pickup Time:</label>
                <input type="datetime-local" name="pickupTime" required>

                <label>Distance (km):</label>
                <input type="text" id="distance" readonly>

                <label>Estimated Fare (LKR):</label>
                <input type="text" id="estimatedFare" name="estimatedFare" readonly>

                <br><br>
                <button type="submit">Request Booking</button>
            </form>
        </div>

        <script>
            function calculateFare() {
                var cabType = document.getElementById("cabType").value;
                var pickupLocation = document.getElementById("pickupLocation").value;
                var dropoffLocation = document.getElementById("dropoffLocation").value;

                if (!pickupLocation || !dropoffLocation) return;

                var xhr = new XMLHttpRequest();
                xhr.open("POST", "BookingServlet", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        var response = JSON.parse(xhr.responseText);
                        document.getElementById("distance").value = response.distance + " km";
                        document.getElementById("estimatedFare").value = response.estimatedFare + " LKR";
                    }
                };

                var params = "cabType=" + cabType + "&pickupLocation=" + pickupLocation + "&dropoffLocation=" + dropoffLocation + "&action=calculateFare";
                xhr.send(params);
            }
        </script>
    </body>
</html>
