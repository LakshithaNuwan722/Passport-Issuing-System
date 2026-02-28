package com.example.passport_issuing.model;

import java.sql.Timestamp;

public class ApplicationReview {
    private int reviewId;
    private int applicationId;
    
    // Personal Information Section
    private boolean personalInfoApproved;
    private String personalInfoReviewedBy;
    private Timestamp personalInfoReviewedAt;
    
    // Address Information Section
    private boolean addressInfoApproved;
    private String addressInfoReviewedBy;
    private Timestamp addressInfoReviewedAt;
    
    // Documents Section
    private boolean documentsApproved;
    private String documentsReviewedBy;
    private Timestamp documentsReviewedAt;
    
    // Biometric Section
    private boolean biometricCompleted;
    private String biometricReviewedBy;
    private Timestamp biometricReviewedAt;
    
    // Final Approval
    private String finalApprovalStatus; // pending, approved, rejected
    private String finalReviewedBy;
    private Timestamp finalReviewedAt;
    private String rejectionReason;
    
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public ApplicationReview() {}

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public boolean isPersonalInfoApproved() {
        return personalInfoApproved;
    }

    public void setPersonalInfoApproved(boolean personalInfoApproved) {
        this.personalInfoApproved = personalInfoApproved;
    }

    public String getPersonalInfoReviewedBy() {
        return personalInfoReviewedBy;
    }

    public void setPersonalInfoReviewedBy(String personalInfoReviewedBy) {
        this.personalInfoReviewedBy = personalInfoReviewedBy;
    }

    public Timestamp getPersonalInfoReviewedAt() {
        return personalInfoReviewedAt;
    }

    public void setPersonalInfoReviewedAt(Timestamp personalInfoReviewedAt) {
        this.personalInfoReviewedAt = personalInfoReviewedAt;
    }

    public boolean isAddressInfoApproved() {
        return addressInfoApproved;
    }

    public void setAddressInfoApproved(boolean addressInfoApproved) {
        this.addressInfoApproved = addressInfoApproved;
    }

    public String getAddressInfoReviewedBy() {
        return addressInfoReviewedBy;
    }

    public void setAddressInfoReviewedBy(String addressInfoReviewedBy) {
        this.addressInfoReviewedBy = addressInfoReviewedBy;
    }

    public Timestamp getAddressInfoReviewedAt() {
        return addressInfoReviewedAt;
    }

    public void setAddressInfoReviewedAt(Timestamp addressInfoReviewedAt) {
        this.addressInfoReviewedAt = addressInfoReviewedAt;
    }

    public boolean isDocumentsApproved() {
        return documentsApproved;
    }

    public void setDocumentsApproved(boolean documentsApproved) {
        this.documentsApproved = documentsApproved;
    }

    public String getDocumentsReviewedBy() {
        return documentsReviewedBy;
    }

    public void setDocumentsReviewedBy(String documentsReviewedBy) {
        this.documentsReviewedBy = documentsReviewedBy;
    }

    public Timestamp getDocumentsReviewedAt() {
        return documentsReviewedAt;
    }

    public void setDocumentsReviewedAt(Timestamp documentsReviewedAt) {
        this.documentsReviewedAt = documentsReviewedAt;
    }

    public boolean isBiometricCompleted() {
        return biometricCompleted;
    }

    public void setBiometricCompleted(boolean biometricCompleted) {
        this.biometricCompleted = biometricCompleted;
    }

    public String getBiometricReviewedBy() {
        return biometricReviewedBy;
    }

    public void setBiometricReviewedBy(String biometricReviewedBy) {
        this.biometricReviewedBy = biometricReviewedBy;
    }

    public Timestamp getBiometricReviewedAt() {
        return biometricReviewedAt;
    }

    public void setBiometricReviewedAt(Timestamp biometricReviewedAt) {
        this.biometricReviewedAt = biometricReviewedAt;
    }

    public String getFinalApprovalStatus() {
        return finalApprovalStatus;
    }

    public void setFinalApprovalStatus(String finalApprovalStatus) {
        this.finalApprovalStatus = finalApprovalStatus;
    }

    public String getFinalReviewedBy() {
        return finalReviewedBy;
    }

    public void setFinalReviewedBy(String finalReviewedBy) {
        this.finalReviewedBy = finalReviewedBy;
    }

    public Timestamp getFinalReviewedAt() {
        return finalReviewedAt;
    }

    public void setFinalReviewedAt(Timestamp finalReviewedAt) {
        this.finalReviewedAt = finalReviewedAt;
    }

    public String getRejectionReason() {
        return rejectionReason;
    }

    public void setRejectionReason(String rejectionReason) {
        this.rejectionReason = rejectionReason;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}

