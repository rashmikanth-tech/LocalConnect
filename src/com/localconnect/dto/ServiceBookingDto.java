package com.localconnect.dto;


import java.io.Serializable;
import java.sql.Timestamp;

public class ServiceBookingDto implements Serializable {
    private int id;
    private boolean cancelRequest;
    private int serviceId;
    private int userId;
    private String status;
    private Timestamp createdAt;



    public boolean isCancelRequest() {
        return cancelRequest;
    }

    public void setCancelRequest(boolean cancelRequest) {
        this.cancelRequest = cancelRequest;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}

