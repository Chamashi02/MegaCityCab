package servlets;

import dao.BookingDAO;
import models.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class BookingHistoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp"); // Redirect if not logged in
            return;
        }

        List<Booking> bookingHistory = BookingDAO.getBookingHistoryByUserId(userId);
        request.setAttribute("bookingHistory", bookingHistory);
        request.getRequestDispatcher("bookingHistory.jsp").forward(request, response);
    }
}
