<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Debug & Fix</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .section { margin: 20px 0; padding: 15px; border: 1px solid #ddd; }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
        button { padding: 10px 20px; margin: 5px; cursor: pointer; }
        pre { background: #f5f5f5; padding: 10px; overflow-x: auto; }
    </style>
</head>
<body>
    <h1>Payment System Debug & Fix</h1>
    
    <div class="section">
        <h2>Step 1: Check User Session</h2>
        <div id="sessionInfo"></div>
        <button onclick="checkSession()">Check Session</button>
    </div>
    
    <div class="section">
        <h2>Step 2: Test Payment Servlet</h2>
        <div id="servletTest"></div>
        <button onclick="testServlet()">Test Servlet</button>
    </div>
    
    <div class="section">
        <h2>Step 3: Submit Test Payment</h2>
        <div>Application ID: <input type="number" id="testAppId" value="82"></div>
        <div>NIC Number: <input type="text" id="testNic" placeholder="Enter your NIC"></div>
        <div id="paymentResult"></div>
        <button onclick="submitTestPayment()">Submit Test Payment</button>
    </div>

    <script>
        function checkSession() {
            const savedUser = localStorage.getItem('lankaEpassportUser');
            const sessionInfo = document.getElementById('sessionInfo');
            
            if (savedUser) {
                const user = JSON.parse(savedUser);
                sessionInfo.innerHTML = `
                    <div class="success">
                        <h3>✓ User Found in localStorage</h3>
                        <pre>${JSON.stringify(user, null, 2)}</pre>
                        <p>NIC: ${user.nicNumber || user.nic || 'NOT FOUND'}</p>
                    </div>
                `;
                document.getElementById('testNic').value = user.nicNumber || user.nic || '';
            } else {
                sessionInfo.innerHTML = `
                    <div class="error">
                        <h3>✗ No User in localStorage</h3>
                        <p>Please login first at <a href="login.jsp">login.jsp</a></p>
                    </div>
                `;
            }
        }
        
        function testServlet() {
            const savedUser = localStorage.getItem('lankaEpassportUser');
            if (!savedUser) {
                alert('Please check session first and login if needed');
                return;
            }
            
            const user = JSON.parse(savedUser);
            const nic = user.nicNumber || user.nic;
            
            fetch('api/payment?test=true&nicNumber=' + nic)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('servletTest').innerHTML = `
                        <div class="success">
                            <h3>✓ Servlet Responding</h3>
                            <pre>${JSON.stringify(data, null, 2)}</pre>
                        </div>
                    `;
                })
                .catch(error => {
                    document.getElementById('servletTest').innerHTML = `
                        <div class="error">
                            <h3>✗ Servlet Error</h3>
                            <pre>${error.message}</pre>
                        </div>
                    `;
                });
        }
        
        function submitTestPayment() {
            const appId = document.getElementById('testAppId').value;
            const nic = document.getElementById('testNic').value;
            
            if (!nic) {
                alert('Please enter NIC number');
                return;
            }
            
            const formData = new FormData();
            formData.append('nicNumber', nic);
            formData.append('applicationId', appId);
            formData.append('paymentMethod', 'credit_card');
            formData.append('processingType', 'regular');
            formData.append('totalAmount', '17000');
            formData.append('processingFee', '15000');
            formData.append('serviceFee', '2000');
            formData.append('taxAmount', '0');
            
            console.log('Submitting test payment...');
            for (let [key, value] of formData.entries()) {
                console.log(key + ': ' + value);
            }
            
            fetch('api/payment', {
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
                        text: text,
                        data: JSON.parse(text)
                    };
                });
            })
            .then(result => {
                const paymentResult = document.getElementById('paymentResult');
                if (result.ok && result.data.success) {
                    paymentResult.innerHTML = `
                        <div class="success">
                            <h3>✓ Payment Successful!</h3>
                            <pre>${JSON.stringify(result.data, null, 2)}</pre>
                            <p>Now try the real payment page: <a href="payment-gateway.jsp?applicationId=${appId}">payment-gateway.jsp</a></p>
                        </div>
                    `;
                } else {
                    paymentResult.innerHTML = `
                        <div class="error">
                            <h3>✗ Payment Failed (Status: ${result.status})</h3>
                            <pre>${JSON.stringify(result.data, null, 2)}</pre>
                            <h4>Full Response:</h4>
                            <pre>${result.text}</pre>
                        </div>
                    `;
                }
            })
            .catch(error => {
                console.error('Payment error:', error);
                document.getElementById('paymentResult').innerHTML = `
                    <div class="error">
                        <h3>✗ Request Failed</h3>
                        <pre>${error.message}</pre>
                    </div>
                `;
            });
        }
        
        // Auto-check session on load
        window.addEventListener('load', checkSession);
    </script>
</body>
</html>

