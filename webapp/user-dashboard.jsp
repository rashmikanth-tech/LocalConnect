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
        /* Background colors */
        .bg-cleaning { background-color: #2196f3; }
        .bg-plumbing { background-color: #ff9800; }
        .bg-electrician { background-color: #4caf50; }
        .bg-painting { background-color: #9c27b0; }

        /* Progress bar */
         .carousel-progress {
             height: 4px;
             background-color: rgba(255, 255, 255, 0.2); /* light background under progress */
         }
        .carousel-progress-bar {
            height: 100%;
            background-color: #ff9800; /* orange fill */
            width: 0%;
            transition: width linear;
        }

        /* Suggestions dropdown */
        #suggestions {
    position: absolute;
    top: 100%;        /* Position right below input */
    left: 0;
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-top: none;
    max-height: 150px;
    overflow-y: auto;
    background: white;
    z-index: 1000;
    display: none;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    border-radius: 0 0 10px 10px;
}

        #suggestions div {
            padding: 8px 12px;
            cursor: pointer;
            user-select: none;
        }
        #suggestions div:hover, #suggestions div.highlight {
            background-color: #d6d6d6;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="user-dashboard.jsp">
            LocalConnect
        </a>

        <!-- Mobile toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMenu">

            <!-- Search Bar -->
            <form class="d-flex mx-auto" action="search-services.jsp" method="get" style="max-width: 500px; flex: 1; position: relative;">
                <input class="form-control me-2 rounded-pill shadow-sm"
                       id="serviceSearch"
                       type="search"
                       name="search"
                       placeholder="Search for services, categories..."
                       aria-label="Search"
                       autocomplete="off"
                       required />
                <div id="suggestions"></div>
                <button class="btn btn-primary rounded-pill px-4 shadow-sm" type="submit">Search</button>
            </form>

            <!-- Right Side Menu -->
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="edit-user-profile.jsp">Edit Profile</a></li>
                <li class="nav-item"><a class="nav-link" href="my-bookings.jsp">My Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">

    <!-- Welcome Text -->
    <div class="mb-4 text-center">
        <h2>Welcome, <%= user.getName() %>!</h2>
        <p class="lead text-muted">Find the services you need quickly and easily.</p>
    </div>

    <!-- Service Categories Grid -->
    <div class="row row-cols-2 row-cols-md-4 g-4 mb-5">
        <div class="col">
            <div class="service-card bg-cleaning" onclick="location.href='search-services.jsp?category=Cleaning'">
                <img src="images/clean.png" alt="Cleaning" class="service-img" />
                <h5>Cleaning</h5>
                <p>Home & Office</p>
            </div>
        </div>
        <div class="col">
            <div class="service-card bg-plumbing" onclick="location.href='search-services.jsp?category=Plumbing'">
                <img src="images/plumb.png" alt="Plumbing" class="service-img" />
                <h5>Plumbing</h5>
                <p>Fix leaks & pipes</p>
            </div>
        </div>
        <div class="col">
            <div class="service-card bg-electrician" onclick="location.href='search-services.jsp?category=Electrician'">
                <img src="images/electric.png" alt="Electrician" class="service-img" />
                <h5>Electrician</h5>
                <p>Wiring & Repairs</p>
            </div>
        </div>
        <div class="col">
            <div class="service-card bg-painting" onclick="location.href='search-services.jsp?category=Painting'">
                <img src="images/paint.png" alt="Painting" class="service-img" />
                <h5>Painting</h5>
                <p>Interior & Exterior</p>
            </div>
        </div>
    </div>

    <!-- Sliding Banner Carousel -->
    <div id="promoCarousel" class="carousel slide rounded shadow overflow-hidden"
         data-bs-ride="carousel"
         data-bs-interval="3000"
         data-bs-wrap="true">

        <div class="carousel-inner position-relative">
            <div class="carousel-item active">
                <img src="images/local.png" class="d-block w-100" alt="Promo 1">
            </div>
            <div class="carousel-item">
                <img src="images/LookingForMehndiArtists.png" class="d-block w-100" alt="Promo 2">
            </div>
            <div class="carousel-item">
                <img src="images/support2.png" class="d-block w-100" alt="Promo 3">
            </div>
            <div class="carousel-item">
                <img src="images/gardan.png" class="d-block w-100" alt="Promo 4">
            </div>

            <!-- Progress bar inside box -->
            <div class="carousel-progress position-absolute bottom-0 start-0 w-100">
                <div class="carousel-progress-bar"></div>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery for autocomplete -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    $(function() {
        const $input = $('#serviceSearch');
        const $suggestions = $('#suggestions');
        let selectedIndex = -1;  // track keyboard selection

        function renderSuggestions(data) {
            $suggestions.empty();

            if (!Array.isArray(data) || data.length === 0) {
                $suggestions.hide();
                selectedIndex = -1;
                return;
            }

            data.forEach(function(service, index) {
                const name = service.serviceName || service.service_name || service.name || "Unnamed";
                const $item = $('<div></div>').text(name).appendTo($suggestions);

                $item.on('click', function() {
                    $input.val(name);
                    $suggestions.empty().hide();
                    selectedIndex = -1;
                });

                $item.on('mouseenter', function() {
                    selectedIndex = index;
                    $suggestions.children().removeClass('highlight');
                    $(this).addClass('highlight');
                });
            });

            selectedIndex = -1;
            $suggestions.show();
        }

        $input.on('input', function() {
            const query = $(this).val().trim();
            if (query.length < 2) {
                $suggestions.empty().hide();
                selectedIndex = -1;
                return;
            }

            $.ajax({
                url: 'search-services',
                data: { q: query },
                success: function(data) {
                    renderSuggestions(data);
                },
                error: function() {
                    $suggestions.empty().hide();
                    selectedIndex = -1;
                }
            });
        });

        $input.on('keydown', function(e) {
            const items = $suggestions.children();
            if (!$suggestions.is(':visible') || items.length === 0) return;

            if (e.key === "ArrowDown") {
                e.preventDefault();
                selectedIndex = (selectedIndex + 1) % items.length;
                items.removeClass('highlight');
                $(items[selectedIndex]).addClass('highlight');
            } else if (e.key === "ArrowUp") {
                e.preventDefault();
                selectedIndex = (selectedIndex - 1 + items.length) % items.length;
                items.removeClass('highlight');
                $(items[selectedIndex]).addClass('highlight');
            } else if (e.key === "Enter") {
                if (selectedIndex >= 0) {
                    e.preventDefault();
                    const selectedText = $(items[selectedIndex]).text();
                    $input.val(selectedText);
                    $suggestions.empty().hide();
                    selectedIndex = -1;
                }
            }
        });

        $(document).on('click', function(e) {
            if (!$(e.target).closest('#serviceSearch, #suggestions').length) {
                $suggestions.empty().hide();
                selectedIndex = -1;
            }
        });
    });
</script>

<br>

<jsp:include page="footer.jsp" />
</body>
</html>
