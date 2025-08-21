<%@ page contentType="text/html;charset=UTF-8" %>
<%
String msg = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles -->
    <style>
        body {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.8s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .form-floating input:focus {
            border-color: #2575fc;
            box-shadow: 0 0 0 0.2rem rgba(37, 117, 252, 0.25);
        }
        .btn-custom {
            background-color: #2575fc;
            color: white;
        }
        .btn-custom:hover {
            background-color: #1a5edb;
        }
    </style>
</head>
<body>
<div class="card p-4 p-md-5" style="max-width: 400px; width: 100%;">
    <h3 class="mb-4 text-center text-primary fw-bold">User Login</h3>

    <% if (msg != null) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= msg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <form action="login" method="post">
        <div class="form-floating mb-3">
            <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
            <label for="email">Email address</label>
        </div>

        <div class="form-floating mb-4">
            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
            <label for="password">Password</label>
        </div>

        <div class="d-grid mb-3">
            <button type="submit" class="btn btn-custom btn-lg">Login</button>
        </div>

        <div class="text-center mt-2">
            <a href="forgot-password.jsp" class="text-danger fw-semibold text-decoration-none">Forgot Password?</a>
        </div>

    </form>

    <div class="text-center mt-3">
        <p class="text-white">Don't have an account?
            <a href="register.jsp" class="text-warning fw-semibold text-decoration-none">Register here</a>
        </p>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
