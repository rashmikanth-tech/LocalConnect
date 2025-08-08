package com.localconnect.dto;

import java.io.Serializable;

public class ServiceDto implements Serializable {
    private int id;
    private String status;
    private String serviceName;
    private String location;
    private String contact;
    private String description;
    private String postedBy;  // Still useful (email or username)
    private int postedById;   // 👈 Add this for linking to view-provider.jsp

    public ServiceDto() {}

    public ServiceDto(String serviceName, String location, String contact, String description, String postedBy, int postedById) {
        this.serviceName = serviceName;
        this.location = location;
        this.contact = contact;
        this.description = description;
        this.postedBy = postedBy;
        this.postedById = postedById;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPostedBy() { return postedBy; }
    public void setPostedBy(String postedBy) { this.postedBy = postedBy; }

    public int getPostedById() { return postedById; }
    public void setPostedById(int postedById) { this.postedById = postedById; }
}
