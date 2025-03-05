package dao;

import models.Booking;
import utils.DBConnection;

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
}
