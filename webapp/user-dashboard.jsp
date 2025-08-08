<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.localconnect.dto.UserDto" %>
<%
UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"user".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-body">
            <h3 class="card-title">Welcome, <%= user.getName() %> (User)</h3>
            <a href="my-bookings.jsp" class="btn btn-outline-primary">📋 My Bookings</a>

            <a href="edit-user-profile.jsp" class="btn btn-outline-primary">📝 Edit Profile</a>

            <p class="card-text">Email: <%= user.getEmail() %></p>
            <a href="search-services.jsp" class="btn btn-primary">Search Services</a>
            <a href="logout.jsp" class="btn btn-secondary ms-2">Logout</a>
        </div>
    </div>
</div>
</body>
</html>
