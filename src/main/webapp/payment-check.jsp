<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<%
    // Get application ID from request
    String applicationIdStr = request.getParameter("applicationId");
    int applicationId = 0;
    String applicationStatus = "Not Found";
    String paymentStatus = "Not Found";
    String applicantName = "Unknown";
    String applicantEmail = "";
    String processingType = "regular";
    boolean applicationExists = false;
    boolean hasPayment = false;
    String lastPaymentDate = "";
    String lastTransactionId = "";
    
    if (applicationIdStr != null && !applicationIdStr.trim().isEmpty()) {
        try {
            applicationId = Integer.parseInt(applicationIdStr);
            
            // Load application and payment details
            try (Connection conn = Database.getConnection()) {
                // Check application details
                String applicationSql = "SELECT first_name, last_name, email, processing_type, application_status, payment_status FROM applications WHERE application_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(applicationSql)) {
                    stmt.setInt(1, applicationId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            applicationExists = true;
                            String firstName = rs.getString("first_name");
                            String lastName = rs.getString("last_name");
                            applicantName = (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : "");
                            applicantEmail = rs.getString("email");
                            processingType = rs.getString("processing_type");
                            applicationStatus = rs.getString("application_status");
                            paymentStatus = rs.getString("payment_status");
                        }
                    }
                }
                
                // Check payment details
                if (applicationExists) {
                    String paymentSql = "SELECT transaction_id, transaction_date FROM payment_transactions WHERE application_id = ? ORDER BY transaction_date DESC LIMIT 1";
                    try (PreparedStatement stmt = conn.prepareStatement(paymentSql)) {
                        stmt.setInt(1, applicationId);
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                hasPayment = true;
                                lastTransactionId = rs.getString("transaction_id");
                                lastPaymentDate = rs.getString("transaction_date");
                            }
                        }
                    }
                }
            } catch (SQLException e) {
                System.err.println("Error loading application details: " + e.getMessage());
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
    <title>Payment Diagnostic Tool - Passport Issuing System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .diagnostic-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .diagnostic-header {
            background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 2rem;
            text-align: center;
        }
        
        .diagnostic-content {
            padding: 2rem;
        }
        
        .status-card {
            border-radius: 15px;
            padding: 1.5rem;
            margin: 1rem 0;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        
        .status-success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            border: 2px solid #28a745;
        }
        
        .status-warning {
            background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
            border: 2px solid #ffc107;
        }
        
        .status-danger {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            border: 2px solid #dc3545;
        }
        
        .status-info {
            background: linear-gradient(135deg, #d1ecf1 0%, #bee5eb 100%);
            border: 2px solid #17a2b8;
        }
        
        .btn-test {
            background: linear-gradient(135deg, #6f42c1 0%, #e83e8c 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 25px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
        }
        
        .btn-test:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(111, 66, 193, 0.3);
            color: white;
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
        
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #6f42c1;
            box-shadow: 0 0 0 0.2rem rgba(111, 66, 193, 0.25);
        }
        
        .alert {
            border-radius: 10px;
            border: none;
        }
        
        .test-result {
            display: none;
            margin-top: 1rem;
            padding: 1rem;
            border-radius: 10px;
        }
        
        .test-result.show {
            display: block;
        }
        
        .test-success {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .test-error {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="diagnostic-container" data-aos="fade-up">
                    <div class="diagnostic-header">
                        <h1 class="mb-3">
                            <i class="fas fa-stethoscope me-3"></i>
                            Payment Diagnostic Tool
                        </h1>
                        <p class="mb-0">Check application status and test payment processing</p>
                    </div>
                    
                    <div class="diagnostic-content">
                        <!-- Application ID Input -->
                        <div class="card mb-4">
                            <div class="card-header bg-light">
                                <h5 class="mb-0">
                                    <i class="fas fa-search me-2"></i>
                                    Check Application
                                </h5>
                            </div>
                            <div class="card-body">
                                <form method="GET" class="row g-3">
                                    <div class="col-md-8">
                                        <label class="form-label">Application ID</label>
                                        <input type="number" class="form-control" name="applicationId" 
                                               value="<%= applicationIdStr != null ? applicationIdStr : "" %>" 
                                               placeholder="Enter Application ID to check">
                                    </div>
                                    <div class="col-md-4 d-flex align-items-end">
                                        <button type="submit" class="btn btn-test w-100">
                                            <i class="fas fa-search me-2"></i>
                                            Check Status
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        <% if (applicationIdStr != null) { %>
                        <!-- Application Status -->
                        <div class="status-card <%= applicationExists ? "status-info" : "status-danger" %>">
                            <h5 class="mb-3">
                                <i class="fas fa-file-alt me-2"></i>
                                Application Status
                            </h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Application ID:</strong> <%= applicationId %></p>
                                    <p><strong>Exists:</strong> 
                                        <span class="badge <%= applicationExists ? "bg-success" : "bg-danger" %>">
                                            <%= applicationExists ? "Yes" : "No" %>
                                        </span>
                                    </p>
                                    <% if (applicationExists) { %>
                                    <p><strong>Applicant:</strong> <%= applicantName %></p>
                                    <p><strong>Email:</strong> <%= applicantEmail %></p>
                                    <% } %>
                                </div>
                                <div class="col-md-6">
                                    <% if (applicationExists) { %>
                                    <p><strong>Processing Type:</strong> <%= processingType.toUpperCase() %></p>
                                    <p><strong>Application Status:</strong> 
                                        <span class="badge bg-info"><%= applicationStatus %></span>
                                    </p>
                                    <p><strong>Payment Status:</strong> 
                                        <span class="badge <%= paymentStatus.equals("paid") ? "bg-success" : "bg-warning" %>">
                                            <%= paymentStatus %>
                                        </span>
                                    </p>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Payment Status -->
                        <div class="status-card <%= hasPayment ? "status-success" : "status-warning" %>">
                            <h5 class="mb-3">
                                <i class="fas fa-credit-card me-2"></i>
                                Payment Status
                            </h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Has Payment:</strong> 
                                        <span class="badge <%= hasPayment ? "bg-success" : "bg-warning" %>">
                                            <%= hasPayment ? "Yes" : "No" %>
                                        </span>
                                    </p>
                                    <% if (hasPayment) { %>
                                    <p><strong>Last Transaction ID:</strong> <%= lastTransactionId %></p>
                                    <% } %>
                                </div>
                                <div class="col-md-6">
                                    <% if (hasPayment) { %>
                                    <p><strong>Last Payment Date:</strong> <%= lastPaymentDate %></p>
                                    <% } else { %>
                                    <p><strong>Status:</strong> No payment found</p>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Test Payment -->
                        <% if (applicationExists && !hasPayment) { %>
                        <div class="status-card status-info">
                            <h5 class="mb-3">
                                <i class="fas fa-flask me-2"></i>
                                Test Payment Processing
                            </h5>
                            <p>This application exists and has no payment. You can test the payment system:</p>
                            <div class="text-center">
                                <a href="fresh-payment.jsp?applicationId=<%= applicationId %>" class="btn btn-success btn-lg me-3">
                                    <i class="fas fa-credit-card me-2"></i>
                                    Test Payment Page
                                </a>
                                <button onclick="testPaymentAPI()" class="btn btn-test btn-lg">
                                    <i class="fas fa-play me-2"></i>
                                    Test API Directly
                                </button>
                            </div>
                            <div id="testResult" class="test-result"></div>
                        </div>
                        <% } else if (applicationExists && hasPayment) { %>
                        <div class="status-card status-success">
                            <h5 class="mb-3">
                                <i class="fas fa-check-circle me-2"></i>
                                Payment Already Completed
                            </h5>
                            <p>This application already has a completed payment. You can view the payment details:</p>
                            <div class="text-center">
                                <a href="fresh-payment-success.jsp?transactionId=<%= lastTransactionId %>&applicationId=<%= applicationId %>" class="btn btn-success btn-lg">
                                    <i class="fas fa-receipt me-2"></i>
                                    View Payment Receipt
                                </a>
                            </div>
                        </div>
                        <% } else { %>
                        <div class="status-card status-danger">
                            <h5 class="mb-3">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                Application Not Found
                            </h5>
                            <p>No application found with ID <%= applicationId %>. Please check the Application ID and try again.</p>
                        </div>
                        <% } %>
                        <% } %>
                        
                        <!-- Quick Actions -->
                        <div class="card mt-4">
                            <div class="card-header bg-light">
                                <h5 class="mb-0">
                                    <i class="fas fa-bolt me-2"></i>
                                    Quick Actions
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 text-center">
                                        <a href="applications.jsp" class="btn btn-outline-primary btn-lg w-100">
                                            <i class="fas fa-list me-2"></i>
                                            View Applications
                                        </a>
                                    </div>
                                    <div class="col-md-4 text-center">
                                        <a href="fresh-payment.jsp" class="btn btn-outline-success btn-lg w-100">
                                            <i class="fas fa-credit-card me-2"></i>
                                            Payment Gateway
                                        </a>
                                    </div>
                                    <div class="col-md-4 text-center">
                                        <a href="index.jsp" class="btn btn-outline-secondary btn-lg w-100">
                                            <i class="fas fa-home me-2"></i>
                                            Home
                                        </a>
                                    </div>
                                </div>
                            </div>
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
        
        // Test payment API directly
        function testPaymentAPI() {
            const applicationId = <%= applicationId %>;
            const testResult = document.getElementById('testResult');
            
            testResult.innerHTML = '<div class="spinner-border text-primary" role="status"><span class="visually-hidden">Testing...</span></div> Testing payment API...';
            testResult.className = 'test-result show';
            
            const paymentData = {
                applicationId: applicationId,
                paymentMethod: 'credit_card',
                processingType: 'regular',
                totalAmount: '17000',
                processingFee: '15000',
                serviceFee: '2000',
                taxAmount: '0'
            };
            
            fetch('/FreshPayment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams(paymentData)
            })
            .then(response => response.text())
            .then(text => {
                console.log('Test response:', text);
                try {
                    const data = JSON.parse(text);
                    if (data.success) {
                        testResult.innerHTML = `
                            <div class="alert alert-success">
                                <h6><i class="fas fa-check-circle me-2"></i>Payment Test Successful!</h6>
                                <p class="mb-0">Transaction ID: ${data.transactionId}</p>
                                <p class="mb-0">Amount: LKR ${data.totalAmount}</p>
                            </div>
                        `;
                        testResult.className = 'test-result show test-success';
                    } else {
                        testResult.innerHTML = `
                            <div class="alert alert-danger">
                                <h6><i class="fas fa-exclamation-circle me-2"></i>Payment Test Failed</h6>
                                <p class="mb-0">Error: ${data.message}</p>
                            </div>
                        `;
                        testResult.className = 'test-result show test-error';
                    }
                } catch (e) {
                    testResult.innerHTML = `
                        <div class="alert alert-danger">
                            <h6><i class="fas fa-exclamation-circle me-2"></i>Invalid Response</h6>
                            <p class="mb-0">Response: ${text.substring(0, 200)}</p>
                        </div>
                    `;
                    testResult.className = 'test-result show test-error';
                }
            })
            .catch(error => {
                console.error('Test error:', error);
                testResult.innerHTML = `
                    <div class="alert alert-danger">
                        <h6><i class="fas fa-exclamation-circle me-2"></i>Test Error</h6>
                        <p class="mb-0">Error: ${error.message}</p>
                    </div>
                `;
                testResult.className = 'test-result show test-error';
            });
        }
    </script>
</body>
</html>
