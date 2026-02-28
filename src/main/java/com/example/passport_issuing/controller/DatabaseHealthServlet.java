package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/health")
public class DatabaseHealthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> health = new HashMap<>();

        try {
            // Test database connection
            try (Connection conn = Database.getConnection()) {
                health.put("databaseConnection", "SUCCESS");

                // Get database info
                DatabaseMetaData metaData = conn.getMetaData();
                health.put("databaseProduct", metaData.getDatabaseProductName());
                health.put("databaseVersion", metaData.getDatabaseProductVersion());
                health.put("driverName", metaData.getDriverName());
                health.put("driverVersion", metaData.getDriverVersion());

                // Check if tables exist
                List<String> tables = new ArrayList<>();
                try (ResultSet rs = metaData.getTables(null, null, "%", new String[]{"TABLE"})) {
                    while (rs.next()) {
                        tables.add(rs.getString("TABLE_NAME"));
                    }
                }
                health.put("tables", tables);

                // Check applications table specifically
                if (tables.contains("applications")) {
                    health.put("applicationsTableExists", true);

                    // Count applications
                    try (PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM applications")) {
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                health.put("applicationCount", rs.getInt(1));
                            }
                        }
                    }

                    // Get sample applications
                    try (PreparedStatement stmt = conn.prepareStatement("SELECT * FROM applications LIMIT 5")) {
                        try (ResultSet rs = stmt.executeQuery()) {
                            List<Map<String, Object>> sampleApps = new ArrayList<>();
                            while (rs.next()) {
                                Map<String, Object> app = new HashMap<>();
                                app.put("applicationId", rs.getInt("application_id"));
                                app.put("nicNumber", rs.getString("nic_number"));
                                app.put("firstName", rs.getString("first_name"));
                                app.put("lastName", rs.getString("last_name"));
                                app.put("email", rs.getString("email"));
                                app.put("status", rs.getString("status"));
                                sampleApps.add(app);
                            }
                            health.put("sampleApplications", sampleApps);
                        }
                    }
                } else {
                    health.put("applicationsTableExists", false);
                }

            } catch (SQLException e) {
                health.put("databaseConnection", "FAILED");
                health.put("error", e.getMessage());
                health.put("sqlState", e.getSQLState());
                health.put("errorCode", e.getErrorCode());
            }

        } catch (Exception e) {
            health.put("databaseConnection", "FAILED");
            health.put("error", e.getMessage());
            health.put("exceptionType", e.getClass().getSimpleName());
        }

        response.getWriter().write(new com.fasterxml.jackson.databind.ObjectMapper().writeValueAsString(health));
    }
}