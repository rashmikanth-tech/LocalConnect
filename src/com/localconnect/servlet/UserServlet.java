package com.localconnect.servlet;

import com.localconnect.dto.UserDto;
import com.localconnect.service.UserService;
import com.localconnect.service.UserServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = "/register", loadOnStartup = 1)
public class UserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        UserDto dto = new UserDto(name, email, password, role);
        UserService service = new UserServiceImpl();
        String result = service.validateAndRegister(dto);

        if ("registered".equals(result)) {
            // ✅ Redirect to login.jsp with success message
            req.setAttribute("success", "Registration successful! Please log in.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
            dispatcher.forward(req, resp);
        } else {
            // ⛔ Show error on registration form
            req.setAttribute("message", result);
            req.setAttribute("dto", dto);
            RequestDispatcher dispatcher = req.getRequestDispatcher("register.jsp");
            dispatcher.forward(req, resp);
        }

    }
}
