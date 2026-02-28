package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/PublicFaqServlet")
public class PublicFaqServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            getActiveFaqs(response, objectMapper);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Server error: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    private void getActiveFaqs(HttpServletResponse response, ObjectMapper objectMapper) throws SQLException, IOException {
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT faq_id, question, answer, category, created_at " +
                        "FROM helpdesk_faq WHERE is_active = TRUE ORDER BY category, created_at DESC";
            
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                
                List<Map<String, Object>> faqs = new ArrayList<>();
                
                while (rs.next()) {
                    Map<String, Object> faq = new HashMap<>();
                    faq.put("faq_id", rs.getInt("faq_id"));
                    faq.put("question", rs.getString("question"));
                    faq.put("answer", rs.getString("answer"));
                    faq.put("category", rs.getString("category"));
                    faq.put("created_at", rs.getTimestamp("created_at").toString());
                    faqs.add(faq);
                }
                
                Map<String, Object> result = new HashMap<>();
                result.put("success", true);
                result.put("faqs", faqs);
                objectMapper.writeValue(response.getWriter(), result);
            }
        }
    }
}
