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
        String query = "SELECT d.*, c.cab_number, c.model FROM driver d LEFT JOIN cabs c ON d.cab_id = c.cab_id";

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
                    rs.getString("status"),
                    rs.getString("cab_number"), 
                    rs.getString("model")      
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
    
    // Get available drivers
    public List<Driver> getAvailableDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String query = "SELECT d.*, c.cab_number, c.model FROM driver d " +
                       "LEFT JOIN cabs c ON d.cab_id = c.cab_id " +
                       "WHERE d.status = 'available'";

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
                    rs.getString("status"),
                    rs.getString("cab_number"),  // Fetch cab number
                    rs.getString("model")        // Fetch cab model
                );
                drivers.add(driver);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return drivers;
    }

    // Get driver by ID
    public Driver getDriverById(int driverId) {
        Driver driver = null;
        String query = "SELECT * FROM driver WHERE driver_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, driverId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    driver = new Driver(
                        rs.getInt("driver_id"),
                        rs.getString("name"),
                        rs.getString("license_number"),
                        rs.getString("phone_number"),
                        rs.getString("address"),
                        rs.getString("status"),
                        null,
                        null
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return driver;
    }
    
        public static int getAllDriversCount() {
        String query = "SELECT COUNT(*) AS drivers_count FROM driver";
        int driversCount = 0;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {
            
            if (rs.next()) {
                driversCount = rs.getInt("drivers_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return driversCount;
    }


}