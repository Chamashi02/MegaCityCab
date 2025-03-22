package servlets;

import dao.BookingDAO;
import dao.CabDAO;
import dao.DriverDAO;
import models.User; 
import models.Role; 
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() != Role.admin) { 
            response.sendRedirect("login.jsp"); 
            return;
        }

        // Get counts for dashboard
        int pendingRequests = BookingDAO.getPendingBookingCount();
        int cabsCount = CabDAO.getAllCabsCount();
        int driversCount = DriverDAO.getAllDriversCount();
        int activeBookings = BookingDAO.getActiveBookingCount();

        // Set attributes for the request
        request.setAttribute("pendingRequests", pendingRequests);
        request.setAttribute("cabsCount", cabsCount);
        request.setAttribute("driversCount", driversCount);
        request.setAttribute("activeBookings", activeBookings);

        // Forward request to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("admindashboard.jsp");
        dispatcher.forward(request, response);
    }
}
