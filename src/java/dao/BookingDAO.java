//dao/BookingDAO
package dao;

import models.Booking;
import utils.DBConnection;
import java.util.List;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class BookingDAO {
    public static boolean addBooking(Booking booking) {
        String query = "INSERT INTO bookings (user_id, cab_type, pickup_location, dropoff_location, pickup_time, status, price, distance) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            
            pst.setInt(1, booking.getUserId());
            pst.setString(2, booking.getCabType());
            pst.setString(3, booking.getPickupLocation());
            pst.setString(4, booking.getDropoffLocation());
            pst.setString(5, booking.getPickupTime());
            pst.setString(6, booking.getStatus());
            pst.setDouble(7, booking.getEstimatedFare());
            pst.setDouble(8, booking.getDistance());

            int rowsInserted = pst.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        
    }
    
    public static boolean updateBookingStatus(int bookingId, String status) {
    String query = "UPDATE bookings SET status = ? WHERE booking_id = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement pst = conn.prepareStatement(query)) {
        
        pst.setString(1, status);
        pst.setInt(2, bookingId);

        int rowsUpdated = pst.executeUpdate();
        return rowsUpdated > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
        }
    }
    
    public static List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String query = "SELECT * FROM bookings";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("user_id"),
                        rs.getString("cab_type"),
                        rs.getString("pickup_location"),
                        rs.getString("dropoff_location"),
                        rs.getString("pickup_time"),
                        rs.getString("status"),
                        rs.getDouble("price"),
                        rs.getDouble("distance")
                );
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return bookings;
    }
}

    


    

