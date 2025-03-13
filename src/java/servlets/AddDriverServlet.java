package servlets;

import dao.DriverDAO;
import models.Driver;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String license = request.getParameter("license_number");
        String phone = request.getParameter("phone_number");
        String address = request.getParameter("address");
        boolean isAuthorized = false;

        Driver driver = new Driver(0, name, license, phone, address, "available","","", isAuthorized);
        boolean success = DriverDAO.addDriver(driver);

        response.sendRedirect("viewDrivers?status=" + (success ? "success" : "error"));
    }
}