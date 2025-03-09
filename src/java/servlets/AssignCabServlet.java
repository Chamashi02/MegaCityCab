package servlets;

import dao.BookingDAO;
import dao.CabDAO;
import models.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class AssignCabServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("confirm".equals(action)) {
            // Confirm booking logic
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            boolean success = BookingDAO.updateBookingStatus(bookingId, "Confirmed");
            if (success) {
                response.sendRedirect("manageBookings.jsp");
            }
        } else if ("cancel".equals(action)) {
            // Cancel booking logic
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            boolean success = BookingDAO.updateBookingStatus(bookingId, "Cancelled");
            if (success) {
                response.sendRedirect("manageBookings.jsp");
            }
        } else if ("assignCab".equals(action)) {
            System.out.println("assignCab called");
            // Assign cab to booking logic
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int cabId = Integer.parseInt(request.getParameter("cabId"));
            System.out.println("Assigning Cab ID: " + cabId + " to Booking ID: " + bookingId);

            boolean success = CabDAO.assignCabToBooking(cabId, bookingId);
            if (success) {
                BookingDAO.updateBookingStatus(bookingId, "Assigned");
                response.sendRedirect("manageBookings.jsp");
            }
        }
    }
}
