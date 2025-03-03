<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Cab" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="models.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book a Trip</title>
    </head>
    <body>
        <h2>Book a Trip</h2>

        <%
            // Ensure user is logged in
            HttpSession userSession = request.getSession(false);
            User user = (User) userSession.getAttribute("user");

            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>

        <form action="BookTripServlet" method="post">
            <label for="pickup">Pickup Location:</label>
            <input type="text" id="pickup" name="pickup" required><br>

            <label for="dropoff">Dropoff Location:</label>
            <input type="text" id="dropoff" name="dropoff" required><br>

            <label for="cabType">Select Cab Type:</label>
            <select id="cabType" name="cabType" required>
                <option value="Sedan">Sedan</option>
                <option value="SUV">SUV</option>
                <option value="Mini">Mini</option>
            </select><br>

            <label for="tripDate">Trip Date:</label>
            <input type="date" id="tripDate" name="tripDate" required><br>

            <label for="pickupTime">Pickup Time:</label>
            <input type="time" id="pickupTime" name="pickupTime" required><br>

            <button type="submit">Request Trip</button>
        </form>
    </body>
</html>
