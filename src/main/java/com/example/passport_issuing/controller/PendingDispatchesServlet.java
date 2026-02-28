package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
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

public class PendingDispatchesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();

        List<Map<String, Object>> rows = new ArrayList<>();
        String sql = "SELECT ap.application_id, ap.nic_number, ap.status, ap.printed_at, " +
                "a.first_name, a.last_name, a.current_address, a.city, a.postal_code " +
                "FROM applications_printed ap " +
                "JOIN applications a ON ap.application_id = a.application_id " +
                "WHERE ap.status = 'printed' " +
                "ORDER BY ap.printed_at DESC";
        try (Connection conn = Database.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
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
                rows.add(row);
            }
            mapper.writeValue(response.getWriter(), rows);
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            mapper.writeValue(response.getWriter(), Map.of("error", "Database error: " + e.getMessage()));
        }
    }
}
