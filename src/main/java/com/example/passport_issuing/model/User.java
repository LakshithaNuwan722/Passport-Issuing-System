package com.example.passport_issuing.model;

public class User {
    private int id;
    private String nicNumber;
    private String email;
    private String password;

    public User() {}

    public User(int id, String nicNumber, String email, String password) {
        this.id = id;
        this.nicNumber = nicNumber;
        this.email = email;
        this.password = password;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNicNumber() {
        return nicNumber;
    }

    public void setNicNumber(String nicNumber) {
        this.nicNumber = nicNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}