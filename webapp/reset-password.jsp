<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function validatePasswords() {
            const pass = document.getElementById("newPassword").value;
            const confirm = document.getElementById("confirmPassword").value;

            if (pass !== confirm) {
                alert("Passwords do not match!");
                return false;
            }
            return true;
        }

        function togglePassword(id, iconId) {
            const input = document.getElementById(id);
            const icon = document.getElementById(iconId);
            if (input.type === "password") {
                input.type = "text";
                icon.textContent = "🙈"; // eye-close emoji
            } else {
                input.type = "password";
                icon.textContent = "👁️"; // eye-open emoji
            }
        }
    </script>
</head>
<body class="d-flex justify-content-center align-items-center vh-100"
      style="background: linear-gradient(to right, #6a11cb, #2575fc);">

<div class="card p-4" style="max-width: 400px; width: 100%;">
    <h3 class="text-center text-primary fw-bold mb-3">Reset Password</h3>

    <% String msg = (String) request.getAttribute("message"); %>
    <% if (msg != null) { %>
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <%= msg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <% String error = request.getParameter("error"); %>
    <% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="reset-password" method="post" onsubmit="return validatePasswords()">
        <div class="mb-3 position-relative">
            <label for="newPassword" class="form-label">New Password</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
            <span id="toggleNewPass"
                  style="position:absolute; top:38px; right:10px; cursor:pointer;"
                  onclick="togglePassword('newPassword','toggleNewPass')">👁️</span>
        </div>

        <div class="mb-3 position-relative">
            <label for="confirmPassword" class="form-label">Confirm Password</label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            <span id="toggleConfirmPass"
                  style="position:absolute; top:38px; right:10px; cursor:pointer;"
                  onclick="togglePassword('confirmPassword','toggleConfirmPass')">👁️</span>
        </div>

        <button type="submit" class="btn btn-primary w-100">Update Password</button>
    </form>

    <div class="text-center mt-3">
        <a href="login.jsp" class="text-decoration-none">Back to Login</a>
    </div>
</div>
</body>
</html>
