package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/HelpdeskServlet")
public class HelpdeskServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check staff authentication
        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("staffLoggedIn"))) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Unauthorized access\"}");
            return;
        }

        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            if ("getFaqs".equals(action)) {
                getFaqs(response, objectMapper);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Invalid action");
                objectMapper.writeValue(response.getWriter(), error);
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Server error: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check staff authentication
        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("staffLoggedIn"))) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Unauthorized access\"}");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // Parse JSON request
            Map<String, Object> requestData = objectMapper.readValue(
                    request.getInputStream(),
                    new TypeReference<Map<String, Object>>() {}
            );

            String action = (String) requestData.get("action");
            String staffUsername = (String) session.getAttribute("staffUsername");

            switch (action) {
                case "addFaq":
                    addFaq(requestData, staffUsername, response, objectMapper);
                    break;
                case "updateFaq":
                    updateFaq(requestData, staffUsername, response, objectMapper);
                    break;
                case "toggleStatus":
                    toggleFaqStatus(requestData, response, objectMapper);
                    break;
                case "deleteFaq":
                    deleteFaq(requestData, response, objectMapper);
                    break;
                default:
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    Map<String, String> error = new HashMap<>();
                    error.put("error", "Invalid action");
                    objectMapper.writeValue(response.getWriter(), error);
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Server error: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    private void getFaqs(HttpServletResponse response, ObjectMapper objectMapper) throws SQLException, IOException {
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT faq_id, question, answer, category, is_active, created_by, created_at, updated_at " +
                        "FROM helpdesk_faq ORDER BY created_at DESC";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                
                List<Map<String, Object>> faqs = new ArrayList<>();
                
                while (rs.next()) {
                    Map<String, Object> faq = new HashMap<>();
                    faq.put("faq_id", rs.getInt("faq_id"));
                    faq.put("question", rs.getString("question"));
                    faq.put("answer", rs.getString("answer"));
                    faq.put("category", rs.getString("category"));
                    faq.put("is_active", rs.getBoolean("is_active"));
                    faq.put("created_by", rs.getString("created_by"));
                    faq.put("created_at", rs.getTimestamp("created_at").toString());
                    faq.put("updated_at", rs.getTimestamp("updated_at").toString());
                    faqs.add(faq);
                }
                
                Map<String, Object> result = new HashMap<>();
                result.put("success", true);
                result.put("faqs", faqs);
                objectMapper.writeValue(response.getWriter(), result);
            }
        }
    }

    private void addFaq(Map<String, Object> requestData, String staffUsername, 
                       HttpServletResponse response, ObjectMapper objectMapper) throws SQLException, IOException {
        
        String question = (String) requestData.get("question");
        String answer = (String) requestData.get("answer");
        String category = (String) requestData.get("category");
        Boolean isActive = (Boolean) requestData.get("is_active");
        
        if (question == null || answer == null || category == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Missing required fields");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        try (Connection conn = Database.getConnection()) {
            String sql = "INSERT INTO helpdesk_faq (question, answer, category, is_active, created_by) VALUES (?, ?, ?, ?, ?)";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, question);
                stmt.setString(2, answer);
                stmt.setString(3, category);
                stmt.setBoolean(4, isActive != null ? isActive : true);
                stmt.setString(5, staffUsername);
                
                int rowsAffected = stmt.executeUpdate();
                
                Map<String, Object> result = new HashMap<>();
                if (rowsAffected > 0) {
                    result.put("success", true);
                    result.put("message", "FAQ added successfully");
                } else {
                    result.put("success", false);
                    result.put("message", "Failed to add FAQ");
                }
                objectMapper.writeValue(response.getWriter(), result);
            }
        }
    }

    private void updateFaq(Map<String, Object> requestData, String staffUsername,
                          HttpServletResponse response, ObjectMapper objectMapper) throws SQLException, IOException {
        
        Integer faqId = (Integer) requestData.get("faq_id");
        String question = (String) requestData.get("question");
        String answer = (String) requestData.get("answer");
        String category = (String) requestData.get("category");
        Boolean isActive = (Boolean) requestData.get("is_active");
        
        if (faqId == null || question == null || answer == null || category == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Missing required fields");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        try (Connection conn = Database.getConnection()) {
            String sql = "UPDATE helpdesk_faq SET question = ?, answer = ?, category = ?, is_active = ?, updated_at = CURRENT_TIMESTAMP " +
                        "WHERE faq_id = ? AND created_by = ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, question);
                stmt.setString(2, answer);
                stmt.setString(3, category);
                stmt.setBoolean(4, isActive != null ? isActive : true);
                stmt.setInt(5, faqId);
                stmt.setString(6, staffUsername);
                
                int rowsAffected = stmt.executeUpdate();
                
                Map<String, Object> result = new HashMap<>();
                if (rowsAffected > 0) {
                    result.put("success", true);
                    result.put("message", "FAQ updated successfully");
                } else {
                    result.put("success", false);
                    result.put("message", "FAQ not found or you don't have permission to update it");
                }
                objectMapper.writeValue(response.getWriter(), result);
            }
        }
    }

    private void toggleFaqStatus(Map<String, Object> requestData,
                                 HttpServletResponse response, ObjectMapper objectMapper) throws SQLException, IOException {
        
        Integer faqId = (Integer) requestData.get("faq_id");
        Boolean isActive = (Boolean) requestData.get("is_active");
        
        if (faqId == null || isActive == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Missing required fields");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        try (Connection conn = Database.getConnection()) {
            String sql = "UPDATE helpdesk_faq SET is_active = ?, updated_at = CURRENT_TIMESTAMP WHERE faq_id = ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setBoolean(1, isActive);
                stmt.setInt(2, faqId);
                
                int rowsAffected = stmt.executeUpdate();
                
                Map<String, Object> result = new HashMap<>();
                if (rowsAffected > 0) {
                    result.put("success", true);
                    result.put("message", "FAQ status updated successfully");
                } else {
                    result.put("success", false);
                    result.put("message", "FAQ not found");
                }
                objectMapper.writeValue(response.getWriter(), result);
            }
        }
    }

    private void deleteFaq(Map<String, Object> requestData,
                           HttpServletResponse response, ObjectMapper objectMapper) throws SQLException, IOException {
        
        Integer faqId = (Integer) requestData.get("faq_id");
        
        if (faqId == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Missing FAQ ID");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        try (Connection conn = Database.getConnection()) {
            String sql = "DELETE FROM helpdesk_faq WHERE faq_id = ?";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, faqId);
                
                int rowsAffected = stmt.executeUpdate();
                
                Map<String, Object> result = new HashMap<>();
                if (rowsAffected > 0) {
                    result.put("success", true);
                    result.put("message", "FAQ deleted successfully");
                } else {
                    result.put("success", false);
                    result.put("message", "FAQ not found");
                }
                objectMapper.writeValue(response.getWriter(), result);
            }
        }
    }
}
