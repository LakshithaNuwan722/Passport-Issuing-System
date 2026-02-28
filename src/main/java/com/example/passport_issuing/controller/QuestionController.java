package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class QuestionController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // Get all questions (both answered and unanswered)
            getQuestions(response, objectMapper);
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

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper objectMapper = new ObjectMapper();

        System.out.println("QuestionController doPost called");
        System.out.println("Request URL: " + request.getRequestURL());
        System.out.println("Request method: " + request.getMethod());

        try {
            // Parse JSON request
            Map<String, Object> requestData = objectMapper.readValue(
                    request.getInputStream(),
                    new TypeReference<Map<String, Object>>() {}
            );

            System.out.println("Request data received: " + requestData);

            String action = (String) requestData.get("action");
            System.out.println("Action: " + action);

            switch (action) {
                case "submit":
                    submitQuestion(requestData, response, objectMapper);
                    break;
                case "reply":
                    replyToQuestion(requestData, request, response, objectMapper);
                    break;
                case "getUnanswered":
                    getUnansweredQuestions(request, response, objectMapper);
                    break;
                default:
                    System.out.println("Invalid action: " + action);
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    Map<String, String> error = new HashMap<>();
                    error.put("error", "Invalid action: " + action);
                    objectMapper.writeValue(response.getWriter(), error);
            }
        } catch (Exception e) {
            System.err.println("Error in QuestionController doPost: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Server error: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    private void getQuestions(HttpServletResponse response, ObjectMapper objectMapper) throws SQLException, IOException {
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT id, question, subject, answer, category, user_name, user_email, created_at, updated_at " +
                    "FROM questions WHERE answer IS NOT NULL ORDER BY created_at DESC";

            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                List<Map<String, Object>> questions = new ArrayList<>();

                while (rs.next()) {
                    Map<String, Object> question = new HashMap<>();
                    question.put("id", rs.getInt("id"));
                    question.put("question", rs.getString("question"));
                    question.put("subject", rs.getString("subject"));
                    question.put("answer", rs.getString("answer"));
                    question.put("category", rs.getString("category"));
                    question.put("user_name", rs.getString("user_name"));
                    question.put("user_email", rs.getString("user_email"));
                    question.put("created_at", rs.getTimestamp("created_at"));
                    question.put("updated_at", rs.getTimestamp("updated_at"));
                    questions.add(question);
                }

                Map<String, Object> result = new HashMap<>();
                result.put("success", true);
                result.put("questions", questions);
                objectMapper.writeValue(response.getWriter(), result);
            }
        }
    }

    private void submitQuestion(Map<String, Object> requestData,
                                HttpServletResponse response, ObjectMapper objectMapper) throws SQLException, IOException {

        System.out.println("submitQuestion method called");

        String question = (String) requestData.get("question");
        String subject = (String) requestData.get("subject");
        String category = (String) requestData.get("category");
        String userName = (String) requestData.get("user_name");
        String userEmail = (String) requestData.get("email");

        System.out.println("Extracted parameters:");
        System.out.println("  question: " + question);
        System.out.println("  subject: " + subject);
        System.out.println("  category: " + category);
        System.out.println("  userName: " + userName);
        System.out.println("  userEmail: " + userEmail);

        if (question == null || question.trim().isEmpty()) {
            System.out.println("Validation failed: question is null or empty");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Question is required");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        if (subject == null || subject.trim().isEmpty()) {
            System.out.println("Validation failed: subject is null or empty");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Subject is required");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        if (userName == null || userName.trim().isEmpty()) {
            System.out.println("Validation failed: userName is null or empty");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Name is required");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        System.out.println("All validations passed, attempting database insert");

        try (Connection conn = Database.getConnection()) {
            System.out.println("Database connection established");

            String sql = "INSERT INTO questions (question, subject, category, user_name, user_email, created_at) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, question.trim());
                stmt.setString(2, subject.trim());
                stmt.setString(3, category != null ? category : "general");
                stmt.setString(4, userName.trim());
                stmt.setString(5, userEmail);

                System.out.println("Executing SQL: " + sql);
                System.out.println("Parameters: question=" + question.trim() + ", subject=" + subject.trim() + ", category=" + category + ", userName=" + userName.trim() + ", userEmail=" + userEmail);

                int rowsAffected = stmt.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);

                Map<String, Object> result = new HashMap<>();
                if (rowsAffected > 0) {
                    result.put("success", true);
                    result.put("message", "Question submitted successfully");
                    System.out.println("Question submitted successfully");
                } else {
                    result.put("success", false);
                    result.put("message", "Failed to submit question");
                    System.out.println("Failed to submit question - no rows affected");
                }
                objectMapper.writeValue(response.getWriter(), result);
            }
        } catch (Exception e) {
            System.err.println("Error in submitQuestion: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Server error: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    private void replyToQuestion(Map<String, Object> requestData,
                                 HttpServletRequest request, HttpServletResponse response, ObjectMapper objectMapper) throws SQLException, IOException {

        // Check if user is staff
        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("staffLoggedIn"))) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Unauthorized access - Staff login required");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        Integer questionId = (Integer) requestData.get("questionId");
        String answer = (String) requestData.get("answer");

        if (questionId == null || answer == null || answer.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Question ID and answer are required");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }

        try (Connection conn = Database.getConnection()) {
            String sql = "UPDATE questions SET answer = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, answer.trim());
                stmt.setInt(2, questionId);

                int rowsAffected = stmt.executeUpdate();

                Map<String, Object> result = new HashMap<>();
                if (rowsAffected > 0) {
                    result.put("success", true);
                    result.put("message", "Reply submitted successfully");
                } else {
                    result.put("success", false);
                    result.put("message", "Question not found");
                }
                objectMapper.writeValue(response.getWriter(), result);
            }
        }
    }

    private void getUnansweredQuestions(HttpServletRequest request, HttpServletResponse response, ObjectMapper objectMapper) throws SQLException, IOException {
        // DEVELOPMENT MODE: Disable staff login check (for debugging/viewing unanswered questions test)
        // To revert: Restore the session staffLoggedIn check below for production.
        /*
        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("staffLoggedIn"))) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Only staff can view unanswered questions");
            objectMapper.writeValue(response.getWriter(), error);
            return;
        }
        */

        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT id, question, subject, category, user_name, user_email, created_at " +
                    "FROM questions WHERE answer IS NULL ORDER BY created_at DESC";

            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                List<Map<String, Object>> questions = new ArrayList<>();

                while (rs.next()) {
                    Map<String, Object> question = new HashMap<>();
                    question.put("id", rs.getInt("id"));
                    question.put("question", rs.getString("question"));
                    question.put("subject", rs.getString("subject"));
                    question.put("category", rs.getString("category"));
                    question.put("user_name", rs.getString("user_name"));
                    question.put("user_email", rs.getString("user_email"));
                    question.put("created_at", rs.getTimestamp("created_at"));
                    questions.add(question);
                }

                Map<String, Object> result = new HashMap<>();
                result.put("success", true);
                result.put("questions", questions);
                objectMapper.writeValue(response.getWriter(), result);
            }
        }
    }
}
