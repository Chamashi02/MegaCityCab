// LocationDAO.java
package dao;

import models.Location;
import utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LocationDAO {

    // fetch a single location based on the name
    public static Location getLocationByName(String name) {
        Location location = null;
        String query = "SELECT * FROM locations WHERE name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            pst.setString(1, name);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                double latitude = rs.getDouble("latitude");
                double longitude = rs.getDouble("longitude");
                location = new Location(name, latitude, longitude);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return location;
    }

    // fetch all locations from the database
    public static List<Location> getAllLocations() {
        List<Location> locations = new ArrayList<>();
        String query = "SELECT * FROM locations";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                double latitude = rs.getDouble("latitude");
                double longitude = rs.getDouble("longitude");
                locations.add(new Location(name, latitude, longitude));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return locations;
    }
}
