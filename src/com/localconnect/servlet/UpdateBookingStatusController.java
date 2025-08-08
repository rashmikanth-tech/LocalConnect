package com.localconnect.servlet;

import com.localconnect.dto.UserDto;
import com.localconnect.repository.BookingRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/update-booking-status")
public class UpdateBookingStatusController extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        String idStr = req.getParameter("id");

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            // No user in session, redirect to login
            resp.sendRedirect("login.jsp");
            return;
        }

        UserDto user = (UserDto) session.getAttribute("user");

        if (status == null || idStr == null) {
            session.setAttribute("msg", "❌ Invalid request.");
            redirectToPanel(user, resp);
            return;
        }

        try {
            int bookingId = Integer.parseInt(idStr);

            BookingRepositoryImpl bookingRepo = new BookingRepositoryImpl();
            boolean updated = bookingRepo.updateBookingStatus(bookingId, status);

            if (updated) {
                session.setAttribute("msg", "✅ Booking status updated to: " + status);
            } else {
                session.setAttribute("msg", "❌ Failed to update status.");
            }

        } catch (Exception e) {
            session.setAttribute("msg", "❌ Error: " + e.getMessage());
        }

        redirectToPanel(user, resp);
    }

    private void redirectToPanel(UserDto user, HttpServletResponse resp) throws IOException {
        if ("provider".equals(user.getRole())) {
            resp.sendRedirect("manage-bookings.jsp");
        } else {
            resp.sendRedirect("user-dashboard.jsp");
        }
    }
}
