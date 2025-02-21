<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register Page</title>
    <link rel="stylesheet" href="css/style.css"/>
</head> 
<body class="body-container">
    <div class="form-container">
        <form action="RegisterServlet" method="post">
            <h2 class="form-title">Registration</h2>

            <label class="form-label" for="name">Name</label>
            <input type="text" id="name" name="name" class="form-input" required>

            <label class="form-label" for="username">Username</label>
            <input type="text" id="username" name="username" class="form-input" required>

            <label class="form-label" for="password">Password</label>
            <input type="password" id="password" name="password" class="form-input" required>

            <label class="form-label" for="email">Email</label>
            <input type="email" id="email" name="email" class="form-input" required>

            <label class="form-label" for="phone">Phone Number</label>
            <input type="text" id="phone" name="phone" class="form-input" required>

            <label class="form-label" for="address">Address</label>
            <input type="text" id="address" name="address" class="form-input" required>

            <label class="form-label" for="nic">NIC</label>
            <input type="text" id="nic" name="nic" class="form-input" required>

            <input type="submit" value="Register" class="form-button">

            <!-- Optional error message section -->
            <div class="error-message">
                <!-- Display error message if authentication fails -->
            </div>
            
            <div class="login-link">
                <p>Already have an account? <a href="login.jsp">Login here</a></p>
            </div>

        </form>
    </div>
</body>
</html>
