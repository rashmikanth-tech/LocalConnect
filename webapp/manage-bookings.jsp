<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.localconnect.dto.*, com.localconnect.repository.*" %>
<%
UserDto provider = (UserDto) session.getAttribute("user");
if (provider == null || !"provider".equals(provider.getRole())) {
response.sendRedirect("login.jsp");
return;
}

BookingRepositoryImpl bookingRepo = new BookingRepositoryImpl();
ServiceRepositoryImpl serviceRepo = new ServiceRepositoryImpl();
UserRepositoryImpl userRepo = new UserRepositoryImpl();

List<ServiceBookingDto> bookings = bookingRepo.getBookingsByProvider(provider.getEmail());
    %>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Bookings - Provider Panel</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <style>
            body {
                background-color: #f8f9fa;
            }
            .status-badge {
                font-size: 0.9rem;
            }
            .navbar-brand {
                font-weight: bold;
            }
        </style>
    </head>
    <body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand" href="provider-dashboard.jsp">🔧 Provider Panel</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="provider-dashboard.jsp">🏠 Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="#">📋 Bookings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="provider-profile.jsp">👤 Profile</a>
                    </li>
                </ul>
                <span class="navbar-text me-3">Welcome, <%= provider.getName() %></span>
                <a href="logout.jsp" class="btn btn-outline-light btn-sm">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main content -->
    <div class="container mt-4">
        <h3 class="mb-4 fw-semibold">📋 Bookings Received</h3>

        <% if (bookings.isEmpty()) { %>
        <div class="alert alert-info">No bookings received yet.</div>
        <% } else { %>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle bg-white shadow-sm">
                <thead class="table-dark">
                <tr>
                    <th>Service</th>
                    <th>Requested By</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (ServiceBookingDto b : bookings) {
                ServiceDto s = serviceRepo.getById(b.getServiceId());
                UserDto user = userRepo.getById(b.getUserId());

                String statusClass = "secondary";
                switch (b.getStatus()) {
                case "pending": statusClass = "warning"; break;
                case "accepted": statusClass = "success"; break;
                case "open": statusClass = "info"; break;
                case "solved": statusClass = "primary"; break;
                case "closed": statusClass = "dark"; break;
                case "rejected": case "cancelled": statusClass = "danger"; break;
                }
                %>
                <tr>
                    <td><%= s.getServiceName() %></td>
                    <td>
                        <div><strong><%= user.getName() %></strong></div>
                        <small class="text-muted"><%= user.getEmail() %></small>
                    </td>
                    <td>
                        <span class="badge bg-<%= statusClass %> status-badge"><%= b.getStatus().toUpperCase() %></span>
                    </td>
                    <td>
                        <div class="d-flex flex-wrap gap-2">
                            <% if ("pending".equals(b.getStatus())) { %>
                            <a href="update-booking-status?id=<%= b.getId() %>&status=accepted" class="btn btn-sm btn-success">✅ Accept</a>
                            <a href="update-booking-status?id=<%= b.getId() %>&status=rejected" class="btn btn-sm btn-danger">❌ Reject</a>

                            <% } else if ("accepted".equals(b.getStatus())) {
                            if (b.isCancelRequest()) { %>
                            <a href="update-booking-status?id=<%= b.getId() %>&status=cancelled" class="btn btn-sm btn-danger">✔ Accept Cancel</a>
                            <a href="update-booking-status?id=<%= b.getId() %>&status=accepted" class="btn btn-sm btn-secondary">✖ Reject Cancel</a>
                            <% } else { %>
                            <a href="update-booking-status?id=<%= b.getId() %>&status=open" class="btn btn-sm btn-info">🔓 Mark Open</a>
                            <% }

                            } else if ("open".equals(b.getStatus())) { %>
                            <a href="update-booking-status?id=<%= b.getId() %>&status=solved" class="btn btn-sm btn-warning">🛠 Mark Solved</a>

                            <% } else if ("solved".equals(b.getStatus())) { %>
                            <a href="update-booking-status?id=<%= b.getId() %>&status=closed" class="btn btn-sm btn-dark">✅ Close</a>

                            <% } else { %>
                            <span class="text-muted">No actions</span>
                            <% } %>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>
