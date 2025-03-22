package servlets;

import dao.BookingDAO;
import dao.LocationDAO;
import models.Booking;
import models.Location;
import utils.HaversineUtil;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.Console;
import java.text.DecimalFormat;

public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // rounding fare and distance
    private static final DecimalFormat distanceFormat = new DecimalFormat("#.#");
    private static final DecimalFormat fareFormat = new DecimalFormat("#.##");

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         System.out.println("BookingServlet called.");
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String action = request.getParameter("action");
            System.out.println("Action received: " + action);

            if ("calculateFare".equals(action)) {
                String cabType = request.getParameter("cabType");
                String pickupLocationName = request.getParameter("pickupLocation");
                String dropoffLocationName = request.getParameter("dropoffLocation");

                Location pickupLocation = LocationDAO.getLocationByName(pickupLocationName);
                Location dropoffLocation = LocationDAO.getLocationByName(dropoffLocationName);

                if (pickupLocation == null || dropoffLocation == null) {
                    response.getWriter().println("Invalid location data.");
                    return;
                }

                // Calculate distance
                double distance = HaversineUtil.calculateDistance(
                    pickupLocation.getLatitude(), pickupLocation.getLongitude(),
                    dropoffLocation.getLatitude(), dropoffLocation.getLongitude()
                );
                String roundedDistance = distanceFormat.format(distance);

                // Calculate fare 
                double estimatedFare = calculateFare(cabType, distance);
                String roundedFare = fareFormat.format(estimatedFare);

                // Send response as JSON
                response.setContentType("application/json");
                response.getWriter().write("{\"estimatedFare\": \"" + roundedFare + "\", \"distance\": \"" + roundedDistance + "\"}");
                return;
            }

            // Booking request handling
            String cabType = request.getParameter("cabType");
            String pickupLocationName = request.getParameter("pickupLocation");
            String dropoffLocationName = request.getParameter("dropoffLocation");
            String pickupTime = request.getParameter("pickupTime");

            Location pickupLocation = LocationDAO.getLocationByName(pickupLocationName);
            Location dropoffLocation = LocationDAO.getLocationByName(dropoffLocationName);

            if (pickupLocation == null || dropoffLocation == null) {
                response.getWriter().println("<script>alert('Invalid pickup or dropoff location!'); window.location='bookTrip.jsp';</script>");
                return;
            }

            double distance = HaversineUtil.calculateDistance(
                pickupLocation.getLatitude(), pickupLocation.getLongitude(),
                dropoffLocation.getLatitude(), dropoffLocation.getLongitude()
            );
            double estimatedFare = calculateFare(cabType, distance);

            Booking booking = new Booking(0, userId, cabType, pickupLocationName, dropoffLocationName, pickupTime, "Pending",null, estimatedFare, distance);
            boolean success = BookingDAO.addBooking(booking);

            if (success) {
                response.getWriter().println("<script>alert('Booking Requested Successfully!'); window.location='BookingHistoryServlet';</script>");
            } else {
                response.getWriter().println("<script>alert('Booking Failed! Try again.'); window.location='bookTrip.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred. Try again!'); window.location='bookTrip.jsp';</script>");
        }
    }

    // Calculate fare based on cabtype and distance
    private double calculateFare(String cabType, double distance) {
        double baseFare = 0;
        if (cabType.equals("Sedan")) {
            baseFare = 100; 
        } else if (cabType.equals("Mini")) {
            baseFare = 80; 
        } else if (cabType.equals("SUV")) {
            baseFare = 150;
        }

        double distanceCharge = distance * 20; 
        double totalFare = baseFare + distanceCharge;

        double discount = 0;
        if (distance > 20) {
            discount = totalFare * 0.20;
        } else if (distance > 15) {
            discount = totalFare * 0.10;
        } else if (distance > 10) {
            discount = totalFare * 0.05;
        }

        double finalFare = totalFare - discount;

        return finalFare;
    }
    
    

}
