package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class ApplicationPrintedServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();
        String applicationId = request.getParameter("applicationId");
        String nicNumber = request.getParameter("nicNumber");

        if (applicationId == null || nicNumber == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "applicationId and nicNumber are required");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        try {
            // Insert print record into applications_printed table
            boolean success = insertPrintedRecord(Integer.parseInt(applicationId), nicNumber);

            if (success) {
                Map<String, String> result = new HashMap<>();
                result.put("success", "true");
                result.put("message", "Passport printed successfully!");
                objectMapper.writeValue(response.getWriter(), result);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Failed to record print");
                objectMapper.writeValue(response.getWriter(), error);
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Server error: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    private boolean insertPrintedRecord(int applicationId, String nicNumber) throws SQLException {
        String sql = "INSERT INTO applications_printed (application_id, nic_number, status, printed_by) " +
                   "VALUES (?, ?, 'printed', ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, applicationId);
            stmt.setString(2, nicNumber);
            stmt.setString(3, "staff_print"); // Default staff member

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        }
    }
}
