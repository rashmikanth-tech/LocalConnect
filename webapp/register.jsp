<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.localconnect.dto.UserDto" %>
<%
String msg = (String) request.getAttribute("message");
UserDto dto = (UserDto) request.getAttribute("dto");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register - LocalConnect</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #f0f9ff, #e3f2fd);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            padding: 2rem;
            max-width: 100%;
            width: 100%;
        }

        .form-label {
            font-weight: 500;
        }

        @media (min-width: 576px) {
            .card {
                width: 100%;
                max-width: 480px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card mx-auto">
        <div class="text-center mb-4">
            <h2 class="fw-bold text-primary"><i class="bi bi-person-plus"></i> Register</h2>
            <p class="text-muted">Join LocalConnect and start finding services</p>
        </div>

        <% if (msg != null) { %>
        <div class="alert alert-info p-2 text-center"><%= msg %></div>
        <% } %>

        <form action="register" method="post" novalidate>
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" placeholder="Enter your name"
                       value="<%= dto != null ? dto.getName() : "" %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" placeholder="you@example.com"
                       value="<%= dto != null ? dto.getEmail() : "" %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="******" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Register As</label>
                <select name="role" class="form-select">
                    <option value="user">User</option>
                    <option value="provider">Service Provider</option>
                </select>
            </div>

            <button class="btn btn-primary w-100">
                <i class="bi bi-person-check"></i> Register
            </button>
        </form>

        <div class="text-center mt-3">
            <small>Already have an account? <a href="login.jsp">Login</a></small>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
