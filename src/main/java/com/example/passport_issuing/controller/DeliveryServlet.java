package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/delivery")
@MultipartConfig
public class DeliveryServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        
        if ("mark_delivered".equals(action)) {
            handleMarkDelivered(request, response);
            return;
        }
        
        handleCreateDelivery(request, response);
    }
    
    private void handleMarkDelivered(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();

        try {
            String applicationIdStr = request.getParameter("applicationId");
            
            if (applicationIdStr == null || applicationIdStr.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                mapper.writeValue(response.getWriter(), Map.of("error", "Application ID is required"));
                return;
            }
            
            int applicationId = Integer.parseInt(applicationIdStr.trim());
            
            // Update status to 'delivered'
            String updateStatusSql = "UPDATE applications_printed SET status = 'delivered' WHERE application_id = ?";
            
            try (Connection conn = Database.getConnection(); 
                 PreparedStatement ps = conn.prepareStatement(updateStatusSql)) {
                
                ps.setInt(1, applicationId);
                int rowsAffected = ps.executeUpdate();
                
                if (rowsAffected > 0) {
                    Map<String, Object> result = new HashMap<>();
                    result.put("success", true);
                    result.put("message", "Application marked as delivered successfully");
                    mapper.writeValue(response.getWriter(), result);
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    mapper.writeValue(response.getWriter(), Map.of("error", "Failed to update delivery status"));
                }
            }

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            mapper.writeValue(response.getWriter(), Map.of("error", "Invalid application ID format"));
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            mapper.writeValue(response.getWriter(), Map.of("error", "Database error: " + e.getMessage()));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            mapper.writeValue(response.getWriter(), Map.of("error", "Unexpected error: " + e.getMessage()));
        }
    }
    // respond json file
    private void handleCreateDelivery(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();

        try {
            // Debug: Log what we received
            System.out.println("=== DELIVERY SERVLET DEBUG ===");
            System.out.println("Request method: " + request.getMethod());
            System.out.println("Content-Type: " + request.getContentType());
            System.out.println("All parameters:");
            java.util.Enumeration<String> paramNames = request.getParameterNames();
            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
                System.out.println("  " + paramName + " = " + paramValue);
            }
            
            // Get form parameters
            String applicationIdStr = request.getParameter("applicationId");
            System.out.println("Received applicationId parameter: '" + applicationIdStr + "'");
            System.out.println("Parameter type: " + (applicationIdStr != null ? applicationIdStr.getClass().getSimpleName() : "null"));
            
            // Validate application ID parameter
            if (applicationIdStr == null || applicationIdStr.trim().isEmpty()) {
                System.out.println("ERROR: Application ID is null or empty");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                mapper.writeValue(response.getWriter(), Map.of("error", "Application ID is required"));
                return;
            }
            
            int applicationId;
            try {
                applicationId = Integer.parseInt(applicationIdStr.trim());
                System.out.println("Successfully parsed applicationId: " + applicationId);
            } catch (NumberFormatException e) {
                System.out.println("ERROR: Cannot parse applicationId '" + applicationIdStr + "' as integer");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                mapper.writeValue(response.getWriter(), Map.of("error", "Invalid application ID format: " + applicationIdStr));
                return;
            }
            
            String trackingNumber = request.getParameter("trackingNumber");
            String deliveryDate = request.getParameter("deliveryDate");
            String recipientName = request.getParameter("recipientName");
            String recipientIdVerification = request.getParameter("recipientIdVerification");
            String notes = request.getParameter("notes");

            // Validate required fields
            if (trackingNumber == null || trackingNumber.trim().isEmpty() ||
                deliveryDate == null || deliveryDate.trim().isEmpty() ||
                recipientName == null || recipientName.trim().isEmpty() ||
                recipientIdVerification == null || recipientIdVerification.trim().isEmpty()) {
                
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                mapper.writeValue(response.getWriter(), Map.of("error", "All required fields must be filled"));
                return;
            }

            // Insert delivery record
            String sql = "INSERT INTO deliveries (application_id, tracking_number, delivery_date, recipient_name, recipient_id_verification, notes) VALUES (?, ?, ?, ?, ?, ?)";
            
            try (Connection conn = Database.getConnection(); 
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                
                ps.setInt(1, applicationId);
                ps.setString(2, trackingNumber.trim());
                ps.setString(3, deliveryDate);
                ps.setString(4, recipientName.trim());
                ps.setString(5, recipientIdVerification.trim());
                ps.setString(6, notes != null ? notes.trim() : null);
                
                int rowsAffected = ps.executeUpdate();
                
                if (rowsAffected > 0) {
                    // Update the status in applications_printed table to 'in_transit'
                    String updateStatusSql = "UPDATE applications_printed SET status = 'in_transit' WHERE application_id = ?";
                    try (PreparedStatement updatePs = conn.prepareStatement(updateStatusSql)) {
                        updatePs.setInt(1, applicationId);
                        int statusRowsAffected = updatePs.executeUpdate();
                        System.out.println("Updated " + statusRowsAffected + " application status to 'in_transit'");
                    }
                    
                    Map<String, Object> result = new HashMap<>();
                    result.put("success", true);
                    result.put("message", "Delivery record created successfully");
                    result.put("deliveryId", getLastInsertId(conn));
                    mapper.writeValue(response.getWriter(), result);
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    mapper.writeValue(response.getWriter(), Map.of("error", "Failed to create delivery record"));
                }
            }

        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            mapper.writeValue(response.getWriter(), Map.of("error", "Database error: " + e.getMessage()));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            mapper.writeValue(response.getWriter(), Map.of("error", "Unexpected error: " + e.getMessage()));
        }
    }

    private int getLastInsertId(Connection conn) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement("SELECT LAST_INSERT_ID()")) {
            var rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
