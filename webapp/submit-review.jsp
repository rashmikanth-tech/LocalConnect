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
    <style>
        .star {
            font-size: 2rem;
            color: gray;
            cursor: pointer;
        }
        .star.selected {
            color: gold;
        }
    </style>
</head>
<body class="container mt-5">

<h3>⭐ Submit Review</h3>
<form action="submit-review" method="post">
    <input type="hidden" name="bookingId" value="<%= bookingId %>" />
    <input type="hidden" name="providerId" value="<%= providerId %>" />
    <input type="hidden" name="rating" id="rating" value="0" required />

    <div class="mb-3">
        <label class="form-label">Rating</label><br/>
        <span class="star" data-value="1">&#9733;</span>
        <span class="star" data-value="2">&#9733;</span>
        <span class="star" data-value="3">&#9733;</span>
        <span class="star" data-value="4">&#9733;</span>
        <span class="star" data-value="5">&#9733;</span>
    </div>

    <div class="mb-3">
        <label class="form-label">Comment</label>
        <textarea name="comment" rows="4" class="form-control" required></textarea>
    </div>

    <button class="btn btn-success">Submit Review</button>
    <a href="my-bookings.jsp" class="btn btn-secondary ms-2">Cancel</a>
</form>

<script>
    const stars = document.querySelectorAll('.star');
    const ratingInput = document.getElementById('rating');

    stars.forEach(star => {
        star.addEventListener('click', () => {
            const ratingValue = star.getAttribute('data-value');
            ratingInput.value = ratingValue;

            stars.forEach(s => {
                s.classList.toggle('selected', s.getAttribute('data-value') <= ratingValue);
            });
        });
    });
</script>

</body>
</html>
