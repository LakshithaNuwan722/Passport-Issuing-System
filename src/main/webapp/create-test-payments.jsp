<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Test Payment Data</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding: 20px; background: #f5f5f5; }
        .container { background: white; padding: 30px; border-radius: 10px; max-width: 800px; margin: 0 auto; }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🛠️ Create Test Payment Data</h1>
        
<%
    String action = request.getParameter("action");
    
    if ("create".equals(action)) {
        try (Connection conn = Database.getConnection()) {
            // First, check if we have applications
            int appCount = 0;
            String checkAppSql = "SELECT COUNT(*) as cnt FROM applications";
            try (PreparedStatement stmt = conn.prepareStatement(checkAppSql);
                 ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    appCount = rs.getInt("cnt");
                }
            }
            
            out.println("<div class='alert alert-info'>Found " + appCount + " applications in database</div>");
            
            // If no applications, create one
            int applicationId = 1;
            if (appCount == 0) {
                String insertAppSql = "INSERT INTO applications " +
                    "(first_name, last_name, email, nic, date_of_birth, gender, " +
                    "address, phone, passport_type, urgency, payment_status, " +
                    "application_status, created_at, updated_at) VALUES " +
                    "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
                    
                try (PreparedStatement stmt = conn.prepareStatement(insertAppSql, Statement.RETURN_GENERATED_KEYS)) {
                    stmt.setString(1, "John");
                    stmt.setString(2, "Doe");
                    stmt.setString(3, "john.doe@example.com");
                    stmt.setString(4, "123456789V");
                    stmt.setString(5, "1990-01-01");
                    stmt.setString(6, "M");
                    stmt.setString(7, "123 Main Street, Colombo");
                    stmt.setString(8, "0771234567");
                    stmt.setString(9, "standard");
                    stmt.setString(10, "normal");
                    stmt.setString(11, "unpaid");
                    stmt.setString(12, "pending");
                    
                    stmt.executeUpdate();
                    
                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            applicationId = rs.getInt(1);
                        }
                    }
                }
                out.println("<div class='alert alert-success'>✅ Created test application with ID: " + applicationId + "</div>");
            } else {
                // Get first application ID
                String getAppIdSql = "SELECT application_id FROM applications LIMIT 1";
                try (PreparedStatement stmt = conn.prepareStatement(getAppIdSql);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        applicationId = rs.getInt("application_id");
                    }
                }
                out.println("<div class='alert alert-info'>Using existing application ID: " + applicationId + "</div>");
            }
            
            // Check existing payments
            String checkPaymentSql = "SELECT COUNT(*) as cnt FROM payment_transactions WHERE payment_method = 'bank_transfer'";
            int paymentCount = 0;
            try (PreparedStatement stmt = conn.prepareStatement(checkPaymentSql);
                 ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    paymentCount = rs.getInt("cnt");
                }
            }
            
            out.println("<div class='alert alert-info'>Found " + paymentCount + " existing bank transfer payments</div>");
            
            // Create test payments
            String insertPaymentSql = "INSERT INTO payment_transactions " +
                "(application_id, payment_method, processing_type, total_amount, " +
                "processing_fee, service_fee, tax_amount, transaction_status, " +
                "payment_reference, transaction_date) VALUES " +
                "(?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
            
            int created = 0;
            
            // Create 3 pending payments
            for (int i = 1; i <= 3; i++) {
                try (PreparedStatement stmt = conn.prepareStatement(insertPaymentSql)) {
                    stmt.setInt(1, applicationId);
                    stmt.setString(2, "bank_transfer");
                    stmt.setString(3, i == 1 ? "regular" : (i == 2 ? "urgent" : "express"));
                    stmt.setDouble(4, 5000.00 + (i * 1000));
                    stmt.setDouble(5, 4000.00 + (i * 1000));
                    stmt.setDouble(6, 500.00);
                    stmt.setDouble(7, 500.00);
                    stmt.setString(8, "pending");
                    stmt.setString(9, "PAY-TEST-PENDING-" + System.currentTimeMillis() + "-" + i);
                    
                    stmt.executeUpdate();
                    created++;
                }
            }
            
            // Create 1 completed payment
            try (PreparedStatement stmt = conn.prepareStatement(insertPaymentSql)) {
                stmt.setInt(1, applicationId);
                stmt.setString(2, "bank_transfer");
                stmt.setString(3, "regular");
                stmt.setDouble(4, 5000.00);
                stmt.setDouble(5, 4000.00);
                stmt.setDouble(6, 500.00);
                stmt.setDouble(7, 500.00);
                stmt.setString(8, "completed");
                stmt.setString(9, "PAY-TEST-COMPLETED-" + System.currentTimeMillis());
                
                stmt.executeUpdate();
                created++;
            }
            
            // Create 1 failed/rejected payment
            try (PreparedStatement stmt = conn.prepareStatement(insertPaymentSql)) {
                stmt.setInt(1, applicationId);
                stmt.setString(2, "bank_transfer");
                stmt.setString(3, "regular");
                stmt.setDouble(4, 5000.00);
                stmt.setDouble(5, 4000.00);
                stmt.setDouble(6, 500.00);
                stmt.setDouble(7, 500.00);
                stmt.setString(8, "failed");
                stmt.setString(9, "PAY-TEST-REJECTED-" + System.currentTimeMillis());
                
                stmt.executeUpdate();
                created++;
            }
            
            out.println("<div class='alert alert-success'>");
            out.println("<h4>✅ SUCCESS!</h4>");
            out.println("<p>Created <strong>" + created + "</strong> test payment records:</p>");
            out.println("<ul>");
            out.println("<li>3 Pending payments (ready for approval)</li>");
            out.println("<li>1 Completed payment (approved)</li>");
            out.println("<li>1 Failed payment (rejected)</li>");
            out.println("</ul>");
            out.println("</div>");
            
            // Show the data
            String selectSql = "SELECT pt.*, a.first_name, a.last_name " +
                "FROM payment_transactions pt " +
                "JOIN applications a ON pt.application_id = a.application_id " +
                "WHERE pt.payment_method = 'bank_transfer' " +
                "ORDER BY pt.transaction_date DESC LIMIT 10";
                
            out.println("<h4>📋 Recent Payment Records:</h4>");
            out.println("<table class='table table-bordered'>");
            out.println("<tr><th>Trans ID</th><th>App ID</th><th>Name</th><th>Amount</th><th>Reference</th><th>Status</th></tr>");
            
            try (PreparedStatement stmt = conn.prepareStatement(selectSql);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String statusColor = "";
                    String status = rs.getString("transaction_status");
                    if ("pending".equals(status)) statusColor = "background: #fff3cd;";
                    else if ("completed".equals(status)) statusColor = "background: #d4edda;";
                    else if ("failed".equals(status)) statusColor = "background: #f8d7da;";
                    
                    out.println("<tr style='" + statusColor + "'>");
                    out.println("<td>" + rs.getInt("transaction_id") + "</td>");
                    out.println("<td>" + rs.getInt("application_id") + "</td>");
                    out.println("<td>" + rs.getString("first_name") + " " + rs.getString("last_name") + "</td>");
                    out.println("<td>LKR " + String.format("%.2f", rs.getDouble("total_amount")) + "</td>");
                    out.println("<td>" + rs.getString("payment_reference") + "</td>");
                    out.println("<td><strong>" + status.toUpperCase() + "</strong></td>");
                    out.println("</tr>");
                }
            }
            out.println("</table>");
            
            out.println("<div class='alert alert-success mt-4'>");
            out.println("<h4>🎉 All Done! Now you can:</h4>");
            out.println("<ol>");
            out.println("<li><a href='test-approval-debug.jsp' class='btn btn-primary'>Re-run Debug Tests</a></li>");
            out.println("<li><a href='payment-approval-fixed.jsp' class='btn btn-success'>Open Payment Approval Page</a></li>");
            out.println("<li><a href='payment-approval.jsp' class='btn btn-info'>Open Original Payment Approval Page</a></li>");
            out.println("</ol>");
            out.println("</div>");
            
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger'>");
            out.println("<h4>❌ Database Error</h4>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("<pre>" + e.toString() + "</pre>");
            out.println("</div>");
            e.printStackTrace();
        }
    } else {
%>
        <div class="alert alert-warning">
            <h4>⚠️ No Payment Data Found</h4>
            <p>The payment approval system needs test data to work properly.</p>
            <p>Click the button below to automatically create:</p>
            <ul>
                <li><strong>3 Pending Payments</strong> - Ready for approval/rejection</li>
                <li><strong>1 Completed Payment</strong> - Approved payment example</li>
                <li><strong>1 Failed Payment</strong> - Rejected payment example</li>
            </ul>
        </div>
        
        <form method="post">
            <input type="hidden" name="action" value="create">
            <button type="submit" class="btn btn-primary btn-lg">
                <i class="fas fa-database"></i> Create Test Payment Data
            </button>
        </form>
        
        <hr>
        
        <h4>📊 Current Database Status:</h4>
        <%
            try (Connection conn = Database.getConnection()) {
                String sql = "SELECT " +
                    "(SELECT COUNT(*) FROM applications) as app_count, " +
                    "(SELECT COUNT(*) FROM payment_transactions) as payment_count, " +
                    "(SELECT COUNT(*) FROM payment_transactions WHERE payment_method = 'bank_transfer') as bank_count, " +
                    "(SELECT COUNT(*) FROM payment_transactions WHERE payment_method = 'bank_transfer' AND transaction_status = 'pending') as pending_count";
                
                try (PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        out.println("<table class='table table-bordered'>");
                        out.println("<tr><th>Metric</th><th>Count</th></tr>");
                        out.println("<tr><td>Total Applications</td><td>" + rs.getInt("app_count") + "</td></tr>");
                        out.println("<tr><td>Total Payments</td><td>" + rs.getInt("payment_count") + "</td></tr>");
                        out.println("<tr><td>Bank Transfer Payments</td><td>" + rs.getInt("bank_count") + "</td></tr>");
                        out.println("<tr><td>Pending Bank Transfers</td><td><strong>" + rs.getInt("pending_count") + "</strong></td></tr>");
                        out.println("</table>");
                    }
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            }
        %>
<%
    }
%>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

