package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        String nicNumber = null;
        String password = null;

        String contentType = request.getContentType();
        if (contentType == null || contentType.startsWith("application/x-www-form-urlencoded") || contentType.startsWith("multipart/form-data")) {
            // Handle standard form submission
            nicNumber = request.getParameter("nicNumber");
            password = request.getParameter("password");
        } else if (contentType.startsWith("application/json")) {
            // Handle JSON body
            try {
                @SuppressWarnings("unchecked")
                Map<String, String> loginData = objectMapper.readValue(request.getInputStream(), Map.class);
                nicNumber = loginData.get("nicNumber");
                password = loginData.get("password");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Invalid JSON format");
                objectMapper.writeValue(response.getWriter(), error);
                return;
            }
        } else {
            // Unsupported content type
            response.setStatus(HttpServletResponse.SC_UNSUPPORTED_MEDIA_TYPE);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Unsupported content type: " + contentType);
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        if (nicNumber == null || password == null || nicNumber.trim().isEmpty() || password.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "NIC and password are required");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM login_credentials WHERE nic_number = ? AND password = ?")) {

            stmt.setString(1, nicNumber);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Login successful - create session and set attributes
                HttpSession session = request.getSession(true);
                session.setAttribute("nic_number", nicNumber);
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("userLoggedIn", true);
                
                // Set session timeout (30 minutes)
                session.setMaxInactiveInterval(30 * 60);
                
                // Return user data
                Map<String, Object> userData = new HashMap<>();
                userData.put("success", true);
                userData.put("nicNumber", rs.getString("nic_number"));
                userData.put("email", rs.getString("email"));

                // Fetch most recent application data for auto-fill
                try (PreparedStatement appStmt = conn.prepareStatement(
                        "SELECT first_name, last_name, date_of_birth, current_address, city, postal_code " +
                        "FROM applications WHERE nic_number = ? ORDER BY application_id DESC LIMIT 1")) {
                    appStmt.setString(1, nicNumber);
                    ResultSet appRs = appStmt.executeQuery();
                    if (appRs.next()) {
                        userData.put("firstName", appRs.getString("first_name"));
                        userData.put("lastName", appRs.getString("last_name"));
                        userData.put("dateOfBirth", appRs.getString("date_of_birth"));
                        userData.put("address", appRs.getString("current_address"));
                        userData.put("city", appRs.getString("city"));
                        userData.put("postalCode", appRs.getString("postal_code"));
                    }
                    appRs.close();
                }

                objectMapper.writeValue(response.getWriter(), userData);
            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Invalid NIC or password");
                objectMapper.writeValue(response.getWriter(), error);
            }

        } catch (java.sql.SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, Object> error = new HashMap<>();
            
            // Provide user-friendly error message
            String errorMsg = e.getMessage();
            if (errorMsg != null && errorMsg.contains("Communications link failure")) {
                error.put("error", "Database connection failed. Please check if MySQL server is running.");
                error.put("details", "The application cannot connect to the database server. " +
                    "Please ensure MySQL service is started and accessible.");
                error.put("troubleshooting", "Visit /db-diagnostic.jsp for detailed diagnostics");
            } else {
                error.put("error", "Database error: " + errorMsg);
            }
            error.put("type", "SQLException");
            
            System.err.println("[LoginServlet] Database error: " + e.getMessage());
            e.printStackTrace();
            
            objectMapper.writeValue(response.getWriter(), error);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, Object> error = new HashMap<>();
            error.put("error", "Internal server error: " + e.getMessage());
            error.put("type", e.getClass().getSimpleName());
            
            System.err.println("[LoginServlet] Unexpected error: " + e.getMessage());
            e.printStackTrace();
            
            objectMapper.writeValue(response.getWriter(), error);
        }
    }
}