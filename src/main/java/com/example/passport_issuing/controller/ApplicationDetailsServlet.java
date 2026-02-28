package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/application-details")
public class ApplicationDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String applicationIdParam = request.getParameter("id");

        if (applicationIdParam == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Application ID is required\"}");
            return;
        }

        try {
            int applicationId = Integer.parseInt(applicationIdParam);
            Map<String, Object> application = getApplicationDetails(applicationId);

            if (application != null) {
                response.getWriter().write(new com.fasterxml.jackson.databind.ObjectMapper().writeValueAsString(application));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Application not found\"}");
            }

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid application ID format\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        }
    }

    private Map<String, Object> getApplicationDetails(int applicationId) throws SQLException {
        Map<String, Object> application = null;

        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT * FROM applications WHERE application_id = ?";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, applicationId);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        application = new HashMap<>();
                        application.put("applicationId", rs.getInt("application_id"));
                        application.put("nicNumber", rs.getString("nic_number"));
                        application.put("firstName", rs.getString("first_name"));
                        application.put("lastName", rs.getString("last_name"));
                        application.put("dateOfBirth", rs.getString("date_of_birth"));
                        application.put("email", rs.getString("email"));
                        application.put("currentAddress", rs.getString("current_address"));
                        application.put("city", rs.getString("city"));
                        application.put("postalCode", rs.getString("postal_code"));
                        application.put("processingType", rs.getString("processing_type"));
                        application.put("biometricDate", rs.getString("biometric_date"));
                        application.put("status", rs.getString("status"));
                    }
                }
            }
        }

        return application;
    }
}