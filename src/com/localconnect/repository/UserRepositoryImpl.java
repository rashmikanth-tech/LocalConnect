package com.localconnect.repository;

import com.localconnect.dto.UserDto;
import com.localconnect.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserRepositoryImpl implements UserRepository {

    @Override
    public boolean save(UserDto dto) throws Exception {
        Connection connection = DBUtil.getConnection();

        // Check if email already exists
        PreparedStatement check = connection.prepareStatement(
                "SELECT * FROM users WHERE email=?"
        );
        check.setString(1, dto.getEmail());
        ResultSet resultSet = check.executeQuery();
        if (resultSet.next()) {
            connection.close();
            return false;
        }

        // Insert new user
        String sql = "INSERT INTO users(name, email, password, role) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, dto.getName());
        stmt.setString(2, dto.getEmail());
        stmt.setString(3, dto.getPassword());
        stmt.setString(4, dto.getRole());

        int row = stmt.executeUpdate();
        connection.close();
        return row > 0;
    }

    @Override
    public UserDto findByEmailAndPassword(String email, String password) {
        try (Connection conn = DBUtil.getConnection()) {
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                UserDto dto = new UserDto();
                dto.setId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setEmail(rs.getString("email"));
                dto.setPassword(rs.getString("password"));
                dto.setMobile(rs.getString("mobile"));
                dto.setRole(rs.getString("role"));
                return dto;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateNameAndEmail(int id, String name, String email) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE users SET name = ?, email = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setInt(3, id);
            stmt.executeUpdate();
        }
    }

    public void updateNameEmailPassword(int id, String name, String email, String password) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE users SET name = ?, email = ?, password = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setInt(4, id);
            stmt.executeUpdate();
        }
    }

    public UserDto getById(int id) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM users WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                UserDto user = new UserDto();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setRole(rs.getString("role"));
                return user;
            }
            return null;
        }
    }

    public boolean updateUserProfile(UserDto user) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE users SET name=?, email=?, mobile=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getMobile());
            stmt.setInt(4, user.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updatePassword(String email, String newPassword) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE users SET password = ? WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean findByEmail(String email) throws Exception {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT id FROM users WHERE email=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

}
