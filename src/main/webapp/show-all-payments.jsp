<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Show ALL Payments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="padding: 20px;">
    <h1>🔍 ALL PAYMENT TRANSACTIONS IN DATABASE</h1>
    
    <div class="alert alert-info">
        <strong>This page shows EXACTLY what's in your payment_transactions table</strong>
    </div>
    
    <%
        try (Connection conn = Database.getConnection()) {
            // Count total records
            String countSql = "SELECT COUNT(*) as total FROM payment_transactions";
            int totalCount = 0;
            try (PreparedStatement stmt = conn.prepareStatement(countSql);
                 ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalCount = rs.getInt("total");
                }
            }
            
            out.println("<h2>Total Records: " + totalCount + "</h2>");
            
            if (totalCount == 0) {
                out.println("<div class='alert alert-danger'>");
                out.println("<h3>❌ NO DATA IN payment_transactions TABLE!</h3>");
                out.println("<p>Your table is empty. You need to insert payment data.</p>");
                out.println("</div>");
            } else {
                // Show ALL payments
                String sql = "SELECT * FROM payment_transactions ORDER BY transaction_date DESC";
                
                out.println("<table class='table table-bordered table-striped'>");
                out.println("<thead class='table-dark'>");
                out.println("<tr>");
                out.println("<th>Trans ID</th>");
                out.println("<th>App ID</th>");
                out.println("<th>Payment Method</th>");
                out.println("<th>Status</th>");
                out.println("<th>Amount</th>");
                out.println("<th>Reference</th>");
                out.println("<th>Date</th>");
                out.println("</tr>");
                out.println("</thead>");
                out.println("<tbody>");
                
                try (PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    
                    int count = 0;
                    while (rs.next()) {
                        count++;
                        String status = rs.getString("transaction_status");
                        String rowColor = "";
                        if ("pending".equals(status)) rowColor = "table-warning";
                        else if ("completed".equals(status)) rowColor = "table-success";
                        else if ("failed".equals(status)) rowColor = "table-danger";
                        
                        out.println("<tr class='" + rowColor + "'>");
                        out.println("<td>" + rs.getInt("transaction_id") + "</td>");
                        out.println("<td>" + rs.getInt("application_id") + "</td>");
                        out.println("<td>" + rs.getString("payment_method") + "</td>");
                        out.println("<td><strong>" + status + "</strong></td>");
                        out.println("<td>LKR " + String.format("%.2f", rs.getDouble("total_amount")) + "</td>");
                        out.println("<td>" + rs.getString("payment_reference") + "</td>");
                        out.println("<td>" + rs.getTimestamp("transaction_date") + "</td>");
                        out.println("</tr>");
                    }
                    
                    out.println("</tbody>");
                    out.println("</table>");
                    
                    out.println("<div class='alert alert-success'>");
                    out.println("<h4>✅ Found " + count + " payment records!</h4>");
                    out.println("</div>");
                }
                
                // Check applications table
                String appCountSql = "SELECT COUNT(*) as total FROM applications";
                int appCount = 0;
                try (PreparedStatement stmt = conn.prepareStatement(appCountSql);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        appCount = rs.getInt("total");
                    }
                }
                
                out.println("<h3>Applications Table: " + appCount + " records</h3>");
                
                // Test the JOIN
                String joinTestSql = "SELECT COUNT(*) as total FROM payment_transactions pt " +
                    "LEFT JOIN applications a ON pt.application_id = a.application_id";
                int joinCount = 0;
                try (PreparedStatement stmt = conn.prepareStatement(joinTestSql);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        joinCount = rs.getInt("total");
                    }
                }
                
                out.println("<div class='alert alert-info'>");
                out.println("<h4>JOIN Test:</h4>");
                out.println("<p>Payment transactions with LEFT JOIN applications: " + joinCount + " records</p>");
                if (joinCount < totalCount) {
                    out.println("<p class='text-danger'><strong>⚠️ Warning: Some payments don't have matching applications!</strong></p>");
                    out.println("<p>This could cause INNER JOIN to fail. Using LEFT JOIN instead.</p>");
                }
                out.println("</div>");
            }
            
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger'>");
            out.println("<h3>❌ DATABASE ERROR</h3>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
            out.println("</div>");
        }
    %>
    
    <hr>
    <h3>Next Steps:</h3>
    <a href="test-approval-debug.jsp" class="btn btn-primary">Test Servlet</a>
    <a href="payment-approval-fixed.jsp" class="btn btn-success">Open Payment Approval Page</a>
</body>
</html>

