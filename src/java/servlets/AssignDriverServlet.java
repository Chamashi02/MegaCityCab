package servlets;

import java.io.IOException;
import dao.CabDAO;
import dao.DriverDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AssignDriverServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int cabId = Integer.parseInt(request.getParameter("cabId"));
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        
        CabDAO cabDAO = new CabDAO();
        boolean success = cabDAO.assignDriverToCab(cabId, driverId);
        
        if (success) {
            response.sendRedirect("viewCabs?success=Driver assigned successfully!");
        } else {
            response.sendRedirect("viewCabs?error=Failed to assign driver!");
        }
    }
}
