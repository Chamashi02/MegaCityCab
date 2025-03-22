<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body class="body-container">
    <script>
            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.has('sessionExpired') && urlParams.get('sessionExpired') === 'true') {
                    alert("Your session has expired. Please log in again.");
                }
            };
        </script>
    <div class="form-container">
        <form action="LoginServlet" method="post">
            <h2 class="form-title">Login</h2>

            <label for="uid" class="form-label">User Name</label>
            <input type="text" id="uid" name="uid" class="form-input" required>

            <label for="pass" class="form-label">Password</label>
            <input type="password" id="pass" name="pass" class="form-input" required>

            <input type="submit" name="submit" value="Login" class="form-button">

            <div class="error-message">
            </div> 

            <div class="register-link">
                <p>Don't have an account? <a href="register.jsp">Register here</a></p>
            </div>
        </form>
    </div>
</body>
</html>
