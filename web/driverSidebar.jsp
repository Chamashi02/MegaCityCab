<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Bootstrap & FontAwesome CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- Custom CSS for Sidebar -->
<style>
    .navbar-nav {
        --bs-nav-link-padding-x: 1rem;
        --bs-nav-link-padding-y: 0.8rem;
    }

    .sidebar {
        width: 17%;
        background-color: #4979ae !important;
        margin-top: -1rem;
    }

    .sidebar .nav-item {
        width: 100%;
    }

    .sidebar .nav-link {
        color: white !important;
        padding: var(--bs-nav-link-padding-y) var(--bs-nav-link-padding-x);
        display: flex;
        align-items: center;
    }

    .sidebar .nav-link i {
        margin-right: 10px;
    }

    .sidebar-divider {
        border-color: rgba(255, 255, 255, 0.8);
    }
    
    .navbar-nav .nav-link:hover {
        background-color: #ffffff; /* White background */
        color: #4979ae !important; /* Primary text color */
        border-radius: 5px;
    }
    .sidebar-panel-name{
        letter-spacing: 4px;
        text-transform: uppercase;
        font-size: x-small;
        margin-top: 3px;
    }
</style>

<!-- Sidebar -->
<ul class="navbar-nav sidebar sidebar-dark position-fixed vh-100" id="accordionSidebar">
    <!-- Sidebar Brand -->
    <a class="sidebar-brand d-flex flex-column align-items-center justify-content-center text-white text-decoration-none py-3" href="AdminDashboard">
        <div class="sidebar-brand-text fw-bold">Mega City Cab</div>
        <div class="sidebar-panel-name">Driver Panel</div>
    </a>


    <hr class="sidebar-divider my-0">

    <!-- Dashboard -->
    <li class="nav-item">
        <a class="nav-link" href="DriverDashboardServlet">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
    </li>

    <hr class="sidebar-divider my-0">

    <!-- Logout -->
    <li class="nav-item">
        <a class="nav-link" href="LogoutServlet">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </li>

    <hr class="sidebar-divider my-0">
</ul>
<!-- End of Sidebar -->
