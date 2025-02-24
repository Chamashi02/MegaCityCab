<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Cab "%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cabs</title>
    </head>
    <body>
        <h2>Cabs List</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Cab Number</th>
                    <th>Model</th>
                    <th>Cab Type</th>
                    <th>Capacity</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Cab> cabList = (List<Cab>) request.getAttribute("cabList");
                    if (cabList != null && !cabList.isEmpty()) {
                        for (Cab cab : cabList) {
                %>
                <tr>
                    <td><%= cab.getCabId() %></td>
                    <td><%= cab.getCabNumber() %></td>
                    <td><%= cab.getModel() %></td>
                    <td><%= cab.getCabType() %></td>
                    <td><%= cab.getCapacity() %></td>
                    <td><%= cab.getStatus() %></td>
                </tr>
                <% 
                        }
                    }else {
                %>
                <tr>
                    <td colspan="6">No cabs found.</td>
                </tr>
                <%
                    }
                %>
                
            </tbody>    
                
        </table>
    </body>
</html>
