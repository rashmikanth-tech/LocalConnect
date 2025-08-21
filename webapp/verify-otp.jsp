<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Verify OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex justify-content-center align-items-center vh-100"
      style="background: linear-gradient(to right, #6a11cb, #2575fc);">

<div class="card p-4" style="max-width: 400px; width: 100%;">
    <h3 class="text-center text-primary fw-bold mb-3">Verify OTP</h3>

    <!-- ✅ Success Message -->
    <% String success = (String) request.getAttribute("success"); %>
    <% if (success != null) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= success %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <!-- OTP Form -->
    <form action="verify-otp" method="post">
        <div class="mb-3">
            <label for="otp" class="form-label">Enter OTP</label>
            <input type="number" class="form-control" id="otp" name="otp" required>
        </div>
        <button type="submit" class="btn btn-success w-100">Verify OTP</button>
    </form>

    <div class="text-center mt-3">
        <a href="login.jsp" class="text-decoration-none">Back to Login</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
