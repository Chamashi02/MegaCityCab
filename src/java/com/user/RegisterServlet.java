package com.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class RegisterServlet extends HttpServlet {

    protected void doPost (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //Retrieve form parameters
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phone");
        String address = request.getParameter("address");
        String NIC = request.getParameter("nic");
        String role = "customer";
        
        //Hash the password using SHA-256
        String hashedPassword = hashPassword(password);
        
        //Database connection parameters
        String url = "jdbc:mysql://localhost:3306/megacitycab";
        String user = "root";
        String pass = "Mashi@@##02";
        
        try {
            //Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            //Establish databse connection
            Connection con = DriverManager.getConnection(url,user,pass);

            //Insert user details into the database
            String sql = "INSERT INTO user (name, username, password, email, phonenumber, address, NIC, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, username);
            stmt.setString(3, hashedPassword);
            stmt.setString(4, email);
            stmt.setString(5, phonenumber);
            stmt.setString(6, address);;
            stmt.setString(7, NIC);
            stmt.setString(8, role);

            int rowsInserted = stmt.executeUpdate();
            stmt.close();
            con.close();

            if (rowsInserted > 0) {
                response.sendRedirect("login.jsp?message=Registration Successful, Please Login");
            } else {
                response.sendRedirect("login.jsp?message=Registration Failed, Try Again");
            }

        }catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Something went wrong, Try again");
        }
        }
    
    //Methid to hash the password using SHA-256
    private String hashPassword(String password) {
        try{
            //Get the MessageDigest instnace for SHA-256
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            
            //Hash the password bytes
            byte[] hashBytes = digest.digest(password.getBytes());
            
            //Convert the byte array info a hexadecimal string
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                hexString.append(String.format("%02x", b));
            }
            
            return hexString.toString(); //Return the hashed password as a hexadecimal string
        }catch (NoSuchAlgorithmException e){
            e.printStackTrace();
            return null; //Return null if an error occurs}
        }
    }
}
