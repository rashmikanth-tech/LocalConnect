package com.localconnect.repository;

import com.localconnect.dto.ReviewDto;
import com.localconnect.dto.ReviewSummaryDto;
import com.localconnect.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ReviewRepositoryImpl {

    // Use DBUtil for connection (centralized)
    private Connection getConnection() throws Exception {
        return DBUtil.getConnection();
    }

    // Insert a review
    public boolean addReview(ReviewDto review) {
        String sql = "INSERT INTO reviews (booking_id, user_id, provider_id, comment, rating, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getBookingId());
            ps.setInt(2, review.getUserId());
            ps.setInt(3, review.getProviderId());
            ps.setString(4, review.getComment());
            ps.setInt(5, review.getRating());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check if a user already reviewed a booking (prevent duplicates)
    public boolean hasUserReviewed(int bookingId, int userId) {
        String sql = "SELECT COUNT(*) FROM reviews WHERE booking_id = ? AND user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get reviews for a provider with reviewer name
    public List<ReviewDto> getReviewsByProvider(int providerId) {
        List<ReviewDto> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.name AS userName, r.created_at AS created_at_ts " +
                "FROM reviews r " +
                "JOIN users u ON r.user_id = u.id " +
                "WHERE r.provider_id = ? " +
                "ORDER BY r.created_at DESC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, providerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReviewDto review = new ReviewDto();
                review.setId(rs.getInt("id"));
                review.setBookingId(rs.getInt("booking_id"));
                review.setUserId(rs.getInt("user_id"));
                review.setProviderId(providerId);
                review.setUserName(rs.getString("userName"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));

                Timestamp ts = rs.getTimestamp("created_at_ts");
                if (ts != null) review.setCreatedAt(new Date(ts.getTime()));

                reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Simple summary DTO: average rating and total reviews
    public ReviewSummaryDto getReviewSummary(int providerId) {
        ReviewSummaryDto summary = new ReviewSummaryDto();
        String sql = "SELECT AVG(rating) AS avgRating, COUNT(*) AS totalReviews FROM reviews WHERE provider_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, providerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                summary.setAvgRating(rs.getDouble("avgRating"));
                summary.setTotalReviews(rs.getInt("totalReviews"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return summary;
    }



    public double getAverageRatingByProvider(int providerId) {
        double avg = 0.0;
        String sql = "SELECT AVG(rating) AS avg_rating FROM reviews WHERE provider_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, providerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                avg = rs.getDouble("avg_rating");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return avg;
    }

}
