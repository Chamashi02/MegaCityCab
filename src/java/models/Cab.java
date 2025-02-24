package models;


public class Cab {
    private int cabId;
    private String cabNumber;
    private String model;
    private String cabType;
    private String capacity;
    private String status; 

    public Cab(int cabId, String cabNumber, String model, String cabType, String capacity, String status) {
        this.cabId = cabId;
        this.cabNumber = cabNumber;
        this.model = model;
        this.cabType = cabType;
        this.capacity = capacity;
        this.status = status;
    }

    public int getCabId() {
        return cabId;
    }

    public void setCabId(int cabId) {
        this.cabId = cabId;
    }

    public String getCabNumber() {
        return cabNumber;
    }

    public void setCabNumber(String cabNumber) {
        this.cabNumber = cabNumber;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getCabType() {
        return cabType;
    }

    public void setCabType(String cabType) {
        this.cabType = cabType;
    }

    public String getCapacity() {
        return capacity;
    }

    public void setCapacity(String capacity) {
        this.capacity = capacity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}

