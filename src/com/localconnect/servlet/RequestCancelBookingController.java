package com.localconnect.servlet;


import com.localconnect.repository.BookingRepositoryImpl;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;

@WebServlet("/cancel-booking")
public class RequestCancelBookingController extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int bookingId = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");

        HttpSession session = req.getSession();

        try {
            BookingRepositoryImpl repo = new BookingRepositoryImpl();

            boolean result = false;
            if ("pending".equals(status)) {
                // Direct cancel
                repo.cancelBooking(bookingId);
                session.setAttribute("bookingMessage", "❌ Booking cancelled.");
            } else if ("accepted".equals(status)) {
                // Request cancel
                result = repo.requestCancellation(bookingId);
                if (result) {
                    session.setAttribute("bookingMessage", "🕒 Cancellation request sent to provider.");
                } else {
                    session.setAttribute("bookingMessage", "❌ Failed to request cancellation.");
                }
            } else {
                session.setAttribute("bookingMessage", "⚠️ Cancellation not allowed.");
            }
        } catch (Exception e) {
            session.setAttribute("bookingMessage", "❌ Error: " + e.getMessage());
        }

        resp.sendRedirect("my-bookings.jsp");
    }
}

