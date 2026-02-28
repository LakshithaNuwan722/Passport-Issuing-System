package com.example.passport_issuing.controller;

import com.example.passport_issuing.dao.Database;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.HorizontalAlignment;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PassportPdfServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String applicationId = request.getParameter("id");
        
        if (applicationId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Application ID is required");
            return;
        }

        try {
            // Get application data
            ApplicationData appData = getApplicationData(Integer.parseInt(applicationId));
            
            // Generate PDF
            byte[] pdfBytes = generatePassportPdf(appData);
            
            // Set response headers
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", 
                "attachment; filename=\"passport_" + appData.getNicNumber() + ".pdf\"");
            response.setContentLength(pdfBytes.length);
            
            // Write PDF to response
            response.getOutputStream().write(pdfBytes);
            response.getOutputStream().flush();
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error generating passport PDF: " + e.getMessage());
        }
    }

    private ApplicationData getApplicationData(int applicationId) throws SQLException {
        String sql = "SELECT ar.application_id, ar.final_approval_status, ar.final_reviewed_at, " +
                   "a.first_name, a.last_name, a.nic_number, a.email, " +
                   "a.date_of_birth, a.current_address, a.city, a.postal_code, " +
                   "a.processing_type, a.payment_date, a.status " +
                   "FROM application_reviews ar " +
                   "JOIN applications a ON ar.application_id = a.application_id " +
                   "WHERE ar.application_id = ? AND ar.final_approval_status = 'APPROVED'";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, applicationId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new ApplicationData(
                        rs.getInt("application_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("nic_number"),
                        rs.getString("email"),
                        rs.getDate("date_of_birth"),
                        rs.getString("current_address"),
                        rs.getString("city"),
                        rs.getString("postal_code"),
                        rs.getString("processing_type"),
                        rs.getTimestamp("final_reviewed_at")
                    );
                }
            }
        }
        throw new SQLException("Application not found or not approved");
    }

    private byte[] generatePassportPdf(ApplicationData appData) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdfDoc = new PdfDocument(writer);
        Document document = new Document(pdfDoc);

        // Set page size to passport dimensions (approximately 125mm x 88mm)
        pdfDoc.getDefaultPageSize().setWidth(350); // ~125mm
        pdfDoc.getDefaultPageSize().setHeight(250); // ~88mm

        try {
            // Create fonts
            PdfFont titleFont = PdfFontFactory.createFont();
            PdfFont headerFont = PdfFontFactory.createFont();
            PdfFont dataFont = PdfFontFactory.createFont();

            // Header with Sri Lanka emblem
            Paragraph header = new Paragraph("DEMOCRATIC SOCIALIST REPUBLIC OF SRI LANKA")
                .setFont(titleFont)
                .setFontSize(10)
                .setTextAlignment(TextAlignment.CENTER)
                .setBold()
                .setMarginBottom(10);
            document.add(header);

            Paragraph passportTitle = new Paragraph("PASSPORT")
                .setFont(titleFont)
                .setFontSize(14)
                .setTextAlignment(TextAlignment.CENTER)
                .setBold()
                .setMarginBottom(15);
            document.add(passportTitle);

            // Create main table for passport layout
            Table passportTable = new Table(2).setWidth(UnitValue.createPercentValue(100));

            // Left side - Photo placeholder
            Cell photoCell = new Cell();
            photoCell.setWidth(UnitValue.createPercentValue(30));
            
            // Add photo placeholder (you can replace this with actual photo loading)
            Paragraph photoPlaceholder = new Paragraph("[PHOTO]")
                .setFont(dataFont)
                .setFontSize(8)
                .setTextAlignment(TextAlignment.CENTER)
                .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                .setPadding(20);
            photoCell.add(photoPlaceholder);
            passportTable.addCell(photoCell);

            // Right side - Personal information
            Cell infoCell = new Cell();
            infoCell.setWidth(UnitValue.createPercentValue(70));
            
            // Personal details table
            Table detailsTable = new Table(2).setWidth(UnitValue.createPercentValue(100));
            
            // Name
            addDetailRow(detailsTable, "Name:", appData.getFirstName() + " " + appData.getLastName(), headerFont, dataFont);
            
            // NIC
            addDetailRow(detailsTable, "NIC No:", appData.getNicNumber(), headerFont, dataFont);
            
            // Date of Birth
            String dob = appData.getDateOfBirth() != null ? 
                new SimpleDateFormat("dd MMM yyyy").format(appData.getDateOfBirth()) : "N/A";
            addDetailRow(detailsTable, "Date of Birth:", dob, headerFont, dataFont);
            
            // Address
            String fullAddress = appData.getCurrentAddress() + ", " + appData.getCity();
            if (appData.getPostalCode() != null && !appData.getPostalCode().isEmpty()) {
                fullAddress += ", " + appData.getPostalCode();
            }
            addDetailRow(detailsTable, "Address:", fullAddress, headerFont, dataFont);
            
            // Passport Type
            addDetailRow(detailsTable, "Type:", appData.getProcessingType().toUpperCase(), headerFont, dataFont);
            
            // Issue Date
            String issueDate = appData.getFinalReviewedAt() != null ? 
                new SimpleDateFormat("dd MMM yyyy").format(appData.getFinalReviewedAt()) : "N/A";
            addDetailRow(detailsTable, "Issued:", issueDate, headerFont, dataFont);
            
            // Passport Number (using application ID)
            addDetailRow(detailsTable, "Passport No:", "SL" + String.format("%08d", appData.getApplicationId()), headerFont, dataFont);

            infoCell.add(detailsTable);
            passportTable.addCell(infoCell);

            document.add(passportTable);

            // Footer
            Paragraph footer = new Paragraph("This passport remains the property of the Government of Sri Lanka")
                .setFont(dataFont)
                .setFontSize(6)
                .setTextAlignment(TextAlignment.CENTER)
                .setMarginTop(10);
            document.add(footer);

            // Signature line
            Paragraph signature = new Paragraph("Signature of Holder: _________________")
                .setFont(dataFont)
                .setFontSize(7)
                .setMarginTop(15);
            document.add(signature);

        } finally {
            document.close();
        }

        return baos.toByteArray();
    }

    private void addDetailRow(Table table, String label, String value, PdfFont headerFont, PdfFont dataFont) {
        Cell labelCell = new Cell().add(new Paragraph(label).setFont(headerFont).setFontSize(7).setBold());
        Cell valueCell = new Cell().add(new Paragraph(value != null ? value : "N/A").setFont(dataFont).setFontSize(7));
        
        table.addCell(labelCell);
        table.addCell(valueCell);
    }

    // Inner class to hold application data
    private static class ApplicationData {
        private final int applicationId;
        private final String firstName;
        private final String lastName;
        private final String nicNumber;
        private final String email;
        private final Date dateOfBirth;
        private final String currentAddress;
        private final String city;
        private final String postalCode;
        private final String processingType;
        private final Date finalReviewedAt;

        public ApplicationData(int applicationId, String firstName, String lastName, String nicNumber,
                             String email, Date dateOfBirth, String currentAddress, String city,
                             String postalCode, String processingType, Date finalReviewedAt) {
            this.applicationId = applicationId;
            this.firstName = firstName;
            this.lastName = lastName;
            this.nicNumber = nicNumber;
            this.email = email;
            this.dateOfBirth = dateOfBirth;
            this.currentAddress = currentAddress;
            this.city = city;
            this.postalCode = postalCode;
            this.processingType = processingType;
            this.finalReviewedAt = finalReviewedAt;
        }

        // Getters
        public int getApplicationId() { return applicationId; }
        public String getFirstName() { return firstName; }
        public String getLastName() { return lastName; }
        public String getNicNumber() { return nicNumber; }
        public String getEmail() { return email; }
        public Date getDateOfBirth() { return dateOfBirth; }
        public String getCurrentAddress() { return currentAddress; }
        public String getCity() { return city; }
        public String getPostalCode() { return postalCode; }
        public String getProcessingType() { return processingType; }
        public Date getFinalReviewedAt() { return finalReviewedAt; }
    }
}
