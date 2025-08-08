package com.localconnect.controller;

import com.localconnect.dto.UserDto;
import com.localconnect.repository.UserRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/update-user-profile")
public class UpdateUserProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        UserDto currentUser = (UserDto) session.getAttribute("user");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");

        currentUser.setName(name);
        currentUser.setEmail(email);
        currentUser.setMobile(mobile);

        try {
            boolean updated = new UserRepositoryImpl().updateUserProfile(currentUser);

            if (updated) {
                // Update the user in session too
                session.setAttribute("user", currentUser);
                session.setAttribute("updateMessage", "✅ Profile updated successfully!");
            } else {
                session.setAttribute("updateMessage", "❌ Failed to update profile.");
            }

            // Always redirect to JSP after POST to avoid form resubmission
            response.sendRedirect("edit-user-profile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("updateMessage", "❌ Error: " + e.getMessage());
            response.sendRedirect("edit-user-profile.jsp");
        }
    }
}
