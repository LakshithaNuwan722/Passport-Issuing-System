package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
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

@WebServlet("/api/in-transit")
public class InTransitServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();

        List<Map<String, Object>> rows = new ArrayList<>();
        String sql = "SELECT ap.application_id, ap.nic_number, ap.status, ap.printed_at, " +
                "a.first_name, a.last_name, a.current_address, a.city, a.postal_code, " +
                "d.tracking_number, d.delivery_date, d.recipient_name, d.recipient_id_verification, d.notes " +
                "FROM applications_printed ap " +
                "JOIN applications a ON ap.application_id = a.application_id " +
                "LEFT JOIN deliveries d ON ap.application_id = d.application_id " +
                "WHERE ap.status = 'in_transit' " +
                "ORDER BY d.delivery_date DESC";
        
        try (Connection conn = Database.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("applicationId", rs.getInt("application_id"));
                row.put("nicNumber", rs.getString("nic_number"));
                row.put("status", rs.getString("status"));
                row.put("printedAt", rs.getTimestamp("printed_at"));
                row.put("firstName", rs.getString("first_name"));
                row.put("lastName", rs.getString("last_name"));
                row.put("currentAddress", rs.getString("current_address"));
                row.put("city", rs.getString("city"));
                row.put("postalCode", rs.getString("postal_code"));
                row.put("trackingNumber", rs.getString("tracking_number"));
                row.put("deliveryDate", rs.getTimestamp("delivery_date"));
                row.put("recipientName", rs.getString("recipient_name"));
                row.put("recipientIdVerification", rs.getString("recipient_id_verification"));
                row.put("notes", rs.getString("notes"));
                rows.add(row);
            }
            mapper.writeValue(response.getWriter(), rows);
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            mapper.writeValue(response.getWriter(), Map.of("error", "Database error: " + e.getMessage()));
        }
    }
}
