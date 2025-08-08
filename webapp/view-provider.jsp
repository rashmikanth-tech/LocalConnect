<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.localconnect.dto.*, com.localconnect.repository.*" %>

<%
String idParam = request.getParameter("id");
if (idParam == null || idParam.isEmpty()) {
out.println("<div class='alert alert-danger m-4'>❌ No provider selected.</div>");
return;
}

int id = Integer.parseInt(idParam);
UserRepositoryImpl repo = new UserRepositoryImpl();
UserDto provider = repo.getById(id);

if (provider == null || !"provider".equals(provider.getRole())) {
out.println("<div class='alert alert-danger m-4'>❌ Provider not found.</div>");
return;
}

ReviewRepositoryImpl reviewRepo = new ReviewRepositoryImpl();
List<ReviewDto> reviews = reviewRepo.getByProviderId(provider.getId());
    %>

    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title><%= provider.getName() %> - Profile</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .profile-card {
                max-width: 500px;
                margin: 60px auto;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                background-color: #fff;
            }
            .profile-icon {
                font-size: 60px;
                color: #0d6efd;
            }
        </style>
    </head>
    <body>

    <div class="container">
        <a href="search-services.jsp" class="btn btn-outline-secondary mt-4 mb-3">← Back to Services</a>

        <div class="profile-card text-center">
            <div class="profile-icon mb-3">👤</div>
            <h3><%= provider.getName() %></h3>
            <hr/>
            <p><strong>Email:</strong> <%= provider.getEmail() %></p>
            <p><strong>Contact:</strong> <%= provider.getMobile() != null ? provider.getMobile() : "N/A" %></p>
            <p class="text-muted mt-4">This is a public profile of the service provider.</p>
        </div>

        <!-- ⭐ Reviews Section -->
        <div class="mt-5">
            <h4>⭐ Reviews</h4>
            <% if (reviews.isEmpty()) { %>
            <p class="text-muted">No reviews yet.</p>
            <% } else { %>
            <ul class="list-group">
                <% for (ReviewDto r : reviews) { %>
                <li class="list-group-item">
                    <strong>Rating:</strong> <%= r.getRating() %>/5 <br/>
                    <%= r.getComment() %>
                    <div class="text-muted small"><%= r.getCreatedAt() %></div>
                </li>
                <% } %>
            </ul>
            <% } %>
        </div>

    </div>

    </body>
    </html>
