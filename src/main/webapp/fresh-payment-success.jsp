<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<%
    // Get transaction details from request
    String transactionId = request.getParameter("transactionId");
    String applicationIdStr = request.getParameter("applicationId");
    
    // Initialize variables
    String applicantName = "Unknown";
    String applicantEmail = "";
    String processingType = "regular";
    double totalAmount = 0;
    double processingFee = 0;
    double serviceFee = 0;
    double taxAmount = 0;
    String paymentMethod = "credit_card";
    String transactionDate = "";
    
    if (transactionId != null && applicationIdStr != null) {
        try {
            int applicationId = Integer.parseInt(applicationIdStr);
            
            // Load transaction and application details
            try (Connection conn = Database.getConnection()) {
                // Get transaction details
                String transactionSql = "SELECT * FROM payment_transactions WHERE transaction_id = ? AND application_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(transactionSql)) {
                    stmt.setString(1, transactionId);
                    stmt.setInt(2, applicationId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            totalAmount = rs.getDouble("total_amount");
                            processingFee = rs.getDouble("processing_fee");
                            serviceFee = rs.getDouble("service_fee");
                            taxAmount = rs.getDouble("tax_amount");
                            paymentMethod = rs.getString("payment_method");
                            processingType = rs.getString("processing_type");
                            transactionDate = rs.getString("transaction_date");
                        }
                    }
                }
                
                // Get application details
                String applicationSql = "SELECT first_name, last_name, email FROM applications WHERE application_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(applicationSql)) {
                    stmt.setInt(1, applicationId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            String firstName = rs.getString("first_name");
                            String lastName = rs.getString("last_name");
                            applicantName = (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : "");
                            applicantEmail = rs.getString("email");
                        }
                    }
                }
            } catch (SQLException e) {
                System.err.println("Error loading transaction details: " + e.getMessage());
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid application ID: " + applicationIdStr);
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Success - Passport Issuing System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .success-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .success-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 2rem;
            text-align: center;
        }
        
        .success-content {
            padding: 2rem;
        }
        
        .success-icon {
            font-size: 4rem;
            color: #28a745;
            margin-bottom: 1rem;
            animation: bounce 2s infinite;
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }
        
        .receipt-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 15px;
            padding: 1.5rem;
            margin: 1rem 0;
            border: 2px solid #28a745;
        }
        
        .receipt-item {
            display: flex;
            justify-content: space-between;
            margin: 0.5rem 0;
            padding: 0.5rem 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .receipt-item:last-child {
            border-bottom: none;
            font-weight: bold;
            font-size: 1.2rem;
            color: #28a745;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(40, 167, 69, 0.3);
        }
        
        .btn-outline-success {
            border: 2px solid #28a745;
            border-radius: 10px;
            padding: 12px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-outline-success:hover {
            background-color: #28a745;
            transform: translateY(-2px);
        }
        
        .transaction-details {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin: 1rem 0;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin: 0.5rem 0;
            padding: 0.5rem 0;
        }
        
        .detail-label {
            font-weight: 600;
            color: #6c757d;
        }
        
        .detail-value {
            color: #495057;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="success-container" data-aos="fade-up">
                    <div class="success-header">
                        <div class="success-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <h1 class="mb-3">Payment Successful!</h1>
                        <p class="mb-0">Your payment has been processed successfully</p>
                    </div>
                    
                    <div class="success-content">
                        <!-- Transaction Details -->
                        <div class="transaction-details">
                            <h4 class="mb-3">
                                <i class="fas fa-receipt me-2"></i>
                                Transaction Details
                            </h4>
                            <div class="detail-row">
                                <span class="detail-label">Transaction ID:</span>
                                <span class="detail-value"><%= transactionId != null ? transactionId : "N/A" %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Application ID:</span>
                                <span class="detail-value"><%= applicationIdStr != null ? applicationIdStr : "N/A" %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Payment Method:</span>
                                <span class="detail-value"><%= paymentMethod.toUpperCase() %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Processing Type:</span>
                                <span class="detail-value"><%= processingType.toUpperCase() %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">Transaction Date:</span>
                                <span class="detail-value"><%= transactionDate != null ? transactionDate : "N/A" %></span>
                            </div>
                        </div>
                        
                        <!-- Payment Receipt -->
                        <div class="receipt-card">
                            <h4 class="mb-3">
                                <i class="fas fa-file-invoice me-2"></i>
                                Payment Receipt
                            </h4>
                            <div class="receipt-item">
                                <span>Applicant Name:</span>
                                <span><%= applicantName %></span>
                            </div>
                            <div class="receipt-item">
                                <span>Email:</span>
                                <span><%= applicantEmail %></span>
                            </div>
                            <div class="receipt-item">
                                <span>Processing Fee:</span>
                                <span>LKR <%= String.format("%,.2f", processingFee) %></span>
                            </div>
                            <div class="receipt-item">
                                <span>Service Fee:</span>
                                <span>LKR <%= String.format("%,.2f", serviceFee) %></span>
                            </div>
                            <div class="receipt-item">
                                <span>Tax:</span>
                                <span>LKR <%= String.format("%,.2f", taxAmount) %></span>
                            </div>
                            <div class="receipt-item">
                                <span>Total Amount:</span>
                                <span>LKR <%= String.format("%,.2f", totalAmount) %></span>
                            </div>
                        </div>
                        
                        <!-- Next Steps -->
                        <div class="alert alert-info" role="alert">
                            <h5 class="alert-heading">
                                <i class="fas fa-info-circle me-2"></i>
                                What's Next?
                            </h5>
                            <p class="mb-2">Your payment has been processed successfully. Here's what happens next:</p>
                            <ul class="mb-0">
                                <li>Your application status will be updated to "Paid"</li>
                                <li>You will receive a confirmation email at <%= applicantEmail %></li>
                                <li>Processing will begin according to your selected timeline</li>
                                <li>You can track your application status in the applications page</li>
                            </ul>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="text-center mt-4">
                            <a href="applications.jsp" class="btn btn-success btn-lg me-3">
                                <i class="fas fa-list me-2"></i>
                                View Applications
                            </a>
                            <button onclick="window.print()" class="btn btn-outline-success btn-lg me-3">
                                <i class="fas fa-print me-2"></i>
                                Print Receipt
                            </button>
                            <a href="index.jsp" class="btn btn-outline-secondary btn-lg">
                                <i class="fas fa-home me-2"></i>
                                Home
                            </a>
                        </div>
                        
                        <!-- Contact Information -->
                        <div class="text-center mt-4">
                            <small class="text-muted">
                                <i class="fas fa-phone me-1"></i>
                                Need help? Contact us at +94 11 123 4567 or 
                                <a href="mailto:support@passport.gov.lk" class="text-decoration-none">support@passport.gov.lk</a>
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        // Initialize AOS
        AOS.init({
            duration: 1000,
            once: true
        });
        
        // Auto-refresh page every 30 seconds to check for updates
        setTimeout(() => {
            location.reload();
        }, 30000);
    </script>
</body>
</html>
