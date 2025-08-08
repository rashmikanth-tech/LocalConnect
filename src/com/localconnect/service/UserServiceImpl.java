package com.localconnect.service;

import com.localconnect.dto.UserDto;
import com.localconnect.repository.UserRepository;
import com.localconnect.repository.UserRepositoryImpl;

public class UserServiceImpl implements UserService {

    @Override
    public String validateAndRegister(UserDto dto) {
        if (dto.getName() == null || dto.getName().length() < 3) {
            return "Name must be at least 3 characters.";
        }
        if (dto.getEmail() == null || !dto.getEmail().contains("@")) {
            return "Invalid email.";
        }
        if (dto.getPassword() == null || dto.getPassword().length() < 6) {
            return "Password must be at least 6 characters.";
        }
        UserRepository repo = new UserRepositoryImpl();
        try {
            boolean saved = repo.save(dto);
            return saved ? "registered" : "email_exists";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
}
