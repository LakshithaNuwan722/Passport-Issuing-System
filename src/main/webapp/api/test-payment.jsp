<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Test</title>
</head>
<body>
    <h1>Payment Transaction Test</h1>
    
    <%
    try {
        // Test database connection
        out.println("<h2>Database Connection Test</h2>");
        Connection conn = Database.getConnection();
        out.println("✅ Database connection successful<br>");
        
        // Test inserting a payment transaction
        out.println("<h2>Payment Transaction Insert Test</h2>");
        
        String sql = "INSERT INTO payment_transactions " +
                    "(application_id, payment_method, processing_type, processing_fee, service_fee, " +
                    "tax_amount, total_amount, transaction_status, payment_reference, transaction_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, 70); // Use existing application ID
            stmt.setString(2, "credit_card");
            stmt.setString(3, "regular");
            stmt.setBigDecimal(4, new java.math.BigDecimal("5000.00"));
            stmt.setBigDecimal(5, new java.math.BigDecimal("2000.00"));
            stmt.setBigDecimal(6, new java.math.BigDecimal("0.00"));
            stmt.setBigDecimal(7, new java.math.BigDecimal("7000.00"));
            stmt.setString(8, "completed");
            stmt.setString(9, "TEST_TXN_12345");
            stmt.setTimestamp(10, new Timestamp(System.currentTimeMillis()));
            
            int rowsAffected = stmt.executeUpdate();
            out.println("Rows affected: " + rowsAffected + "<br>");
            
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int transactionDbId = generatedKeys.getInt(1);
                        out.println("✅ Transaction saved with ID: " + transactionDbId + "<br>");
                    }
                }
            } else {
                out.println("❌ No rows were inserted<br>");
            }
        }
        
        // Check if the transaction was actually saved
        out.println("<h2>Verification</h2>");
        String checkSql = "SELECT COUNT(*) as count FROM payment_transactions WHERE payment_reference = 'TEST_TXN_12345'";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql);
             ResultSet rs = checkStmt.executeQuery()) {
            if (rs.next()) {
                int count = rs.getInt("count");
                out.println("Transactions with reference 'TEST_TXN_12345': " + count + "<br>");
                if (count > 0) {
                    out.println("✅ Transaction was successfully saved to database<br>");
                } else {
                    out.println("❌ Transaction was not saved to database<br>");
                }
            }
        }
        
        // Show all payment transactions
        out.println("<h2>All Payment Transactions</h2>");
        String selectSql = "SELECT transaction_id, application_id, payment_method, total_amount, transaction_status, payment_reference FROM payment_transactions ORDER BY transaction_id DESC LIMIT 10";
        try (PreparedStatement selectStmt = conn.prepareStatement(selectSql);
             ResultSet rs = selectStmt.executeQuery()) {
            out.println("<table border='1'>");
            out.println("<tr><th>ID</th><th>App ID</th><th>Method</th><th>Amount</th><th>Status</th><th>Reference</th></tr>");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("transaction_id") + "</td>");
                out.println("<td>" + rs.getInt("application_id") + "</td>");
                out.println("<td>" + rs.getString("payment_method") + "</td>");
                out.println("<td>" + rs.getBigDecimal("total_amount") + "</td>");
                out.println("<td>" + rs.getString("transaction_status") + "</td>");
                out.println("<td>" + rs.getString("payment_reference") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        }
        
        conn.close();
        
    } catch (Exception e) {
        out.println("<h2>Error</h2>");
        out.println("❌ Error: " + e.getMessage() + "<br>");
        out.println("Error Type: " + e.getClass().getSimpleName() + "<br>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
    %>
    
    <h2>Test PaymentServlet</h2>
    <button onclick="testPaymentServlet()">Test PaymentServlet</button>
    <div id="result"></div>
    
    <script>
    function testPaymentServlet() {
        const formData = new FormData();
        formData.append('applicationId', '70');
        formData.append('paymentMethod', 'credit_card');
        formData.append('processingType', 'regular');
        formData.append('totalAmount', '7000');
        formData.append('processingFee', '5000');
        formData.append('serviceFee', '2000');
        formData.append('taxAmount', '0');
        formData.append('nicNumber', '200303711075'); // Use existing NIC
        
        fetch('api/payment', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            document.getElementById('result').innerHTML = 
                '<h3>PaymentServlet Response:</h3>' +
                '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
        })
        .catch(error => {
            document.getElementById('result').innerHTML = 
                '<h3>Error:</h3>' +
                '<pre>' + error.message + '</pre>';
        });
    }
    </script>
</body>
</html>