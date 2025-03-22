package servlets;

import dao.BookingDAO;
import dao.DriverDAO;
import models.Booking;
import models.Role;
import models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/driverDashboard")
public class DriverDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        System.out.println("DriverDashboardServlet called");

        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() != Role.driver) {  
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();  

        int driverId = DriverDAO.getDriverIdByUserId(userId);
        if (driverId == -1) {
            request.setAttribute("error", "No associated driver profile found.");
            request.getRequestDispatcher("driverDashboard.jsp").forward(request, response);
            return;
        }

        int cabId = DriverDAO.getCabIdByDriver(driverId);
        if (cabId == -1) {
            request.setAttribute("error", "No cab assigned to you.");
        } else {
            List<Booking> bookings = BookingDAO.getBookingsForCab(cabId);
            request.setAttribute("bookings", bookings);
        }

        request.getRequestDispatcher("driverDashboard.jsp").forward(request, response);
    }
}
