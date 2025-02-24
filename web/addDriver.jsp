<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Driver</title>
</head>
<body>
    <form action="AddDriver" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" placeholder="Enter driver's full name" required>
        <br>
        <label for="license_number">License Number:</label>
        <input type="text" id="license_number" name="license_number" placeholder="Enter license number (e.g., A1234567)" pattern="[A-Za-z]{1}[0-9]{7}" required maxlength="8">
        <br>
        <label for="phone_number">Phone:</label>
        <input type="tel" id="phone_number" name="phone_number" placeholder="Enter phone number" pattern="^\d{10}$" required maxlength="10">
        <br>
        <label for="address">Address:</label>
        <textarea id="address" name="address" placeholder="Enter driver's address" rows="3"></textarea>
        <br>
        <button type="submit">Add Driver</button>
    </form>
</body>
</html>