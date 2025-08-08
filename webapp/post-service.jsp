<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.localconnect.dto.UserDto" %>
<%
UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"provider".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}
%>
<html>
<head>
    <title>Post a Service</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

</head>
<body class="container mt-5">
<h3>Post a Local Service</h3>
<% if (request.getAttribute("message") != null) { %>
<div class="alert alert-info"><%= request.getAttribute("message") %></div>
<% } %>
<a href="provider-dashboard.jsp" class="btn btn-outline-secondary mb-3">← Back to Dashboard</a>

<form action="post-service" method="post">
    <input type="text" name="serviceName" placeholder="Service Name (e.g. Electrician)" class="form-control mb-3" required />
    <input type="text" name="location" placeholder="Location (e.g. Shivamogga)" class="form-control mb-3" required />
    <input type="text" name="contact" placeholder="Contact Number" class="form-control mb-3" required />
    <textarea name="description" placeholder="Short Description" class="form-control mb-3" rows="3"></textarea>
    <button class="btn btn-success">Post Service</button>
</form>
</body>
</html>
