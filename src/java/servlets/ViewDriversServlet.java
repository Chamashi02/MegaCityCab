package servlets;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.DriverDAO;
import models.Driver;

public class ViewDriversServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("🔵 ViewDriversServlet triggered!"); // Debugging log

        DriverDAO driverDAO = new DriverDAO();
        List<Driver> drivers = driverDAO.getAllDrivers();

        System.out.println("🟢 Retrieved " + drivers.size() + " drivers from DB."); // Debugging log

        request.setAttribute("driverList", drivers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewDrivers.jsp");
        dispatcher.forward(request, response);
    }
}