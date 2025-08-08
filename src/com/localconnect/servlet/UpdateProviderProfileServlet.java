package com.localconnect.servlet;

import com.localconnect.dto.UserDto;
import com.localconnect.repository.UserRepositoryImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/update-provider-profile")
public class UpdateProviderProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserDto user = (UserDto) session.getAttribute("user");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // Call DB update
            UserRepositoryImpl repo = new UserRepositoryImpl();

            if (password != null && !password.isEmpty()) {
                if (!password.equals(confirmPassword)) {
                    session.setAttribute("updateMessage", "Passwords do not match.");
                    response.sendRedirect("provider-profile.jsp"); // or edit-profile.jsp
                    return;
                }
                repo.updateNameEmailPassword(user.getId(), name, email, password);
            } else {
                repo.updateNameAndEmail(user.getId(), name, email);
            }

            // Update session
            user.setName(name);
            user.setEmail(email);
            session.setAttribute("user", user);
            session.setAttribute("updateMessage", "Profile updated successfully!");
            response.sendRedirect("provider-dashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
