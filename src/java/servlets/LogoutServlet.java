package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get the existing session, don't create a new one
        if (session != null) {
            session.invalidate(); // Invalidate the session
        }

        // Remove JSESSIONID cookie
        Cookie cookie = new Cookie("JSESSIONID", "");
        cookie.setPath(request.getContextPath());
        cookie.setMaxAge(0); // Expire the cookie immediately
        response.addCookie(cookie);

        // Make sure the new session doesn't get created automatically
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // Prevent caching
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
}
