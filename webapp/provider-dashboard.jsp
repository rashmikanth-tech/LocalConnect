<!-- Updated version of provider-dashboard.jsp with better Bootstrap design and animations -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="com.localconnect.dto.ServiceDto" %>
<%@ page import="com.localconnect.dto.UserDto" %>
<%@ page import="com.localconnect.repository.ServiceRepositoryImpl" %>

<%
String updateMsg = null;
String postMsg = null;
String userName = null;

if (session != null) {
updateMsg = (String) session.getAttribute("updateMessage");
postMsg = (String) session.getAttribute("postMessage");
userName = (UserDto) session.getAttribute("user") != null ? ((UserDto) session.getAttribute("user")).getName() : null;
session.removeAttribute("updateMessage");
session.removeAttribute("postMessage");
}

UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"provider".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}

ServiceRepositoryImpl repo = new ServiceRepositoryImpl();
String search = request.getParameter("search");
String status = request.getParameter("status");
List<ServiceDto> services;

    if (search != null && !search.isEmpty()) {
    services = repo.searchByEmailAndKeyword(user.getEmail(), search);
    } else if (status != null && !status.isEmpty()) {
    services = repo.getByStatus(user.getEmail(), status);
    } else {
    services = repo.getAllByEmail(user.getEmail());
    }

    int total = services.size(), active = 0, inactive = 0;
    for (ServiceDto s : services) {
    if ("active".equalsIgnoreCase(s.getStatus())) active++;
    else if ("inactive".equalsIgnoreCase(s.getStatus())) inactive++;
    }
    %>
    <% if (services.isEmpty()) { %>
    <tr><td colspan="5" class="text-center text-muted">No services found.</td></tr>
    <% } %>


    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Provider Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            body {
                background: linear-gradient(to bottom right, #e6f0ff, #ffffff);
            }
            .navbar {
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            .dashboard-stats .col {
                border-radius: 12px;
                background-color: #ffffff;
                box-shadow: 0 4px 8px rgba(0,0,0,0.05);
                transition: all 0.3s ease-in-out;
            }
            .dashboard-stats .col:hover {
                transform: translateY(-5px);
            }
            .fade-in {
                animation: fadeIn 1s ease-in;
            }
            @keyframes fadeIn {
                from {opacity: 0; transform: translateY(20px);}
                to {opacity: 1; transform: translateY(0);}
            }

            .navbar {
  position: sticky;
  top: 0;
  z-index: 1000;
}

        </style>
    </head>
    <body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand animate__animated animate__fadeInLeft" href="#">LocalConnect</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manage-bookings.jsp"><i class="fas fa-calendar-check"></i> Bookings</a>

                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="provider-profile.jsp">Profile</a>
                    </li>
                </ul>
                <span class="navbar-text me-3">Welcome, <%= userName %></span>
                <a href="logout.jsp" class="btn btn-outline-light btn-sm">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4 fade-in">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="animate__animated animate__fadeInDown">Provider Dashboard</h2>
            <a class="btn btn-outline-info" href="view-provider.jsp?id=<%= user.getId() %>" target="_blank">View Public Profile</a>
        </div>

        <% if (postMsg != null) { %>
        <div class="alert alert-info animate__animated animate__fadeIn"><%= postMsg %></div>
        <% } %>
        <% if (updateMsg != null) { %>
        <div class="alert alert-success animate__animated animate__fadeIn"><%= updateMsg %></div>
        <% } %>

        <form method="get" class="row g-2 mb-4">
            <div class="col-md-6">
                <input type="text" name="search" class="form-control" placeholder="Search services..."
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            </div>
            <div class="col-md-3">
                <select name="status" class="form-select">
                    <option value="">All Status</option>
                    <option value="active" <%= "active".equals(request.getParameter("status")) ? "selected" : "" %>>Active</option>
                    <option value="inactive" <%= "inactive".equals(request.getParameter("status")) ? "selected" : "" %>>Inactive</option>
                </select>
            </div>
            <div class="col-md-3 d-flex gap-2">
                <button type="submit" class="btn btn-primary">Search</button>
                <% if (request.getParameter("search") != null || request.getParameter("status") != null) { %>
                <a href="provider-dashboard.jsp" class="btn btn-outline-secondary">Reset</a>
                <% } %>
            </div>
        </form>

        <a href="post-service.jsp" class="btn btn-success mb-3">+ Post New Service</a>

        <div class="row dashboard-stats text-center mb-4">
            <div class="col p-3">Total: <strong><%= total %></strong></div>
            <div class="col p-3">Active: <strong class="text-success"><%= active %></strong></div>
            <div class="col p-3">Inactive: <strong class="text-danger"><%= inactive %></strong></div>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-light">
                <tr>
                    <th>Service</th>
                    <th>Location</th>
                    <th>Contact</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (ServiceDto s : services) { %>
                <tr>
                    <td><%= s.getServiceName() %></td>
                    <td><%= s.getLocation() %></td>
                    <td><%= s.getContact() %></td>
                    <td><%= s.getDescription() %></td>
                    <td>
                        <a href="edit-service.jsp?id=<%= s.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="delete-service?id=<%= s.getId() %>" class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this service?')">Delete</a>
                        <a href="toggle-status?id=<%= s.getId() %>" class="btn btn-secondary btn-sm">
                            <%= "active".equalsIgnoreCase(s.getStatus()) ? "Disable" : "Enable" %>
                        </a>
                    </td>
                    <td>
                        <span class="badge bg-<%= s.getStatus().equalsIgnoreCase("active") ? "success" : "secondary" %>">
                        <%= s.getStatus().toUpperCase() %>
                        </span>
                    </td>

                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>