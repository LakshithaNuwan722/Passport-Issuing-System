package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

public class TestQuestionServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        
        try {
            Connection conn = Database.getConnection();
            
            // Check if questions table exists
            DatabaseMetaData metaData = conn.getMetaData();
            ResultSet tables = metaData.getTables(null, null, "questions", null);
            
            if (tables.next()) {
                response.getWriter().println("<h2>✓ Questions table exists!</h2>");
                
                // Count questions
                PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM questions");
                ResultSet countRs = countStmt.executeQuery();
                if (countRs.next()) {
                    int count = countRs.getInt(1);
                    response.getWriter().println("<p>Total questions: " + count + "</p>");
                }
                
                // Show recent questions
                PreparedStatement selectStmt = conn.prepareStatement("SELECT * FROM questions ORDER BY created_at DESC LIMIT 5");
                ResultSet selectRs = selectStmt.executeQuery();
                
                response.getWriter().println("<h3>Recent Questions:</h3>");
                response.getWriter().println("<table border='1'>");
                response.getWriter().println("<tr><th>ID</th><th>Question</th><th>Subject</th><th>User</th><th>Answer</th></tr>");
                
                while (selectRs.next()) {
                    response.getWriter().println("<tr>");
                    response.getWriter().println("<td>" + selectRs.getInt("id") + "</td>");
                    response.getWriter().println("<td>" + selectRs.getString("question") + "</td>");
                    response.getWriter().println("<td>" + selectRs.getString("subject") + "</td>");
                    response.getWriter().println("<td>" + selectRs.getString("user_name") + "</td>");
                    response.getWriter().println("<td>" + (selectRs.getString("answer") != null ? selectRs.getString("answer") : "No answer") + "</td>");
                    response.getWriter().println("</tr>");
                }
                response.getWriter().println("</table>");
                
            } else {
                response.getWriter().println("<h2>⚠ Questions table does not exist!</h2>");
                response.getWriter().println("<p>Please run the manual_setup_questions.sql script first.</p>");
            }
            
            conn.close();
            
        } catch (Exception e) {
            response.getWriter().println("<h2>✗ Database Error:</h2>");
            response.getWriter().println("<p>" + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json; charset=UTF-8");
        
        try {
            String question = request.getParameter("question");
            String subject = request.getParameter("subject");
            String userName = request.getParameter("user_name");
            String email = request.getParameter("email");
            
            if (question == null || question.trim().isEmpty()) {
                response.getWriter().println("{\"success\": false, \"error\": \"Question is required\"}");
                return;
            }
            
            Connection conn = Database.getConnection();
            String sql = "INSERT INTO questions (question, subject, category, user_name, user_email, created_at) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, question.trim());
                stmt.setString(2, subject != null ? subject.trim() : "General Inquiry");
                stmt.setString(3, "general");
                stmt.setString(4, userName != null ? userName.trim() : "Anonymous");
                stmt.setString(5, email);
                
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    response.getWriter().println("{\"success\": true, \"message\": \"Question submitted successfully\"}");
                } else {
                    response.getWriter().println("{\"success\": false, \"error\": \"Failed to submit question\"}");
                }
            }
            
            conn.close();
            
        } catch (Exception e) {
            response.getWriter().println("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }
}
