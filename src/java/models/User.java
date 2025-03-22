package models;

public class User {
    private int id;
    private String name;
    private String userName;
    private String password;
    private String email;
    private int phone;
    private String address;
    private String nic;
    private Role role;

    public User(int id, String name, String userName, String password, String email, int phone, String address, String nic, Role role) {
        this.id = id;
        this.name = name;
        this.userName = userName;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.nic = nic;
        this.role = role;
    }

    public int getId() { 
        return id;
    }

    public String getName() {
        return name;
    }

    public String getUserName() {
        return userName;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public int getPhone() {
        return phone;
    }

    public String getAddress() {
        return address;
    }

    public String getNic() {
        return nic;
    }

    public Role getRole() {
        return role;
    }
}
