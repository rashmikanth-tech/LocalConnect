<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.localconnect.dto.*" %>
<%@ page import="com.localconnect.repository.*" %>

<%
UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"user".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}

BookingRepositoryImpl bookingRepo = new BookingRepositoryImpl();
ServiceRepositoryImpl serviceRepo = new ServiceRepositoryImpl();
UserRepositoryImpl userRepo = new UserRepositoryImpl();

List<ServiceBookingDto> bookings = bookingRepo.getBookingsByUser(user.getId());

    String bookingMsg = (String) session.getAttribute("bookingMessage");
    if (bookingMsg != null) {
    %>
    <div class="alert alert-info"><%= bookingMsg %></div>
    <%
    session.removeAttribute("bookingMessage");
    }
    %>

    <html>
    <head>
        <title>My Bookings</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            td form {
                display: inline-block;
                margin-top: 4px;
            }
            td span {
                display: block;
                margin-top: 4px;
            }
        </style>
    </head>
    <body class="container mt-4">

    <a href="user-dashboard.jsp" class="btn btn-outline-secondary mb-3">← Back to Dashboard</a>
    <h2>📋 My Bookings</h2>

    <% if (bookings.isEmpty()) { %>
    <p class="text-muted">No bookings found.</p>
    <% } else { %>
    <table class="table table-bordered align-middle">
        <thead class="table-light">
        <tr>
            <th>Service</th>
            <th>Provider</th>
            <th>Status</th>
            <th>Booked On</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <% for (ServiceBookingDto b : bookings) {
        ServiceDto s = serviceRepo.getById(b.getServiceId());
        UserDto provider = userRepo.getById(s.getPostedById());
        %>
        <tr>
            <td><%= s.getServiceName() %></td>
            <td>
                <% if (provider != null) { %>
                <%= provider.getName() %><br><small class="text-muted"><%= provider.getEmail() %></small>
                <% } else { %>
                <span class="text-danger">[Provider not found]</span>
                <% } %>
            </td>
            <td><%= b.getStatus() %></td>
            <td><%= b.getCreatedAt() %></td>
            <td>
                <% if ("pending".equals(b.getStatus())) { %>
                <form action="cancel-booking" method="post">
                    <input type="hidden" name="id" value="<%= b.getId() %>" />
                    <input type="hidden" name="status" value="pending" />
                    <button class="btn btn-sm btn-danger"
                            onclick="return confirm('Are you sure to cancel this booking?')">Cancel</button>
                </form>
                <% } else if ("accepted".equals(b.getStatus()) && !b.isCancelRequest()) { %>
                <form action="cancel-booking" method="post">
                    <input type="hidden" name="id" value="<%= b.getId() %>" />
                    <input type="hidden" name="status" value="accepted" />
                    <button class="btn btn-sm btn-warning"
                            onclick="return confirm('Send cancellation request to provider?')">Request Cancel</button>
                </form>
                <% } else if (b.isCancelRequest()) { %>
                <span class="text-warning">Cancel Requested</span>
                <% } else { %>
                <span class="text-muted">No Action</span>
                <% } %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>

    </body>
    </html>
