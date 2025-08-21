<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex justify-content-center align-items-center vh-100"
      style="background: linear-gradient(to right, #6a11cb, #2575fc);">

<div class="card p-4" style="max-width: 400px; width: 100%;">
    <h3 class="text-center text-primary fw-bold mb-3">Reset Password</h3>

    <%-- Success message (green) --%>
    <% String success = (String) request.getAttribute("success"); %>
    <% if (success != null) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= success %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <%-- Warning/Info message --%>
    <% String msg = (String) request.getAttribute("message"); %>
    <% if (msg != null) { %>
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <%= msg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <%-- Error message (red) --%>
    <% String error = request.getParameter("error"); %>
    <% if (error != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <form action="forgot-password" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">Registered Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Send OTP</button>
    </form>

    <div class="text-center mt-3">
        <a href="login.jsp" class="text-decoration-none">Back to Login</a>
    </div>
</div>
</body>
</html>
