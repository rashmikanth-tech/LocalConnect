package com.localconnect.repository;

import com.localconnect.dto.ServiceBookingDto;
import com.localconnect.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static com.localconnect.util.DBUtil.getConnection;

public class BookingRepositoryImpl implements BookingRepository {

    // Insert new booking
    public boolean createBooking(int serviceId, int userId) throws Exception {
        Connection conn = getConnection();
        String sql = "INSERT INTO service_bookings (service_id, user_id, status) VALUES (?, ?, 'pending')";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, serviceId);
        stmt.setInt(2, userId);
        boolean inserted = stmt.executeUpdate() > 0;
        conn.close();
        return inserted;
    }

    // Get bookings by provider email (joining with service + user)
    public List<ServiceBookingDto> getBookingsByProvider(String providerEmail) throws Exception {
        Connection conn = getConnection();
        String sql = "SELECT b.* FROM service_bookings b JOIN services s ON b.service_id = s.id WHERE s.posted_by = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, providerEmail);
        ResultSet rs = stmt.executeQuery();

        List<ServiceBookingDto> list = new ArrayList<>();
        while (rs.next()) {
            ServiceBookingDto dto = new ServiceBookingDto();
            dto.setId(rs.getInt("id"));
            dto.setServiceId(rs.getInt("service_id"));
            dto.setUserId(rs.getInt("user_id"));
            dto.setStatus(rs.getString("status"));
            dto.setCreatedAt(rs.getTimestamp("created_at"));
            dto.setCancelRequest(rs.getBoolean("cancel_request"));
            list.add(dto);
        }
        conn.close();
        return list;
    }

    // Get bookings for user
    public List<ServiceBookingDto> getBookingsByUser(int userId) throws Exception {
        Connection conn = getConnection();
        String sql = "SELECT * FROM service_bookings WHERE user_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();

        List<ServiceBookingDto> list = new ArrayList<>();
        while (rs.next()) {
            ServiceBookingDto dto = new ServiceBookingDto();
            dto.setId(rs.getInt("id"));
            dto.setServiceId(rs.getInt("service_id"));
            dto.setUserId(rs.getInt("user_id"));
            dto.setStatus(rs.getString("status"));
            dto.setCreatedAt(rs.getTimestamp("created_at"));
            dto.setCancelRequest(rs.getBoolean("cancel_request"));
            list.add(dto);
        }
        conn.close();
        return list;
    }

    // Update booking status (accept/reject)
    public boolean updateBookingStatus(int bookingId, String status) throws Exception {
        Connection conn = getConnection();
        String sql = "UPDATE service_bookings SET status = ? WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, status);
        stmt.setInt(2, bookingId);
        boolean updated = stmt.executeUpdate() > 0;
        conn.close();
        return updated;
    }

    // Optional: Cancel booking (user side)
    public void cancelBooking(int bookingId) throws Exception {
        Connection conn = getConnection();
        String sql = "DELETE FROM service_bookings WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bookingId);
        stmt.executeUpdate();
        conn.close();
    }

    // Send cancellation request
    public boolean requestCancellation(int bookingId) throws Exception {
        Connection conn = getConnection();
        String sql = "UPDATE service_bookings SET cancel_request = TRUE WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bookingId);
        boolean updated = stmt.executeUpdate() > 0;
        conn.close();
        return updated;
    }

    // Return booking status for a booking id and verify the booking belongs to the userId (for security)
    public String getBookingStatus(int bookingId, int userId) {
        String sql = "SELECT status FROM service_bookings WHERE id = ? AND user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("status");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean markBookingReviewed(int bookingId) {
        String sql = "UPDATE service_bookings SET reviewed = TRUE WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


}
