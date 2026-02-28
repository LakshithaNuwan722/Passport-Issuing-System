<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    // Get parameters
    String transactionIdParam = request.getParameter("transactionId");
    String applicationIdStr = request.getParameter("applicationId");
    
    // Initialize variables
    String paymentReference = "";
    int applicationId = 0;
    String applicantName = "N/A";
    String applicantEmail = "N/A";
    String applicantNic = "N/A";
    String processingType = "regular";
    double totalAmount = 0;
    double processingFee = 0;
    double serviceFee = 0;
    double taxAmount = 0;
    String paymentMethod = "N/A";
    String transactionDate = "";
    String transactionStatus = "pending";
    int transactionId = 0;
    
    boolean dataLoaded = false;
    
    if (transactionIdParam != null && applicationIdStr != null) {
        try {
            applicationId = Integer.parseInt(applicationIdStr);
            
            // Load transaction and application details
            try (Connection conn = Database.getConnection()) {
                // Get transaction details using payment_reference
                String transactionSql = "SELECT * FROM payment_transactions WHERE payment_reference = ? AND application_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(transactionSql)) {
                    stmt.setString(1, transactionIdParam);
                    stmt.setInt(2, applicationId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            transactionId = rs.getInt("transaction_id");
                            paymentReference = rs.getString("payment_reference");
                            totalAmount = rs.getDouble("total_amount");
                            processingFee = rs.getDouble("processing_fee");
                            serviceFee = rs.getDouble("service_fee");
                            taxAmount = rs.getDouble("tax_amount");
                            paymentMethod = rs.getString("payment_method");
                            processingType = rs.getString("processing_type");
                            transactionStatus = rs.getString("transaction_status");
                            transactionDate = rs.getString("transaction_date");
                            dataLoaded = true;
                        }
                    }
                }
                
                // Get application details
                if (dataLoaded) {
                    String applicationSql = "SELECT first_name, last_name, email, nic FROM applications WHERE application_id = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(applicationSql)) {
                        stmt.setInt(1, applicationId);
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                String firstName = rs.getString("first_name");
                                String lastName = rs.getString("last_name");
                                applicantName = (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : "");
                                applicantEmail = rs.getString("email");
                                applicantNic = rs.getString("nic");
                            }
                        }
                    }
                }
            } catch (SQLException e) {
                System.err.println("Error loading invoice data: " + e.getMessage());
                e.printStackTrace();
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid application ID: " + applicationIdStr);
        }
    }
    
    // Format current date
    String currentDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("MMMM dd, yyyy"));
    String currentTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("hh:mm a"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Invoice - <%= paymentReference %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
        }
        
        .invoice-container {
            background: white;
            max-width: 900px;
            margin: 2rem auto;
            padding: 3rem;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        
        .invoice-header {
            border-bottom: 3px solid #667eea;
            padding-bottom: 2rem;
            margin-bottom: 2rem;
        }
        
        .company-logo {
            font-size: 2.5rem;
            color: #667eea;
            font-weight: bold;
        }
        
        .invoice-title {
            font-size: 3rem;
            color: #333;
            font-weight: bold;
            text-align: right;
        }
        
        .invoice-details {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin: 2rem 0;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #6c757d;
        }
        
        .info-value {
            color: #495057;
        }
        
        .items-table {
            margin: 2rem 0;
        }
        
        .items-table table {
            width: 100%;
        }
        
        .items-table th {
            background: #667eea;
            color: white;
            padding: 1rem;
            text-align: left;
        }
        
        .items-table td {
            padding: 1rem;
            border-bottom: 1px solid #dee2e6;
        }
        
        .total-row {
            background: #f8f9fa;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .total-row td {
            padding: 1.5rem 1rem !important;
        }
        
        .status-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: bold;
            text-transform: uppercase;
        }
        
        .status-paid {
            background: #d4edda;
            color: #155724;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .invoice-footer {
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 2px solid #dee2e6;
            text-align: center;
            color: #6c757d;
        }
        
        .action-buttons {
            margin: 2rem 0;
            text-align: center;
        }
        
        /* Print styles */
        @media print {
            body {
                background: white;
            }
            
            .no-print {
                display: none !important;
            }
            
            .invoice-container {
                box-shadow: none;
                padding: 0;
                margin: 0;
            }
            
            .action-buttons {
                display: none;
            }
        }
    </style>
</head>
<body>
    <% if (!dataLoaded) { %>
    <div class="container py-5">
        <div class="alert alert-danger" role="alert">
            <h4 class="alert-heading"><i class="fas fa-exclamation-triangle me-2"></i>Invoice Not Found</h4>
            <p>The requested invoice could not be found. Please check the transaction ID and try again.</p>
            <hr>
            <a href="applications.jsp" class="btn btn-primary">Back to Applications</a>
        </div>
    </div>
    <% } else { %>
    
    <div class="invoice-container">
        <!-- Header -->
        <div class="invoice-header">
            <div class="row">
                <div class="col-md-6">
                    <div class="company-logo">
                        <i class="fas fa-passport me-2"></i>
                        E-Passport
                    </div>
                    <h5 class="mt-3">Department of Immigration</h5>
                    <p class="mb-0">Passport Issuing System</p>
                    <p class="mb-0"><small>No. 45, Galle Road, Colombo 03, Sri Lanka</small></p>
                    <p class="mb-0"><small>Tel: +94 11 123 4567</small></p>
                    <p class="mb-0"><small>Email: info@passport.gov.lk</small></p>
                </div>
                <div class="col-md-6 text-end">
                    <div class="invoice-title">INVOICE</div>
                    <p class="mt-3"><strong>Invoice #:</strong> <%= transactionId %></p>
                    <p><strong>Date:</strong> <%= currentDate %></p>
                    <p><strong>Time:</strong> <%= currentTime %></p>
                </div>
            </div>
        </div>
        
        <!-- Invoice Details -->
        <div class="row">
            <div class="col-md-6">
                <h5 class="mb-3">Bill To:</h5>
                <div class="invoice-details">
                    <div class="info-row">
                        <span class="info-label">Name:</span>
                        <span class="info-value"><strong><%= applicantName %></strong></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">NIC:</span>
                        <span class="info-value"><%= applicantNic %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Email:</span>
                        <span class="info-value"><%= applicantEmail %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Application ID:</span>
                        <span class="info-value"><%= applicationId %></span>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <h5 class="mb-3">Payment Information:</h5>
                <div class="invoice-details">
                    <div class="info-row">
                        <span class="info-label">Transaction ID:</span>
                        <span class="info-value"><strong><%= paymentReference %></strong></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Payment Method:</span>
                        <span class="info-value text-capitalize"><%= paymentMethod.replace("_", " ") %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Transaction Date:</span>
                        <span class="info-value"><%= transactionDate %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Status:</span>
                        <span class="info-value">
                            <span class="status-badge status-<%= transactionStatus %>"><%= transactionStatus.toUpperCase() %></span>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Items Table -->
        <div class="items-table">
            <table>
                <thead>
                    <tr>
                        <th>Description</th>
                        <th style="text-align: center;">Processing Type</th>
                        <th style="text-align: center;">Quantity</th>
                        <th style="text-align: right;">Amount (LKR)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Passport Processing Fee</td>
                        <td style="text-align: center;" class="text-capitalize"><%= processingType %></td>
                        <td style="text-align: center;">1</td>
                        <td style="text-align: right;"><%= String.format("%,.2f", processingFee) %></td>
                    </tr>
                    <tr>
                        <td>Service Fee</td>
                        <td style="text-align: center;">-</td>
                        <td style="text-align: center;">1</td>
                        <td style="text-align: right;"><%= String.format("%,.2f", serviceFee) %></td>
                    </tr>
                    <tr>
                        <td>Tax</td>
                        <td style="text-align: center;">-</td>
                        <td style="text-align: center;">1</td>
                        <td style="text-align: right;"><%= String.format("%,.2f", taxAmount) %></td>
                    </tr>
                    <tr class="total-row">
                        <td colspan="3" style="text-align: right;">TOTAL AMOUNT:</td>
                        <td style="text-align: right;">LKR <%= String.format("%,.2f", totalAmount) %></td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <!-- Footer -->
        <div class="invoice-footer">
            <p><strong>Thank you for using our service!</strong></p>
            <p class="small">This is a computer-generated invoice and does not require a signature.</p>
            <p class="small">For inquiries, please contact us at info@passport.gov.lk or call +94 11 123 4567</p>
        </div>
        
        <!-- Action Buttons -->
        <div class="action-buttons no-print">
            <button onclick="window.print()" class="btn btn-primary btn-lg me-2">
                <i class="fas fa-download me-2"></i>Download PDF
            </button>
            <button onclick="window.print()" class="btn btn-outline-primary btn-lg me-2">
                <i class="fas fa-print me-2"></i>Print
            </button>
            <a href="applications.jsp" class="btn btn-outline-secondary btn-lg">
                <i class="fas fa-arrow-left me-2"></i>Back to Applications
            </a>
        </div>
    </div>
    
    <% } %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
