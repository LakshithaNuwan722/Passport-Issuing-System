package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@WebServlet("/PaymentProcessor")
public class PaymentProcessorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String test = request.getParameter("test");
        
        // Database connectivity test
        if ("db".equals(test)) {
            testDatabaseConnection(response);
            return;
        }
        
        // Application details test
        String appIdStr = request.getParameter("applicationId");
        if (appIdStr != null) {
            getApplicationDetails(appIdStr, response);
            return;
        }
        
        // Default response
        Map<String, Object> result = new HashMap<>();
        result.put("status", "PaymentProcessor Servlet Active");
        result.put("timestamp", LocalDateTime.now().toString());
        new ObjectMapper().writeValue(response.getWriter(), result);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> result = new HashMap<>();
        
        System.out.println("\n=== PAYMENT PROCESSOR STARTED ===");
        
        try {
            // Get all parameters
            String applicationIdStr = request.getParameter("applicationId");
            String paymentMethod = request.getParameter("paymentMethod");
            String processingType = request.getParameter("processingType");
            String processingFeeStr = request.getParameter("processingFee");
            String serviceFeeStr = request.getParameter("serviceFee");
            String totalAmountStr = request.getParameter("totalAmount");
            
            // Log received parameters
            System.out.println("Received parameters:");
            System.out.println("  applicationId: " + applicationIdStr);
            System.out.println("  paymentMethod: " + paymentMethod);
            System.out.println("  processingType: " + processingType);
            System.out.println("  processingFee: " + processingFeeStr);
            System.out.println("  serviceFee: " + serviceFeeStr);
            System.out.println("  totalAmount: " + totalAmountStr);
            
            // Validate required parameters
            if (applicationIdStr == null || paymentMethod == null || processingType == null ||
                processingFeeStr == null || serviceFeeStr == null || totalAmountStr == null) {
                
                result.put("success", false);
                result.put("error", "Missing required parameters");
                result.put("received", Map.of(
                    "applicationId", applicationIdStr != null,
                    "paymentMethod", paymentMethod != null,
                    "processingType", processingType != null,
                    "processingFee", processingFeeStr != null,
                    "serviceFee", serviceFeeStr != null,
                    "totalAmount", totalAmountStr != null
                ));
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                objectMapper.writeValue(response.getWriter(), result);
                return;
            }
            
            // Parse numeric values
            int applicationId = Integer.parseInt(applicationIdStr);
            BigDecimal processingFee = new BigDecimal(processingFeeStr);
            BigDecimal serviceFee = new BigDecimal(serviceFeeStr);
            BigDecimal totalAmount = new BigDecimal(totalAmountStr);
            BigDecimal taxAmount = BigDecimal.ZERO;
            
            System.out.println("Parsed values successfully");
            System.out.println("  applicationId: " + applicationId);
            System.out.println("  totalAmount: " + totalAmount);
            
            // Check if application exists
            if (!applicationExists(applicationId)) {
                result.put("success", false);
                result.put("error", "Application ID " + applicationId + " not found in database");
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                objectMapper.writeValue(response.getWriter(), result);
                return;
            }
            
            System.out.println("Application exists in database");
            
            // Check if already paid
            if (isAlreadyPaid(applicationId)) {
                result.put("success", false);
                result.put("error", "Payment already completed for this application");
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                objectMapper.writeValue(response.getWriter(), result);
                return;
            }
            
            System.out.println("Application not yet paid - proceeding with payment");
            
            // Generate transaction ID
            String transactionId = "TXN_" + System.currentTimeMillis() + "_" + 
                                   UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            System.out.println("Generated transaction ID: " + transactionId);
            
            // Save to database
            int savedTransactionId = savePaymentToDatabase(
                applicationId, paymentMethod, processingType,
                processingFee, serviceFee, taxAmount, totalAmount, transactionId
            );
            
            if (savedTransactionId > 0) {
                System.out.println("Payment saved successfully with ID: " + savedTransactionId);
                
                // Update application status
                updateApplicationPaymentStatus(applicationId);
                
                System.out.println("Application payment status updated");
                
                // Success response
                result.put("success", true);
                result.put("message", "Payment processed successfully");
                result.put("transactionId", transactionId);
                result.put("transactionDbId", savedTransactionId);
                result.put("applicationId", applicationId);
                result.put("amount", totalAmount);
                result.put("timestamp", LocalDateTime.now().toString());
                
                System.out.println("=== PAYMENT PROCESSOR COMPLETED SUCCESSFULLY ===\n");
                
            } else {
                throw new Exception("Failed to save payment to database");
            }
            
        } catch (NumberFormatException e) {
            System.err.println("ERROR: Invalid number format - " + e.getMessage());
            result.put("success", false);
            result.put("error", "Invalid numeric value: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            
        } catch (SQLException e) {
            System.err.println("ERROR: Database connection error");
            System.err.println("Error type: " + e.getClass().getSimpleName());
            System.err.println("Error message: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            
            result.put("success", false);
            
            // Provide user-friendly error message for connection failures
            String errorMsg = e.getMessage();
            if (errorMsg != null && errorMsg.contains("Communications link failure")) {
                result.put("error", "Database connection failed. Please check if MySQL server is running.");
                result.put("details", "The application cannot connect to the database server. " +
                    "Please ensure MySQL service is started and accessible.");
                result.put("troubleshooting", "Visit /db-diagnostic.jsp for detailed diagnostics");
            } else {
                result.put("error", "Database error: " + errorMsg);
            }
            
            result.put("errorType", "SQLException");
            result.put("sqlState", e.getSQLState());
            result.put("errorCode", e.getErrorCode());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            
        } catch (Exception e) {
            System.err.println("ERROR: Payment processing failed");
            System.err.println("Error type: " + e.getClass().getSimpleName());
            System.err.println("Error message: " + e.getMessage());
            e.printStackTrace();
            
            result.put("success", false);
            result.put("error", "Payment processing failed: " + e.getMessage());
            result.put("errorType", e.getClass().getSimpleName());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        
        objectMapper.writeValue(response.getWriter(), result);
    }
    
    private boolean applicationExists(int applicationId) {
        String sql = "SELECT COUNT(*) FROM applications WHERE application_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, applicationId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                boolean exists = rs.getInt(1) > 0;
                System.out.println("Application " + applicationId + " exists: " + exists);
                return exists;
            }
            return false;
            
        } catch (SQLException e) {
            System.err.println("Error checking application existence: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    private boolean isAlreadyPaid(int applicationId) {
        String sql = "SELECT payment_status FROM applications WHERE application_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, applicationId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String status = rs.getString("payment_status");
                boolean isPaid = "paid".equals(status);
                System.out.println("Application " + applicationId + " payment status: " + status);
                return isPaid;
            }
            return false;
            
        } catch (SQLException e) {
            System.err.println("Error checking payment status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    private int savePaymentToDatabase(int applicationId, String paymentMethod, String processingType,
                                      BigDecimal processingFee, BigDecimal serviceFee, BigDecimal taxAmount,
                                      BigDecimal totalAmount, String transactionId) throws SQLException {
        
        String sql = "INSERT INTO payment_transactions " +
                    "(application_id, payment_method, processing_type, processing_fee, service_fee, " +
                    "tax_amount, total_amount, transaction_status, payment_reference, transaction_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, 'completed', ?, NOW())";
        
        System.out.println("Saving payment transaction to database...");
        System.out.println("SQL: " + sql);
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, applicationId);
            stmt.setString(2, paymentMethod);
            stmt.setString(3, processingType);
            stmt.setBigDecimal(4, processingFee);
            stmt.setBigDecimal(5, serviceFee);
            stmt.setBigDecimal(6, taxAmount);
            stmt.setBigDecimal(7, totalAmount);
            stmt.setString(8, transactionId);
            
            System.out.println("Executing SQL insert...");
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            
            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    int id = rs.getInt(1);
                    System.out.println("Transaction saved with database ID: " + id);
                    return id;
                }
            }
            
            return -1;
            
        } catch (SQLException e) {
            System.err.println("SQL ERROR while saving payment:");
            System.err.println("  SQL State: " + e.getSQLState());
            System.err.println("  Error Code: " + e.getErrorCode());
            System.err.println("  Message: " + e.getMessage());
            throw e;
        }
    }
    
    private void updateApplicationPaymentStatus(int applicationId) throws SQLException {
        String sql = "UPDATE applications SET payment_status = 'paid', payment_date = NOW() " +
                    "WHERE application_id = ?";
        
        System.out.println("Updating application payment status...");
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, applicationId);
            int rowsUpdated = stmt.executeUpdate();
            
            System.out.println("Application status update - rows affected: " + rowsUpdated);
            
        } catch (SQLException e) {
            System.err.println("SQL ERROR while updating application status:");
            System.err.println("  Message: " + e.getMessage());
            throw e;
        }
    }
    
    private void testDatabaseConnection(HttpServletResponse response) throws IOException {
        Map<String, Object> result = new HashMap<>();
        
        try (Connection conn = Database.getConnection()) {
            result.put("connected", true);
            result.put("database", conn.getCatalog());
            
            // Test applications table
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM applications")) {
                if (rs.next()) {
                    result.put("applicationsCount", rs.getInt("count"));
                }
            }
            
            // Test payment_transactions table
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM payment_transactions")) {
                if (rs.next()) {
                    result.put("paymentsCount", rs.getInt("count"));
                }
            }
            
            result.put("message", "Database connection successful");
            
        } catch (Exception e) {
            result.put("connected", false);
            result.put("error", e.getMessage());
        }
        
        new ObjectMapper().writeValue(response.getWriter(), result);
    }
    
    private void getApplicationDetails(String appIdStr, HttpServletResponse response) throws IOException {
        Map<String, Object> result = new HashMap<>();
        
        try {
            int appId = Integer.parseInt(appIdStr);
            
            String sql = "SELECT * FROM applications WHERE application_id = ?";
            
            try (Connection conn = Database.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                
                stmt.setInt(1, appId);
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
                    result.put("found", true);
                    result.put("applicationId", rs.getInt("application_id"));
                    result.put("nicNumber", rs.getString("nic_number"));
                    result.put("firstName", rs.getString("first_name"));
                    result.put("lastName", rs.getString("last_name"));
                    result.put("processingType", rs.getString("processing_type"));
                    result.put("paymentStatus", rs.getString("payment_status"));
                } else {
                    result.put("found", false);
                    result.put("message", "Application not found");
                }
            }
            
        } catch (Exception e) {
            result.put("error", e.getMessage());
        }
        
        new ObjectMapper().writeValue(response.getWriter(), result);
    }
}

