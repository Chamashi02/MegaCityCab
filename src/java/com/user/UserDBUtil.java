package com.user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDBUtil {
    
    public static List<User> validate (String userName, String hashedPassword){
    
    ArrayList<User> usr = new ArrayList<>();
    
    //Create DB Connection
    
    String url = "jdbc:mysql://localhost:3306/megacitycab";
    String user = "root";
    String pass = "Mashi@@##02";
    
    //Validate
    
    try{
        Class.forName("com.mysql.jdbc.Driver");
        
        Connection con = DriverManager.getConnection(url,user,pass);
        Statement stmt = con.createStatement();
        String sql = "SELECT * FROM megacitycab.user WHERE username='"+userName+"' AND password = '"+hashedPassword+"'";
        ResultSet rs = stmt.executeQuery(sql);
        
        if(rs.next()){
            int id = rs.getInt(1);
            String name = rs.getString(2);
            String userU = rs.getString(3);
            String passU = rs.getString(4);
            String email = rs.getString(5);
            int phone = rs.getInt(6);
            String address = rs.getString(7);
            String nic = rs.getString(8);
            String roleStr = rs.getString(9);
            
            //Convert role from String to Role enum
            Role role = Role.valueOf(roleStr.toLowerCase());
            
            User u = new User (id,name,userName,hashedPassword,email,phone,address,nic,role);
            usr.add(u);
        }
    }
    
    catch(Exception e){
        e.printStackTrace();
    }
    
    return usr;
    
    }
}
