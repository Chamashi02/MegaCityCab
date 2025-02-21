<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard - Add Cars</title>
        <link rel="stylesheet" href="css/admindashboard.css">
    <script>
        function validateForm() {
            var cabId = document.getElementById("cabId").value;
            var brand = document.getElementById("brand").value;
            var numberPlate = document.getElementById("numberPlate").value;
            var driverName = document.getElementById("driverName").value;
            var driverPhone = document.getElementById("driverPhone").value;
            var availability = document.getElementById("availability").value;

            if (cabId == "" || brand == "" || numberPlate == "" || driverName == "" || driverPhone == "" || availability == "") {
                alert("Please fill out all fields.");
                return false;
            }
            return true;
        }
    </script>
    </head>
    
    <body class="body-container">
        <div class="admin-container">
            <h2 class="admin-title">Admin Dashboard - Add Cab</h2>

        <form action="AddCabServlet" method="post" class="admin-form" onsubmit="return validateForm()">
            
            
            <label class="form-label">Cab Id</label>
            <input type="text" name="cabId" id="cabId" class="form-input" required>
            
            <label class="form-label">Brand</label>
            <input type="text" name="brand" id="brand" class="form-input" required>
            
            <label class="form-label">Cab Type</label>
            <input type="text" name="type" id="type" class="form-input" required>

            <label class="form-label">Number Plate</label>
            <input type="text" name="numberPlate" id="numberPlate" class="form-input" required>

            <label class="form-label">Driver Name</label>
            <input type="text" name="driverName" id="driverName" class="form-input" required>

            <label class="form-label">Driver Phone No.</label>
            <input type="number" name="driverPhone" id="driverPhone" class="form-input" required>

            <label class="form-label">Availability</label>
            <select name="availability" id="availability" class="form-input" required>
                   <option value="available">Available</option>
                   <option value="not_available">Not Available</option>
            </select>

   
            <input type="submit" value="Add Cab" class="form-button"> 
        </form>

        </div>
    </body>
</html>
