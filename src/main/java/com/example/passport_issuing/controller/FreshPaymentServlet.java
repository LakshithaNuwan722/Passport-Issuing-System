package com.example.passport_issuing.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@WebServlet("/FreshPayment")
public class FreshPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // Database uses static methods, no instance needed
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        Map<String, Object> result = new HashMap<>();
        PrintWriter out = null;
        
        try {
            // Get parameters
            String applicationIdStr = request.getParameter("applicationId");
            String paymentMethod = request.getParameter("paymentMethod");
            String processingType = request.getParameter("processingType");
            String totalAmountStr = request.getParameter("totalAmount");
            String processingFeeStr = request.getParameter("processingFee");
            String serviceFeeStr = request.getParameter("serviceFee");
            String taxAmountStr = request.getParameter("taxAmount");
            
            // Log all received parameters
            System.out.println("=== FreshPaymentServlet Debug ===");
            System.out.println("Application ID: " + applicationIdStr);
            System.out.println("Payment Method: " + paymentMethod);
            System.out.println("Processing Type: " + processingType);
            System.out.println("Total Amount: " + totalAmountStr);
            System.out.println("Processing Fee: " + processingFeeStr);
            System.out.println("Service Fee: " + serviceFeeStr);
            System.out.println("Tax Amount: " + taxAmountStr);
            
            // Validate required parameters
            if (applicationIdStr == null || applicationIdStr.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "Application ID is required");
                response.getWriter().print(objectMapper.writeValueAsString(result));
                return;
            }
            
            int applicationId;
            try {
                applicationId = Integer.parseInt(applicationIdStr);
            } catch (NumberFormatException e) {
                result.put("success", false);
                result.put("message", "Invalid Application ID format");
                response.getWriter().print(objectMapper.writeValueAsString(result));
                return;
            }
            
            // Set defaults for missing parameters
            if (paymentMethod == null) paymentMethod = "credit_card";
            if (processingType == null) processingType = "regular";
            if (totalAmountStr == null) totalAmountStr = "15000";
            if (processingFeeStr == null) processingFeeStr = "15000";
            if (serviceFeeStr == null) serviceFeeStr = "2000";
            if (taxAmountStr == null) taxAmountStr = "0";
            
            // Parse amounts
            double totalAmount, processingFee, serviceFee, taxAmount;
            try {
                totalAmount = Double.parseDouble(totalAmountStr);
                processingFee = Double.parseDouble(processingFeeStr);
                serviceFee = Double.parseDouble(serviceFeeStr);
                taxAmount = Double.parseDouble(taxAmountStr);
            } catch (NumberFormatException e) {
                result.put("success", false);
                result.put("message", "Invalid amount format");
                response.getWriter().print(objectMapper.writeValueAsString(result));
                return;
            }
            
            // Check if application exists
            if (!validateApplicationExists(applicationId)) {
                result.put("success", false);
                result.put("message", "Application ID " + applicationId + " not found in database. Please check if this application exists.");
                System.err.println("Application validation failed for ID: " + applicationId);
                response.getWriter().print(objectMapper.writeValueAsString(result));
                return;
            }
            
            // Check if already paid
            if (hasCompletedPayment(applicationId)) {
                result.put("success", false);
                result.put("message", "Payment already completed for this application");
                response.getWriter().print(objectMapper.writeValueAsString(result));
                return;
            }
            
            // Generate transaction ID
            String transactionId = generateTransactionId();
            
            // Save payment transaction
            boolean paymentSaved = savePaymentTransaction(
                applicationId, transactionId, paymentMethod, processingType,
                totalAmount, processingFee, serviceFee, taxAmount
            );
            
            if (paymentSaved) {
                // Update application payment status (only for completed payments, not pending)
                if (!paymentMethod.equals("bank_transfer")) {
                    updateApplicationPaymentStatus(applicationId);
                }
                
                result.put("success", true);
                if (paymentMethod.equals("bank_transfer")) {
                    result.put("message", "Payment submitted successfully. Pending staff approval.");
                } else {
                    result.put("message", "Payment processed successfully");
                }
                result.put("transactionId", transactionId);
                result.put("applicationId", applicationId);
                result.put("totalAmount", totalAmount);
                result.put("processingType", processingType);
                
                System.out.println("Payment successful for Application ID: " + applicationId);
                System.out.println("Transaction ID: " + transactionId);
            } else {
                result.put("success", false);
                result.put("message", "Failed to save payment transaction. Please check Tomcat console for SQL errors.");
                System.err.println("Payment transaction save failed for Application ID: " + applicationId);
            }
            
        } catch (Exception e) {
            System.err.println("Error in FreshPaymentServlet: " + e.getMessage());
            e.printStackTrace();
            
            result.put("success", false);
            result.put("message", "Internal server error: " + e.getMessage());
        } finally {
            out = response.getWriter();
            out.print(objectMapper.writeValueAsString(result));
            out.flush();
            out.close();
        }
    }
    
    private boolean validateApplicationExists(int applicationId) {
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT COUNT(*) FROM applications WHERE application_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, applicationId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        System.out.println("Application " + applicationId + " exists: " + (count > 0));
                        return count > 0;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error validating application: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    private boolean hasCompletedPayment(int applicationId) {
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT COUNT(*) FROM payment_transactions WHERE application_id = ? AND transaction_status = 'completed'";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, applicationId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        System.out.println("Application " + applicationId + " has completed payment: " + (count > 0));
                        return count > 0;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking payment status: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    private String generateTransactionId() {
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String uuid = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        return "TXN" + timestamp + uuid;
    }
    
    private boolean savePaymentTransaction(int applicationId, String transactionId, String paymentMethod,
                                        String processingType, double totalAmount, double processingFee,
                                        double serviceFee, double taxAmount) {
        try (Connection conn = Database.getConnection()) {
            // Bank transfers need approval, cards are auto-approved
            String status = paymentMethod.equals("bank_transfer") ? "pending" : "completed";
            
            // Note: transaction_id is AUTO_INCREMENT PRIMARY KEY, but we're using payment_reference for our generated ID
            String sql = "INSERT INTO payment_transactions (application_id, payment_method, " +
                        "processing_type, total_amount, processing_fee, service_fee, tax_amount, " +
                        "transaction_status, payment_reference, transaction_date) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, applicationId);
                stmt.setString(2, paymentMethod);
                stmt.setString(3, processingType);
                stmt.setDouble(4, totalAmount);
                stmt.setDouble(5, processingFee);
                stmt.setDouble(6, serviceFee);
                stmt.setDouble(7, taxAmount);
                stmt.setString(8, status);  // pending for bank_transfer, completed for cards
                stmt.setString(9, transactionId);  // Store in payment_reference
                
                int rowsAffected = stmt.executeUpdate();
                System.out.println("Payment transaction saved. Rows affected: " + rowsAffected);
                System.out.println("Transaction Reference: " + transactionId);
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error saving payment transaction: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        }
    }
    
    private void updateApplicationPaymentStatus(int applicationId) {
        try (Connection conn = Database.getConnection()) {
            String sql = "UPDATE applications SET payment_status = 'paid', updated_at = NOW() WHERE application_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, applicationId);
                int rowsAffected = stmt.executeUpdate();
                System.out.println("Application payment status updated. Rows affected: " + rowsAffected);
            }
        } catch (SQLException e) {
            System.err.println("Error updating application payment status: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
