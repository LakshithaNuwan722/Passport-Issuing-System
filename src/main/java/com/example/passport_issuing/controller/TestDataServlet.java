package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/api/test-data")
public class TestDataServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Add sample applications
            addSampleApplications();

            response.getWriter().write("{\"message\": \"Sample data added successfully\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to add sample data: " + e.getMessage() + "\"}");
        }
    }

    private void addSampleApplications() throws SQLException {
        try (Connection conn = Database.getConnection()) {
            // Clear existing data first
            try (PreparedStatement clearStmt = conn.prepareStatement("DELETE FROM applications")) {
                clearStmt.executeUpdate();
            }

            // Add sample applications
            String sql = "INSERT INTO applications (nic_number, first_name, last_name, date_of_birth, email, current_address, city, postal_code, processing_type, biometric_date, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                // Sample application 1
                stmt.setString(1, "123456789V");
                stmt.setString(2, "John");
                stmt.setString(3, "Doe");
                stmt.setString(4, "1990-05-15");
                stmt.setString(5, "john.doe@email.com");
                stmt.setString(6, "123 Main Street, Colombo 07");
                stmt.setString(7, "Colombo");
                stmt.setString(8, "10000");
                stmt.setString(9, "regular");
                stmt.setString(10, "2024-02-15");
                stmt.setString(11, "submitted");
                stmt.executeUpdate();

                // Sample application 2
                stmt.setString(1, "987654321V");
                stmt.setString(2, "Jane");
                stmt.setString(3, "Smith");
                stmt.setString(4, "1985-08-22");
                stmt.setString(5, "jane.smith@email.com");
                stmt.setString(6, "456 Oak Avenue, Kandy City");
                stmt.setString(7, "Kandy");
                stmt.setString(8, "20000");
                stmt.setString(9, "express");
                stmt.setString(10, "2024-02-20");
                stmt.setString(11, "processing");
                stmt.executeUpdate();

                // Sample application 3
                stmt.setString(1, "555666777V");
                stmt.setString(2, "Michael");
                stmt.setString(3, "Johnson");
                stmt.setString(4, "1992-12-10");
                stmt.setString(5, "michael.johnson@email.com");
                stmt.setString(6, "789 Pine Road, Galle Fort");
                stmt.setString(7, "Galle");
                stmt.setString(8, "80000");
                stmt.setString(9, "regular");
                stmt.setString(10, "2024-02-25");
                stmt.setString(11, "approved");
                stmt.executeUpdate();

                // Sample application 4
                stmt.setString(1, "111222333V");
                stmt.setString(2, "Sarah");
                stmt.setString(3, "Williams");
                stmt.setString(4, "1988-03-18");
                stmt.setString(5, "sarah.williams@email.com");
                stmt.setString(6, "321 Beach Road, Negombo");
                stmt.setString(7, "Negombo");
                stmt.setString(8, "11500");
                stmt.setString(9, "express");
                stmt.setString(10, "2024-03-01");
                stmt.setString(11, "rejected");
                stmt.executeUpdate();

                // Sample application 5
                stmt.setString(1, "444555666V");
                stmt.setString(2, "David");
                stmt.setString(3, "Brown");
                stmt.setString(4, "1995-11-05");
                stmt.setString(5, "david.brown@email.com");
                stmt.setString(6, "654 Hill Street, Nuwara Eliya");
                stmt.setString(7, "Nuwara Eliya");
                stmt.setString(8, "22200");
                stmt.setString(9, "regular");
                stmt.setString(10, "2024-03-05");
                stmt.setString(11, "draft");
                stmt.executeUpdate();
            }
        }
    }
}