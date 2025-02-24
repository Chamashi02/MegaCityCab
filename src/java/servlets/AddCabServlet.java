package servlets;

import dao.CabDAO;
import models.Cab;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class AddCabServlet extends HttpServlet {

   
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
    
        String cabNumber = request.getParameter("cab_number");
        String model = request.getParameter("model");
        String cabType = request.getParameter("cab_type");
        String capacity = request.getParameter("capacity");
        
        Cab cab = new Cab (0, cabNumber, model, cabType, capacity, "available");
        boolean success = CabDAO.addCab(cab);
        
        response.sendRedirect("viewCabs?status=" + (success ? "success" : "error"));




    }
}
        