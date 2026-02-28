package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
public class DatabaseInitServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            initializeDatabase();
            response.getWriter().write("{\"message\": \"Database initialized successfully\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to initialize database: " + e.getMessage() + "\"}");
        }
    }

    private void initializeDatabase() throws SQLException {
        try (Connection conn = Database.getConnection()) {

            // Create login_credentials table
            String createLoginTable = """
                CREATE TABLE IF NOT EXISTS login_credentials (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    nic_number VARCHAR(20) NOT NULL UNIQUE,
                    email VARCHAR(100) NOT NULL UNIQUE,
                    password VARCHAR(255) NOT NULL
                )
                """;

            try (PreparedStatement stmt = conn.prepareStatement(createLoginTable)) {
                stmt.executeUpdate();
                System.out.println("Created login_credentials table");
            }

            // Create applications table
            String createApplicationsTable = """
                CREATE TABLE IF NOT EXISTS applications (
                    application_id INT AUTO_INCREMENT PRIMARY KEY,
                    nic_number VARCHAR(20) NOT NULL,
                    first_name VARCHAR(100) NOT NULL,
                    last_name VARCHAR(100) NOT NULL,
                    date_of_birth DATE NOT NULL,
                    email VARCHAR(100) NOT NULL,
                    current_address TEXT NOT NULL,
                    city VARCHAR(100) NOT NULL,
                    postal_code VARCHAR(20),
                    processing_type ENUM('regular', 'express') NOT NULL,
                    biometric_date DATE,
                    status ENUM('draft', 'submitted', 'payment_completed', 'processing', 'approved', 'printed', 'delivered', 'rejected') DEFAULT 'submitted'
                )
                """;

            try (PreparedStatement stmt = conn.prepareStatement(createApplicationsTable)) {
                stmt.executeUpdate();
                System.out.println("Created applications table");
            }

            // Create application_documents table
            String createDocumentsTable = """
                CREATE TABLE IF NOT EXISTS application_documents (
                    document_id INT AUTO_INCREMENT PRIMARY KEY,
                    application_id INT NOT NULL,
                    document_type ENUM('passport_photo', 'birth_certificate', 'address_proof', 'signature') NOT NULL,
                    file_name VARCHAR(255) NOT NULL,
                    file_path VARCHAR(500) NOT NULL,
                    file_size BIGINT NOT NULL,
                    mime_type VARCHAR(100) NOT NULL,
                    FOREIGN KEY (application_id) REFERENCES applications(application_id) ON DELETE CASCADE
                )
                """;

            try (PreparedStatement stmt = conn.prepareStatement(createDocumentsTable)) {
                stmt.executeUpdate();
                System.out.println("Created application_documents table");
            }

            // Create deliveries table
            String createDeliveriesTable = """
                CREATE TABLE IF NOT EXISTS deliveries (
                    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
                    application_id INT NOT NULL,
                    tracking_number VARCHAR(50) NOT NULL UNIQUE,
                    delivery_date DATETIME NOT NULL,
                    recipient_name VARCHAR(200) NOT NULL,
                    recipient_id_verification VARCHAR(100) NOT NULL,
                    notes TEXT,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (application_id) REFERENCES applications(application_id) ON DELETE CASCADE
                )
                """;

            try (PreparedStatement stmt = conn.prepareStatement(createDeliveriesTable)) {
                stmt.executeUpdate();
                System.out.println("Created deliveries table");
            }

            // Create questions table
            String createQuestionsTable = """
                CREATE TABLE IF NOT EXISTS questions (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    question TEXT NOT NULL,
                    subject VARCHAR(200) NOT NULL,
                    answer TEXT NULL,
                    category VARCHAR(50) DEFAULT 'general',
                    user_name VARCHAR(200) NULL,
                    user_email VARCHAR(100) NULL,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
                )
                """;

            try (PreparedStatement stmt = conn.prepareStatement(createQuestionsTable)) {
                stmt.executeUpdate();
                System.out.println("Created questions table");
            }
        }
    }
}