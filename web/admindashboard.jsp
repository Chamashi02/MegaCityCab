<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.User, models.Role" %>

<%
    HttpSession userSession = request.getSession(false);
    User user = (userSession != null) ? (User) userSession.getAttribute("user") : null;

    if (user == null || user.getRole() != Role.admin) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard</title>

    <!-- Bootstrap 5 & FontAwesome CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/YOUR_KIT_ID.js" crossorigin="anonymous"></script>

    <style>
        /* Adjust body to accommodate sidebar */
        .body-wrap {
            margin-left: 17%;
            margin-top: 1rem;
        }
    </style>
</head>
<body id="page-top">
    <!-- Include Sidebar -->
    <jsp:include page="sidebar.jsp" />
    
    <div class="body-wrap">
        <!-- Main Content -->
        <div class="container-fluid mt-0">
            <h1 class="h3 mb-4 text-gray-800">WELCOME ADMIN</h1>

            <div class="row">
                <!-- Total Drivers -->
                <div class="col-md-3">
                    <a href="viewDrivers" style="text-decoration: none">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Total Drivers
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                            <%= request.getAttribute("driversCount") %>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-id-card fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>

                <!-- Total Cabs -->
                <div class="col-md-3">
                    <a href="viewCabs" style="text-decoration: none">
                        <div class="card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Total Cabs
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                                            <%= request.getAttribute("cabsCount") %>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-car fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>

                <!-- Active Bookings -->
                <div class="col-md-3">
                    <a href="manageBookings.jsp" style="text-decoration: none">
                        <div class="card border-left-warning shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Active Bookings
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">15</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-calendar-check fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>

                <!-- Pending Requests -->
                <div class="col-md-3">
                    <div class="card border-left-danger shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                        Pending Requests
                                    </div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                                        <%= request.getAttribute("pendingRequests") %>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-exclamation-circle fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!-- End of Main Content -->

    <!-- Bootstrap & jQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
