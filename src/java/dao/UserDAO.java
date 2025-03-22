package dao;

import models.Role;
import models.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.DBConnection;

public class UserDAO {
    
    // Validate user credentials
    public static List<User> validate(String userName, String hashedPassword){
        ArrayList<User> usr = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement()) {

            String sql = "SELECT * FROM megacitycab.user WHERE username='" + userName + "' AND password = '" + hashedPassword + "'";
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                int id = rs.getInt(1);
                String name = rs.getString(2);
                String userU = rs.getString(3);
                String passU = rs.getString(4);
                String email = rs.getString(5);
                int phone = rs.getInt(6);
                String address = rs.getString(7);
                String nic = rs.getString(8);
                String roleStr = rs.getString(9);

                Role role = Role.valueOf(roleStr.toLowerCase());

                User u = new User(id, name, userU, passU, email, phone, address, nic, role);
                usr.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return usr;
    }

    // get User by ID
    public static User getUserById(int userId) {
        User user = null;
        try (Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement()) {

            String sql = "SELECT * FROM megacitycab.user WHERE id=" + userId;
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                String name = rs.getString(2);
                String userU = rs.getString(3);
                String passU = rs.getString(4);
                String email = rs.getString(5);
                int phone = rs.getInt(6);
                String address = rs.getString(7);
                String nic = rs.getString(8);
                String roleStr = rs.getString(9);

                Role role = Role.valueOf(roleStr.toLowerCase());

                user = new User(userId, name, userU, passU, email, phone, address, nic, role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
