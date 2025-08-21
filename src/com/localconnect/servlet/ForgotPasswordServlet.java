package com.localconnect.servlet;

import com.localconnect.repository.UserRepositoryImpl;
import com.localconnect.util.EmailUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        UserRepositoryImpl repo = new UserRepositoryImpl();

        try {
            // Check if user exists
            if (repo.findByEmail(email)) {
                // Generate OTP
                Random random = new Random();
                int otp = 100000 + random.nextInt(900000);

                // Store OTP in session
                HttpSession session = req.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("email", email);

                // TODO: Send OTP to user's email (for now just print/log it)
                System.out.println("Generated OTP for " + email + " = " + otp);
                // After generating OTP
                String subject = "Your OTP Code";
                String body = "Your OTP is: " + otp + "\nThis will expire in 5 minutes.";

                EmailUtil.sendEmail(email, subject, body);


                // ✅ Use "success" instead of "message"
                req.setAttribute("success", "OTP has been sent successfully to your email.");
                RequestDispatcher rd = req.getRequestDispatcher("verify-otp.jsp");
                rd.forward(req, resp);

            } else {
                // If email not registered → redirect with query param
                resp.sendRedirect("forgot-password.jsp?error=Email+not+registered");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // On error → show message on same page
            req.setAttribute("message", "Something went wrong, try again.");
            RequestDispatcher rd = req.getRequestDispatcher("forgot-password.jsp");
            rd.forward(req, resp);
        }
    }
}
