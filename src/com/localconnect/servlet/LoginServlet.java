package com.localconnect.servlet;

import com.localconnect.dto.UserDto;
import com.localconnect.repository.UserRepository;
import com.localconnect.repository.UserRepositoryImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = "/login", loadOnStartup = 2)
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserRepository repo = new UserRepositoryImpl();
        UserDto dto = repo.findByEmailAndPassword(email, password);

        if (dto != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", dto);

            // Redirect based on role
            if ("provider".equals(dto.getRole())) {
                resp.sendRedirect("provider-dashboard.jsp");
            } else {
                resp.sendRedirect("user-dashboard.jsp");
            }

        } else {
            // Invalid login
            req.setAttribute("message", "Invalid email or password.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
