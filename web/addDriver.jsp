<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Driver</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .d-flex{
            margin-top: 0.5rem;
        }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <jsp:include page="sidebar.jsp" />
        
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content" style="margin-left: 18%">
                
                <div class="container mt-3">
                    <h2 class="text-left">Add a New Driver</h2>
                    <div id="alert-container"></div>
                    
                    <form action="AddDriver" method="post" class="mt-4">
                        <div class="mb-3">
                            <label for="name" class="form-label">Name:</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" id="name" name="name" class="form-control" placeholder="Enter driver's full name" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="license_number" class="form-label">License Number:</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                <input type="text" id="license_number" name="license_number" class="form-control" 
                                       placeholder="A1234567" pattern="[A-Za-z]{1}[0-9]{7}" required 
                                       title="License number should start with 1 letter followed by 7 digits (e.g., A1234567)"
                                       maxlength="8">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="phone_number" class="form-label">Phone:</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                <input type="tel" id="phone_number" name="phone_number" class="form-control" 
                                       placeholder="Enter phone number" pattern="\d{10}" required 
                                       title="Phone number should be 10 digits"
                                       maxlength="10">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="address" class="form-label">Address:</label>
                            <textarea id="address" name="address" class="form-control" placeholder="Enter driver's address" rows="3"></textarea>
                        </div>
                        
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">Add Driver</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
