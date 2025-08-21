package com.localconnect.servlet;

import com.localconnect.repository.UserRepositoryImpl;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String newPassword = req.getParameter("newPassword");
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");

        if (email != null) {
            try {
                UserRepositoryImpl repo = new UserRepositoryImpl();
                boolean updated = repo.updatePassword(email, newPassword);

                if (updated) {
                    session.removeAttribute("otp");
                    session.removeAttribute("email");
                    req.setAttribute("message", "Password reset successful! Please login.");
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                } else {
                    req.setAttribute("message", "Failed to update password.");
                    req.getRequestDispatcher("reset-password.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            resp.sendRedirect("forgot-password.jsp");
        }
    }
}
