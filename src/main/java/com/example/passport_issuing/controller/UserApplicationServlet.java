package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.*;
import java.time.LocalDate;
import java.util.*;

@MultipartConfig
public class UserApplicationServlet extends HttpServlet {
    private static final Set<String> ALLOWED_DOC_TYPES = new HashSet<>(Arrays.asList(
            "passport_photo", "birth_certificate", "address_proof", "signature"
    ));

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            mapper.writeValue(response.getWriter(), Map.of("error", "Missing id"));
            return;
        }
        int applicationId = Integer.parseInt(idStr);

        try (Connection conn = Database.getConnection()) {
            Map<String, Object> result = new HashMap<>();
            String appSql = "SELECT application_id, nic_number, first_name, last_name, date_of_birth, email, " +
                    "current_address, city, postal_code, processing_type, status " +
                    "FROM applications WHERE application_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(appSql)) {
                ps.setInt(1, applicationId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        mapper.writeValue(response.getWriter(), Map.of("error", "Application not found"));
                        return;
                    }
                    result.put("applicationId", rs.getInt("application_id"));
                    result.put("nicNumber", rs.getString("nic_number"));
                    result.put("firstName", rs.getString("first_name"));
                    result.put("lastName", rs.getString("last_name"));
                    result.put("dateOfBirth", rs.getDate("date_of_birth"));
                    result.put("email", rs.getString("email"));
                    result.put("currentAddress", rs.getString("current_address"));
                    result.put("city", rs.getString("city"));
                    result.put("postalCode", rs.getString("postal_code"));
                    result.put("processingType", rs.getString("processing_type"));
                    result.put("status", rs.getString("status"));
                }
            }

            // Documents
            String docSql = "SELECT document_type, file_name, file_path, mime_type, document_id FROM application_documents WHERE application_id = ? ORDER BY document_id DESC";
            Map<String, Map<String,Object>> latestByType = new LinkedHashMap<>();
            try (PreparedStatement ps = conn.prepareStatement(docSql)) {
                ps.setInt(1, applicationId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String type = rs.getString("document_type");
                        if (latestByType.containsKey(type)) continue; // keep first (latest)
                        Map<String, Object> d = new HashMap<>();
                        d.put("documentType", type);
                        d.put("fileName", rs.getString("file_name"));
                        d.put("filePath", rs.getString("file_path"));
                        d.put("mimeType", rs.getString("mime_type"));
                        latestByType.put(type, d);
                    }
                }
            }
            result.put("documents", new ArrayList<>(latestByType.values()));

            mapper.writeValue(response.getWriter(), result);
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            mapper.writeValue(response.getWriter(), Map.of("error", "Database error: " + e.getMessage()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();

        String idStr = request.getParameter("applicationId");
        if (idStr == null || idStr.isBlank()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            mapper.writeValue(response.getWriter(), Map.of("error", "Missing applicationId"));
            return;
        }
        int applicationId = Integer.parseInt(idStr);

        try (Connection conn = Database.getConnection()) {
            conn.setAutoCommit(false);

            // Guard: block updates if status >= payment_verified
            String status;
            try (PreparedStatement ps = conn.prepareStatement("SELECT status FROM applications WHERE application_id = ?")) {
                ps.setInt(1, applicationId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        conn.rollback();
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        mapper.writeValue(response.getWriter(), Map.of("error", "Application not found"));
                        return;
                    }
                    status = rs.getString("status");
                }
            }
            if (status != null && (status.equalsIgnoreCase("payment_verified") ||
                    status.equalsIgnoreCase("approved") || status.equalsIgnoreCase("printed") || status.equalsIgnoreCase("delivered") || status.equalsIgnoreCase("rejected"))) {
                conn.rollback();
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                mapper.writeValue(response.getWriter(), Map.of("error", "Editing is not allowed after payment verification"));
                return;
            }

            // Update basic fields
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String nicNumber = request.getParameter("nicNumber");
            String dateOfBirth = request.getParameter("dateOfBirth");
            String email = request.getParameter("email");
            String currentAddress = request.getParameter("currentAddress");
            String city = request.getParameter("city");
            String postalCode = request.getParameter("postalCode");

            String updSql = "UPDATE applications SET nic_number=?, first_name=?, last_name=?, date_of_birth=?, email=?, current_address=?, city=?, postal_code=? WHERE application_id=?";
            try (PreparedStatement ps = conn.prepareStatement(updSql)) {
                ps.setString(1, nicNumber);
                ps.setString(2, firstName);
                ps.setString(3, lastName);
                if (dateOfBirth != null && !dateOfBirth.isBlank()) {
                    ps.setDate(4, java.sql.Date.valueOf(LocalDate.parse(dateOfBirth)));
                } else {
                    ps.setNull(4, Types.DATE);
                }
                ps.setString(5, email);
                ps.setString(6, currentAddress);
                ps.setString(7, city);
                ps.setString(8, postalCode);
                ps.setInt(9, applicationId);
                ps.executeUpdate();
            }

            // Handle optional documents
            for (Part part : request.getParts()) {
                String fieldName = part.getName();
                if (!ALLOWED_DOC_TYPES.contains(fieldName)) continue;
                if (part.getSize() <= 0) continue;

                String uploadsDir = getServletContext().getRealPath("/") + File.separator + "uploads" + File.separator + "app_" + applicationId;
                Files.createDirectories(Paths.get(uploadsDir));
                String submittedFileName = getFileName(part);
                String fileName = System.currentTimeMillis() + "_" + (submittedFileName != null ? submittedFileName.replaceAll("[^a-zA-Z0-9._-]", "_") : fieldName + ".bin");
                Path filePath = Paths.get(uploadsDir, fileName);
                try (InputStream in = part.getInputStream(); FileOutputStream out = new FileOutputStream(filePath.toFile())) {
                    in.transferTo(out);
                }
                String webPath = "uploads/app_" + applicationId + "/" + fileName;

                // Upsert document record
                // Ensure only one row per (application_id, document_type)
                try (PreparedStatement del = conn.prepareStatement("DELETE FROM application_documents WHERE application_id=? AND document_type=?")) {
                    del.setInt(1, applicationId);
                    del.setString(2, fieldName);
                    del.executeUpdate();
                }

                String insert = "INSERT INTO application_documents (application_id, document_type, file_name, file_path, file_size, mime_type) VALUES (?,?,?,?,?,?)";
                try (PreparedStatement ps = conn.prepareStatement(insert)) {
                    ps.setInt(1, applicationId);
                    ps.setString(2, fieldName);
                    ps.setString(3, submittedFileName);
                    ps.setString(4, webPath);
                    ps.setLong(5, part.getSize());
                    ps.setString(6, part.getContentType());
                    ps.executeUpdate();
                }
            }

            conn.commit();
            mapper.writeValue(response.getWriter(), Map.of("success", true, "message", "Application updated successfully"));
        } catch (SQLException | ServletException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            new ObjectMapper().writeValue(response.getWriter(), Map.of("error", "Server error: " + e.getMessage()));
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return null;
        for (String cd : contentDisp.split(";")) {
            cd = cd.trim();
            if (cd.startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName;
            }
        }
        return null;
    }
}
