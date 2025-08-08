package com.localconnect.repository;

import com.localconnect.dto.ReviewDto;
import java.sql.*;
import java.util.*;

public class ReviewRepositoryImpl {

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/localconnect", "root", "yourpassword");
    }

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

    public List<ReviewDto> getByProviderId(int providerId) {
        List<ReviewDto> list = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE provider_id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, providerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReviewDto r = new ReviewDto();
                r.setId(rs.getInt("id"));
                r.setBookingId(rs.getInt("booking_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setProviderId(providerId);
                r.setComment(rs.getString("comment"));
                r.setRating(rs.getInt("rating"));
                r.setCreatedAt(rs.getString("created_at"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
