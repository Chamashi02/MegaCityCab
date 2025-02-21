<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="css/style.css"/>
</head>
<body class="body-container">
    <div class="form-container">
        <form action="LoginServlet" method="post">
            <h2 class="form-title">Login</h2>

            <label for="uid" class="form-label">User Name</label>
            <input type="text" id="uid" name="uid" class="form-input" required>

            <label for="pass" class="form-label">Password</label>
            <input type="password" id="pass" name="pass" class="form-input" required>

            <input type="submit" name="submit" value="Login" class="form-button">

            <!-- Optional error message section -->
            <div class="error-message">
                <!-- Display error message if authentication fails -->
            </div> 

            <div class="register-link">
                <p>Don't have an account? <a href="register.jsp">Register here</a></p>
            </div>
        </form>
    </div>
</body>
</html>
