package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.DBConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class AuthorizeDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Retrieve form parameters
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String role = "driver";

        // Hash the password using SHA-256
        String hashedPassword = hashPassword(password);
        if (hashedPassword == null) {
            response.sendRedirect("error.jsp?error=Error hashing password");
            return;
        }

        // Insert the new user into the user table
        String sql = "INSERT INTO user (name, username, password, email, phonenumber, address, NIC, role) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, username);
            stmt.setString(3, hashedPassword);
            stmt.setString(4, email);
            stmt.setString(5, phone);
            stmt.setString(6, address);
            stmt.setString(7, nic);
            stmt.setString(8, role);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                // After successful authorization, you can redirect or update accordingly
                response.sendRedirect("viewDrivers?message=Driver Authorized Successfully");
            } else {
                response.sendRedirect("viewDrivers?message=Authorization Failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewDrivers?error=Error occurred during authorization");
        }
    }

    // Method to hash the password using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
