<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Test Single Application</title></head>
<body>
<h2>Testing Single Application Fetch</h2>
<button onclick="testFetch()">Test Fetch App ID 82</button>
<pre id="result"></pre>
<script>
async function testFetch() {
    const result = document.getElementById('result');
    try {
        const url = '<%=request.getContextPath()%>/api/application-review?id=82';
        result.textContent = 'Fetching: ' + url + '\n\n';
        
        const response = await fetch(url);
        result.textContent += 'Status: ' + response.status + '\n';
        
        const text = await response.text();
        result.textContent += 'Response:\n' + text;
    } catch (error) {
        result.textContent = 'ERROR: ' + error.message;
    }
}
</script>
</body>
</html>

