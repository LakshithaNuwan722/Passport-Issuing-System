package com.example.passport_issuing.model;

import java.sql.Timestamp;

public class Staff {
    private int staffId;
    private String username;
    private String password;
    private String section;
    private String email;
    private String fullName;
    private boolean isActive;
    private Timestamp createdAt;

    public Staff() {}

    public Staff(int staffId, String username, String password, String section,
                 String email, String fullName, boolean isActive, Timestamp createdAt) {
        this.staffId = staffId;
        this.username = username;
        this.password = password;
        this.section = section;
        this.email = email;
        this.fullName = fullName;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSection() {
        return section;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}