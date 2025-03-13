<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.LocationDAO" %>
<%@ page import="models.Location" %>
<%@ page import="models.User" %>
<%
    HttpSession userSession = request.getSession(false);
    User user = (User) userSession.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Request a Cab</title>
        <link rel="stylesheet" href="css/bookTrip.css"/>
        <style>
            /* Popup container - hidden by default */
.popup {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    color: black;
    background-color: rgba(0, 0, 0, 0.4); /* Black background with opacity */
    overflow: auto; /* Enable scroll if needed */
    padding-top: 60px; /* Position popup in the center */
}

/* Popup content */
.popup-content {
    background-color: #fefefe;
    margin: 5% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 400px;
    border-radius: 10px;
    text-align: center;
}

/* Close button */
.close-btn {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close-btn:hover,
.close-btn:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.popup h2 {
    margin-top: 0;
    font-size: 1.5em;
    margin-bottom: 2rem;
}

.popup p {
    font-size: 1.2em;
    margin: 10px 0;
    color: #555;
}

        </style>
    </head>
    <body>
        <nav class="navbar">
            <div class="logo">Mega City Cabs</div>
            <div class="nav-links">
                <a href="bookTrip.jsp">Book a Trip</a>
                <a href="BookingHistoryServlet">Booking History</a>
                <a href="#">About</a>
                <a href="#">Contact</a>
                <a href="LogoutServlet">Logout</a>
            </div>
        </nav>
        <section class="hero">
            <h1>Request a Cab</h1>
            <p>Reliable and Comfortable Rides in Colombo</p>
        </section>
        <form id="bookingForm" action="BookingServlet" method="POST">
        <div class="booking-container">
            <label>Select Cab Type:</label>
            <div class="custom-dropdown">
                <button type="button" class="dropdown-btn" onclick="toggleDropdown()">
                    <span id="selectedCab">Select Cab Type</span>
                </button>
                <div class="dropdown-content" id="dropdownMenu">
                    <div onclick="selectCab('Mini')"><img src="assets/minicab.png" alt="Mini">
                        <div class="cab-details">
                            <span class="cab-name">Mini</span>
                            <span class="cab-passengers">3 passengers</span>
                        </div>                                                                   
                    </div>
                    <div onclick="selectCab('Sedan')"><img src="assets/sedancab.png" alt="Sedan">
                        <div class="cab-details">
                            <span class="cab-name">Sedan</span>
                            <span class="cab-passengers">4 passengers</span>
                        </div>  
                    </div>
                    <div onclick="selectCab('SUV')"><img src="assets/suvcab.png" alt="SUV">
                        <div class="cab-details">
                            <span class="cab-name">SUV</span>
                            <span class="cab-passengers">6 passengers</span>
                        </div>  
                    </div>
                </div>
                <input type="hidden" name="cabType" id="cabType" value="">
            </div>
            <label>Pickup Time:</label>
            <input class="datetime-input" type="datetime-local" name="pickupTime" required>
            <label>Pickup Location:</label>
            <select name="pickupLocation" id="pickupLocation">
                <option value="">Select Pickup Location</option>
                <% List<Location> locations = LocationDAO.getAllLocations();
                   for (Location location : locations) { %>
                    <option value="<%= location.getName() %>"><%= location.getName() %></option>
                <% } %>
            </select>
            <label>Drop-off Location:</label>
            <select name="dropoffLocation" id="dropoffLocation">
                <option value="">Select Drop-off Location</option>
                <% for (Location location : locations) { %>
                    <option value="<%= location.getName() %>"><%= location.getName() %></option>
                <% } %>
            </select>
            <button type="button" class="submit-btn" onclick="calculateFare()">Get Estimate</button>
        </div>
            <!-- Custom Popup -->
        <div id="popup" class="popup">
            <div class="popup-content">
                <span class="close-btn" onclick="closePopup()">×</span>
                <h2>Fare Estimate</h2>
                <p>Distance:<strong> <span id="popupDistance">0</span> km</strong></p>
                <p>Estimated Fare: <strong><span id="popupFare">0</span> LKR</strong></p>

                <!-- Discount Info Section -->
                <p id="discountMessage" style="color: green; font-weight: bold; margin-top: 2rem;"></p>

                <button id="requestBookingBtn" type="button" onclick="submitBooking()">Request Booking</button>
            </div>
        </div>
        </form>
        <script>
            function calculateFare() {
                var cabType = document.getElementById("cabType").value;
                var pickupLocation = document.getElementById("pickupLocation").value;
                var dropoffLocation = document.getElementById("dropoffLocation").value;

                if (!pickupLocation || !dropoffLocation || !cabType) {
                    alert("Please select your preferred cab type, pickup and dropoff locations.");
                    return;
                }

                var xhr = new XMLHttpRequest();
                xhr.open("POST", "BookingServlet", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        var response = JSON.parse(xhr.responseText);
                        console.log("📌 Full Response Object:", response);

                        var distance = response.distance ? parseFloat(response.distance) : 0;
                        var estimatedFare = response.estimatedFare ? parseFloat(response.estimatedFare) : 0;

                        console.log("🔵 Distance:", distance);
                        console.log("🔵 Estimated Fare:", estimatedFare);

                        // Update the popup content with the fare estimate
                        document.getElementById("popupDistance").innerText = distance.toFixed(2);
                        document.getElementById("popupFare").innerText = estimatedFare.toFixed(2);

                        // Apply Discount Logic
                        var discountMessage = "";
                        if (distance > 20) {
                            discountMessage = "🎉 20% OFF applied for trips over 20km!";
                            estimatedFare *= 0.8;
                        } else if (distance > 15) {
                            discountMessage = "🎉 10% OFF applied for trips over 15km!";
                            estimatedFare *= 0.9;
                        } else if (distance > 10) {
                            discountMessage = "🎉 5% OFF applied for trips over 10km!";
                            estimatedFare *= 0.95;
                        } else {
                            discountMessage = "No discounts available for this trip.";
                        }

                        document.getElementById("discountMessage").innerText = discountMessage;
                        document.getElementById("popupFare").innerText = estimatedFare.toFixed(2); // Update fare after discount

                        // Show the popup
                        document.getElementById("popup").style.display = "block";
                    }
                };

                var params = "cabType=" + encodeURIComponent(cabType) +
                             "&pickupLocation=" + encodeURIComponent(pickupLocation) +
                             "&dropoffLocation=" + encodeURIComponent(dropoffLocation) +
                             "&action=calculateFare";
                xhr.send(params);
            }


            // Function to close the popup
            function closePopup() {
                document.getElementById("popup").style.display = "none";
            }

            // Function to Submit Booking
            function submitBooking() {
                var form = document.getElementById("bookingForm");

                // Append the 'action' parameter before submission
                var actionInput = document.createElement("input");
                actionInput.type = "hidden";
                actionInput.name = "action";
                actionInput.value = "requestBooking";
                form.appendChild(actionInput);

                // Submit the form
                form.submit();
            }
        </script>
        <script>
            function toggleDropdown() {
                document.getElementById("dropdownMenu").style.display = 
                    document.getElementById("dropdownMenu").style.display === "block" ? "none" : "block";
            }

            function selectCab(type) {
                document.getElementById("selectedCab").innerHTML =  " " + type;
                document.getElementById("cabType").value = type;
                document.getElementById("dropdownMenu").style.display = "none";
            }

            document.addEventListener("click", function(event) {
                if (!event.target.closest(".custom-dropdown")) {
                    document.getElementById("dropdownMenu").style.display = "none";
                }
            });
        </script>
    </body>
</html>
