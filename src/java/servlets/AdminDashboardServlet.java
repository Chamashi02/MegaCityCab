package servlets;

import dao.BookingDAO;
import dao.CabDAO;
import dao.DriverDAO;
import models.User;  // Ensure User model is imported
import models.Role;  // Ensure Role enum is imported
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Ensure the user is logged in and has admin privileges
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() != Role.admin) { 
            response.sendRedirect("login.jsp"); 
            return;
        }

        // Get counts for dashboard
        int pendingRequests = BookingDAO.getPendingBookingCount();
        int cabsCount = CabDAO.getAllCabsCount();
        int driversCount = DriverDAO.getAllDriversCount();

        // Set attributes for the request
        request.setAttribute("pendingRequests", pendingRequests);
        request.setAttribute("cabsCount", cabsCount);
        request.setAttribute("driversCount", driversCount);

        // Forward request to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("admindashboard.jsp");
        dispatcher.forward(request, response);
    }
}
