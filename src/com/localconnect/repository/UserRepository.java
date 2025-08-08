package com.localconnect.repository;

import com.localconnect.dto.UserDto;

public interface UserRepository {
    boolean save(UserDto dto) throws Exception;
    UserDto findByEmailAndPassword(String email, String password);


}
