<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Approval Debug</title>
    <style>
        body { font-family: Arial; padding: 20px; background: #f5f5f5; }
        .test-box { background: white; padding: 20px; margin: 10px 0; border-radius: 5px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .success { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
        button { padding: 10px 20px; margin: 5px; cursor: pointer; }
    </style>
</head>
<body>
    <h1>🔍 Payment Approval System - Debug</h1>
    
    <div class="test-box">
        <h2>✅ Step 1: JSP Compilation</h2>
        <p class="success">SUCCESS - This JSP is loading correctly!</p>
        <p>Context Path: <%= request.getContextPath() %></p>
        <p>Server: <%= application.getServerInfo() %></p>
    </div>
    
    <div class="test-box">
        <h2>Step 2: Test Servlet Connection</h2>
        <button onclick="testServlet()">Test PaymentApproval Servlet</button>
        <div id="servletResult"></div>
    </div>
    
    <div class="test-box">
        <h2>Step 3: Test Database</h2>
        <button onclick="testDatabase()">Test Database Connection</button>
        <div id="dbResult"></div>
    </div>
    
    <div class="test-box">
        <h2>Step 4: Test Data Query</h2>
        <button onclick="testData()">Check Payment Data</button>
        <div id="dataResult"></div>
    </div>
    
    <div class="test-box">
        <h2>Step 5: View Actual Page</h2>
        <a href="payment-approval.jsp" target="_blank">
            <button>Open Payment Approval Page</button>
        </a>
    </div>
    
    <script>
        const ctx = '<%= request.getContextPath() %>';
        
        function testServlet() {
            const resultDiv = document.getElementById('servletResult');
            resultDiv.innerHTML = '<p>Testing servlet...</p>';
            
            fetch(ctx + '/PaymentApproval?status=all')
                .then(response => {
                    console.log('Servlet Response Status:', response.status);
                    if (!response.ok) {
                        throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Servlet Response Data:', data);
                    resultDiv.innerHTML = '<p class="success">✅ Servlet is working!</p>' +
                        '<p>Returned ' + (Array.isArray(data) ? data.length : 0) + ' records</p>' +
                        '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
                })
                .catch(error => {
                    console.error('Servlet Error:', error);
                    resultDiv.innerHTML = '<p class="error">❌ ERROR: ' + error.message + '</p>' +
                        '<p>Check console for details</p>';
                });
        }
        
        function testDatabase() {
            const resultDiv = document.getElementById('dbResult');
            resultDiv.innerHTML = '<p>Testing database...</p>';
            
            fetch(ctx + '/api/db-test.jsp')
                .then(response => response.text())
                .then(html => {
                    resultDiv.innerHTML = '<p class="success">✅ Database test completed</p>' +
                        '<div>' + html + '</div>';
                })
                .catch(error => {
                    resultDiv.innerHTML = '<p class="error">❌ ERROR: ' + error.message + '</p>';
                });
        }
        
        function testData() {
            const resultDiv = document.getElementById('dataResult');
            resultDiv.innerHTML = '<p>Checking payment data...</p>';
            
            fetch(ctx + '/PaymentApproval?status=pending')
                .then(response => response.json())
                .then(data => {
                    if (data.length === 0) {
                        resultDiv.innerHTML = '<p class="error">⚠️ No pending payments found</p>' +
                            '<p>You need to create test payment data first</p>';
                    } else {
                        resultDiv.innerHTML = '<p class="success">✅ Found ' + data.length + ' pending payments</p>' +
                            '<pre>' + JSON.stringify(data[0], null, 2) + '</pre>';
                    }
                })
                .catch(error => {
                    resultDiv.innerHTML = '<p class="error">❌ ERROR: ' + error.message + '</p>';
                });
        }
    </script>
</body>
</html>

