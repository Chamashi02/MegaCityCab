<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Cab</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .form-container {
            margin-left: 18%;
            margin-top: -0.5rem;
        }
    </style>
</head>
<body class="bg-light">
    <div id="wrapper" style="margin-top: 1rem">
        <jsp:include page="sidebar.jsp" />
        
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content" class="form-container">
                <div class="container mt-3">
                    <h2 class="text-left">Add a New Cab</h2>
                    <div id="alert-container"></div>
                    
                    <form action="AddCab" method="post" class="mt-4">
                        <div class="mb-3">
                            <label for="cab_number" class="form-label">Cab Number:</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-car"></i></span>
                                <input type="text" id="cab_number" name="cab_number" class="form-control" placeholder="Enter Cab Number" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="model" class="form-label">Model:</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-cogs"></i></span>
                                <input type="text" id="model" name="model" class="form-control" placeholder="Enter Cab Model" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="cab_type" class="form-label">Cab Type:</label>
                            <select id="cab_type" name="cab_type" class="form-select" required>
                                <option value="Sedan">Sedan</option>
                                <option value="SUV">SUV</option>
                                <option value="Mini">Mini</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="capacity" class="form-label">Capacity:</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user-friends"></i></span>
                                <input type="number" id="capacity" name="capacity" class="form-control" placeholder="Enter Cab Capacity" required>
                            </div>
                        </div>
                        
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">Add Cab</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
