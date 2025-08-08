<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.localconnect.dto.UserDto" %>

<%
UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"provider".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="provider-dashboard.jsp">LocalConnect</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="provider-dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="edit-provider-profile.jsp">Edit Profile</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger" href="logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- ✅ Main Form Content -->
<div class="container mt-5">
    <h2 class="mb-4">👤 Edit Profile</h2>

    <form action="update-provider-profile" method="post">
        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text" name="name" value="<%= user.getName() %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email (Contact)</label>
            <input type="email" name="email" value="<%= user.getEmail() %>" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">New Password</label>
            <input type="password" name="password" class="form-control" placeholder="Leave blank to keep current" />
        </div>

        <div class="mb-3">
            <label class="form-label">Confirm Password</label>
            <input type="password" name="confirmPassword" class="form-control" />
        </div>

        <button type="submit" class="btn btn-primary">Update Profile</button>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
