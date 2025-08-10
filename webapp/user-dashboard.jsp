<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.localconnect.dto.UserDto" %>
<%
UserDto user = (UserDto) session.getAttribute("user");
if (user == null || !"user".equals(user.getRole())) {
response.sendRedirect("login.jsp");
return;
}
%>
<!DOCTYPE html>
<html lang="en" xmlns:jsp="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8" />
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .service-card {
            cursor: pointer;
            border-radius: 15px;
            color: white;
            padding: 20px 15px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .service-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .service-img {
            width: 70px;
            height: 70px;
            object-fit: contain;
            margin-bottom: 15px;
            border-radius: 10px;
            background: white;

            align-self: center;
        }


        /* Background colors for each service */
        .bg-cleaning { background-color: #2196f3; }      /* Blue */
        .bg-plumbing { background-color: #ff9800; }      /* Orange */
        .bg-electrician { background-color: #4caf50; }   /* Green */
        .bg-painting { background-color: #9c27b0; }      /* Purple */



.banner-container {
  width: 100%;
  max-height: 180px;
  overflow: hidden;
  background-color: #f8f9fa; /* optional */
}

.banner-container img {
  width: 100%;
  height: auto;
  max-height: 180px;
  object-fit: contain;
  display: block;
  margin: 0 auto;
}







        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: #007bff !important;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="user-dashboard.jsp">LocalConnect</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu"
                aria-controls="navbarMenu" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarMenu">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item me-3">
                    <span class="nav-link">Welcome, <strong><%= user.getName() %></strong></span>
                </li>
                <li class="nav-item"><a class="nav-link" href="edit-user-profile.jsp">Edit Profile</a></li>
                <li class="nav-item"><a class="nav-link" href="my-bookings.jsp">My Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mt-5">

    <!-- Welcome Text -->
    <div class="mb-4 text-center">
        <h2>Welcome, <%= user.getName() %>!</h2>
        <p class="lead text-muted">Find the services you need quickly and easily.</p>
    </div>

    <!-- Service Categories Grid -->
    <div class="row row-cols-2 row-cols-md-4 g-4 mb-5">
        <div class="col">
            <div class="service-card bg-cleaning shadow-sm" onclick="location.href='search-services.jsp?category=Cleaning'">
                <img src="images/clean.png" alt="Cleaning" class="service-img" />
                <h5>Cleaning</h5>
                <p>Home & Office</p>
            </div>
        </div>
        <div class="col">
            <div class="service-card bg-plumbing shadow-sm" onclick="location.href='search-services.jsp?category=Plumbing'">
                <img src="images/plumb.png" alt="Plumbing" class="service-img" />
                <h5>Plumbing</h5>
                <p>Fix leaks & pipes</p>
            </div>
        </div>
        <div class="col">
            <div class="service-card bg-electrician shadow-sm" onclick="location.href='search-services.jsp?category=Electrician'">
                <img src="images/electric.png" alt="Electrician" class="service-img" />
                <h5>Electrician</h5>
                <p>Wiring & Repairs</p>
            </div>
        </div>
        <div class="col">
            <div class="service-card bg-painting shadow-sm" onclick="location.href='search-services.jsp?category=Painting'">
                <img src="images/paint.png" alt="Painting" class="service-img" />
                <h5>Painting</h5>
                <p>Interior & Exterior</p>
            </div>
        </div>
    </div>

    <!-- Sliding Banner Carousel -->
    <div id="promoCarousel" class="carousel slide rounded shadow" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#promoCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#promoCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#promoCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/local.png" class="d-block w-100" alt="Promo 1">
                <div class="carousel-caption d-none d-md-block text-dark">
                </div>
            </div>
            <div class="carousel-item">
                <img src="images/LookingForMehndiArtists.png" class="d-block w-100" alt="Promo 2">
                <div class="carousel-caption d-none d-md-block text-dark">
                </div>
            </div>
            <div class="carousel-item">
                <img src="images/support2.png" class="d-block w-100" alt="Promo 3">
                <div class="carousel-caption d-none d-md-block text-dark">

                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#promoCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#promoCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

</div>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<br>
<jsp:include page="footer.jsp" />
</body>
</html>
