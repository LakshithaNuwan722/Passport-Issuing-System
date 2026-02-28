<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Database Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Database Connection Test</h1>
    
    <div class="card">
        <div class="card-header">
            <h5>Database Status</h5>
        </div>
        <div class="card-body">
            <%
                try {
                    Connection conn = Database.getConnection();
                    out.println("<div class='alert alert-success'>✓ Database connection successful!</div>");
                    
                    // Check if questions table exists
                    DatabaseMetaData metaData = conn.getMetaData();
                    ResultSet tables = metaData.getTables(null, null, "questions", null);
                    
                    if (tables.next()) {
                        out.println("<div class='alert alert-success'>✓ Questions table exists!</div>");
                        
                        // Show table structure
                        ResultSet columns = metaData.getColumns(null, null, "questions", null);
                        out.println("<h6>Table Structure:</h6>");
                        out.println("<table class='table table-sm'>");
                        out.println("<tr><th>Column</th><th>Type</th><th>Nullable</th></tr>");
                        while (columns.next()) {
                            out.println("<tr>");
                            out.println("<td>" + columns.getString("COLUMN_NAME") + "</td>");
                            out.println("<td>" + columns.getString("TYPE_NAME") + "</td>");
                            out.println("<td>" + columns.getString("IS_NULLABLE") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                        
                        // Count records
                        PreparedStatement countStmt = conn.prepareStatement("SELECT COUNT(*) FROM questions");
                        ResultSet countRs = countStmt.executeQuery();
                        if (countRs.next()) {
                            int count = countRs.getInt(1);
                            out.println("<div class='alert alert-info'>Total questions in database: " + count + "</div>");
                        }
                        
                        // Show recent questions
                        PreparedStatement selectStmt = conn.prepareStatement("SELECT * FROM questions ORDER BY created_at DESC LIMIT 5");
                        ResultSet selectRs = selectStmt.executeQuery();
                        out.println("<h6>Recent Questions:</h6>");
                        out.println("<table class='table table-sm'>");
                        out.println("<tr><th>ID</th><th>Question</th><th>Subject</th><th>User</th><th>Created</th></tr>");
                        while (selectRs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + selectRs.getInt("id") + "</td>");
                            out.println("<td>" + selectRs.getString("question") + "</td>");
                            out.println("<td>" + selectRs.getString("subject") + "</td>");
                            out.println("<td>" + selectRs.getString("user_name") + "</td>");
                            out.println("<td>" + selectRs.getTimestamp("created_at") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                        
                    } else {
                        out.println("<div class='alert alert-warning'>⚠ Questions table does not exist!</div>");
                        out.println("<p>Click the button below to create it:</p>");
                        out.println("<a href='api/init-db' class='btn btn-primary'>Initialize Database</a>");
                    }
                    
                    conn.close();
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>✗ Database error: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
    
    <div class="card mt-3">
        <div class="card-header">
            <h5>Test Question Submission</h5>
        </div>
        <div class="card-body">
            <form id="testForm">
                <div class="mb-3">
                    <label for="userName" class="form-label">Name</label>
                    <input type="text" class="form-control" id="userName" value="Test User" required>
                </div>
                <div class="mb-3">
                    <label for="subject" class="form-label">Subject</label>
                    <select class="form-control" id="subject" required>
                        <option value="General Inquiry">General Inquiry</option>
                        <option value="Application Process">Application Process</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="question" class="form-label">Question</label>
                    <textarea class="form-control" id="question" rows="3" required>Test question from database test page</textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit Test Question</button>
            </form>
            <div id="result" class="mt-3"></div>
        </div>
    </div>
</div>

<script>
document.getElementById('testForm').addEventListener('submit', async function(e) {
    e.preventDefault();
    
    const userName = document.getElementById('userName').value.trim();
    const subject = document.getElementById('subject').value.trim();
    const question = document.getElementById('question').value.trim();
    
    try {
        const response = await fetch('api/questions', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                action: 'submit',
                user_name: userName,
                subject: subject,
                question: question,
                email: 'test@example.com',
                category: 'general'
            })
        });
        
        const data = await response.json();
        const resultDiv = document.getElementById('result');
        
        if (response.ok && data.success) {
            resultDiv.innerHTML = '<div class="alert alert-success">✓ Question submitted successfully!</div>';
            setTimeout(() => location.reload(), 2000);
        } else {
            resultDiv.innerHTML = '<div class="alert alert-danger">✗ Failed: ' + (data.error || 'Unknown error') + '</div>';
        }
    } catch (error) {
        document.getElementById('result').innerHTML = '<div class="alert alert-danger">✗ Error: ' + error.message + '</div>';
    }
});
</script>
</body>
</html>