package com.localconnect.service;
import com.localconnect.dto.UserDto;

public interface UserService {
    String validateAndRegister(UserDto dto);
}
