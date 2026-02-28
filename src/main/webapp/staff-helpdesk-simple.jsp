<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Helpdesk - Reply to Questions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
          --gov-primary: #003366;
          --gov-secondary: #004080;
          --gov-accent: #FFB81C;
          --gov-success: #006633;
          --gov-info: #005A9C;
          --gov-warning: #FF8C00;
          --gov-danger: #CC0000;
          --gov-dark: #1a1a1a;
          --gov-light: #f5f5f5;
          --gov-white: #ffffff;
          --gov-border: #e0e0e0;
          --gov-text: #333333;
          --gov-text-light: #666666;
        }

        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }

        body {
          font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
          color: var(--gov-text);
          line-height: 1.6;
          background-color: var(--gov-white);
        }

        /* Government-Style Navigation */
        .navbar {
          background: var(--gov-primary) !important;
          border-bottom: 3px solid var(--gov-accent);
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
          padding: 0.75rem 0;
          transition: all 0.3s ease;
        }

        .navbar.scrolled {
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
          padding: 0.5rem 0;
        }

        /* Government Brand */
        .navbar-brand {
          font-size: 1.4rem;
          font-weight: 700;
          color: var(--gov-white) !important;
          display: flex;
          align-items: center;
          gap: 0.75rem;
        }

        .brand-icon {
          width: 45px;
          height: 45px;
          background: var(--gov-white);
          border-radius: 8px;
          display: flex;
          align-items: center;
          justify-content: center;
          color: var(--gov-primary);
          font-size: 1.5rem;
          border: 2px solid var(--gov-accent);
        }

        .brand-title {
          font-weight: 700;
          letter-spacing: 0.5px;
          line-height: 1.2;
        }

        .brand-subtitle {
          font-size: 0.7rem;
          opacity: 0.9;
          font-weight: 400;
          letter-spacing: 0.3px;
          display: block;
          margin-top: 2px;
        }

        /* Professional Navigation Links */
        .nav-link-modern {
          padding: 0.5rem 1rem !important;
          margin: 0 0.15rem;
          color: rgba(255, 255, 255, 0.9) !important;
          font-weight: 500;
          font-size: 0.95rem;
          transition: all 0.2s ease;
          border-radius: 4px;
        }

        .nav-link-modern:hover {
          background: rgba(255, 255, 255, 0.15);
          color: var(--gov-white) !important;
        }

        .nav-link-modern.active {
          background: rgba(255, 255, 255, 0.2);
          color: var(--gov-white) !important;
          font-weight: 600;
        }

        /* Government-Style Buttons */
        .btn-modern-nav {
          border-radius: 4px;
          padding: 0.5rem 1.25rem;
          font-weight: 600;
          font-size: 0.9rem;
          transition: all 0.2s ease;
          border: none;
          text-transform: none;
          letter-spacing: 0.3px;
        }

        .btn-modern-nav:hover {
          transform: translateY(-1px);
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* Mobile Navigation */
        .navbar-toggler {
          border: none;
          padding: 0.5rem;
          border-radius: 10px;
          transition: all 0.3s ease;
        }

        .navbar-toggler:focus {
          box-shadow: none;
          outline: none;
        }

        .navbar-toggler:hover {
          background: rgba(255, 255, 255, 0.1);
        }

        .navbar-toggler-icon {
          transition: all 0.3s ease;
        }

        .navbar-toggler[aria-expanded="true"] .navbar-toggler-icon {
          transform: rotate(90deg);
        }

        /* Responsive Navigation */
        @media (max-width: 991.98px) {
          .navbar-collapse {
            background: rgba(13, 110, 253, 0.98);
            border-radius: 15px;
            margin-top: 1rem;
            padding: 1rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
          }

          .nav-link-modern {
            margin: 0.25rem 0;
            text-align: center;
          }

          .btn-modern-nav {
            margin: 0.5rem 0;
            width: 100%;
          }

          .brand-subtitle {
            display: none !important;
          }
        }

        /* Staff Helpdesk Simple specific styles */
        .staff-header {
            background: linear-gradient(135deg, var(--gov-primary), var(--gov-info));
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .question-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        .question-card:hover {
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .unanswered {
            border-left: 4px solid var(--gov-warning);
        }
        .answered {
            border-left: 4px solid var(--gov-success);
        }
    </style>
</head>
<body>
    <!-- Enhanced Professional Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNavbar">
      <div class="container">
        <!-- Enhanced Brand -->
        <a class="navbar-brand fw-bold d-flex align-items-center" href="index.jsp">
          <div class="brand-icon me-3">
            <i class="fas fa-passport"></i>
          </div>
          <div class="brand-text">
            <span class="brand-title">Lanka Epassport Service</span>
            <small class="brand-subtitle d-none d-sm-block">Official Government Portal</small>
          </div>
        </a>

        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navigation Menu -->
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item">
              <a class="nav-link nav-link-modern" href="index.jsp">
                <i class="fas fa-home me-1 d-none d-sm-inline"></i>
                <span>Home</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link nav-link-modern" href="application.jsp">
                <i class="fas fa-plus me-1 d-none d-sm-inline"></i>
                <span>New Application</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link nav-link-modern" href="applications.jsp">
                <i class="fas fa-list me-1 d-none d-sm-inline"></i>
                <span>My Applications</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link nav-link-modern" href="helpdesk.jsp">
                <i class="fas fa-question-circle me-1 d-none d-sm-inline"></i>
                <span>Help Desk</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link nav-link-modern" href="profile.jsp">
                <i class="fas fa-user me-1 d-none d-sm-inline"></i>
                <span>Profile</span>
              </a>
            </li>
            <li class="nav-item ms-2">
                <a class="nav-link btn btn-primary btn-modern-nav" href="application.jsp">
                  <i class="fas fa-file-alt me-1"></i>
                  <span>Apply Now</span>
                </a>
            </li>
            <li class="nav-item ms-2">
              <a class="nav-link btn btn-warning btn-modern-nav" href="staff-login.jsp">
                <i class="fas fa-user-tie me-1"></i>
                <span>Staff Login</span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Staff Header -->
    <div class="staff-header">
        <div class="container">
            <h1 class="display-5 fw-bold mb-3">
                <i class="fas fa-user-tie me-3"></i>
                Staff Helpdesk Management
            </h1>
            <p class="lead mb-0">Reply to user questions and manage support requests</p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- Instructions -->
        <div class="alert alert-info mb-4">
            <h5><i class="fas fa-info-circle me-2"></i>How to Use This Page</h5>
            <ol class="mb-0">
                <li><strong>View Questions:</strong> All user questions are displayed below</li>
                <li><strong>Reply to Questions:</strong> Click "Reply" on unanswered questions</li>
                <li><strong>Enter Answer:</strong> Type your response in the text area</li>
                <li><strong>Submit:</strong> Click "Submit Answer" to save your response</li>
            </ol>
        </div>

        <!-- Questions List -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-warning text-dark">
                        <h5><i class="fas fa-question-circle me-2"></i>User Questions</h5>
                    </div>
                    <div class="card-body">
                        <div id="questionsList">
                            <div class="text-center">
                                <div class="spinner-border text-primary" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                                <p class="mt-2">Loading questions...</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Reply Modal -->
    <div class="modal fade" id="replyModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-reply me-2"></i>Reply to Question
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label"><strong>Question:</strong></label>
                        <div class="p-3 bg-light rounded" id="questionText"></div>
                    </div>
                    <div class="mb-3">
                        <label for="answerText" class="form-label"><strong>Your Answer:</strong></label>
                        <textarea class="form-control" id="answerText" rows="6" placeholder="Enter your detailed answer here..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="submitReply()">
                        <i class="fas fa-paper-plane me-2"></i>Submit Answer
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Enhanced Navbar scroll effect
        window.addEventListener('scroll', function() {
          const navbar = document.getElementById('mainNavbar');
          if (navbar) {
            if (window.scrollY > 50) {
              navbar.classList.add('scrolled');
            } else {
              navbar.classList.remove('scrolled');
            }
          }
        });

        // Set active nav link based on current page
        document.addEventListener('DOMContentLoaded', function() {
          const currentPage = window.location.pathname.split('/').pop();
          const navLinks = document.querySelectorAll('.nav-link-modern');

          navLinks.forEach(link => {
            const href = link.getAttribute('href');
            if (href && (href === currentPage || (currentPage === '' && href === 'index.jsp'))) {
              link.classList.add('active');
            }
          });
        });

        let currentQuestionId = null;
        let questions = [];

        // Load questions on page load
        document.addEventListener('DOMContentLoaded', function() {
            loadQuestions();
        });

        // Load questions from API
        async function loadQuestions() {
            try {
                const response = await fetch('api/questions', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                if (response.ok) {
                    const data = await response.json();
                    questions = data.questions || [];
                    displayQuestions(questions);
                } else {
                    showError('Failed to load questions');
                }
            } catch (error) {
                console.error('Error loading questions:', error);
                showError('Error loading questions');
            }
        }

        // Display questions
        function displayQuestions(questions) {
            const container = document.getElementById('questionsList');
            
            if (questions.length === 0) {
                container.innerHTML = `
                    <div class="text-center py-4 text-muted">
                        <i class="fas fa-inbox fa-3x mb-3"></i>
                        <h5>No questions found</h5>
                        <p>No user questions have been submitted yet.</p>
                    </div>
                `;
                return;
            }

            // Sort questions: unanswered first, then by date
            const sortedQuestions = questions.sort((a, b) => {
                if (a.answer && !b.answer) return 1;
                if (!a.answer && b.answer) return -1;
                return new Date(b.created_at) - new Date(a.created_at);
            });

            container.innerHTML = sortedQuestions.map(q => `
                <div class="question-card ${q.answer ? 'answered' : 'unanswered'} p-3">
                    <div class="row">
                        <div class="col-md-8">
                            <h6 class="fw-bold mb-2">
                                <i class="fas fa-question-circle text-primary me-2"></i>
                                ${escapeHtml(q.question)}
                            </h6>
                            <p class="text-muted mb-2">
                                <i class="fas fa-user me-1"></i>
                                Asked by: <strong>${escapeHtml(q.user_name || 'Anonymous')}</strong>
                            </p>
                            <p class="text-muted mb-2">
                                <i class="fas fa-envelope me-1"></i>
                                Email: ${escapeHtml(q.user_email || 'Not provided')}
                            </p>
                            <p class="text-muted mb-2">
                                <i class="fas fa-clock me-1"></i>
                                Asked on: ${formatDate(q.created_at)}
                            </p>
                            ${q.answer ? `
                                <div class="mt-3 p-3 bg-success bg-opacity-10 rounded">
                                    <h6 class="text-success mb-2">
                                        <i class="fas fa-check-circle me-2"></i>Answer:
                                    </h6>
                                    <p class="mb-0">${escapeHtml(q.answer)}</p>
                                </div>
                            ` : ''}
                        </div>
                        <div class="col-md-4 text-end">
                            <span class="badge bg-${q.answer ? 'success' : 'warning'} mb-2">
                                ${q.answer ? 'Answered' : 'Unanswered'}
                            </span>
                            <div>
                                ${!q.answer ? `
                                    <button class="btn btn-primary btn-sm" onclick="openReplyModal(${q.id})">
                                        <i class="fas fa-reply me-1"></i>Reply
                                    </button>
                                ` : `
                                    <button class="btn btn-outline-primary btn-sm" onclick="openReplyModal(${q.id})">
                                        <i class="fas fa-edit me-1"></i>Edit Answer
                                    </button>
                                `}
                            </div>
                        </div>
                    </div>
                </div>
            `).join('');
        }

        // Open reply modal
        function openReplyModal(questionId) {
            const question = questions.find(q => q.id === questionId);
            if (!question) return;

            currentQuestionId = questionId;
            document.getElementById('questionText').textContent = question.question;
            document.getElementById('answerText').value = question.answer || '';
            
            new bootstrap.Modal(document.getElementById('replyModal')).show();
        }

        // Submit reply
        async function submitReply() {
            const answer = document.getElementById('answerText').value.trim();
            
            if (!answer) {
                alert('Please enter an answer');
                return;
            }

            try {
                const response = await fetch('api/questions', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        action: 'reply',
                        questionId: currentQuestionId,
                        answer: answer
                    })
                });

                if (response.ok) {
                    const data = await response.json();
                    if (data.success) {
                        alert('Answer submitted successfully!');
                        bootstrap.Modal.getInstance(document.getElementById('replyModal')).hide();
                        loadQuestions(); // Reload questions
                    } else {
                        alert('Failed to submit answer: ' + (data.message || 'Unknown error'));
                    }
                } else {
                    alert('Failed to submit answer');
                }
            } catch (error) {
                console.error('Error submitting reply:', error);
                alert('Error submitting answer');
            }
        }

        // Utility functions
        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        }

        function showError(message) {
            document.getElementById('questionsList').innerHTML = `
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${message}
                </div>
            `;
        }
    </script>
</body>
</html>
