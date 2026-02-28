package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.Map;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, String> userData;

        try {
            userData = objectMapper.readValue(request.getInputStream(), Map.class);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Invalid JSON format");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        String nicNumber = userData.get("nicNumber");
        String email = userData.get("email");
        String password = userData.get("password");

        if (nicNumber == null || email == null || password == null || nicNumber.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "All fields are required");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        try (Connection conn = Database.getConnection();
              PreparedStatement stmt = conn.prepareStatement("INSERT INTO login_credentials (nic_number, email, password) VALUES (?, ?, ?)")) {

            stmt.setString(1, nicNumber);
            stmt.setString(2, email);
            stmt.setString(3, password);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                Map<String, String> success = new HashMap<>();
                success.put("message", "Registration successful");
                new ObjectMapper().writeValue(response.getWriter(), success);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Registration failed");
                new ObjectMapper().writeValue(response.getWriter(), error);
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Database error: " + e.getMessage());
            new ObjectMapper().writeValue(response.getWriter(), error);
        }
    }
}