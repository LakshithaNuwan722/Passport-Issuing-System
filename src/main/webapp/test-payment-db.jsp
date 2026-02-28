<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment System Database Test</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: #f8f9fa;
            padding: 2rem 0;
        }
        
        .test-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-bottom: 1.5rem;
        }
        
        .test-result {
            background: #f8f9fa;
            border-radius: 5px;
            padding: 1rem;
            margin-top: 1rem;
            font-family: monospace;
            white-space: pre-wrap;
        }
        
        .success { 
            border-left: 4px solid #198754;
            background: #d1e7dd;
        }
        
        .error { 
            border-left: 4px solid #dc3545;
            background: #f8d7da;
        }
        
        .btn-test {
            margin: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="mb-4">
            <i class="fas fa-database me-2"></i>
            Payment System Database Test
        </h1>
        
        <!-- Database Connection Test -->
        <div class="test-card">
            <h3><i class="fas fa-plug me-2"></i>Database Connection</h3>
            <p class="text-muted">Test if the payment system can connect to the database</p>
            <button onclick="testDatabaseConnection()" class="btn btn-primary btn-test">
                <i class="fas fa-play me-1"></i>Test Connection
            </button>
            <div id="dbResult" class="test-result" style="display:none;"></div>
        </div>
        
        <!-- Application Check -->
        <div class="test-card">
            <h3><i class="fas fa-search me-2"></i>Check Application</h3>
            <p class="text-muted">Check if an application exists and its payment status</p>
            <div class="input-group mb-3">
                <input type="number" class="form-control" id="appIdInput" placeholder="Enter Application ID" value="82">
                <button onclick="checkApplication()" class="btn btn-primary">
                    <i class="fas fa-search me-1"></i>Check Application
                </button>
            </div>
            <div id="appResult" class="test-result" style="display:none;"></div>
        </div>
        
        <!-- Quick Payment Test -->
        <div class="test-card">
            <h3><i class="fas fa-money-bill-wave me-2"></i>Quick Payment Test</h3>
            <p class="text-muted">Submit a test payment (make sure application exists and is not paid)</p>
            <div class="row">
                <div class="col-md-6 mb-2">
                    <label>Application ID:</label>
                    <input type="number" class="form-control" id="testAppId" value="82">
                </div>
                <div class="col-md-6 mb-2">
                    <label>Processing Type:</label>
                    <select class="form-select" id="testProcessingType">
                        <option value="regular">Regular (LKR 15,000)</option>
                        <option value="express">Express (LKR 20,000)</option>
                    </select>
                </div>
                <div class="col-md-6 mb-2">
                    <label>Payment Method:</label>
                    <select class="form-select" id="testPaymentMethod">
                        <option value="credit_card">Credit Card</option>
                        <option value="bank_transfer">Bank Transfer</option>
                        <option value="paypal">PayPal</option>
                    </select>
                </div>
            </div>
            <button onclick="submitTestPayment()" class="btn btn-success btn-test mt-2">
                <i class="fas fa-credit-card me-1"></i>Submit Test Payment
            </button>
            <div id="paymentResult" class="test-result" style="display:none;"></div>
        </div>
        
        <!-- Direct Link -->
        <div class="test-card">
            <h3><i class="fas fa-link me-2"></i>Direct Links</h3>
            <p class="text-muted">Quick access to payment pages</p>
            <a href="payment-new.jsp?applicationId=82" class="btn btn-outline-primary btn-test" target="_blank">
                <i class="fas fa-external-link-alt me-1"></i>Open Payment Page (App ID: 82)
            </a>
            <a href="applications.jsp" class="btn btn-outline-secondary btn-test" target="_blank">
                <i class="fas fa-list me-1"></i>View Applications
            </a>
        </div>
    </div>
    
    <script>
        function testDatabaseConnection() {
            const resultDiv = document.getElementById('dbResult');
            resultDiv.style.display = 'block';
            resultDiv.textContent = 'Testing connection...';
            resultDiv.className = 'test-result';
            
            fetch('PaymentProcessor?test=db')
                .then(response => response.json())
                .then(data => {
                    if (data.connected) {
                        resultDiv.className = 'test-result success';
                        resultDiv.textContent = '✓ CONNECTION SUCCESSFUL\n\n' +
                                              'Database: ' + data.database + '\n' +
                                              'Applications Count: ' + data.applicationsCount + '\n' +
                                              'Payments Count: ' + data.paymentsCount;
                    } else {
                        resultDiv.className = 'test-result error';
                        resultDiv.textContent = '✗ CONNECTION FAILED\n\n' +
                                              'Error: ' + data.error;
                    }
                })
                .catch(error => {
                    resultDiv.className = 'test-result error';
                    resultDiv.textContent = '✗ REQUEST FAILED\n\n' + error.message;
                });
        }
        
        function checkApplication() {
            const appId = document.getElementById('appIdInput').value;
            const resultDiv = document.getElementById('appResult');
            
            if (!appId) {
                alert('Please enter an application ID');
                return;
            }
            
            resultDiv.style.display = 'block';
            resultDiv.textContent = 'Checking application...';
            resultDiv.className = 'test-result';
            
            fetch('PaymentProcessor?applicationId=' + appId)
                .then(response => response.json())
                .then(data => {
                    if (data.found) {
                        resultDiv.className = 'test-result success';
                        resultDiv.textContent = '✓ APPLICATION FOUND\n\n' +
                                              'Application ID: ' + data.applicationId + '\n' +
                                              'NIC Number: ' + data.nicNumber + '\n' +
                                              'Name: ' + data.firstName + ' ' + data.lastName + '\n' +
                                              'Processing Type: ' + data.processingType + '\n' +
                                              'Payment Status: ' + data.paymentStatus.toUpperCase();
                    } else {
                        resultDiv.className = 'test-result error';
                        resultDiv.textContent = '✗ APPLICATION NOT FOUND\n\n' +
                                              'Application ID ' + appId + ' does not exist in database';
                    }
                })
                .catch(error => {
                    resultDiv.className = 'test-result error';
                    resultDiv.textContent = '✗ REQUEST FAILED\n\n' + error.message;
                });
        }
        
        function submitTestPayment() {
            const appId = document.getElementById('testAppId').value;
            const processingType = document.getElementById('testProcessingType').value;
            const paymentMethod = document.getElementById('testPaymentMethod').value;
            const resultDiv = document.getElementById('paymentResult');
            
            if (!appId) {
                alert('Please enter an application ID');
                return;
            }
            
            const processingFees = {
                'regular': 15000,
                'express': 20000
            };
            const serviceFee = 2000;
            const processingFee = processingFees[processingType];
            const totalAmount = processingFee + serviceFee;
            
            resultDiv.style.display = 'block';
            resultDiv.textContent = 'Processing payment...';
            resultDiv.className = 'test-result';
            
            const formData = new FormData();
            formData.append('applicationId', appId);
            formData.append('paymentMethod', paymentMethod);
            formData.append('processingType', processingType);
            formData.append('processingFee', processingFee);
            formData.append('serviceFee', serviceFee);
            formData.append('totalAmount', totalAmount);
            
            fetch('PaymentProcessor', {
                method: 'POST',
                body: formData
            })
            .then(response => response.text().then(text => ({
                status: response.status,
                ok: response.ok,
                text: text,
                data: JSON.parse(text)
            })))
            .then(result => {
                if (result.ok && result.data.success) {
                    resultDiv.className = 'test-result success';
                    resultDiv.textContent = '✓ PAYMENT SUCCESSFUL\n\n' +
                                          'Transaction ID: ' + result.data.transactionId + '\n' +
                                          'Transaction DB ID: ' + result.data.transactionDbId + '\n' +
                                          'Application ID: ' + result.data.applicationId + '\n' +
                                          'Amount: LKR ' + result.data.amount + '\n' +
                                          'Timestamp: ' + result.data.timestamp + '\n\n' +
                                          'Payment has been saved to database successfully!';
                } else {
                    resultDiv.className = 'test-result error';
                    resultDiv.textContent = '✗ PAYMENT FAILED\n\n' +
                                          'Status: ' + result.status + '\n' +
                                          'Error: ' + (result.data.error || result.data.message) + '\n\n' +
                                          'Full Response:\n' + JSON.stringify(result.data, null, 2);
                }
            })
            .catch(error => {
                resultDiv.className = 'test-result error';
                resultDiv.textContent = '✗ REQUEST FAILED\n\n' + error.message;
            });
        }
    </script>
</body>
</html>

