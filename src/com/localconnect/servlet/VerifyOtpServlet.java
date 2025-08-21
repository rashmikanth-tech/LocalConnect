package com.localconnect.servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int enteredOtp = Integer.parseInt(req.getParameter("otp"));

        HttpSession session = req.getSession();
        Integer savedOtp = (Integer) session.getAttribute("otp");

        if (savedOtp != null && enteredOtp == savedOtp) {
            // OTP is correct → forward to reset password page
            RequestDispatcher rd = req.getRequestDispatcher("reset-password.jsp");
            rd.forward(req, resp);
        } else {
            req.setAttribute("message", "Invalid OTP, please try again.");
            RequestDispatcher rd = req.getRequestDispatcher("verify-otp.jsp");
            rd.forward(req, resp);
        }
    }
}
