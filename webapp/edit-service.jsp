<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.localconnect.dto.ServiceDto" %>
<%@ page import="com.localconnect.repository.ServiceRepositoryImpl" %>
<%
String idStr = request.getParameter("id");
if (idStr == null) {
response.sendRedirect("provider-dashboard.jsp");
return;
}

int id = Integer.parseInt(idStr);
ServiceRepositoryImpl repo = new ServiceRepositoryImpl();
ServiceDto service = repo.getById(id);

if (service == null) {
response.sendRedirect("provider-dashboard.jsp");
return;
}
%>
<html>
<head>
    <title>Edit Service</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
<h3>Edit Service</h3>
<form action="update-service" method="post">
    <input type="hidden" name="id" value="<%= service.getId() %>" />
    <input type="text" name="serviceName" value="<%= service.getServiceName() %>" class="form-control mb-2" required />
    <input type="text" name="location" value="<%= service.getLocation() %>" class="form-control mb-2" required />
    <input type="text" name="contact" value="<%= service.getContact() %>" class="form-control mb-2" required />
    <textarea name="description" class="form-control mb-3"><%= service.getDescription() %></textarea>
    <button class="btn btn-primary">Update Service</button>
</form>
</body>
</html>
