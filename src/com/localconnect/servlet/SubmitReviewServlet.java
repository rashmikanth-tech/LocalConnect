package com.localconnect.servlet;

import com.localconnect.dto.ReviewDto;
import com.localconnect.dto.UserDto;
import com.localconnect.repository.ReviewRepositoryImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDto user = (UserDto) session.getAttribute("user");

        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        int providerId = Integer.parseInt(req.getParameter("providerId"));
        int rating = Integer.parseInt(req.getParameter("rating"));
        String comment = req.getParameter("comment");

        ReviewDto review = new ReviewDto();
        review.setBookingId(bookingId);
        review.setUserId(user.getId());
        review.setProviderId(providerId);
        review.setRating(rating);
        review.setComment(comment);

        ReviewRepositoryImpl repo = new ReviewRepositoryImpl();
        boolean saved = repo.addReview(review);

        if (saved) {
            session.setAttribute("bookingMessage", "✅ Review submitted!");
        } else {
            session.setAttribute("bookingMessage", "❌ Failed to submit review.");
        }

        res.sendRedirect("my-bookings.jsp");
    }
}
