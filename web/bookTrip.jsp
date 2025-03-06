<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.LocationDAO" %>
<%@ page import="models.Location" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Request a Cab</title>
        <link rel="stylesheet" href="css/bookTrip.css"/>
    </head>
    <body>
        <nav class="navbar">
            <div class="logo">Mega City Cabs</div>
            <div class="nav-links">
                <a href="#">Home</a>
                <a href="#">About</a>
                <a href="#">Services</a>
                <a href="#">Contact</a>
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
                    <div onclick="selectCab('Mini')"><img src="assets/minicab.png" alt="Mini"> Mini</div>
                    <div onclick="selectCab('Sedan')"><img src="assets/sedancab.png" alt="Sedan"> Sedan</div>
                    <div onclick="selectCab('SUV')"><img src="assets/suvcab.png" alt="SUV"> SUV</div>
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
        <div id="fareModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2>Fare Estimate</h2>
                <div id="fareInfo"></div>
                <button id="requestBookingBtn" onclick="submitBooking()">Request Booking</button>
            </div>
        </div>
        </form>
        <script>
            function calculateFare() {
                var cabType = document.getElementById("cabType").value;
                var pickupLocation = document.getElementById("pickupLocation").value;
                var dropoffLocation = document.getElementById("dropoffLocation").value;

                if (!pickupLocation || !dropoffLocation) {
                    alert("Please select both pickup and dropoff locations.");
                    return;
                }

                var xhr = new XMLHttpRequest();
                xhr.open("POST", "BookingServlet", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        var response = JSON.parse(xhr.responseText);
                        console.log(xhr.responseText);


                        // Ensure response contains expected values
                        if (response.distance && response.estimatedFare) {
                            var fareInfoContent = `
                                <p><strong>Distance:</strong> ${response.distance} km</p>
                                <p><strong>Estimated Fare:</strong> ${response.estimatedFare} LKR</p>
                            `;

                            document.getElementById("fareInfo").innerHTML = fareInfoContent;
                            document.getElementById("fareModal").style.display = "flex"; // Show modal
                        } else {
                            alert("Error retrieving fare estimate. Please try again.");
                        }
                    }
                };

                var params = "cabType=" + encodeURIComponent(cabType) +
                             "&pickupLocation=" + encodeURIComponent(pickupLocation) +
                             "&dropoffLocation=" + encodeURIComponent(dropoffLocation) +
                             "&action=calculateFare";
                xhr.send(params);
            }

            // Function to Close Modal
            function closeModal() {
                document.getElementById("fareModal").style.display = "none";
            }

            // Function to Submit Booking
            function submitBooking() {
                document.querySelector("form").submit();
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
