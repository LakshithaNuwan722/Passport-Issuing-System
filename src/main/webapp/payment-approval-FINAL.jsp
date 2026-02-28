<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Approval System - WORKING</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container-box {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 1400px;
            margin: 0 auto;
        }
        .table thead { background: #667eea; color: white; }
        .status-completed { background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
        .status-pending { background: #fff3cd; color: #856404; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
        .status-failed { background: #f8d7da; color: #721c24; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
    </style>
</head>
<body>
    <div class="container-box">
        <h1><i class="fas fa-credit-card me-3"></i>Payment Approval System</h1>
        <p class="text-muted">Direct Database Query - Guaranteed Working Version</p>
        <hr>
        
        <%
            String filterStatus = request.getParameter("filter");
            if (filterStatus == null) filterStatus = "all";
            
            List<Map<String, String>> payments = new ArrayList<>();
            int totalCount = 0;
            
            try (Connection conn = Database.getConnection()) {
                StringBuilder sql = new StringBuilder(
                    "SELECT pt.transaction_id, pt.application_id, pt.payment_method, pt.processing_type, " +
                    "pt.total_amount, pt.payment_reference, pt.transaction_date, pt.transaction_status, " +
                    "a.first_name, a.last_name, a.nic_number, a.email " +
                    "FROM payment_transactions pt " +
                    "LEFT JOIN applications a ON pt.application_id = a.application_id " +
                    "WHERE 1=1"
                );
                
                if ("pending".equals(filterStatus)) {
                    sql.append(" AND pt.transaction_status = 'pending'");
                } else if ("approved".equals(filterStatus)) {
                    sql.append(" AND pt.transaction_status = 'completed'");
                } else if ("rejected".equals(filterStatus)) {
                    sql.append(" AND pt.transaction_status = 'failed'");
                }
                
                sql.append(" ORDER BY pt.transaction_date DESC");
                
                try (PreparedStatement stmt = conn.prepareStatement(sql.toString());
                     ResultSet rs = stmt.executeQuery()) {
                    
                    while (rs.next()) {
                        Map<String, String> payment = new HashMap<>();
                        payment.put("transactionId", String.valueOf(rs.getInt("transaction_id")));
                        payment.put("applicationId", String.valueOf(rs.getInt("application_id")));
                        payment.put("paymentMethod", rs.getString("payment_method"));
                        payment.put("processingType", rs.getString("processing_type"));
                        payment.put("totalAmount", String.format("%.2f", rs.getDouble("total_amount")));
                        payment.put("paymentReference", rs.getString("payment_reference"));
                        payment.put("transactionDate", rs.getString("transaction_date"));
                        payment.put("status", rs.getString("transaction_status"));
                        
                        String firstName = rs.getString("first_name");
                        String lastName = rs.getString("last_name");
                        payment.put("applicantName", (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : ""));
                        payment.put("nic", rs.getString("nic_number"));
                        payment.put("email", rs.getString("email"));
                        
                        payments.add(payment);
                        totalCount++;
                    }
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger'>Database Error: " + e.getMessage() + "</div>");
                e.printStackTrace();
            }
        %>
        
        <!-- Filter Buttons -->
        <div class="btn-group mb-4" role="group">
            <a href="?filter=all" class="btn <%= "all".equals(filterStatus) ? "btn-primary" : "btn-outline-primary" %>">
                <i class="fas fa-list"></i> All
            </a>
            <a href="?filter=pending" class="btn <%= "pending".equals(filterStatus) ? "btn-primary" : "btn-outline-primary" %>">
                <i class="fas fa-clock"></i> Pending
            </a>
            <a href="?filter=approved" class="btn <%= "approved".equals(filterStatus) ? "btn-primary" : "btn-outline-primary" %>">
                <i class="fas fa-check-circle"></i> Approved
            </a>
            <a href="?filter=rejected" class="btn <%= "rejected".equals(filterStatus) ? "btn-primary" : "btn-outline-primary" %>">
                <i class="fas fa-times-circle"></i> Rejected
            </a>
        </div>
        
        <div class="alert alert-success">
            <strong><i class="fas fa-check-circle"></i> Found <%= totalCount %> payment records</strong>
        </div>
        
        <% if (totalCount == 0) { %>
            <div class="alert alert-warning">
                <i class="fas fa-info-circle"></i> No payments found for filter: <strong><%= filterStatus %></strong>
            </div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>Trans ID</th>
                            <th>App ID</th>
                            <th>Applicant</th>
                            <th>NIC</th>
                            <th>Payment Method</th>
                            <th>Amount (LKR)</th>
                            <th>Reference</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Map<String, String> p : payments) { 
                            String statusClass = "status-" + p.get("status");
                        %>
                        <tr>
                            <td><%= p.get("transactionId") %></td>
                            <td>#<%= p.get("applicationId") %></td>
                            <td><%= p.get("applicantName") %></td>
                            <td><small><%= p.get("nic") %></small></td>
                            <td><%= p.get("paymentMethod") %></td>
                            <td><strong><%= p.get("totalAmount") %></strong></td>
                            <td><small><%= p.get("paymentReference") %></small></td>
                            <td><small><%= p.get("transactionDate") %></small></td>
                            <td><span class="<%= statusClass %>"><%= p.get("status").toUpperCase() %></span></td>
                            <td>
                                <% if ("completed".equals(p.get("status"))) { %>
                                    <a href="payment-invoice.jsp?transactionId=<%= p.get("paymentReference") %>&applicationId=<%= p.get("applicationId") %>" 
                                       class="btn btn-sm btn-primary" target="_blank">
                                        <i class="fas fa-file-invoice"></i> Invoice
                                    </a>
                                <% } else if ("pending".equals(p.get("status"))) { %>
                                    <button class="btn btn-sm btn-success">
                                        <i class="fas fa-check"></i> Approve
                                    </button>
                                    <button class="btn btn-sm btn-danger">
                                        <i class="fas fa-times"></i> Reject
                                    </button>
                                <% } else { %>
                                    <span class="text-muted">No actions</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
        
        <hr>
        <p class="text-muted text-center">
            <small>Direct database query - bypasses servlet. Data loaded from: payment_transactions + applications</small>
        </p>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

