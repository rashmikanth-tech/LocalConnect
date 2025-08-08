package com.localconnect.servlet;

import com.localconnect.dto.UserDto;
import com.localconnect.repository.UserRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/change-user-password")
public class ChangeUserPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDto user = (UserDto) session.getAttribute("user");

        String current = request.getParameter("current");
        String newpass = request.getParameter("newpass");
        String confirm = request.getParameter("confirmpass");

        try {
            if (!newpass.equals(confirm)) {
                session.setAttribute("msg", "❌ New passwords do not match!");
                response.sendRedirect("change-user-password.jsp");
                return;
            }

            if (!current.equals(user.getPassword())) {
                session.setAttribute("msg", "❌ Current password is incorrect!");
                response.sendRedirect("change-user-password.jsp");
                return;
            }

            boolean updated = new UserRepositoryImpl().updatePassword(user.getEmail(), newpass);
            if (updated) {
                user.setPassword(newpass); // update in session
                session.setAttribute("user", user);
                session.setAttribute("msg", "✅ Password updated successfully.");
            } else {
                session.setAttribute("msg", "❌ Failed to update password. Try again.");
            }

            response.sendRedirect("change-user-password.jsp");

        } catch (Exception e) {
            session.setAttribute("msg", "❌ Error: " + e.getMessage());
            response.sendRedirect("change-user-password.jsp");
        }
    }
}
