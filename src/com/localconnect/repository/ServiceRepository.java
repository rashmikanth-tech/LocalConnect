package com.localconnect.repository;

import com.localconnect.dto.ServiceDto;

public interface ServiceRepository {
    boolean save(ServiceDto dto) throws Exception;
}

