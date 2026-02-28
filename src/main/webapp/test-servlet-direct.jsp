<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Servlet Direct</title>
    <style>
        body { padding: 20px; font-family: Arial; }
        pre { background: #f5f5f5; padding: 10px; border: 1px solid #ccc; }
    </style>
</head>
<body>
    <h1>Testing Servlet Direct Connection</h1>
    <button onclick="testServlet()">Click to Test Servlet</button>
    <div id="result"></div>
    
    <script>
        function testServlet() {
            const ctx = '<%= request.getContextPath() %>';
            document.getElementById('result').innerHTML = '<p>Testing: ' + ctx + '/PaymentApproval?status=all</p>';
            
            fetch(ctx + '/PaymentApproval?status=all')
                .then(response => {
                    if (!response.ok) throw new Error('HTTP ' + response.status);
                    return response.json();
                })
                .then(data => {
                    document.getElementById('result').innerHTML += 
                        '<h3>✅ SUCCESS - Found ' + data.length + ' records</h3>' +
                        '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
                })
                .catch(error => {
                    document.getElementById('result').innerHTML += 
                        '<h3 style="color:red">❌ ERROR</h3><p>' + error.message + '</p>';
                });
        }
    </script>
</body>
</html>

