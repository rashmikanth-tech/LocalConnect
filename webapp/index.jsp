<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LocalConnect - Find Services Near You</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body {
            transition: background-color 0.3s, color 0.3s;
        }
        .dark-mode {
            background-color: #121212;
            color: #e0e0e0;
        }
        .category-card {
            transition: transform 0.3s ease;
        }
        .category-card:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light px-4 py-2">
    <a class="navbar-brand fw-bold" href="#">LocalConnect</a>
    <div class="ms-auto d-flex align-items-center">
        <button class="btn btn-outline-dark me-2" onclick="toggleTheme()">
            <i class="bi bi-moon-fill"></i> Theme
        </button>
        <a href="login.jsp" class="btn btn-outline-primary me-2">Login</a>
        <a href="register.jsp" class="btn btn-primary">Register</a>
    </div>
</nav>

<header class="text-center py-5 bg-primary text-white">
    <h1 class="display-4 fw-bold">Find Trusted Services Near You</h1>
    <p class="lead">Connecting you with verified professionals in your area</p>
    <a href="explore-services.jsp" class="btn btn-light btn-lg mt-3">Explore Services</a>
</header>

<section class="container my-5">
    <h2 class="mb-4 text-center">Popular Categories</h2>
    <div class="row g-4">
        <div class="col-md-3">
            <div class="card category-card shadow text-center p-3">
                <i class="bi bi-tools fs-1"></i>
                <h5 class="mt-2">Electrician</h5>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card category-card shadow text-center p-3">
                <i class="bi bi-droplet-half fs-1"></i>
                <h5 class="mt-2">Plumber</h5>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card category-card shadow text-center p-3">
                <i class="bi bi-house-door fs-1"></i>
                <h5 class="mt-2">Home Cleaning</h5>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card category-card shadow text-center p-3">
                <i class="bi bi-scissors fs-1"></i>
                <h5 class="mt-2">Beautician</h5>
            </div>
        </div>
    </div>
</section>

<section class="bg-light py-5">
    <div class="container">
        <h2 class="text-center mb-4">What Our Users Say</h2>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card p-3 shadow">
                    <p>"Quick and reliable services. Found a great electrician within minutes!"</p>
                    <h6 class="fw-bold">- Priya R.</h6>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3 shadow">
                    <p>"Loved the UI, and the service quality was amazing! Highly recommended."</p>
                    <h6 class="fw-bold">- Rakesh M.</h6>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3 shadow">
                    <p>"Finally, a platform that actually works for local service needs."</p>
                    <h6 class="fw-bold">- Anita S.</h6>
                </div>
            </div>
        </div>
    </div>
</section>

<footer class="text-center py-4 bg-dark text-white">
    &copy; 2025 LocalConnect. All rights reserved.
</footer>

<script>
    function toggleTheme() {
        document.body.classList.toggle("dark-mode");
        localStorage.setItem("theme", document.body.classList.contains("dark-mode") ? "dark" : "light");
    }

    // Auto theme detection
    window.onload = function () {
        const theme = localStorage.getItem("theme");
        const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
        if (theme === "dark" || (!theme && prefersDark)) {
            document.body.classList.add("dark-mode");
        }
    }
</script>
</body>
</html>
