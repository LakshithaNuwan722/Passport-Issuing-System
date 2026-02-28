<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful - Lanka Epassport</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .success-container {
            max-width: 600px;
            margin: 0 auto;
        }
        
        .success-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .success-header {
            background: linear-gradient(135deg, #198754, #20c997);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
        }
        
        .success-icon {
            font-size: 5rem;
            animation: checkmark 0.8s ease-in-out;
        }
        
        @keyframes checkmark {
            0% {
                transform: scale(0) rotate(-45deg);
            }
            50% {
                transform: scale(1.2) rotate(10deg);
            }
            100% {
                transform: scale(1) rotate(0deg);
            }
        }
        
        .success-body {
            padding: 2rem;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 1rem 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .detail-row:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            color: #6c757d;
            font-weight: 500;
        }
        
        .detail-value {
            font-weight: 600;
            color: #212529;
        }
        
        .amount-highlight {
            background: #e7f1ff;
            border-radius: 10px;
            padding: 1.5rem;
            margin: 1.5rem 0;
            text-align: center;
        }
        
        .amount-highlight h2 {
            color: #0d6efd;
            margin: 0;
        }
        
        .btn-action {
            padding: 0.75rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        
        .info-box {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 1rem;
            border-radius: 5px;
            margin-top: 1.5rem;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-card">
            <!-- Header -->
            <div class="success-header">
                <div class="success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h1 class="mt-3 mb-2">Payment Successful!</h1>
                <p class="mb-0">Your payment has been processed successfully</p>
            </div>
            
            <!-- Body -->
            <div class="success-body">
                <!-- Transaction Details -->
                <h5 class="mb-3"><i class="fas fa-receipt me-2"></i>Transaction Details</h5>
                
                <div class="detail-row">
                    <span class="detail-label">Transaction ID:</span>
                    <span class="detail-value" id="transactionId">-</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Application ID:</span>
                    <span class="detail-value" id="applicationId">-</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Date & Time:</span>
                    <span class="detail-value" id="timestamp">-</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Status:</span>
                    <span class="detail-value">
                        <span class="badge bg-success">Completed</span>
                    </span>
                </div>
                
                <!-- Amount -->
                <div class="amount-highlight">
                    <small class="text-muted d-block mb-2">Amount Paid</small>
                    <h2 id="amountPaid">LKR 0</h2>
                </div>
                
                <!-- Info Box -->
                <div class="info-box">
                    <i class="fas fa-info-circle me-2"></i>
                    <strong>Next Steps:</strong>
                    <ul class="mb-0 mt-2">
                        <li>A confirmation email has been sent to your registered email address</li>
                        <li>Please attend your biometric appointment on the scheduled date</li>
                        <li>You can track your application status in "My Applications"</li>
                    </ul>
                </div>
                
                <!-- Actions -->
                <div class="d-grid gap-2 mt-4">
                    <a href="applications.jsp" class="btn btn-primary btn-action">
                        <i class="fas fa-list me-2"></i>View My Applications
                    </a>
                    <a href="index.jsp" class="btn btn-outline-secondary btn-action">
                        <i class="fas fa-home me-2"></i>Back to Home
                    </a>
                </div>
                
                <!-- Print Receipt -->
                <div class="text-center mt-3">
                    <button onclick="window.print()" class="btn btn-link">
                        <i class="fas fa-print me-1"></i>Print Receipt
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Get URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const transactionId = urlParams.get('transactionId');
        const amount = urlParams.get('amount');
        const applicationId = urlParams.get('applicationId');
        
        // Display transaction details
        if (transactionId) {
            document.getElementById('transactionId').textContent = transactionId;
        }
        
        if (applicationId) {
            document.getElementById('applicationId').textContent = applicationId;
        }
        
        if (amount) {
            document.getElementById('amountPaid').textContent = 'LKR ' + parseFloat(amount).toLocaleString();
        }
        
        // Display current timestamp
        const now = new Date();
        const formattedDate = now.toLocaleDateString('en-US', { 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric' 
        });
        const formattedTime = now.toLocaleTimeString('en-US', { 
            hour: '2-digit', 
            minute: '2-digit'
        });
        document.getElementById('timestamp').textContent = formattedDate + ' at ' + formattedTime;
    </script>
</body>
</html>

