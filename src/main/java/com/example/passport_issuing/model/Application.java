package com.example.passport_issuing.model;

import java.sql.Date;

public class Application {
    private int applicationId;
    private String nicNumber;
    private String firstName;
    private String lastName;
    private Date dateOfBirth;
    private String email;
    private String currentAddress;
    private String city;
    private String postalCode;
    private String processingType;
    private Date biometricDate;
    private String status;

    public Application() {}

    public Application(int applicationId, String nicNumber, String firstName, String lastName,
                       Date dateOfBirth, String email, String currentAddress, String city,
                       String postalCode, String processingType, Date biometricDate, String status) {
        this.applicationId = applicationId;
        this.nicNumber = nicNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dateOfBirth = dateOfBirth;
        this.email = email;
        this.currentAddress = currentAddress;
        this.city = city;
        this.postalCode = postalCode;
        this.processingType = processingType;
        this.biometricDate = biometricDate;
        this.status = status;
    }

    // Getters and Setters
    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public String getNicNumber() {
        return nicNumber;
    }

    public void setNicNumber(String nicNumber) {
        this.nicNumber = nicNumber;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCurrentAddress() {
        return currentAddress;
    }

    public void setCurrentAddress(String currentAddress) {
        this.currentAddress = currentAddress;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getProcessingType() {
        return processingType;
    }

    public void setProcessingType(String processingType) {
        this.processingType = processingType;
    }

    public Date getBiometricDate() {
        return biometricDate;
    }

    public void setBiometricDate(Date biometricDate) {
        this.biometricDate = biometricDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}