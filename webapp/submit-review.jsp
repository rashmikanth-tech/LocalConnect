<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.localconnect.dto.UserDto" %>
<%
UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"user".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}
String bookingId = request.getParameter("bookingId");
String providerId = request.getParameter("providerId");
%>

<html>
<head>
    <title>Submit Review</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="container mt-5">

<h3>⭐ Submit Review</h3>
<form action="submit-review" method="post">
    <input type="hidden" name="bookingId" value="<%= bookingId %>" />
    <input type="hidden" name="providerId" value="<%= providerId %>" />

    <div class="mb-3">
        <label class="form-label">Rating (1-5)</label>
        <input type="number" name="rating" min="1" max="5" class="form-control" required
               oninvalid="this.setCustomValidity('Please enter a rating between 1 and 5')"
               oninput="this.setCustomValidity('')" />
    </div>

    <div class="mb-3">
        <label class="form-label">Comment</label>
        <textarea name="comment" rows="4" class="form-control" required></textarea>
    </div>

    <button class="btn btn-success">Submit Review</button>
    <a href="my-bookings.jsp" class="btn btn-secondary ms-2">Cancel</a>
</form>

</body>
</html>
