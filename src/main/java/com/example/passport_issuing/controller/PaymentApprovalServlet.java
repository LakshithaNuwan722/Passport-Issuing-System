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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/PaymentApproval")
public class PaymentApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Get parameters
        String statusFilter = request.getParameter("status");
        String searchQuery = request.getParameter("search");
        
        if (statusFilter == null || statusFilter.trim().isEmpty()) {
            statusFilter = "all";  // Changed from "pending" to "all"
        }
        
        try {
            List<Map<String, Object>> payments = getPayments(statusFilter, searchQuery);
            response.getWriter().print(objectMapper.writeValueAsString(payments));
        } catch (Exception e) {
            System.err.println("Error in PaymentApprovalServlet GET: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, Object> error = new HashMap<>();
            error.put("error", "Failed to load payments: " + e.getMessage());
            response.getWriter().print(objectMapper.writeValueAsString(error));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Get session for staff username
        HttpSession session = request.getSession(false);
        String staffUsername = "System";
        if (session != null && session.getAttribute("staffUsername") != null) {
            staffUsername = (String) session.getAttribute("staffUsername");
        }
        
        String transactionIdStr = request.getParameter("transactionId");
        String action = request.getParameter("action");
        String notes = request.getParameter("notes");
        
        Map<String, Object> result = new HashMap<>();
        
        try {
            if (transactionIdStr == null || action == null) {
                result.put("success", false);
                result.put("message", "Missing required parameters");
                response.getWriter().print(objectMapper.writeValueAsString(result));
                return;
            }
            
            int transactionId = Integer.parseInt(transactionIdStr);
            
            if ("approve".equals(action)) {
                boolean approved = approvePayment(transactionId, staffUsername, notes);
                result.put("success", approved);
                result.put("message", approved ? "Payment approved successfully" : "Failed to approve payment");
            } else if ("reject".equals(action)) {
                if (notes == null || notes.trim().isEmpty()) {
                    result.put("success", false);
                    result.put("message", "Rejection reason is required");
                } else {
                    boolean rejected = rejectPayment(transactionId, staffUsername, notes);
                    result.put("success", rejected);
                    result.put("message", rejected ? "Payment rejected successfully" : "Failed to reject payment");
                }
            } else {
                result.put("success", false);
                result.put("message", "Invalid action");
            }
        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("message", "Invalid transaction ID");
        } catch (Exception e) {
            System.err.println("Error in PaymentApprovalServlet POST: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
        }
        
        response.getWriter().print(objectMapper.writeValueAsString(result));
    }
    
    private List<Map<String, Object>> getPayments(String statusFilter, String searchQuery) {
        List<Map<String, Object>> payments = new ArrayList<>();
        
        try (Connection conn = Database.getConnection()) {
            StringBuilder sql = new StringBuilder(
                "SELECT pt.transaction_id, pt.application_id, pt.payment_method, pt.processing_type, " +
                "pt.total_amount, pt.processing_fee, pt.service_fee, pt.tax_amount, " +
                "pt.transaction_status, pt.payment_reference, pt.transaction_date, pt.notes, " +
                "a.first_name, a.last_name, a.nic, a.email " +
                "FROM payment_transactions pt " +
                "LEFT JOIN applications a ON pt.application_id = a.application_id " +
                "WHERE 1=1"
            );
            
            // Add status filter
            if ("pending".equals(statusFilter)) {
                sql.append(" AND pt.transaction_status = 'pending'");
            } else if ("approved".equals(statusFilter)) {
                sql.append(" AND pt.transaction_status = 'completed'");
            } else if ("rejected".equals(statusFilter)) {
                sql.append(" AND pt.transaction_status = 'failed'");
            }
            // "all" shows everything, no additional filter
            
            // Add search filter
            boolean hasSearch = searchQuery != null && !searchQuery.trim().isEmpty();
            if (hasSearch) {
                sql.append(" AND (CAST(pt.application_id AS CHAR) LIKE ? OR pt.payment_reference LIKE ?)");
            }
            
            sql.append(" ORDER BY pt.transaction_date DESC");
            
            // LOG THE QUERY
            System.out.println("=== PaymentApprovalServlet ===");
            System.out.println("Status Filter: " + statusFilter);
            System.out.println("Search Query: " + searchQuery);
            System.out.println("SQL: " + sql.toString());
            
            try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
                if (hasSearch) {
                    String searchPattern = "%" + searchQuery.trim() + "%";
                    stmt.setString(1, searchPattern);
                    stmt.setString(2, searchPattern);
                }
                
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> payment = new HashMap<>();
                        payment.put("transactionId", rs.getInt("transaction_id"));
                        payment.put("applicationId", rs.getInt("application_id"));
                        payment.put("paymentMethod", rs.getString("payment_method") != null ? rs.getString("payment_method") : "N/A");
                        payment.put("processingType", rs.getString("processing_type") != null ? rs.getString("processing_type") : "regular");
                        payment.put("totalAmount", rs.getDouble("total_amount"));
                        payment.put("processingFee", rs.getDouble("processing_fee"));
                        payment.put("serviceFee", rs.getDouble("service_fee"));
                        payment.put("taxAmount", rs.getDouble("tax_amount"));
                        payment.put("status", rs.getString("transaction_status") != null ? rs.getString("transaction_status") : "pending");
                        payment.put("paymentReference", rs.getString("payment_reference") != null ? rs.getString("payment_reference") : "");
                        payment.put("transactionDate", rs.getString("transaction_date") != null ? rs.getString("transaction_date") : "");
                        payment.put("notes", rs.getString("notes") != null ? rs.getString("notes") : "");
                        
                        String firstName = rs.getString("first_name");
                        String lastName = rs.getString("last_name");
                        String fullName = ((firstName != null ? firstName : "") + " " + (lastName != null ? lastName : "")).trim();
                        payment.put("applicantName", fullName.isEmpty() ? "N/A" : fullName);
                        payment.put("nic", rs.getString("nic") != null ? rs.getString("nic") : "N/A");
                        payment.put("email", rs.getString("email") != null ? rs.getString("email") : "N/A");
                        
                        payments.add(payment);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching payments: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("Returned " + payments.size() + " payment records");
        System.out.println("==============================");
        
        return payments;
    }
    
    private boolean approvePayment(int transactionId, String staffUsername, String notes) {
        Connection conn = null;
        try {
            conn = Database.getConnection();
            conn.setAutoCommit(false);
            
            // Get application ID
            int applicationId = -1;
            String sql1 = "SELECT application_id FROM payment_transactions WHERE transaction_id = ? AND transaction_status = 'pending'";
            try (PreparedStatement stmt = conn.prepareStatement(sql1)) {
                stmt.setInt(1, transactionId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        applicationId = rs.getInt("application_id");
                    } else {
                        conn.rollback();
                        return false;
                    }
                }
            }
            
            // Update payment transaction status
            String approvalNotes = "Approved by " + staffUsername + (notes != null && !notes.trim().isEmpty() ? ". " + notes : "");
            String sql2 = "UPDATE payment_transactions SET transaction_status = 'completed', notes = ? WHERE transaction_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql2)) {
                stmt.setString(1, approvalNotes);
                stmt.setInt(2, transactionId);
                int updated = stmt.executeUpdate();
                if (updated == 0) {
                    conn.rollback();
                    return false;
                }
            }
            
            // Update application payment status AND set status to payment_verified
            String sql3 = "UPDATE applications SET payment_status = 'paid', status = 'payment_verified' WHERE application_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql3)) {
                stmt.setInt(1, applicationId);
                stmt.executeUpdate();
            }
            
            conn.commit();
            System.out.println("Payment approved: Transaction ID " + transactionId + " by " + staffUsername);
            return true;
            
        } catch (SQLException e) {
            System.err.println("Error approving payment: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    private boolean rejectPayment(int transactionId, String staffUsername, String notes) {
        try (Connection conn = Database.getConnection()) {
            String rejectionNotes = "Rejected by " + staffUsername + ". " + notes;
            String sql = "UPDATE payment_transactions SET transaction_status = 'failed', notes = ? WHERE transaction_id = ? AND transaction_status = 'pending'";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, rejectionNotes);
                stmt.setInt(2, transactionId);
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    System.out.println("Payment rejected: Transaction ID " + transactionId + " by " + staffUsername);
                    return true;
                }
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error rejecting payment: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}

