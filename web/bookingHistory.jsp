<%@ page import="models.Booking" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Booking> bookingHistory = (List<Booking>) request.getAttribute("bookingHistory");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History</title>
    <link rel="stylesheet" href="css/bookTrip.css"> <!-- Using the same CSS file -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 50px;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            color: white;
            z-index: 1000;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            text-decoration: none;
            color: white;
        }

        .content {
            margin-top: 100px;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            margin-bottom: 50px;
        }

        h2 {
            color: #333;
            text-align: left;
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .table-container {
            max-height: 500px;
            overflow-y: auto;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f1c40f;
            color: white;
        }

        tr {
            color: black;
            cursor: pointer;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .status-warning { background-color: #f39c12; color: white; padding: 5px 10px; border-radius: 5px; }
        .status-success { background-color: #28a745; color: white; padding: 5px 10px; border-radius: 5px; }
        .status-primary { background-color: #007bff; color: white; padding: 5px 10px; border-radius: 5px; }
        .status-danger { background-color: #dc3545; color: white; padding: 5px 10px; border-radius: 5px; }

        .back-btn {
            display: block;
            text-align: center;
            margin-top: 30px;
            font-size: 1.1rem;
            padding: 10px 20px;
            border: none;
            background: #f1c40f;
            color: black;
            border-radius: 5px;
            cursor: pointer;
            width: 200px;
            margin: 20px auto;
            text-decoration: none;
        }

        .back-btn:hover {
            background: #d4ac0d;
        }

        /* Popup Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: white;
            padding: 20px;
            margin: 18% auto;
            width: 40%;
            border-radius: 10px;
            text-align: center;
        }

        .close-btn {
            color: red;
            float: right;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">Mega City Cabs</div>
        <div class="nav-links">
            <a href="bookTrip.jsp">Book a Ride</a>
            <a href="BookingHistoryServlet">Booking History</a>
            <a href="#">About</a>
            <a href="#">Contact</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </nav>

    <div class="content">
        <h2>Your Booking History</h2>

        <div class="table-container">
            <% if (bookingHistory != null && !bookingHistory.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Cab Type</th>
                            <th>Pickup Location</th>
                            <th>Dropoff Location</th>
                            <th>Pickup Time</th>
                            <th>Status</th>
                            <th>Estimated Fare</th>
                            <th>Distance</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Booking booking : bookingHistory) { 
                            String status = booking.getStatus();
                            String statusClass = "";
                            switch (status) {
                                case "Pending": statusClass = "status-warning"; break;
                                case "Confirmed": statusClass = "status-success"; break;
                                case "Completed": statusClass = "status-primary"; break;
                                case "Cancelled": statusClass = "status-danger"; break;
                            }
                        %>
                            <tr onclick="fetchCabDetails(<%= booking.getCabId() %>)">
                                <td><%= booking.getBookingId() %></td>
                                <td><%= booking.getCabType() %></td>
                                <td><%= booking.getPickupLocation() %></td>
                                <td><%= booking.getDropoffLocation() %></td>
                                <td><%= booking.getPickupTime() %></td>
                                <td><span class="<%= statusClass %>"><%= status %></span></td>
                                <td>Rs.<%= booking.getEstimatedFare() %></td>
                                <td><%= booking.getDistance() %> km</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p style="text-align: center; color: black;">No booking history found.</p>
            <% } %>
        </div>

        <a href="bookTrip.jsp" class="back-btn">Book Another Ride</a>
    </div>

    <!-- Popup Modal -->
    <div id="cabDetailsModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeModal()">&times;</span>
            <h2 style="text-align: center;">Cab & Driver Details</h2>
            <p id="cabDetailsText" style="line-height: 2;"></p>
        </div>
    </div>

    <script>
        function fetchCabDetails(cabId) {
            if (!cabId) {
                document.getElementById("cabDetailsText").innerHTML = 
                    "We're preparing your ride. A driver will be assigned to you soon.<br>Thank you for your patience.";
                document.getElementById("cabDetailsModal").style.display = "block";
                return;
            }

            console.log("Fetching details for Cab ID: " + cabId);

            fetch('GetCabDetailsServlet?cabId=' + cabId)
                .then(response => response.text())
                .then(data => {
                    console.log(data); // Add this line to log the response from the server
                    if (data === "No Data Found" || data === "Error") {
                        alert("Cab details not found!");
                    } else {
                        let details = data.split("|");
                        document.getElementById("cabDetailsText").innerHTML = 
                            "<strong>Cab Number: </strong> " + details[0] + "<br>" +
                            "<strong>Cab Type: </strong> " + details[1] + "<br>" +
                            "<strong>Driver Name: </strong> " + details[2] + "<br>" +
                            "<strong>Phone Number: </strong> " + details[3];
                        document.getElementById("cabDetailsModal").style.display = "block";
                    }
                })
                .catch(error => {
                    console.error("Error fetching cab details: ", error);
                    alert("An error occurred while fetching cab details.");
                });
        }


        function closeModal() {
            document.getElementById("cabDetailsModal").style.display = "none";
        }
    </script>

</body>
</html>
