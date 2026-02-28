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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/update-application")
public class UpdateApplicationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String applicationIdParam = request.getParameter("id");

        if (applicationIdParam == null || applicationIdParam.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Application ID is required");
            new ObjectMapper().writeValue(response.getWriter(), error);
            return;
        }

        try {
            int applicationId = Integer.parseInt(applicationIdParam);
            Map<String, Object> applicationData = getApplicationDataForUpdate(applicationId);

            if (applicationData != null) {
                new ObjectMapper().writeValue(response.getWriter(), applicationData);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Application not found");
                new ObjectMapper().writeValue(response.getWriter(), error);
            }

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Invalid application ID format");
            new ObjectMapper().writeValue(response.getWriter(), error);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Database error: " + e.getMessage());
            new ObjectMapper().writeValue(response.getWriter(), error);
        }
    }

    private Map<String, Object> getApplicationDataForUpdate(int applicationId) throws Exception {
        Map<String, Object> application = null;

        try (Connection conn = Database.getConnection()) {
            // Get application details
            String sql = "SELECT a.*, " +
                        "d.document_id, d.document_type, d.file_name, d.file_path, d.file_size, d.mime_type " +
                        "FROM applications a " +
                        "LEFT JOIN application_documents d ON a.application_id = d.application_id " +
                        "WHERE a.application_id = ? " +
                        "ORDER BY d.document_type";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, applicationId);

                try (ResultSet rs = stmt.executeQuery()) {
                    Map<Integer, Map<String, Object>> appMap = new HashMap<>();

                    while (rs.next()) {
                        int appId = rs.getInt("application_id");

                        // Create application object if not exists
                        if (!appMap.containsKey(appId)) {
                            Map<String, Object> app = new HashMap<>();
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

                            // Initialize documents list
                            app.put("documents", new ArrayList<Map<String, Object>>());
                            appMap.put(appId, app);
                        }

                        // Add document if exists
                        int docId = rs.getInt("document_id");
                        if (docId > 0) {
                            @SuppressWarnings("unchecked")
                            List<Map<String, Object>> docs = (List<Map<String, Object>>) appMap.get(appId).get("documents");

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

                    if (!appMap.isEmpty()) {
                        application = appMap.values().iterator().next();

                        // Add document existence flags for easier frontend handling
                        @SuppressWarnings("unchecked")
                        List<Map<String, Object>> docs = (List<Map<String, Object>>) application.get("documents");

                        boolean hasPassportPhoto = docs.stream().anyMatch(doc -> "passport_photo".equals(doc.get("documentType")));
                        boolean hasBirthCertificate = docs.stream().anyMatch(doc -> "birth_certificate".equals(doc.get("documentType")));
                        boolean hasAddressProof = docs.stream().anyMatch(doc -> "address_proof".equals(doc.get("documentType")));
                        boolean hasSignature = docs.stream().anyMatch(doc -> "signature".equals(doc.get("documentType")));

                        application.put("hasPassportPhoto", hasPassportPhoto);
                        application.put("hasBirthCertificate", hasBirthCertificate);
                        application.put("hasAddressProof", hasAddressProof);
                        application.put("hasSignature", hasSignature);

                        // Add document URLs for preview (if needed)
                        Map<String, String> documentUrls = new HashMap<>();
                        for (Map<String, Object> doc : docs) {
                            String docType = (String) doc.get("documentType");
                            String filePath = (String) doc.get("filePath");
                            if (filePath != null && !filePath.isEmpty()) {
                                documentUrls.put(docType, filePath);
                            }
                        }
                        application.put("documentUrls", documentUrls);
                    }
                }
            }
        }

        return application;
    }
}