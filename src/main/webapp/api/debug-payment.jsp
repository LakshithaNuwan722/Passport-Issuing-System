<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Debug Test</title>
</head>
<body>
    <h1>Payment Debug Test</h1>
    
    <div id="debugInfo"></div>
    
    <h2>Test Payment</h2>
    <button onclick="testPayment()">Test Payment</button>
    <div id="result"></div>
    
    <script>
        function testPayment() {
            const debugInfo = document.getElementById('debugInfo');
            const result = document.getElementById('result');
            
            // Check localStorage
            const savedUser = localStorage.getItem('lankaEpassportUser');
            debugInfo.innerHTML = '<h3>Debug Info:</h3>';
            debugInfo.innerHTML += '<p>localStorage lankaEpassportUser: ' + (savedUser || 'NOT FOUND') + '</p>';
            
            if (savedUser) {
                const user = JSON.parse(savedUser);
                debugInfo.innerHTML += '<p>Parsed user object: ' + JSON.stringify(user, null, 2) + '</p>';
                debugInfo.innerHTML += '<p>NIC Number: ' + (user.nicNumber || 'NOT FOUND') + '</p>';
                
                // Test payment
                const formData = new FormData();
                formData.append('applicationId', '70');
                formData.append('paymentMethod', 'credit_card');
                formData.append('processingType', 'regular');
                formData.append('totalAmount', '7000');
                formData.append('processingFee', '5000');
                formData.append('serviceFee', '2000');
                formData.append('taxAmount', '0');
                formData.append('nicNumber', user.nicNumber);
                
                result.innerHTML = '<p>Testing payment...</p>';
                
                fetch('api/payment', {
                    method: 'POST',
                    body: formData
                })
                .then(response => {
                    result.innerHTML += '<p>Response status: ' + response.status + '</p>';
                    return response.json();
                })
                .then(data => {
                    result.innerHTML += '<p>Response data: ' + JSON.stringify(data, null, 2) + '</p>';
                })
                .catch(error => {
                    result.innerHTML += '<p>Error: ' + error.message + '</p>';
                });
            } else {
                debugInfo.innerHTML += '<p style="color: red;">No user found in localStorage. Please login first.</p>';
            }
        }
        
        // Auto-run test on page load
        window.onload = function() {
            testPayment();
        };
    </script>
</body>
</html>
