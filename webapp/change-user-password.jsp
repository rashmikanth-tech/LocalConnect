<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.localconnect.dto.UserDto" %>

<%
UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"user".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}
String msg = (String) session.getAttribute("msg");
if (msg != null) {
%>
<div class="alert alert-info"><%= msg %></div>
<%
session.removeAttribute("msg");
}
%>

<html>
<head>
    <title>Change Password</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
</head>
<body class="container mt-5">

<a href="user-dashboard.jsp" class="btn btn-outline-secondary mb-3">← Back to Dashboard</a>

<h2>🔐 Change Password</h2>
<form method="post" action="change-user-password">
    <div class="mb-3">
        <label>Current Password</label>
        <input type="password" name="current" class="form-control" required />
    </div>
    <div class="mb-3">
        <label>New Password</label>
        <input type="password" name="newpass" class="form-control" required minlength="6" />
    </div>
    <div class="mb-3">
        <label>Confirm New Password</label>
        <input type="password" name="confirmpass" class="form-control" required minlength="6" />
    </div>
    <button type="submit" class="btn btn-primary">Update Password</button>
</form>

</body>
</html>
