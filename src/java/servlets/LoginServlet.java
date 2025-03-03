package servlets;

import dao.UserDAO;
import models.Role;
import models.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class LoginServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
                String username = request.getParameter("uid");
                String password = request.getParameter("pass");
                
                //Hash th entered password using SHA-256
                String hashedPassword = hashPassword(password);
                
                List<User> userDetails = UserDAO.validate(username, hashedPassword);
                
                if (!userDetails.isEmpty()){
                    User user = userDetails.get(0);
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    
                    //Check the role
                    if(user.getRole().equals(Role.admin)){
                    response.sendRedirect("admindashboard.jsp");
                    }else{
                        response.sendRedirect("bookTrip.jsp");
                    }
                }else{
                    response.sendRedirect("login.jsp?error=Invalid credentials");
                }
                
    }

    //Helper function to hash the password using SHA-256
    private String hashPassword(String password) {
        try{
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
            
        }catch (NoSuchAlgorithmException e){
            e.printStackTrace();
            return null;
        }
        
    }

}
