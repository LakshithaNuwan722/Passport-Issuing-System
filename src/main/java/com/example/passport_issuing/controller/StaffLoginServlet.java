package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
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

public class StaffLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        // Handle both JSON and form data; only username and password are required
        String username = null;
        String password = null;

        // Check if it's a form submission or JSON
        String contentType = request.getContentType();
        if (contentType != null) contentType = contentType.toLowerCase();

        if (contentType == null || contentType.startsWith("application/x-www-form-urlencoded")) {
            // Form data
            username = request.getParameter("username");
            password = request.getParameter("password");
        } else if (contentType.startsWith("application/json")) {
            // JSON data
            try {
                Map<String, String> loginData = objectMapper.readValue(
                        request.getInputStream(),
                        new TypeReference<Map<String, String>>() {}
                );
                username = loginData.get("username");
                password = loginData.get("password");
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Invalid JSON format");
                objectMapper.writeValue(response.getWriter(), error);
                return;
            }
        }

        // Validate input - only username and password are required
        if (username == null || password == null ||
            username.trim().isEmpty() || password.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Username and password are required");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        try (Connection conn = Database.getConnection()) {
            // Query staff credentials - only check username and password
            String sql = "SELECT username, section FROM staff_credentials WHERE username = ? AND password = ? AND is_active = TRUE";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Always use the section from database for session and redirects
                    String finalSection = rs.getString("section");

                    // Login successful
                    HttpSession session = request.getSession();
                    session.setAttribute("staffLoggedIn", true);
                    session.setAttribute("staffUsername", rs.getString("username"));
                    session.setAttribute("staffSection", finalSection);
                    String fullName = rs.getString("username");
                    session.setAttribute("staffFullName", fullName);
                    session.setAttribute("staffEmail", null);

                    // Set session timeout (e.g., 30 minutes)
                    session.setMaxInactiveInterval(30 * 60);

                    Map<String, Object> successData = new HashMap<>();
                    successData.put("success", true);
                    successData.put("message", "Login successful");
                    successData.put("section", finalSection);
                    successData.put("fullName", fullName);
                    successData.put("redirectUrl", getRedirectUrl(finalSection));

                    objectMapper.writeValue(response.getWriter(), successData);

                } else {
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    Map<String, String> error = new HashMap<>();
                    error.put("error", "Invalid username or password");
                    objectMapper.writeValue(response.getWriter(), error);
                }

                rs.close();
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Database error: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if staff is logged in
        HttpSession session = request.getSession(false);
        boolean loggedIn = session != null && Boolean.TRUE.equals(session.getAttribute("staffLoggedIn"));

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> data = new HashMap<>();

        if (loggedIn) {
            data.put("loggedIn", true);
            data.put("username", session.getAttribute("staffUsername"));
            data.put("section", session.getAttribute("staffSection"));
            data.put("fullName", session.getAttribute("staffFullName"));
        } else {
            data.put("loggedIn", false);
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }

        objectMapper.writeValue(response.getWriter(), data);
    }

    private String getRedirectUrl(String section) {
        switch (section) {
            case "application":
                return "application_review.jsp";
            case "payment":
                return "payment-approval.jsp";
            case "print":
                return "view.jsp"; // placeholder until a print dashboard exists
            case "logistic":
                return "view.jsp"; // placeholder until a logistic dashboard exists
            case "helpdesk":
                return "staff-helpdesk.jsp";
            default:
                return "applications.jsp";
        }
    }
}