package com.localconnect.repository;


import com.localconnect.dto.ServiceBookingDto;

import java.util.List;

public interface BookingRepository {
    boolean createBooking(int serviceId, int userId) throws Exception;

    List<ServiceBookingDto> getBookingsByProvider(String providerEmail) throws Exception;

    List<ServiceBookingDto> getBookingsByUser(int userId) throws Exception;

    boolean updateBookingStatus(int bookingId, String status) throws Exception;

    void cancelBooking(int bookingId) throws Exception;
}

