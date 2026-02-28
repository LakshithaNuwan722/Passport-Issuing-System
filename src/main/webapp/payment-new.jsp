<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Gateway - Lanka Epassport</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #0d6efd;
            --success-color: #198754;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem 0;
        }
        
        .payment-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .payment-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .payment-header {
            background: linear-gradient(135deg, var(--primary-color), #0a58ca);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .payment-body {
            padding: 2rem;
        }
        
        .info-box {
            background: #f8f9fa;
            border-left: 4px solid var(--primary-color);
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 5px;
        }
        
        .payment-option {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .payment-option:hover {
            border-color: var(--primary-color);
            background: #f8f9fa;
        }
        
        .payment-option.selected {
            border-color: var(--primary-color);
            background: #e7f1ff;
        }
        
        .payment-option input[type="radio"] {
            margin-right: 10px;
        }
        
        .amount-summary {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin: 1.5rem 0;
        }
        
        .amount-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
        }
        
        .amount-row.total {
            border-top: 2px solid #dee2e6;
            margin-top: 0.5rem;
            padding-top: 1rem;
            font-size: 1.25rem;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        .btn-pay {
            background: linear-gradient(135deg, var(--success-color), #20c997);
            border: none;
            color: white;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            border-radius: 10px;
            width: 100%;
            transition: all 0.3s;
        }
        
        .btn-pay:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        
        .btn-pay:disabled {
            background: #6c757d;
            cursor: not-allowed;
        }
        
        .alert {
            border-radius: 10px;
            border: none;
        }
        
        .loading {
            display: none;
            text-align: center;
            padding: 2rem;
        }
        
        .loading.show {
            display: block;
        }
        
        .spinner-border {
            width: 3rem;
            height: 3rem;
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <div class="payment-card">
            <!-- Header -->
            <div class="payment-header">
                <h2><i class="fas fa-credit-card me-2"></i>Payment Gateway</h2>
                <p class="mb-0">Secure Payment Processing</p>
            </div>
            
            <!-- Body -->
            <div class="payment-body">
                <!-- Application Info -->
                <div class="info-box" id="appInfo">
                    <h5><i class="fas fa-info-circle me-2"></i>Application Information</h5>
                    <p class="mb-0">Application ID: <strong id="displayAppId">Loading...</strong></p>
                    <p class="mb-0">Status: <span id="appStatus">Checking...</span></p>
                </div>
                
                <!-- Alerts -->
                <div id="alertContainer"></div>
                
                <!-- Payment Form -->
                <form id="paymentForm" style="display:none;">
                    <h5 class="mb-3">Select Processing Type</h5>
                    
                    <div class="payment-option" onclick="selectProcessingType('regular')">
                        <input type="radio" name="processingType" value="regular" id="regular">
                        <label for="regular" class="mb-0">
                            <strong>Regular Processing</strong>
                            <div class="text-muted">7-10 business days - LKR 15,000</div>
                        </label>
                    </div>
                    
                    <div class="payment-option" onclick="selectProcessingType('express')">
                        <input type="radio" name="processingType" value="express" id="express">
                        <label for="express" class="mb-0">
                            <strong>Express Processing</strong>
                            <div class="text-muted">3-5 business days - LKR 20,000</div>
                        </label>
                    </div>
                    
                    <h5 class="mb-3 mt-4">Select Payment Method</h5>
                    
                    <div class="payment-option" onclick="selectPaymentMethod('credit_card')">
                        <input type="radio" name="paymentMethod" value="credit_card" id="credit_card">
                        <label for="credit_card" class="mb-0">
                            <strong><i class="fas fa-credit-card me-2"></i>Credit/Debit Card</strong>
                        </label>
                    </div>
                    
                    <div class="payment-option" onclick="selectPaymentMethod('bank_transfer')">
                        <input type="radio" name="paymentMethod" value="bank_transfer" id="bank_transfer">
                        <label for="bank_transfer" class="mb-0">
                            <strong><i class="fas fa-university me-2"></i>Bank Transfer</strong>
                        </label>
                    </div>
                    
                    <div class="payment-option" onclick="selectPaymentMethod('paypal')">
                        <input type="radio" name="paymentMethod" value="paypal" id="paypal">
                        <label for="paypal" class="mb-0">
                            <strong><i class="fab fa-paypal me-2"></i>PayPal</strong>
                        </label>
                    </div>
                    
                    <!-- Amount Summary -->
                    <div class="amount-summary">
                        <h5 class="mb-3">Payment Summary</h5>
                        <div class="amount-row">
                            <span>Processing Fee:</span>
                            <span id="processingFeeDisplay">LKR 0</span>
                        </div>
                        <div class="amount-row">
                            <span>Service Fee:</span>
                            <span>LKR 2,000</span>
                        </div>
                        <div class="amount-row total">
                            <span>Total Amount:</span>
                            <span id="totalAmountDisplay">LKR 2,000</span>
                        </div>
                    </div>
                    
                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-pay" id="payButton" disabled>
                        <i class="fas fa-lock me-2"></i>Complete Payment
                    </button>
                </form>
                
                <!-- Loading -->
                <div class="loading" id="loadingDiv">
                    <div class="spinner-border text-primary" role="status"></div>
                    <p class="mt-3">Processing your payment...</p>
                    <p class="text-muted">Please do not close this window</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let applicationId = null;
        let selectedProcessingType = null;
        let selectedPaymentMethod = null;
        
        const processingFees = {
            'regular': 15000,
            'express': 20000
        };
        const serviceFee = 2000;
        
        // Get application ID from URL
        const urlParams = new URLSearchParams(window.location.search);
        applicationId = urlParams.get('applicationId');
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            if (!applicationId) {
                showAlert('Error: No application ID provided', 'danger');
                return;
            }
            
            document.getElementById('displayAppId').textContent = applicationId;
            checkApplication();
        });
        
        // Check application status
        function checkApplication() {
            fetch('PaymentProcessor?applicationId=' + applicationId)
                .then(response => response.json())
                .then(data => {
                    console.log('Application check:', data);
                    
                    if (data.found) {
                        if (data.paymentStatus === 'paid') {
                            showAlert('This application has already been paid.', 'warning');
                            document.getElementById('appStatus').innerHTML = '<span class="badge bg-success">Paid</span>';
                        } else {
                            document.getElementById('appStatus').innerHTML = '<span class="badge bg-warning">Pending Payment</span>';
                            document.getElementById('paymentForm').style.display = 'block';
                        }
                    } else {
                        showAlert('Application not found in database. Please check the application ID.', 'danger');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showAlert('Failed to check application status: ' + error.message, 'danger');
                });
        }
        
        // Select processing type
        function selectProcessingType(type) {
            selectedProcessingType = type;
            document.getElementById(type).checked = true;
            
            // Update styling
            document.querySelectorAll('.payment-option').forEach(el => {
                if (el.querySelector('input[name="processingType"]')) {
                    el.classList.remove('selected');
                }
            });
            document.getElementById(type).closest('.payment-option').classList.add('selected');
            
            updateSummary();
            checkFormComplete();
        }
        
        // Select payment method
        function selectPaymentMethod(method) {
            selectedPaymentMethod = method;
            document.getElementById(method).checked = true;
            
            // Update styling
            document.querySelectorAll('.payment-option').forEach(el => {
                if (el.querySelector('input[name="paymentMethod"]')) {
                    el.classList.remove('selected');
                }
            });
            document.getElementById(method).closest('.payment-option').classList.add('selected');
            
            checkFormComplete();
        }
        
        // Update payment summary
        function updateSummary() {
            if (selectedProcessingType) {
                const processingFee = processingFees[selectedProcessingType];
                const total = processingFee + serviceFee;
                
                document.getElementById('processingFeeDisplay').textContent = 'LKR ' + processingFee.toLocaleString();
                document.getElementById('totalAmountDisplay').textContent = 'LKR ' + total.toLocaleString();
            }
        }
        
        // Check if form is complete
        function checkFormComplete() {
            const payButton = document.getElementById('payButton');
            if (selectedProcessingType && selectedPaymentMethod) {
                payButton.disabled = false;
            } else {
                payButton.disabled = true;
            }
        }
        
        // Handle form submission
        document.getElementById('paymentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (!selectedProcessingType || !selectedPaymentMethod) {
                showAlert('Please select processing type and payment method', 'warning');
                return;
            }
            
            processPayment();
        });
        
        // Process payment
        function processPayment() {
            const processingFee = processingFees[selectedProcessingType];
            const totalAmount = processingFee + serviceFee;
            
            // Show loading
            document.getElementById('paymentForm').style.display = 'none';
            document.getElementById('loadingDiv').classList.add('show');
            
            // Prepare form data
            const formData = new FormData();
            formData.append('applicationId', applicationId);
            formData.append('paymentMethod', selectedPaymentMethod);
            formData.append('processingType', selectedProcessingType);
            formData.append('processingFee', processingFee);
            formData.append('serviceFee', serviceFee);
            formData.append('totalAmount', totalAmount);
            
            console.log('Submitting payment:', {
                applicationId,
                paymentMethod: selectedPaymentMethod,
                processingType: selectedProcessingType,
                processingFee,
                serviceFee,
                totalAmount
            });
            
            // Submit payment
            fetch('PaymentProcessor', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                console.log('Response status:', response.status);
                return response.text().then(text => {
                    console.log('Response text:', text);
                    return {
                        status: response.status,
                        ok: response.ok,
                        data: JSON.parse(text)
                    };
                });
            })
            .then(result => {
                console.log('Payment result:', result);
                
                if (result.ok && result.data.success) {
                    // Success! Redirect to success page
                    window.location.href = 'payment-success.jsp?transactionId=' + result.data.transactionId + 
                                          '&amount=' + result.data.amount +
                                          '&applicationId=' + applicationId;
                } else {
                    // Failed
                    document.getElementById('loadingDiv').classList.remove('show');
                    document.getElementById('paymentForm').style.display = 'block';
                    showAlert('Payment failed: ' + (result.data.error || result.data.message || 'Unknown error'), 'danger');
                }
            })
            .catch(error => {
                console.error('Payment error:', error);
                document.getElementById('loadingDiv').classList.remove('show');
                document.getElementById('paymentForm').style.display = 'block';
                showAlert('Payment processing error: ' + error.message, 'danger');
            });
        }
        
        // Show alert
        function showAlert(message, type) {
            const alertHtml = `
                <div class="alert alert-${type} alert-dismissible fade show" role="alert">
                    <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'danger' ? 'exclamation-circle' : 'info-circle'} me-2"></i>
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            `;
            document.getElementById('alertContainer').innerHTML = alertHtml;
        }
    </script>
</body>
</html>

