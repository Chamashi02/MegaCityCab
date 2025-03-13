package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.DBConnection;

public class GetCabDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        
        String cabId = request.getParameter("cabId");
        if (cabId == null || cabId.isEmpty()) {
            out.print("Invalid Request");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String query = "SELECT c.cab_number,c.cab_type, d.name, d.phone_number " +
                           "FROM cabs c INNER JOIN driver d ON c.cab_id = d.cab_id " +
                           "WHERE c.cab_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(cabId));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String cabNumber = rs.getString("cab_number");
                String cabType = rs.getString("cab_type");
                String driverName = rs.getString("name");
                String driverPhone = rs.getString("phone_number");
                out.print(cabNumber + "|" + cabType + "|" + driverName + "|" + driverPhone);  // Pipe-separated data
            } else {
                out.print("No Data Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("Error: " + e.getMessage());  // Send error details to the client for debugging
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
