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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/load-all-data")
public class DataLoaderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();

        try {
            List<Map<String, Object>> applications = loadAllApplications();
            result.put("success", true);
            result.put("count", applications.size());
            result.put("applications", applications);

        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        response.getWriter().write(new com.fasterxml.jackson.databind.ObjectMapper().writeValueAsString(result));
    }

    private List<Map<String, Object>> loadAllApplications() throws SQLException {
        List<Map<String, Object>> applications = new ArrayList<>();

        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT * FROM applications ORDER BY application_id";

            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> app = new HashMap<>();
                    app.put("applicationId", rs.getInt("application_id"));
                    app.put("nicNumber", rs.getString("nic_number"));
                    app.put("firstName", rs.getString("first_name"));
                    app.put("lastName", rs.getString("last_name"));
                    app.put("dateOfBirth", rs.getString("date_of_birth"));
                    app.put("email", rs.getString("email"));
                    app.put("currentAddress", rs.getString("current_address"));
                    app.put("city", rs.getString("city"));
                    app.put("postalCode", rs.getString("postal_code"));
                    app.put("processingType", rs.getString("processing_type"));
                    app.put("biometricDate", rs.getString("biometric_date"));
                    app.put("status", rs.getString("status"));

                    applications.add(app);
                }
            }
        }

        return applications;
    }
}