<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.localconnect.dto.UserDto" %>
<%@ page import="com.localconnect.repository.ServiceRepositoryImpl" %>
<%@ page import="com.localconnect.dto.ServiceDto" %>
<%@ page import="java.util.List" %>

<%
UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"provider".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}

ServiceRepositoryImpl repo = new ServiceRepositoryImpl();
List<ServiceDto> services = repo.getAllByEmail(user.getEmail());

    int total = services.size(), active = 0, inactive = 0;
    for (ServiceDto s : services) {
    if ("active".equalsIgnoreCase(s.getStatus())) active++;
    else if ("inactive".equalsIgnoreCase(s.getStatus())) inactive++;
    }
    %>

    <html>
    <head>
        <title>Provider Profile</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="container mt-5">

    <a href="provider-dashboard.jsp" class="btn btn-outline-secondary mb-3 float-end">← Back to Dashboard</a>
    <h2>👤 Provider Profile</h2>

    <div class="mb-4 mt-3">
        <p><strong>Name:</strong> <%= user.getName() %></p>
        <p><strong>Email:</strong> <%= user.getEmail() %></p>
        <p><strong>Services Posted:</strong> <%= total %></p>
    </div>

    <div class="row text-center mb-4">
        <div class="col bg-light p-3 border">Total: <%= total %></div>
        <div class="col bg-light p-3 border">Active: <%= active %></div>
        <div class="col bg-light p-3 border">Inactive: <%= inactive %></div>
    </div>

    <!-- ✅ Add Edit Profile Button -->
    <a href="edit-provider-profile.jsp" class="btn btn-primary">✏️ Edit Profile</a>

    </body>
    </html>
