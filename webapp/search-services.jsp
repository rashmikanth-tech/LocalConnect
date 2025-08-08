<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.localconnect.dto.ServiceDto" %>
<%@ page import="com.localconnect.repository.ServiceRepositoryImpl" %>
<%@ page import="com.localconnect.dto.UserDto" %>

<%
UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"user".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}

String bookingMsg = (String) session.getAttribute("bookingMessage");
String keyword = request.getParameter("search");

ServiceRepositoryImpl repo = new ServiceRepositoryImpl();
List<ServiceDto> results;

    if (keyword != null && !keyword.trim().isEmpty()) {
    results = repo.searchByKeyword(keyword);
    } else {
    results = repo.getAllActive();
    }
    %>


    <html>
    <head>
        <title>Search Services</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    </head>
    <body class="container mt-4">
    <% if (bookingMsg != null) { %>
    <div class="alert alert-info"><%= bookingMsg %></div>
    <%
    session.removeAttribute("bookingMessage");
    %>
    <% } %>

    <a href="user-dashboard.jsp" class="btn btn-outline-secondary mb-3">← Back to Dashboard</a>

    <h2>Search Services</h2>
    <form method="get" class="mb-4 d-flex gap-2">
        <input type="text" name="search" class="form-control"
               value="<%= keyword != null ? keyword : "" %>"
        placeholder="Search by service name or location..." />
        <button type="submit" class="btn btn-primary">Search 🔍</button>
    </form>

    <% if (results.isEmpty()) { %>
    <p class="text-muted">No services found for "<%= keyword %>"</p>
    <% } else { %>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Service</th>
            <th>Location</th>
            <th>Description</th>
            <th>Provider</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <% for (ServiceDto s : results) { %>
        <tr>
            <td><%= s.getServiceName() %></td>
            <td><%= s.getLocation() %></td>
            <td><%= s.getDescription() %></td>
            <td><%= s.getPostedBy() %></td>
            <td>
                <a href="view-provider.jsp?id=<%= s.getPostedById() %>" class="btn btn-sm btn-info">View Provider</a>
                <!-- ✅ Book button -->
                <form action="book-service" method="post" style="display:inline;">
                    <input type="hidden" name="serviceId" value="<%= s.getId() %>" />
                    <button type="submit" class="btn btn-sm btn-success">Book</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
    </body>
    </html>
