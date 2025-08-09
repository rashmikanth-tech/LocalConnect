package com.localconnect.servlet;

import com.localconnect.dto.ReviewDto;
import com.localconnect.dto.UserDto;
import com.localconnect.repository.ReviewRepositoryImpl;
import com.localconnect.repository.BookingRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/submit-review")
public class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }
        UserDto user = (UserDto) session.getAttribute("user");

        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        int providerId = Integer.parseInt(req.getParameter("providerId"));
        int rating = Integer.parseInt(req.getParameter("rating"));
        String comment = req.getParameter("comment");

        ReviewRepositoryImpl reviewRepo = new ReviewRepositoryImpl();
        BookingRepositoryImpl bookingRepo = new BookingRepositoryImpl();

        // Ensure booking belongs to user and is closed
        String currentStatus = bookingRepo.getBookingStatus(bookingId, user.getId());
        if (currentStatus == null || !"closed".equalsIgnoreCase(currentStatus)) {
            session.setAttribute("bookingMessage", "❌ You can only review after the booking is closed.");
            res.sendRedirect("my-bookings.jsp");
            return;
        }

        // Prevent duplicate review
        if (reviewRepo.hasUserReviewed(bookingId, user.getId())) {
            session.setAttribute("bookingMessage", "⚠ You have already reviewed this booking.");
            res.sendRedirect("my-bookings.jsp");
            return;
        }

        // Save review
        ReviewDto review = new ReviewDto();
        review.setBookingId(bookingId);
        review.setUserId(user.getId());
        review.setProviderId(providerId);
        review.setRating(rating);
        review.setComment(comment);

        boolean saved = reviewRepo.addReview(review);

        if (saved) {
            bookingRepo.markBookingReviewed(bookingId);
            session.setAttribute("bookingMessage", "✅ Review submitted!");
        } else {
            session.setAttribute("bookingMessage", "❌ Failed to submit review.");
        }

        res.sendRedirect("my-bookings.jsp");
    }
}
