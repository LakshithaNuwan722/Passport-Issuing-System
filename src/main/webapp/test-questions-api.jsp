<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Questions API</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Test Questions API</h1>

    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h5>Submit Test Question</h5>
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
                                <option value="Payment & Fees">Payment & Fees</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="question" class="form-label">Question</label>
                            <textarea class="form-control" id="question" rows="3" required>This is a test question to verify the API is working.</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" value="test@example.com">
                        </div>
                        <button type="submit" class="btn btn-primary">Submit Test Question</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h5>API Response</h5>
                </div>
                <div class="card-body">
                    <pre id="response"></pre>
                </div>
            </div>

            <div class="card mt-3">
                <div class="card-header">
                    <h5>All Questions</h5>
                </div>
                <div class="card-body">
                    <button class="btn btn-secondary" onclick="loadQuestions()">Load Questions</button>
                    <div id="questionsList" class="mt-3"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('testForm').addEventListener('submit', async function(e) {
        e.preventDefault();

        const userName = document.getElementById('userName').value.trim();
        const subject = document.getElementById('subject').value.trim();
        const question = document.getElementById('question').value.trim();
        const email = document.getElementById('email').value.trim();

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
                    email: email,
                    category: 'general'
                })
            });

            const data = await response.json();
            document.getElementById('response').textContent = JSON.stringify(data, null, 2);

            if (response.ok) {
                alert('Question submitted successfully!');
                loadQuestions();
            } else {
                alert('Failed to submit question: ' + data.error);
            }
        } catch (error) {
            console.error('Error:', error);
            document.getElementById('response').textContent = 'Error: ' + error.message;
            alert('Error submitting question');
        }
    });

    async function loadQuestions() {
        try {
            const response = await fetch('api/questions');
            const data = await response.json();

            const questionsList = document.getElementById('questionsList');

            if (data.success && data.questions && data.questions.length > 0) {
                let html = '<h6>Questions in Database:</h6>';
                data.questions.forEach(q => {
                    html += `
                            <div class="card mb-2">
                                <div class="card-body">
                                    <h6>${q.question}</h6>
                                    <p><strong>Answer:</strong> ${q.answer || 'No answer yet'}</p>
                                    <small>Asked by: ${q.user_name || 'Anonymous'} | Subject: ${q.subject || 'N/A'}</small>
                                </div>
                            </div>
                        `;
                });
                questionsList.innerHTML = html;
            } else {
                questionsList.innerHTML = '<p>No questions found in database.</p>';
            }
        } catch (error) {
            console.error('Error loading questions:', error);
            document.getElementById('questionsList').innerHTML = '<p>Error loading questions: ' + error.message + '</p>';
        }
    }
</script>
</body>
</html>
