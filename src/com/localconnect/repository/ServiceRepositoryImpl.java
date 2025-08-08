package com.localconnect.repository;

import com.localconnect.dto.ServiceDto;
import com.localconnect.util.DBUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ServiceRepositoryImpl implements ServiceRepository{
    public boolean save(ServiceDto dto) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/localconnect", "root", "@Mysql182530");

        // ✅ No need to mention "id" in the INSERT query
        String sql = "INSERT INTO services(service_name, location, contact, description, posted_by, posted_by_id, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, dto.getServiceName());
        stmt.setString(2, dto.getLocation());
        stmt.setString(3, dto.getContact());
        stmt.setString(4, dto.getDescription());
        stmt.setString(5, dto.getPostedBy());
        stmt.setInt(6, dto.getPostedById()); // ← NEW!
        stmt.setString(7, "active");



        int row = stmt.executeUpdate();
        conn.close();
        return row > 0;
    }

    public List<ServiceDto> getAllByEmail(String email) throws Exception {
        List<ServiceDto> list = new ArrayList<>();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/localconnect", "root", "@Mysql182530");

        String sql = "SELECT * FROM services WHERE posted_by=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {

            ServiceDto dto = new ServiceDto();
            dto.setStatus(rs.getString("status"));
            dto.setId(rs.getInt("id"));
            dto.setServiceName(rs.getString("service_name"));
            dto.setLocation(rs.getString("location"));
            dto.setContact(rs.getString("contact"));
            dto.setDescription(rs.getString("description"));
            dto.setPostedBy(rs.getString("posted_by"));
            list.add(dto);
        }
        conn.close();
        return list;
    }
    public ServiceDto getById(int id) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/localconnect", "root", "@Mysql182530");

        String sql = "SELECT * FROM services WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            ServiceDto dto = new ServiceDto();
            dto.setStatus(rs.getString("status"));
            dto.setId(rs.getInt("id"));
            dto.setServiceName(rs.getString("service_name"));
            dto.setLocation(rs.getString("location"));
            dto.setContact(rs.getString("contact"));
            dto.setDescription(rs.getString("description"));
            dto.setPostedBy(rs.getString("posted_by"));
            dto.setPostedById(rs.getInt("posted_by_id")); // ✅ FIXED: This line was missing
            conn.close();
            return dto;
        }
        conn.close();
        return null;
    }



    public boolean update(ServiceDto dto) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/localconnect", "root", "@Mysql182530")) {
            String sql = "UPDATE services SET service_name=?, location=?, contact=?, description=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, dto.getServiceName());
            stmt.setString(2, dto.getLocation());
            stmt.setString(3, dto.getContact());
            stmt.setString(4, dto.getDescription());
            stmt.setInt(5, dto.getId());

            return stmt.executeUpdate() > 0;
        }
    }



    public void delete(int id) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/localconnect", "root", "@Mysql182530");

        String sql = "DELETE FROM services WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
        conn.close();
    }

    // Get current status by service ID
    public String getStatusById(int id) throws Exception {
        Connection conn = DBUtil.getConnection();
        String query = "SELECT status FROM services WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getString("status");
        }
        return "inactive"; // default fallback
    }

    // Update status (active/inactive)
    public boolean updateStatus(int id, String status) throws Exception {
        Connection conn = DBUtil.getConnection();
        String query = "UPDATE services SET status = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, status);
        ps.setInt(2, id);
        return ps.executeUpdate() > 0;
    }


    public List<ServiceDto> searchByNameOrLocation(String email, String keyword) throws Exception {
        List<ServiceDto> list = new ArrayList<>();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/localconnect", "root", "@Mysql182530");

        String sql = "SELECT * FROM services WHERE posted_by=? AND (service_name LIKE ? OR location LIKE ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, "%" + keyword + "%");
        stmt.setString(3, "%" + keyword + "%");
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            ServiceDto dto = new ServiceDto();
            dto.setId(rs.getInt("id"));
            dto.setServiceName(rs.getString("service_name"));
            dto.setLocation(rs.getString("location"));
            dto.setContact(rs.getString("contact"));
            dto.setDescription(rs.getString("description"));
            dto.setPostedBy(rs.getString("posted_by"));
            dto.setStatus(rs.getString("status"));
            list.add(dto);
        }

        conn.close();
        return list;
    }


    public List<ServiceDto> getByStatus(String email, String status) throws Exception {
        List<ServiceDto> list = new ArrayList<>();
        Connection conn = DBUtil.getConnection();

        String sql = "SELECT * FROM services WHERE posted_by = ? AND status = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, status);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            ServiceDto dto = new ServiceDto();
            dto.setId(rs.getInt("id"));
            dto.setServiceName(rs.getString("service_name"));
            dto.setLocation(rs.getString("location"));
            dto.setContact(rs.getString("contact"));
            dto.setDescription(rs.getString("description"));
            dto.setPostedBy(rs.getString("posted_by"));
            dto.setStatus(rs.getString("status"));
            list.add(dto);
        }

        conn.close();
        return list;
    }



    public List<ServiceDto> searchByEmailAndKeyword(String email, String keyword) throws Exception {
        List<ServiceDto> list = new ArrayList<>();
        Connection conn = DBUtil.getConnection();

        String sql = "SELECT * FROM services WHERE posted_by = ? AND (service_name LIKE ? OR location LIKE ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, "%" + keyword + "%");
        stmt.setString(3, "%" + keyword + "%");
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            ServiceDto dto = new ServiceDto();
            dto.setId(rs.getInt("id"));
            dto.setServiceName(rs.getString("service_name"));
            dto.setLocation(rs.getString("location"));
            dto.setContact(rs.getString("contact"));
            dto.setDescription(rs.getString("description"));
            dto.setPostedBy(rs.getString("posted_by"));
            dto.setStatus(rs.getString("status"));
            list.add(dto);
        }

        conn.close();
        return list;
    }

    // ✅ Search active services by keyword (used when user searches)
    public List<ServiceDto> searchByKeyword(String keyword) {
        List<ServiceDto> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM services WHERE status='active' AND (service_name LIKE ? OR location LIKE ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ServiceDto s = new ServiceDto();
                s.setId(rs.getInt("id"));
                s.setServiceName(rs.getString("service_name"));
                s.setLocation(rs.getString("location"));
                s.setDescription(rs.getString("description"));
                s.setPostedBy(rs.getString("posted_by"));
                s.setPostedById(rs.getInt("posted_by_id"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // ✅ Get all active services (used when no search keyword is provided)
    public List<ServiceDto> getAllActive() {
        List<ServiceDto> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM services WHERE status='active'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ServiceDto s = new ServiceDto();
                s.setId(rs.getInt("id"));
                s.setServiceName(rs.getString("service_name"));
                s.setLocation(rs.getString("location"));
                s.setDescription(rs.getString("description"));
                s.setPostedBy(rs.getString("posted_by"));
                s.setPostedById(rs.getInt("posted_by_id")); // You must have this field in your table & DTO
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }




}

