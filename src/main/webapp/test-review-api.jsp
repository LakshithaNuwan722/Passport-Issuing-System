<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Review API</title>
</head>
<body>
    <h1>Testing Application Review API</h1>
    <button onclick="testAPI()">Test API Call</button>
    <pre id="result"></pre>

    <script>
        async function testAPI() {
            const resultDiv = document.getElementById('result');
            resultDiv.textContent = 'Loading...';
            
            try {
                const basePath = '<%= request.getContextPath() %>';
                const url = basePath + '/api/application-review';
                
                resultDiv.textContent = 'Calling: ' + url + '\n\n';
                
                const response = await fetch(url);
                
                resultDiv.textContent += 'Status: ' + response.status + '\n';
                resultDiv.textContent += 'Status Text: ' + response.statusText + '\n\n';
                
                const data = await response.text();
                resultDiv.textContent += 'Response:\n' + data;
                
            } catch (error) {
                resultDiv.textContent = 'ERROR: ' + error.message;
            }
        }
    </script>
</body>
</html>

