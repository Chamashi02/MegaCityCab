package servlets;

import java.io.IOException;
import dao.CabDAO;
import jakarta.servlet.RequestDispatcher;
import models.Cab;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

public class ViewCabsServlet extends HttpServlet {
    private static final long serialVersionUID =1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("ViewCabsServlet triggered!");
        
        CabDAO cabDAO = new CabDAO();
        List<Cab> cabs = cabDAO.getAllCabs();
        
        System.out.println("🟢 Retrieved " + cabs.size() + " cabs from DB."); // Debugging log

        request.setAttribute("cabList", cabs);
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewCabs.jsp");
        dispatcher.forward(request, response);
        
        }
    }

    


