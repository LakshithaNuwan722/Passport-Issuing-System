<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<%
    // Define fee constants
    int regularProcessingFee = 15000;
    int expressProcessingFee = 20000;
    int serviceFee = 2000;
    int taxAmount = 0;
    
    // Get application ID from request
    String applicationIdStr = request.getParameter("applicationId");
    int applicationId = 0;
    String applicantName = "Unknown";
    String applicantEmail = "";
    String processingType = "regular";
    
    if (applicationIdStr != null && !applicationIdStr.trim().isEmpty()) {
        try {
            applicationId = Integer.parseInt(applicationIdStr);
            
            // Load application details
            try (Connection conn = Database.getConnection()) {
                String sql = "SELECT first_name, last_name, email, processing_type FROM applications WHERE application_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, applicationId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            String firstName = rs.getString("first_name");
                            String lastName = rs.getString("last_name");
                            applicantName = (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : "");
                            applicantEmail = rs.getString("email");
                            processingType = rs.getString("processing_type");
                            if (processingType == null) processingType = "regular";
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
    <title>Fresh Payment Gateway - Passport Issuing System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .payment-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .payment-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 2rem;
            text-align: center;
        }
        
        .payment-form {
            padding: 2rem;
        }
        
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-pay {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 15px 30px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        
        .btn-pay:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .amount-display {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 15px;
            padding: 1.5rem;
            margin: 1rem 0;
        }
        
        .amount-item {
            display: flex;
            justify-content: space-between;
            margin: 0.5rem 0;
            padding: 0.5rem 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .amount-item:last-child {
            border-bottom: none;
            font-weight: bold;
            font-size: 1.2rem;
            color: #667eea;
        }
        
        .alert {
            border-radius: 10px;
            border: none;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        
        .loading {
            display: none;
        }
        
        .loading.show {
            display: block;
        }
        
        .success-message {
            display: none;
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin: 1rem 0;
            box-shadow: 0 10px 30px rgba(40, 167, 69, 0.3);
            text-align: center;
            animation: slideInDown 0.5s ease;
        }
        
        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .success-message .btn {
            margin-top: 1rem;
        }
        
        .error-message {
            display: none;
            background: linear-gradient(135deg, #dc3545 0%, #fd7e14 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin: 1rem 0;
            box-shadow: 0 10px 30px rgba(220, 53, 69, 0.3);
            text-align: center;
            animation: shake 0.5s ease;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        
        /* Payment Method Sections */
        .payment-method-section {
            display: none;
            margin-top: 1.5rem;
            animation: fadeIn 0.5s ease;
        }
        
        .payment-method-section.show {
            display: block;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Card Form Styles */
        .card-form {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        
        .card-input {
            position: relative;
        }
        
        .card-input i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        .card-number-input {
            font-family: 'Courier New', monospace;
            letter-spacing: 2px;
        }
        
        /* Bank Transfer Styles */
        .bank-details-card {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border: 2px solid #667eea;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .bank-detail-item {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .bank-detail-item:last-child {
            border-bottom: none;
        }
        
        .copy-btn {
            background: #667eea;
            color: white;
            border: none;
            padding: 3px 10px;
            border-radius: 5px;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .copy-btn:hover {
            background: #764ba2;
        }
        
        .upload-area {
            border: 2px dashed #667eea;
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
        }
        
        .upload-area:hover {
            border-color: #764ba2;
            background: #f8f9fa;
        }
        
        .upload-area.dragover {
            background: #e9ecef;
            border-color: #764ba2;
        }
        
        .image-preview {
            max-width: 200px;
            max-height: 200px;
            margin: 1rem auto;
            border-radius: 10px;
            display: none;
        }
        
        .image-preview.show {
            display: block;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="payment-container" data-aos="fade-up">
                    <div class="payment-header">
                        <h1 class="mb-3">
                            <i class="fas fa-credit-card me-3"></i>
                            Fresh Payment Gateway
                        </h1>
                        <p class="mb-0">Secure payment processing for passport applications</p>
                    </div>
                    
                    <div class="payment-form">
                        <!-- Application Details -->
                        <div class="card mb-4">
                            <div class="card-header bg-light">
                                <h5 class="mb-0">
                                    <i class="fas fa-file-alt me-2"></i>
                                    Application Details
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label class="form-label">Application ID</label>
                                        <input type="text" class="form-control" id="applicationId" 
                                               value="<%= applicationId %>" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Applicant Name</label>
                                        <input type="text" class="form-control" value="<%= applicantName %>" readonly>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" value="<%= applicantEmail %>" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Current Processing Type</label>
                                        <input type="text" class="form-control" value="<%= processingType.toUpperCase() %>" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Payment Form -->
                        <form id="paymentForm">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header bg-light">
                                            <h5 class="mb-0">
                                                <i class="fas fa-cog me-2"></i>
                                                Processing Options
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="mb-3">
                                                <label class="form-label">Processing Type</label>
                                                <select class="form-select" id="processingType" name="processingType">
                                                    <option value="regular" data-price="<%= regularProcessingFee %>">Regular Processing - LKR <%= String.format("%,d", regularProcessingFee) %> (7-10 business days)</option>
                                                    <option value="express" data-price="<%= expressProcessingFee %>">Express Processing - LKR <%= String.format("%,d", expressProcessingFee) %> (2-3 business days)</option>
                                                </select>
                                            </div>
                                            
                                            <div class="mb-3">
                                                <label class="form-label">Payment Method</label>
                                                <select class="form-select" id="paymentMethod" name="paymentMethod">
                                                    <option value="credit_card">Credit Card</option>
                                                    <option value="debit_card">Debit Card</option>
                                                    <option value="bank_transfer">Bank Transfer</option>
                                                </select>
                                            </div>
                                            
                                            <!-- Credit/Debit Card Form -->
                                            <div id="cardFormSection" class="payment-method-section">
                                                <div class="card-form">
                                                    <h6 class="mb-3">
                                                        <i class="fas fa-credit-card me-2"></i>
                                                        Card Details
                                                    </h6>
                                                    
                                                    <div class="mb-3 card-input">
                                                        <label class="form-label">Card Number</label>
                                                        <input type="text" class="form-control card-number-input" id="cardNumber" 
                                                               placeholder="1234 5678 9012 3456" maxlength="19">
                                                        <i class="fas fa-credit-card"></i>
                                                    </div>
                                                    
                                                    <div class="mb-3">
                                                        <label class="form-label">Cardholder Name</label>
                                                        <input type="text" class="form-control" id="cardholderName" 
                                                               placeholder="John Doe" style="text-transform: uppercase;">
                                                    </div>
                                                    
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">Expiry Date</label>
                                                                <input type="text" class="form-control" id="expiryDate" 
                                                                       placeholder="MM/YY" maxlength="5">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="form-label">CVV</label>
                                                                <input type="password" class="form-control" id="cvv" 
                                                                       placeholder="123" maxlength="3">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="alert alert-info small mb-0">
                                                        <i class="fas fa-lock me-2"></i>
                                                        Your card information is encrypted and secure
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- Bank Transfer Section -->
                                            <div id="bankTransferSection" class="payment-method-section">
                                                <div class="bank-details-card">
                                                    <h6 class="mb-3">
                                                        <i class="fas fa-university me-2"></i>
                                                        Bank Account Details
                                                    </h6>
                                                    
                                                    <div class="bank-detail-item">
                                                        <strong>Bank Name:</strong>
                                                        <span>
                                                            Bank of Ceylon
                                                            <button type="button" class="copy-btn ms-2" onclick="copyToClipboard('Bank of Ceylon')">
                                                                <i class="fas fa-copy"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                    
                                                    <div class="bank-detail-item">
                                                        <strong>Account Number:</strong>
                                                        <span>
                                                            1234567890
                                                            <button type="button" class="copy-btn ms-2" onclick="copyToClipboard('1234567890')">
                                                                <i class="fas fa-copy"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                    
                                                    <div class="bank-detail-item">
                                                        <strong>Account Name:</strong>
                                                        <span>Department of Immigration</span>
                                                    </div>
                                                    
                                                    <div class="bank-detail-item">
                                                        <strong>Branch:</strong>
                                                        <span>Colombo Main Branch</span>
                                                    </div>
                                                    
                                                    <div class="bank-detail-item">
                                                        <strong>Swift Code:</strong>
                                                        <span>
                                                            BCEYLKLX
                                                            <button type="button" class="copy-btn ms-2" onclick="copyToClipboard('BCEYLKLX')">
                                                                <i class="fas fa-copy"></i>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </div>
                                                
                                                <div class="card-form">
                                                    <h6 class="mb-3">
                                                        <i class="fas fa-upload me-2"></i>
                                                        Upload Payment Proof
                                                    </h6>
                                                    
                                                    <div class="mb-3">
                                                        <label class="form-label">Payment Slip / Receipt</label>
                                                        <div class="upload-area" id="uploadArea" onclick="document.getElementById('paymentSlip').click()">
                                                            <i class="fas fa-cloud-upload-alt fa-3x text-primary mb-3"></i>
                                                            <p class="mb-2">Click to upload or drag and drop</p>
                                                            <small class="text-muted">JPG, PNG or PDF (Max 5MB)</small>
                                                        </div>
                                                        <input type="file" id="paymentSlip" accept=".jpg,.jpeg,.png,.pdf" style="display: none;">
                                                        <img id="slipPreview" class="image-preview" alt="Preview">
                                                        <div id="fileName" class="text-center mt-2 text-muted small"></div>
                                                    </div>
                                                    
                                                    <div class="mb-3">
                                                        <label class="form-label">Reference Number</label>
                                                        <input type="text" class="form-control" id="referenceNumber" 
                                                               placeholder="Enter bank transfer reference number">
                                                        <small class="text-muted">Enter the reference number from your bank transfer</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header bg-light">
                                            <h5 class="mb-0">
                                                <i class="fas fa-calculator me-2"></i>
                                                Payment Summary
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="amount-display">
                                                <div class="amount-item">
                                                    <span>Processing Fee:</span>
                                                    <span id="processingFeeDisplay">LKR <%= String.format("%,d", regularProcessingFee) %></span>
                                                </div>
                                                <div class="amount-item">
                                                    <span>Service Fee:</span>
                                                    <span>LKR <%= String.format("%,d", serviceFee) %></span>
                                                </div>
                                                <div class="amount-item">
                                                    <span>Tax:</span>
                                                    <span>LKR <%= String.format("%,d", taxAmount) %></span>
                                                </div>
                                                <div class="amount-item">
                                                    <span>Total Amount:</span>
                                                    <span id="totalAmountDisplay">LKR <%= String.format("%,d", regularProcessingFee + serviceFee + taxAmount) %></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Hidden fields -->
                            <input type="hidden" id="processingFee" name="processingFee" value="<%= regularProcessingFee %>">
                            <input type="hidden" id="serviceFee" name="serviceFee" value="<%= serviceFee %>">
                            <input type="hidden" id="taxAmount" name="taxAmount" value="<%= taxAmount %>">
                            <input type="hidden" id="totalAmount" name="totalAmount" value="<%= regularProcessingFee + serviceFee + taxAmount %>">
                            
                            <!-- Messages -->
                            <div class="success-message" id="successMessage">
                                <i class="fas fa-check-circle me-2"></i>
                                <span id="successText">Payment processed successfully!</span>
                            </div>
                            
                            <div class="error-message" id="errorMessage">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <span id="errorText">Payment failed. Please try again.</span>
                            </div>
                            
                            <!-- Submit Button -->
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-pay btn-lg text-white" id="submitBtn">
                                    <i class="fas fa-lock me-2"></i>
                                    Process Payment
                                </button>
                                
                                <div class="loading mt-3" id="loadingSpinner">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="visually-hidden">Processing...</span>
                                    </div>
                                    <p class="mt-2 text-muted">Processing your payment...</p>
                                </div>
                            </div>
                        </form>
                        
                        <!-- Back to Applications -->
                        <div class="text-center mt-4">
                            <a href="applications.jsp" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>
                                Back to Applications
                            </a>
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
        
        // Set initial processing type
        document.getElementById('processingType').value = '<%= processingType %>';
        
        // Payment method show/hide logic
        const paymentMethodDropdown = document.getElementById('paymentMethod');
        const cardFormSection = document.getElementById('cardFormSection');
        const bankTransferSection = document.getElementById('bankTransferSection');
        
        // Show card form by default
        cardFormSection.classList.add('show');
        
        paymentMethodDropdown.addEventListener('change', function() {
            const method = this.value;
            
            // Hide all sections first
            cardFormSection.classList.remove('show');
            bankTransferSection.classList.remove('show');
            
            // Show relevant section
            if (method === 'credit_card' || method === 'debit_card') {
                setTimeout(() => cardFormSection.classList.add('show'), 50);
            } else if (method === 'bank_transfer') {
                setTimeout(() => bankTransferSection.classList.add('show'), 50);
            }
        });
        
        // Card number formatting
        const cardNumberInput = document.getElementById('cardNumber');
        if (cardNumberInput) {
            cardNumberInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\s/g, '');
                let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
                e.target.value = formattedValue;
            });
        }
        
        // Expiry date formatting
        const expiryDateInput = document.getElementById('expiryDate');
        if (expiryDateInput) {
            expiryDateInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length >= 2) {
                    value = value.substring(0, 2) + '/' + value.substring(2, 4);
                }
                e.target.value = value;
            });
        }
        
        // CVV validation
        const cvvInput = document.getElementById('cvv');
        if (cvvInput) {
            cvvInput.addEventListener('input', function(e) {
                e.target.value = e.target.value.replace(/\D/g, '').substring(0, 3);
            });
        }
        
        // File upload handling
        const paymentSlipInput = document.getElementById('paymentSlip');
        const uploadArea = document.getElementById('uploadArea');
        const slipPreview = document.getElementById('slipPreview');
        const fileNameDisplay = document.getElementById('fileName');
        
        if (paymentSlipInput) {
            paymentSlipInput.addEventListener('change', function(e) {
                handleFileUpload(e.target.files[0]);
            });
            
            // Drag and drop
            uploadArea.addEventListener('dragover', function(e) {
                e.preventDefault();
                uploadArea.classList.add('dragover');
            });
            
            uploadArea.addEventListener('dragleave', function(e) {
                e.preventDefault();
                uploadArea.classList.remove('dragover');
            });
            
            uploadArea.addEventListener('drop', function(e) {
                e.preventDefault();
                uploadArea.classList.remove('dragover');
                if (e.dataTransfer.files.length > 0) {
                    handleFileUpload(e.dataTransfer.files[0]);
                }
            });
        }
        
        function handleFileUpload(file) {
            if (!file) return;
            
            // Validate file size (5MB max)
            if (file.size > 5 * 1024 * 1024) {
                alert('File size must be less than 5MB');
                return;
            }
            
            // Validate file type
            const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'application/pdf'];
            if (!allowedTypes.includes(file.type)) {
                alert('Please upload JPG, PNG or PDF file only');
                return;
            }
            
            // Show file name
            fileNameDisplay.textContent = file.name;
            
            // Show preview for images
            if (file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    slipPreview.src = e.target.result;
                    slipPreview.classList.add('show');
                };
                reader.readAsDataURL(file);
            } else {
                slipPreview.classList.remove('show');
            }
        }
        
        // Copy to clipboard function
        function copyToClipboard(text) {
            navigator.clipboard.writeText(text).then(function() {
                // Show temporary success message
                const toast = document.createElement('div');
                toast.className = 'alert alert-success position-fixed top-0 start-50 translate-middle-x mt-3';
                toast.style.zIndex = '9999';
                toast.innerHTML = '<i class="fas fa-check me-2"></i>Copied to clipboard!';
                document.body.appendChild(toast);
                setTimeout(() => toast.remove(), 2000);
            });
        }
        
        // Validation functions
        function validateCardDetails() {
            const cardNumber = document.getElementById('cardNumber').value.replace(/\s/g, '');
            const cardholderName = document.getElementById('cardholderName').value.trim();
            const expiryDate = document.getElementById('expiryDate').value;
            const cvv = document.getElementById('cvv').value;
            
            if (cardNumber.length !== 16) {
                alert('Please enter a valid 16-digit card number');
                return false;
            }
            
            if (cardholderName.length < 3) {
                alert('Please enter cardholder name');
                return false;
            }
            
            if (!/^\d{2}\/\d{2}$/.test(expiryDate)) {
                alert('Please enter expiry date in MM/YY format');
                return false;
            }
            
            if (cvv.length !== 3) {
                alert('Please enter a valid 3-digit CVV');
                return false;
            }
            
            return true;
        }
        
        function validateBankTransfer() {
            const paymentSlip = document.getElementById('paymentSlip').files[0];
            const referenceNumber = document.getElementById('referenceNumber').value.trim();
            
            if (!paymentSlip) {
                alert('Please upload payment slip');
                return false;
            }
            
            if (referenceNumber.length < 5) {
                alert('Please enter a valid reference number');
                return false;
            }
            
            return true;
        }
        
        // Update amounts when processing type changes
        document.getElementById('processingType').addEventListener('change', function() {
            updateAmounts();
        });
        
        function updateAmounts() {
            const processingType = document.getElementById('processingType');
            const selectedOption = processingType.options[processingType.selectedIndex];
            const processingFee = parseInt(selectedOption.getAttribute('data-price'));
            const serviceFee = <%= serviceFee %>;
            const taxAmount = <%= taxAmount %>;
            const totalAmount = processingFee + serviceFee + taxAmount;
            
            // Update display
            document.getElementById('processingFeeDisplay').textContent = 'LKR ' + processingFee.toLocaleString();
            document.getElementById('totalAmountDisplay').textContent = 'LKR ' + totalAmount.toLocaleString();
            
            // Update hidden fields
            document.getElementById('processingFee').value = processingFee;
            document.getElementById('totalAmount').value = totalAmount;
        }
        
        // Handle form submission
        document.getElementById('paymentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const submitBtn = document.getElementById('submitBtn');
            const loadingSpinner = document.getElementById('loadingSpinner');
            const successMessage = document.getElementById('successMessage');
            const errorMessage = document.getElementById('errorMessage');
            
            // Hide previous messages
            successMessage.style.display = 'none';
            errorMessage.style.display = 'none';
            
            // Validate payment method specific fields
            const paymentMethod = document.getElementById('paymentMethod').value;
            if (paymentMethod === 'credit_card' || paymentMethod === 'debit_card') {
                if (!validateCardDetails()) {
                    return;
                }
            } else if (paymentMethod === 'bank_transfer') {
                if (!validateBankTransfer()) {
                    return;
                }
            }
            
            // Show loading
            submitBtn.disabled = true;
            loadingSpinner.classList.add('show');
            
            // Prepare payment data
            const paymentData = {
                applicationId: document.getElementById('applicationId').value,
                paymentMethod: document.getElementById('paymentMethod').value,
                processingType: document.getElementById('processingType').value,
                totalAmount: document.getElementById('totalAmount').value,
                processingFee: document.getElementById('processingFee').value,
                serviceFee: document.getElementById('serviceFee').value,
                taxAmount: document.getElementById('taxAmount').value
            };
            
            console.log('Submitting payment:', paymentData);
            
            // Submit payment
            const contextPath = '<%= request.getContextPath() %>';
            fetch(contextPath + '/FreshPayment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams(paymentData)
            })
            .then(response => {
                console.log('Response status:', response.status);
                return response.text().then(text => {
                    console.log('Response text:', text);
                    
                    if (!response.ok) {
                        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
                    }
                    return JSON.parse(text);
                });
            })
            .then(data => {
                console.log('Payment response:', data);
                
                if (data.success) {
                    // Show success message with details
                    document.getElementById('successText').innerHTML = 
                        '<strong><i class="fas fa-check-circle me-2"></i>Payment Successful!</strong><br>' +
                        '<small>Transaction ID: ' + data.transactionId + '</small><br>' +
                        '<small>Application ID: ' + data.applicationId + '</small><br>' +
                        '<small>Amount: LKR ' + parseFloat(data.totalAmount).toLocaleString() + '</small><br><br>' +
                        '<a href="applications.jsp" class="btn btn-success btn-sm me-2"><i class="fas fa-list me-1"></i>View Applications</a> ' +
                        '<a href="payment-invoice.jsp?transactionId=' + data.transactionId + '&applicationId=' + data.applicationId + '" class="btn btn-outline-success btn-sm"><i class="fas fa-receipt me-1"></i>View Receipt</a>';
                    successMessage.style.display = 'block';
                    
                    // Disable form inputs after successful payment (but keep buttons clickable)
                    const formInputs = document.querySelectorAll('#paymentForm input, #paymentForm select, #paymentForm button[type="submit"]');
                    formInputs.forEach(input => {
                        input.disabled = true;
                        input.style.opacity = '0.5';
                    });
                    
                    // Scroll to success message
                    successMessage.scrollIntoView({ behavior: 'smooth', block: 'center' });
                } else {
                    // Show error message
                    document.getElementById('errorText').textContent = data.message || 'Payment failed. Please try again.';
                    errorMessage.style.display = 'block';
                }
            })
            .catch(error => {
                console.error('Payment error:', error);
                document.getElementById('errorText').textContent = 'Payment failed: ' + error.message;
                errorMessage.style.display = 'block';
            })
            .finally(() => {
                // Hide loading
                submitBtn.disabled = false;
                loadingSpinner.classList.remove('show');
            });
        });
        
        // Initialize amounts on page load
        updateAmounts();
    </script>
</body>
</html>
