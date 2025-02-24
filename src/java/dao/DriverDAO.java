package dao;
import utils.DBConnection;
import models.Driver;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {
    public static boolean addDriver(Driver driver) {
        String sql = "INSERT INTO driver (name, license_number, phone_number, address, status) VALUES (?, ?, ?, ?, 'available')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, driver.getName());
            pstmt.setString(2, driver.getLicenseNumber());
            pstmt.setString(3, driver.getPhoneNumber());
            pstmt.setString(4, driver.getAddress());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Driver> getAllDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String query = "SELECT * FROM driver";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Driver driver = new Driver(
                    rs.getInt("driver_id"),
                    rs.getString("name"),
                    rs.getString("license_number"),
                    rs.getString("phone_number"),
                    rs.getString("address"),
                    rs.getString("status")
                );
                drivers.add(driver);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return drivers;
    }

    public static boolean deleteDriver(int driverId) {
        String sql = "DELETE FROM driver WHERE driver_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, driverId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}