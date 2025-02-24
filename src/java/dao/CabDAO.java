package dao;

import utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Cab;

public class CabDAO {
    public static boolean addCab(Cab cab) {
        String sql = "INSERT INTO cabs (cab_number,model,cab_type,capacity,status) VALUES (?, ?, ?, ?, 'available')";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, cab.getCabNumber());
            pstmt.setString(2, cab.getModel());
            pstmt.setString(3, cab.getCabType());
            pstmt.setString(4, cab.getCapacity());
        
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Cab> getAllCabs() {
        List<Cab> cabs = new ArrayList<>();
        String query = "SELECT * FROM cabs";
        
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery()){
            
            while (rs.next()) {
                Cab cab = new Cab(
                    rs.getInt("cab_id"),
                    rs.getString("cab_number"),
                    rs.getString("model"),
                    rs.getString("cab_type"),
                    rs.getString("capacity"),
                    rs.getString("status")
                );
            cabs.add(cab);
            }   
        } catch(Exception e){
            e.printStackTrace();
        }
        return cabs;
    }
}
    
