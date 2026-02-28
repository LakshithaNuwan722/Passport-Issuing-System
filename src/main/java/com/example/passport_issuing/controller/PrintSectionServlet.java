package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PrintSectionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            List<Map<String, Object>> approvedApplications = new ArrayList<>();

            try (Connection conn = Database.getConnection()) {
                // Query to get approved applications that haven't been printed yet
                String sql = "SELECT ar.application_id, ar.final_approval_status, ar.final_reviewed_at, " +
                           "a.first_name, a.last_name, a.nic_number, a.email, " +
                           "a.date_of_birth, a.current_address, a.city, a.postal_code, " +
                           "a.processing_type, a.payment_date, a.status " +
                           "FROM application_reviews ar " +
                           "JOIN applications a ON ar.application_id = a.application_id " +
                           "WHERE ar.final_approval_status = 'APPROVED' " +
                           "AND NOT EXISTS (SELECT 1 FROM applications_printed ap WHERE ap.application_id = ar.application_id) " +
                           "ORDER BY ar.final_reviewed_at DESC";

                try (PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {

                    while (rs.next()) {
                        Map<String, Object> application = new HashMap<>();
                        
                        // Application ID and review info
                        application.put("applicationId", rs.getInt("application_id"));
                        application.put("finalApprovalStatus", rs.getString("final_approval_status"));
                        application.put("finalReviewedAt", rs.getTimestamp("final_reviewed_at"));
                        
                        // Personal information
                        application.put("firstName", rs.getString("first_name"));
                        application.put("lastName", rs.getString("last_name"));
                        application.put("nicNumber", rs.getString("nic_number"));
                        application.put("email", rs.getString("email"));
                        application.put("dateOfBirth", rs.getDate("date_of_birth"));
                        
                        // Address information
                        application.put("currentAddress", rs.getString("current_address"));
                        application.put("city", rs.getString("city"));
                        application.put("postalCode", rs.getString("postal_code"));
                        
                        // Application details
                        application.put("processingType", rs.getString("processing_type"));
                        application.put("paymentDate", rs.getTimestamp("payment_date"));
                        application.put("status", rs.getString("status"));
                        
                        approvedApplications.add(application);
                    }
                }
            }

            // Return the list of approved applications as JSON
            objectMapper.writeValue(response.getWriter(), approvedApplications);

        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Database error: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Server error: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }
}
