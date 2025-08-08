package com.localconnect.controller;

import com.localconnect.repository.BookingRepositoryImpl;
import com.localconnect.dto.UserDto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/book-service")
public class BookServiceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDto user = (UserDto) session.getAttribute("user");

        // Check if user is logged in and is a user
        if (user == null || !"user".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int userId = user.getId();

            BookingRepositoryImpl repo = new BookingRepositoryImpl();
            boolean success = repo.createBooking(serviceId, userId);

            if (success) {
                session.setAttribute("bookingMessage", "✅ Booking request sent successfully.");
            } else {
                session.setAttribute("bookingMessage", "❌ Failed to send booking request.");
            }

            response.sendRedirect("search-services.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("bookingMessage", "❌ Something went wrong: " + e.getMessage());
            response.sendRedirect("search-services.jsp");
        }
    }
}
