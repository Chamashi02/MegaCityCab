<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Cab</title>
    </head>
    <body>
        <form action="AddCab" method="post">
            <label for="cab_number">Cab Number: </label>
            <input type="text" id="cab_number" name="cab_number" placeholder="Enter Cab Number" required=> <br>
            
            <label for="model">Model: </label>
            <input type="text" id="model" name="model" placeholder="Enter cab Model" required> <br>
            
            <label for="cab_type">Cab Type:</label>
            <select id="cab_type" name="cab_type" required>
                <option value="Sedan">Sedan</option>
                <option value="SUV">SUV</option>
                <option value="Mini">Mini</option> </select> <br>
            
            <label for="capacity">Capacity: </label>
            <input type="number" id="capacity" name="capacity" placeholder="Enter Cab Capacity" required> <br>
            
            <button type="submit">Add Cab</button>
       
        </form>
      
    </body>
</html>
