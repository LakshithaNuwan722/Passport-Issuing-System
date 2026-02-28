package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/application-review")
public class ApplicationReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            String applicationIdParam = request.getParameter("id");
            String statusFilter = request.getParameter("status");

            // Default to payment_verified if no status specified
            if (statusFilter == null || statusFilter.isEmpty()) {
                statusFilter = "payment_verified";
            }

            List<Map<String, Object>> applications = new ArrayList<>();

            try (Connection conn = Database.getConnection()) {
                String sql;
                PreparedStatement stmt;

                if (applicationIdParam != null) {
                    // Get specific application with documents and review data
                    sql = "SELECT a.*, d.document_id, d.document_type, d.file_name, d.file_path, d.file_size, d.mime_type, " +
                          "r.review_id, r.personal_info_approved, r.address_info_approved, r.documents_approved, " +
                          "r.biometric_completed, r.final_approval_status, r.final_reviewed_by, r.final_reviewed_at, r.rejection_reason, " +
                          "pt.transaction_id, pt.transaction_status, pt.transaction_date " +
                          "FROM applications a " +
                          "LEFT JOIN application_documents d ON a.application_id = d.application_id " +
                          "LEFT JOIN application_reviews r ON a.application_id = r.application_id " +
                          "LEFT JOIN payment_transactions pt ON a.application_id = pt.application_id " +
                          "WHERE a.application_id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, Integer.parseInt(applicationIdParam));
                } else {
                    // Get applications that have COMPLETED payment transactions (payment verified)
                    // Query payment_transactions table to find verified payments, then get application data
                    sql = "SELECT a.*, d.document_id, d.document_type, d.file_name, d.file_path, d.file_size, d.mime_type, " +
                          "r.review_id, r.personal_info_approved, r.address_info_approved, r.documents_approved, " +
                          "r.biometric_completed, r.final_approval_status, r.final_reviewed_by, r.final_reviewed_at, r.rejection_reason, " +
                          "pt.transaction_id, pt.transaction_status, pt.transaction_date " +
                          "FROM applications a " +
                          "INNER JOIN payment_transactions pt ON a.application_id = pt.application_id " +
                          "LEFT JOIN application_documents d ON a.application_id = d.application_id " +
                          "LEFT JOIN application_reviews r ON a.application_id = r.application_id " +
                          "WHERE pt.transaction_status IN ('completed', 'verified') " +
                          "AND (a.status IS NULL OR a.status != 'approved') " +
                          "ORDER BY pt.transaction_date DESC, a.application_id DESC";
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
                            app.put("paymentStatus", rs.getString("payment_status"));
                            app.put("paymentDate", rs.getTimestamp("payment_date") != null ? rs.getTimestamp("payment_date").toString() : null);
                            // Review data from application_reviews table (may be NULL if no review record exists)
                            int reviewId = rs.getInt("review_id");
                            app.put("reviewId", reviewId);
                            app.put("personalInfoApproved", reviewId > 0 ? rs.getBoolean("personal_info_approved") : false);
                            app.put("addressInfoApproved", reviewId > 0 ? rs.getBoolean("address_info_approved") : false);
                            app.put("documentsApproved", reviewId > 0 ? rs.getBoolean("documents_approved") : false);
                            app.put("biometricCompleted", reviewId > 0 ? rs.getBoolean("biometric_completed") : false);
                            app.put("finalApprovalStatus", rs.getString("final_approval_status"));
                            app.put("finalReviewedBy", rs.getString("final_reviewed_by"));
                            app.put("finalReviewedAt", rs.getTimestamp("final_reviewed_at") != null ? rs.getTimestamp("final_reviewed_at").toString() : null);
                            app.put("rejectionReason", rs.getString("rejection_reason"));
                            // Payment transaction data (may be NULL)
                            try {
                                int transactionId = rs.getInt("transaction_id");
                                app.put("transactionId", transactionId);
                                app.put("transactionStatus", rs.getString("transaction_status"));
                                app.put("transactionDate", rs.getTimestamp("transaction_date") != null ? rs.getTimestamp("transaction_date").toString() : null);
                            } catch (Exception e) {
                                // Transaction columns might not exist or be null
                                app.put("transactionId", 0);
                                app.put("transactionStatus", null);
                                app.put("transactionDate", null);
                            }
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
                System.err.println("Database error in ApplicationReviewServlet.doGet:");
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Database error: " + e.getMessage());
                error.put("errorType", e.getClass().getSimpleName());
                if (e.getCause() != null) {
                    error.put("cause", e.getCause().getMessage());
                }
                objectMapper.writeValue(response.getWriter(), error);
            }

        } catch (Exception e) {
            System.err.println("Request error in ApplicationReviewServlet.doGet:");
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Invalid request: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // Get session to verify staff credentials
            HttpSession session = request.getSession(false);
            String staffUsername = null;
            if (session != null) {
                staffUsername = (String) session.getAttribute("staffUsername");
            }

            if (staffUsername == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Unauthorized: Staff login required");
                objectMapper.writeValue(response.getWriter(), error);
                return;
            }

            // Get request parameters
            String applicationIdParam = request.getParameter("applicationId");
            String action = request.getParameter("action");
            String section = request.getParameter("section");

            if (applicationIdParam == null || action == null || section == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Missing required parameters: applicationId, action, section");
                objectMapper.writeValue(response.getWriter(), error);
                return;
            }

            int applicationId = Integer.parseInt(applicationIdParam);
            boolean approved = "approve".equalsIgnoreCase(action);

            // Update the specific section in application_reviews table
            try (Connection conn = Database.getConnection()) {
                // First, ensure a review record exists for this application
                String checkSql = "SELECT review_id FROM application_reviews WHERE application_id = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setInt(1, applicationId);
                    ResultSet checkRs = checkStmt.executeQuery();
                    
                    if (!checkRs.next()) {
                        // Create a new review record
                        String insertSql = "INSERT INTO application_reviews (application_id) VALUES (?)";
                        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                            insertStmt.setInt(1, applicationId);
                            insertStmt.executeUpdate();
                        }
                    }
                }

                String sql = "";
                String columnName = "";
                String reviewedByColumn = "";

                switch (section.toLowerCase()) {
                    case "personal_info":
                        columnName = "personal_info_approved";
                        reviewedByColumn = "personal_info_reviewed_by";
                        break;
                    case "address_info":
                        columnName = "address_info_approved";
                        reviewedByColumn = "address_info_reviewed_by";
                        break;
                    case "documents":
                        columnName = "documents_approved";
                        reviewedByColumn = "documents_reviewed_by";
                        break;
                    case "biometric":
                        columnName = "biometric_completed";
                        reviewedByColumn = "biometric_reviewed_by";
                        break;
                    default:
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        Map<String, String> error = new HashMap<>();
                        error.put("error", "Invalid section: " + section);
                        objectMapper.writeValue(response.getWriter(), error);
                        return;
                }

                sql = "UPDATE application_reviews SET " + columnName + " = ?, " + 
                      reviewedByColumn + " = ?, " + reviewedByColumn.replace("_by", "_at") + " = NOW() " +
                      "WHERE application_id = ?";

                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setBoolean(1, approved);
                    stmt.setString(2, staffUsername);
                    stmt.setInt(3, applicationId);

                    int rows = stmt.executeUpdate();

                    if (rows > 0) {
                        Map<String, Object> success = new HashMap<>();
                        success.put("message", "Section " + section + " " + (approved ? "approved" : "rejected") + " successfully");
                        success.put("applicationId", applicationId);
                        success.put("section", section);
                        success.put("approved", approved);
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
            // Get session to verify staff credentials
            HttpSession session = request.getSession(false);
            String staffUsername = null;
            if (session != null) {
                staffUsername = (String) session.getAttribute("staffUsername");
            }

            // For PUT, need to manually parse body
            java.io.BufferedReader reader = request.getReader();
            StringBuilder body = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                body.append(line);
            }
            
            // Parse URL-encoded body
            Map<String, String> params = new HashMap<>();
            String[] pairs = body.toString().split("&");
            for (String pair : pairs) {
                String[] keyValue = pair.split("=");
                if (keyValue.length == 2) {
                    params.put(keyValue[0], java.net.URLDecoder.decode(keyValue[1], "UTF-8"));
                }
            }

            // Get request parameters from parsed body
            String applicationIdParam = params.get("applicationId");
            String action = params.get("action");

            if (applicationIdParam == null || action == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                Map<String, String> error = new HashMap<>();
                error.put("error", "Missing required parameters: applicationId, action");
                objectMapper.writeValue(response.getWriter(), error);
                return;
            }

            int applicationId = Integer.parseInt(applicationIdParam);
            String newStatus = "approve".equalsIgnoreCase(action) ? "approved" : "rejected";
            String rejectionReason = params.get("rejectionReason");

            // Update application status and final review data
            try (Connection conn = Database.getConnection()) {
                // First, ensure a review record exists for this application
                String checkSql = "SELECT review_id FROM application_reviews WHERE application_id = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setInt(1, applicationId);
                    ResultSet checkRs = checkStmt.executeQuery();
                    
                    if (!checkRs.next()) {
                        // Create a new review record
                        String insertSql = "INSERT INTO application_reviews (application_id) VALUES (?)";
                        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                            insertStmt.setInt(1, applicationId);
                            insertStmt.executeUpdate();
                        }
                    }
                }

                // Update applications table status
                String appSql = "UPDATE applications SET status = ? WHERE application_id = ?";
                try (PreparedStatement appStmt = conn.prepareStatement(appSql)) {
                    appStmt.setString(1, newStatus);
                    appStmt.setInt(2, applicationId);
                    appStmt.executeUpdate();
                }

                // Update application_reviews table with final approval
                String reviewSql = "UPDATE application_reviews SET final_approval_status = ?, " +
                                  "final_reviewed_by = ?, final_reviewed_at = NOW(), rejection_reason = ? " +
                                  "WHERE application_id = ?";

                try (PreparedStatement stmt = conn.prepareStatement(reviewSql)) {
                    stmt.setString(1, newStatus);
                    stmt.setString(2, staffUsername != null ? staffUsername : "guest");
                    stmt.setString(3, rejectionReason);
                    stmt.setInt(4, applicationId);

                    int rows = stmt.executeUpdate();

                    if (rows > 0) {
                        Map<String, Object> success = new HashMap<>();
                        success.put("message", "Application " + newStatus + " successfully");
                        success.put("applicationId", applicationId);
                        success.put("status", newStatus);
                        success.put("reviewedBy", staffUsername);
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
            error.put("error", "Invalid request: " + e.getMessage());
            objectMapper.writeValue(response.getWriter(), error);
        }
    }
}

