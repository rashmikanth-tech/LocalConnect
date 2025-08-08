<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.localconnect.dto.UserDto" %>
<%
UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"user".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}
%>

<html>
<head>
    <title>Edit Profile</title>
    <%
    String updateMsg = (String) session.getAttribute("updateMessage");
    if (updateMsg != null) {
    %>
    <div class="alert alert-info"><%= updateMsg %></div>
    <%
    session.removeAttribute("updateMessage");
    }
    %>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
<a href="user-dashboard.jsp" class="btn btn-outline-secondary mb-3">← Back to Dashboard</a>

<h2>📝 Edit Profile</h2>

<form action="update-user-profile" method="post" class="mt-4">
    <div class="mb-3">
        <label>Name:</label>
        <input type="text" name="name" class="form-control" value="<%= user.getName() %>" required />
    </div>
    <div class="mb-3">
        <label>Email:</label>
        <input type="email" name="email" class="form-control" value="<%= user.getEmail() %>" required />
    </div>
    <div class="mb-3">
        <label>Mobile:</label>
        <input type="text" name="mobile" class="form-control" value="<%= user.getMobile() != null ? user.getMobile() : "" %>" required />
    </div>
    <button type="submit" class="btn btn-primary">💾 Update</button>
    <a href="change-user-password.jsp" class="btn btn-warning">🔐 Change Password</a>
</form>
</body>
</html>
