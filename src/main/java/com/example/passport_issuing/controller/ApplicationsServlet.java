package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//file upload capabilities
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 5 * 1024 * 1024,   // 5MB
    maxRequestSize = 10 * 1024 * 1024 // 10MB
)
public class ApplicationsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        String applicationIdParam = request.getParameter("id");
        if (applicationIdParam != null) {
            // Update existing application
            try {
                int applicationId = Integer.parseInt(applicationIdParam);

                // Get form parameters
                String nic = request.getParameter("nic");

                // Verify that the application belongs to the user
                try (Connection conn = Database.getConnection();
                     PreparedStatement checkStmt = conn.prepareStatement("SELECT nic_number FROM applications WHERE application_id = ?")) {
                    checkStmt.setInt(1, applicationId);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next()) {
                            String appNic = rs.getString("nic_number");
                            if (!appNic.equals(nic)) {
                                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                                Map<String, String> error = new HashMap<>();
                                error.put("error", "You can only update your own application");
                                objectMapper.writeValue(response.getWriter(), error);
                                return;
                            }
                        } else {
                            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                            Map<String, String> error = new HashMap<>();
                            error.put("error", "Application not found");
                            objectMapper.writeValue(response.getWriter(), error);
                            return;
                        }
                    }
                } catch (java.sql.SQLException e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    Map<String, Object> error = new HashMap<>();
                    
                    String errorMsg = e.getMessage();
                    if (errorMsg != null && errorMsg.contains("Communications link failure")) {
                        error.put("error", "Database connection failed. Please check if MySQL server is running.");
                        error.put("details", "The application cannot connect to the database server.");
                        error.put("troubleshooting", "Visit /db-diagnostic.jsp for detailed diagnostics");
                    } else {
                        error.put("error", "Database error: " + errorMsg);
                    }
                    error.put("type", "SQLException");
                    
                    System.err.println("[ApplicationsServlet] Database error: " + e.getMessage());
                    e.printStackTrace();
                    
                    objectMapper.writeValue(response.getWriter(), error);
                    return;
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    Map<String, Object> error = new HashMap<>();
                    error.put("error", "Internal server error: " + e.getMessage());
                    error.put("type", e.getClass().getSimpleName());
                    
                    System.err.println("[ApplicationsServlet] Unexpected error: " + e.getMessage());
                    e.printStackTrace();
                    
                    objectMapper.writeValue(response.getWriter(), error);
                    return;
                }
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String dob = request.getParameter("dob");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                String city = request.getParameter("city");
                String postalCode = request.getParameter("postalCode");

                // Update database
                try (Connection conn = Database.getConnection();
                     PreparedStatement stmt = conn.prepareStatement(
                         "UPDATE applications SET first_name = ?, last_name = ?, date_of_birth = ?, email = ?, current_address = ?, city = ?, postal_code = ? WHERE application_id = ?")) {

                    stmt.setString(1, firstName);
                    stmt.setString(2, lastName);
                    stmt.setString(3, dob);
                    stmt.setString(4, email);
                    stmt.setString(5, address);
                    stmt.setString(6, city);
                    stmt.setString(7, postalCode);
                    stmt.setInt(8, applicationId);

                    int rows = stmt.executeUpdate();

                    if (rows > 0) {
                        // Check if any files provided, if yes, delete existing documents and upload new
                        boolean hasFiles = false;
                        String[] fileTypes = {"passportPhoto", "birthCertificate", "addressProof", "signature"};
                        for (String type : fileTypes) {
                            Part part = request.getPart(type);
                            if (part != null && part.getSize() > 0) {
                                hasFiles = true;
                                break;
                            }
                        }

                        if (hasFiles) {
                            // Delete existing documents
                            try (PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM application_documents WHERE application_id = ?")) {
                                deleteStmt.setInt(1, applicationId);
                                deleteStmt.executeUpdate();
                            }
                            // Upload new files
                            handleFileUploads(request, applicationId);
                        }

                        Map<String, Object> success = new HashMap<>();
                        success.put("message", "Application updated successfully");
                        success.put("applicationId", applicationId);
                        objectMapper.writeValue(response.getWriter(), success);
                    } else {
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        Map<String, String> error = new HashMap<>();
                        error.put("error", "Application not found");
                        objectMapper.writeValue(response.getWriter(), error);
                    }

                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    Map<String, String> error = new HashMap<>();
                    error.put("error", "Database error: " + e.getMessage());
                    objectMapper.writeValue(response.getWriter(), error);
                }

            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Invalid request format");
                objectMapper.writeValue(response.getWriter(), error);
            }
            return;
        }

        // Create new application
        try {
            // Get form parameters
            String nic = request.getParameter("nic");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String dob = request.getParameter("dob");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String postalCode = request.getParameter("postalCode");
            String processingType = request.getParameter("processingType");
            String biometricDate = request.getParameter("biometricDate");

            // Validate required fields with specific error messages
            List<String> missingFields = new ArrayList<>();

            if (nic == null || nic.trim().isEmpty()) {
                missingFields.add("NIC Number");
            }
            if (firstName == null || firstName.trim().isEmpty()) {
                missingFields.add("First Name");
            }
            if (lastName == null || lastName.trim().isEmpty()) {
                missingFields.add("Last Name");
            }
            if (dob == null || dob.trim().isEmpty()) {
                missingFields.add("Date of Birth");
            }
            if (email == null || email.trim().isEmpty()) {
                missingFields.add("Email Address");
            }
            if (address == null || address.trim().isEmpty()) {
                missingFields.add("Current Address");
            }
            if (city == null || city.trim().isEmpty()) {
                missingFields.add("City");
            }
            if (processingType == null || processingType.trim().isEmpty()) {
                missingFields.add("Processing Type");
            }
            if (biometricDate == null || biometricDate.trim().isEmpty()) {
                missingFields.add("Biometric Appointment Date");
            }

            if (!missingFields.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                Map<String, String> error = new HashMap<>();
                error.put("error", "The following required fields are missing: " + String.join(", ", missingFields));
                objectMapper.writeValue(response.getWriter(), error);
                return;
            }

            // Validate required file uploads with specific error messages
            String[] requiredFiles = {"passportPhoto", "birthCertificate", "addressProof", "signature"};
            String[] fileLabels = {"Passport Photo", "Birth Certificate", "Address Proof", "Signature Image"};
            List<String> missingFiles = new ArrayList<>();

            for (int i = 0; i < requiredFiles.length; i++) {
                Part filePart = request.getPart(requiredFiles[i]);
                if (filePart == null || filePart.getSize() == 0) {
                    missingFiles.add(fileLabels[i]);
                }
            }

            if (!missingFiles.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                Map<String, String> error = new HashMap<>();
                error.put("error", "The following required documents are missing: " + String.join(", ", missingFiles));
                objectMapper.writeValue(response.getWriter(), error);
                return;
            }

            // Check if an application already exists for this NIC
            try (Connection conn = Database.getConnection();
                 PreparedStatement checkStmt = conn.prepareStatement("SELECT COUNT(*) FROM applications WHERE nic_number = ?")) {
                checkStmt.setString(1, nic);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        response.setStatus(HttpServletResponse.SC_CONFLICT);
                        Map<String, String> error = new HashMap<>();
                        error.put("error", "An application already exists for this NIC number. You can update your existing application.");
                        objectMapper.writeValue(response.getWriter(), error);
                        return;
                    }
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Database error: " + e.getMessage());
                objectMapper.writeValue(response.getWriter(), error);
                return;
            }

            // Insert into database
            try (Connection conn = Database.getConnection();
                  PreparedStatement stmt = conn.prepareStatement(
                      "INSERT INTO applications (nic_number, first_name, last_name, date_of_birth, email, current_address, city, postal_code, processing_type, biometric_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                      PreparedStatement.RETURN_GENERATED_KEYS)) {

                stmt.setString(1, nic);
                stmt.setString(2, firstName);
                stmt.setString(3, lastName);
                stmt.setString(4, dob);
                stmt.setString(5, email);
                stmt.setString(6, address);
                stmt.setString(7, city);
                stmt.setString(8, postalCode);
                stmt.setString(9, processingType);
                stmt.setString(10, biometricDate);

                int rows = stmt.executeUpdate();

                if (rows > 0) {
                    // Get generated application_id
                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            int applicationId = rs.getInt(1);

                            // Handle file uploads
                            handleFileUploads(request, applicationId);

                            Map<String, Object> success = new HashMap<>();
                            success.put("message", "Application submitted successfully");
                            success.put("applicationId", applicationId);
                            objectMapper.writeValue(response.getWriter(), success);
                        }
                    }
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    Map<String, String> error = new HashMap<>();
                    error.put("error", "Failed to submit application");
                    objectMapper.writeValue(response.getWriter(), error);
                }

            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Database error: " + e.getMessage());
                objectMapper.writeValue(response.getWriter(), error);
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Invalid request format");
            objectMapper.writeValue(response.getWriter(), error);
        }
    }
//doGet() Method - READ Applications
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            String nic = request.getParameter("nic");
            String applicationIdParam = request.getParameter("id");

            List<Map<String, Object>> applications = new ArrayList<>();

            try (Connection conn = Database.getConnection()) {
                String sql;
                PreparedStatement stmt;

                if (applicationIdParam != null) {
                    // Get specific application - return single object.
                    // If nic is provided, ensure the application belongs to that nic.
                    if (nic != null && !nic.trim().isEmpty()) {
                        sql = "SELECT a.*, d.document_id, d.document_type, d.file_name, d.file_path, d.file_size, d.mime_type " +
                              "FROM applications a LEFT JOIN application_documents d ON a.application_id = d.application_id " +
                              "WHERE a.application_id = ? AND a.nic_number = ?";
                        stmt = conn.prepareStatement(sql);
                        stmt.setInt(1, Integer.parseInt(applicationIdParam));
                        stmt.setString(2, nic);
                    } else {
                        sql = "SELECT a.*, d.document_id, d.document_type, d.file_name, d.file_path, d.file_size, d.mime_type " +
                              "FROM applications a LEFT JOIN application_documents d ON a.application_id = d.application_id " +
                              "WHERE a.application_id = ?";
                        stmt = conn.prepareStatement(sql);
                        stmt.setInt(1, Integer.parseInt(applicationIdParam));
                    }

                    try (ResultSet rs = stmt.executeQuery()) {
                        Map<Integer, Map<String, Object>> appMap = new HashMap<>();

                        while (rs.next()) {
                            int appId = rs.getInt("application_id");

                            Map<String, Object> app = appMap.get(appId);
                            if (app == null) {
                                app = new HashMap<>();
                                app.put("applicationId", appId);
                                app.put("nicNumber", rs.getString("nic_number"));
                                app.put("firstName", rs.getString("first_name"));
                                app.put("lastName", rs.getString("last_name"));
                                app.put("dateOfBirth", rs.getString("date_of_birth"));
                                app.put("email", rs.getString("email"));
                                app.put("currentAddress", rs.getString("current_address"));
                                app.put("city", rs.getString("city"));
                                app.put("postalCode", rs.getString("postal_code"));
                                app.put("processingType", rs.getString("processing_type"));
                                app.put("biometricDate", rs.getString("biometric_date"));
                                app.put("status", rs.getString("status"));
                                app.put("documents", new ArrayList<Map<String, Object>>());
                                appMap.put(appId, app);
                            }

                            // Add document if exists
                            int docId = rs.getInt("document_id");
                            if (docId > 0) {
                                @SuppressWarnings("unchecked")
                                List<Map<String, Object>> docs = (List<Map<String, Object>>) app.get("documents");
                                Map<String, Object> doc = new HashMap<>();
                                doc.put("documentId", docId);
                                doc.put("documentType", rs.getString("document_type"));
                                doc.put("fileName", rs.getString("file_name"));
                                doc.put("filePath", rs.getString("file_path"));
                                doc.put("fileSize", rs.getLong("file_size"));
                                doc.put("mimeType", rs.getString("mime_type"));
                                docs.add(doc);
                            }
                        }

                        // Return single application object instead of array
                        if (!appMap.isEmpty()) {
                            objectMapper.writeValue(response.getWriter(), appMap.values().iterator().next());
                        } else {
                            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                            Map<String, String> error = new HashMap<>();
                            error.put("error", "Application not found");
                            objectMapper.writeValue(response.getWriter(), error);
                        }
                    }
                    return; // Exit early for single application request
                } else if (nic != null) {
                    // Get applications for user
                    sql = "SELECT a.*, d.document_id, d.document_type, d.file_name, d.file_path, d.file_size, d.mime_type " +
                          "FROM applications a LEFT JOIN application_documents d ON a.application_id = d.application_id " +
                          "WHERE a.nic_number = ? ORDER BY a.application_id";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, nic);
                } else {
                    // Get all applications (admin view)
                    sql = "SELECT a.*, d.document_id, d.document_type, d.file_name, d.file_path, d.file_size, d.mime_type " +
                          "FROM applications a LEFT JOIN application_documents d ON a.application_id = d.application_id " +
                          "ORDER BY a.application_id";
                    stmt = conn.prepareStatement(sql);
                }

                try (ResultSet rs = stmt.executeQuery()) {
                    Map<Integer, Map<String, Object>> appMap = new HashMap<>();

                    while (rs.next()) {
                        int appId = rs.getInt("application_id");

                        Map<String, Object> app = appMap.get(appId);
                        if (app == null) {
                            app = new HashMap<>();
                            app.put("applicationId", appId);
                            app.put("nicNumber", rs.getString("nic_number"));
                            app.put("firstName", rs.getString("first_name"));
                            app.put("lastName", rs.getString("last_name"));
                            app.put("dateOfBirth", rs.getString("date_of_birth"));
                            app.put("email", rs.getString("email"));
                            app.put("currentAddress", rs.getString("current_address"));
                            app.put("city", rs.getString("city"));
                            app.put("postalCode", rs.getString("postal_code"));
                            app.put("processingType", rs.getString("processing_type"));
                            app.put("biometricDate", rs.getString("biometric_date"));
                            app.put("status", rs.getString("status"));
                            app.put("documents", new ArrayList<Map<String, Object>>());
                            appMap.put(appId, app);
                        }

                        // Add document if exists
                        int docId = rs.getInt("document_id");
                        if (docId > 0) {
                            @SuppressWarnings("unchecked")
                            List<Map<String, Object>> docs = (List<Map<String, Object>>) app.get("documents");
                            Map<String, Object> doc = new HashMap<>();
                            doc.put("documentId", docId);
                            doc.put("documentType", rs.getString("document_type"));
                            doc.put("fileName", rs.getString("file_name"));
                            doc.put("filePath", rs.getString("file_path"));
                            doc.put("fileSize", rs.getLong("file_size"));
                            doc.put("mimeType", rs.getString("mime_type"));
                            docs.add(doc);
                        }
                    }

                    applications.addAll(appMap.values());
                }

                objectMapper.writeValue(response.getWriter(), applications);

            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Database error: " + e.getMessage());
                objectMapper.writeValue(response.getWriter(), error);
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Invalid request: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            String applicationIdParam = request.getParameter("id");
            if (applicationIdParam == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Application ID is required");
                objectMapper.writeValue(response.getWriter(), error);
                return;
            }

            int applicationId = Integer.parseInt(applicationIdParam);

            // Get form parameters
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String dob = request.getParameter("dob");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String postalCode = request.getParameter("postalCode");
            String processingType = request.getParameter("processingType");
            String biometricDate = request.getParameter("biometricDate");
            String status = request.getParameter("status");

            // Update database
            try (Connection conn = Database.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE applications SET first_name = ?, last_name = ?, date_of_birth = ?, email = ?, current_address = ?, city = ?, postal_code = ?, processing_type = ?, biometric_date = ?, status = ? WHERE application_id = ?")) {

                stmt.setString(1, firstName);
                stmt.setString(2, lastName);
                stmt.setString(3, dob);
                stmt.setString(4, email);
                stmt.setString(5, address);
                stmt.setString(6, city);
                stmt.setString(7, postalCode);
                stmt.setString(8, processingType);
                stmt.setString(9, biometricDate);
                stmt.setString(10, status);
                stmt.setInt(11, applicationId);

                int rows = stmt.executeUpdate();

                if (rows > 0) {
                    // Check if any files provided, if yes, delete existing documents and upload new
                    boolean hasFiles = false;
                    String[] fileTypes = {"passportPhoto", "birthCertificate", "addressProof", "signature"};
                    for (String type : fileTypes) {
                        Part part = request.getPart(type);
                        if (part != null && part.getSize() > 0) {
                            hasFiles = true;
                            break;
                        }
                    }

                    if (hasFiles) {
                        // Delete existing documents
                        try (PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM application_documents WHERE application_id = ?")) {
                            deleteStmt.setInt(1, applicationId);
                            deleteStmt.executeUpdate();
                        }
                        // Upload new files
                        handleFileUploads(request, applicationId);
                    }

                    Map<String, Object> success = new HashMap<>();
                    success.put("message", "Application updated successfully");
                    success.put("applicationId", applicationId);
                    objectMapper.writeValue(response.getWriter(), success);
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    Map<String, String> error = new HashMap<>();
                    error.put("error", "Application not found");
                    objectMapper.writeValue(response.getWriter(), error);
                }

            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Database error: " + e.getMessage());
                objectMapper.writeValue(response.getWriter(), error);
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Invalid request format");
            objectMapper.writeValue(response.getWriter(), error);
        }
    }
//doDelete() Method - DELETE Application
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            String applicationIdParam = request.getParameter("id");
            if (applicationIdParam == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Application ID is required");
                objectMapper.writeValue(response.getWriter(), error);
                return;
            }

            int applicationId = Integer.parseInt(applicationIdParam);

            // Delete from database
            try (Connection conn = Database.getConnection()) {
                // First delete documents
                try (PreparedStatement deleteDocsStmt = conn.prepareStatement("DELETE FROM application_documents WHERE application_id = ?")) {
                    deleteDocsStmt.setInt(1, applicationId);
                    deleteDocsStmt.executeUpdate();
                }

                // Then delete application
                try (PreparedStatement stmt = conn.prepareStatement("DELETE FROM applications WHERE application_id = ?")) {
                    stmt.setInt(1, applicationId);
                    int rows = stmt.executeUpdate();

                    if (rows > 0) {
                        Map<String, Object> success = new HashMap<>();
                        success.put("message", "Application deleted successfully");
                        success.put("applicationId", applicationId);
                        objectMapper.writeValue(response.getWriter(), success);
                    } else {
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        Map<String, String> error = new HashMap<>();
                        error.put("error", "Application not found");
                        objectMapper.writeValue(response.getWriter(), error);
                    }
                }

            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Database error: " + e.getMessage());
                objectMapper.writeValue(response.getWriter(), error);
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Invalid request format");
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    private void handleFileUploads(HttpServletRequest request, int applicationId) throws Exception {
        // Define upload directory
        Path uploadDir = Paths.get(getServletContext().getRealPath("/uploads/applications"));
        Files.createDirectories(uploadDir);

        // File types to handle
        String[] fileTypes = {"passportPhoto", "birthCertificate", "addressProof", "signature"};
        String[] docTypes = {"passport_photo", "birth_certificate", "address_proof", "signature"};

        try (Connection conn = Database.getConnection()) {
            for (int i = 0; i < fileTypes.length; i++) {
                Part filePart = request.getPart(fileTypes[i]);
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = filePart.getSubmittedFileName();
                    String mimeType = filePart.getContentType();
                    long fileSize = filePart.getSize();

                    // Generate unique filename
                    String extension = getFileExtension(fileName);
                    String uniqueFileName = applicationId + "_" + docTypes[i] + "_" + System.currentTimeMillis() + "." + extension;
                    Path filePath = uploadDir.resolve(uniqueFileName);

                    // Save file
                    Files.copy(filePart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                    // Insert into database
                    try (PreparedStatement stmt = conn.prepareStatement(
                        "INSERT INTO application_documents (application_id, document_type, file_name, file_path, file_size, mime_type) VALUES (?, ?, ?, ?, ?, ?)")) {
                        stmt.setInt(1, applicationId);
                        stmt.setString(2, docTypes[i]);
                        stmt.setString(3, fileName);
                        stmt.setString(4, "uploads/applications/" + uniqueFileName);
                        stmt.setLong(5, fileSize);
                        stmt.setString(6, mimeType);
                        stmt.executeUpdate();
                    }
                }
            }
        }
    }

    private String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf('.');
        return lastDotIndex > 0 ? fileName.substring(lastDotIndex + 1) : "";
    }
}