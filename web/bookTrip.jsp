<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.LocationDAO" %>
<%@ page import="models.Location" %>
<%@ page import="models.User" %>
<%
    HttpSession userSession = request.getSession(false);
    User user = (User) userSession.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?sessionExpired=true");
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
    </head>
    <body>
        <script>
            window.onload = function () {
                document.getElementById("pickupTime").value = minDateTime;
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.has('sessionExpired') && urlParams.get('sessionExpired') === 'true') {
                    alert("Your session has expired. Please log in again.");
                }
            };
        </script>

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
            <h1>Schedule your Rides with Us</h1>
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
            <input class="datetime-input" type="datetime-local" name="pickupTime" id="pickupTime" required>
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
                        document.getElementById("popupFare").innerText = estimatedFare.toFixed(2);

                        document.getElementById("popup").style.display = "block";
                    }
                };

                var params = "cabType=" + encodeURIComponent(cabType) +
                             "&pickupLocation=" + encodeURIComponent(pickupLocation) +
                             "&dropoffLocation=" + encodeURIComponent(dropoffLocation) +
                             "&action=calculateFare";
                xhr.send(params);
            }

            function closePopup() {
                document.getElementById("popup").style.display = "none";
            }

            function submitBooking() {
                var form = document.getElementById("bookingForm");

                var actionInput = document.createElement("input");
                actionInput.type = "hidden";
                actionInput.name = "action";
                actionInput.value = "requestBooking";
                form.appendChild(actionInput);

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
