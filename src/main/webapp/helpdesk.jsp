<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help Desk - Lanka Epassport Service</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Government Style CSS -->
    <link rel="stylesheet" href="assets/css/government-style.css">

    <style>
        .page-header {
            background: linear-gradient(135deg, var(--gov-primary) 0%, var(--gov-secondary) 100%);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            border-bottom: 3px solid var(--gov-accent);
        }
        .hero {
            background: linear-gradient(135deg, #FFB703 0%, #FB8500 100%);
            color: white;
            padding: 3rem 0;
            border-radius: 0 0 1rem 1rem;
        }
        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .faq-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            overflow: hidden;
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            position: relative;
            margin-bottom: 2rem;
        }

        .faq-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 16px 48px rgba(0,0,0,0.15);
        }

        .faq-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--card-color), var(--card-color-light));
        }

        .faq-card.application {
            --card-color: #007bff;
            --card-color-light: #4dabf7;
        }

        .faq-card.payment {
            --card-color: #28a745;
            --card-color-light: #34ce57;
        }

        .faq-card.tracking {
            --card-color: #ffc107;
            --card-color-light: #ffed4e;
        }

        .faq-card.delivery {
            --card-color: #dc3545;
            --card-color-light: #e85d6b;
        }

        .card-icon.application-icon {
            background: linear-gradient(135deg, #007bff, #4dabf7);
            color: white;
        }

        .card-icon.payment-icon {
            background: linear-gradient(135deg, #28a745, #34ce57);
            color: white;
        }

        .card-icon.tracking-icon {
            background: linear-gradient(135deg, #ffc107, #ffed4e);
            color: #856404;
        }

        .card-icon.delivery-icon {
            background: linear-gradient(135deg, #dc3545, #e85d6b);
            color: white;
        }

        .faq-card:hover .card-icon {
            transform: scale(1.1);
        }

        .card-title {
            font-weight: 700;
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }

        .card-description {
            color: #6c757d;
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 1rem;
        }

        .helpdesk-btn {
            border-radius: 12px;
            padding: 0.5rem 1.25rem;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            border: none;
            position: relative;
            overflow: hidden;
        }

        .helpdesk-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .helpdesk-btn:hover::before {
            left: 100%;
        }

        .helpdesk-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        .badge-counter {
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
        }

        .accordion-button:not(.collapsed) {
            background-color: rgba(102, 126, 234, 0.1);
            color: #667eea;
        }

        .accordion-button:focus {
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <h1><i class="fas fa-question-circle me-2"></i>Help Desk</h1>
        <p class="lead">Find answers to common questions or submit your own inquiry</p>
    </div>
</div>

<!-- Main Content -->
<main class="container mb-5">
    <div class="row">
        <!-- FAQ Section -->
        <div class="col-lg-8">
            <h2 class="mb-4"><i class="fas fa-lightbulb me-2"></i>Frequently Asked Questions</h2>

            <!-- Application Process FAQ -->
            <div class="faq-card application">
                <div class="card-body p-4">
                    <div class="d-flex align-items-start">
                        <div class="card-icon application-icon">
                            <i class="fas fa-file-alt"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h5 class="card-title">
                                Application Process
                                <span class="badge bg-primary badge-counter">9 Questions</span>
                            </h5>
                            <p class="card-description">Everything about passport application requirements, eligibility, and procedures.</p>
                        </div>
                    </div>

                    <div class="accordion mt-3" id="applicationAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#app1">
                                    What documents do I need to apply for a passport?
                                </button>
                            </h2>
                            <div id="app1" class="accordion-collapse collapse" data-bs-parent="#applicationAccordion">
                                <div class="accordion-body">
                                    You need: Original birth certificate, NIC (National Identity Card), recent passport-size photographs (2 copies), completed application form, and proof of address. For renewals, bring your old passport.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#app2">
                                    How long does the application process take?
                                </button>
                            </h2>
                            <div id="app2" class="accordion-collapse collapse" data-bs-parent="#applicationAccordion">
                                <div class="accordion-body">
                                    Standard processing takes 7-10 business days from the date of application submission. Express processing (additional fee) takes 3-5 business days.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#app3">
                                    Can I apply for a passport online?
                                </button>
                            </h2>
                            <div id="app3" class="accordion-collapse collapse" data-bs-parent="#applicationAccordion">
                                <div class="accordion-body">
                                    Yes, you can start your application online through our portal. However, you must visit our office in person for document verification and biometric capture.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#app4">
                                    What are the age requirements for passport application?
                                </button>
                            </h2>
                            <div id="app4" class="accordion-collapse collapse" data-bs-parent="#applicationAccordion">
                                <div class="accordion-body">
                                    Children under 16 need parental consent and both parents' presence during application. Adults 16 and above can apply independently with valid identification.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#app5">
                                    Can I change my name on the passport?
                                </button>
                            </h2>
                            <div id="app5" class="accordion-collapse collapse" data-bs-parent="#applicationAccordion">
                                <div class="accordion-body">
                                    Name changes require legal documentation (marriage certificate, deed poll, court order). Additional fees apply for name change applications.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Payment & Invoices FAQ -->
            <div class="faq-card payment">
                <div class="card-body p-4">
                    <div class="d-flex align-items-start">
                        <div class="card-icon payment-icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h5 class="card-title">
                                Payment & Invoices
                                <span class="badge bg-success badge-counter">7 Questions</span>
                            </h5>
                            <p class="card-description">Information about payment methods, fees, invoices, and refunds.</p>
                        </div>
                    </div>

                    <div class="accordion mt-3" id="paymentAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#pay1">
                                    What payment methods do you accept?
                                </button>
                            </h2>
                            <div id="pay1" class="accordion-collapse collapse" data-bs-parent="#paymentAccordion">
                                <div class="accordion-body">
                                    We accept credit/debit cards (Visa, MasterCard), bank transfers, and cash payments at our office. Online payments are processed securely through our payment gateway.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#pay2">
                                    How much does a passport cost?
                                </button>
                            </h2>
                            <div id="pay2" class="accordion-collapse collapse" data-bs-parent="#paymentAccordion">
                                <div class="accordion-body">
                                    Standard passport: LKR 7,500. Express passport: LKR 12,500. Additional fees apply for name changes (LKR 2,000) and lost passport replacement (LKR 15,000).
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#pay3">
                                    Can I get a refund if I cancel my application?
                                </button>
                            </h2>
                            <div id="pay3" class="accordion-collapse collapse" data-bs-parent="#paymentAccordion">
                                <div class="accordion-body">
                                    Refunds are available if cancellation is made before processing begins (within 24 hours). Processing fees (LKR 1,500) are non-refundable. Express service fees are non-refundable.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#pay4">
                                    How can I download my invoice?
                                </button>
                            </h2>
                            <div id="pay4" class="accordion-collapse collapse" data-bs-parent="#paymentAccordion">
                                <div class="accordion-body">
                                    Log into your account and go to "My Applications" → "Payment History" → "Download Invoice". Invoices are also emailed to you after successful payment.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Status Tracking FAQ -->
            <div class="faq-card tracking">
                <div class="card-body p-4">
                    <div class="d-flex align-items-start">
                        <div class="card-icon tracking-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h5 class="card-title">
                                Status Tracking
                                <span class="badge bg-warning text-dark badge-counter">6 Questions</span>
                            </h5>
                            <p class="card-description">Track your application status and understand processing stages.</p>
                        </div>
                    </div>

                    <div class="accordion mt-3" id="trackingAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#track1">
                                    How can I check my application status?
                                </button>
                            </h2>
                            <div id="track1" class="accordion-collapse collapse" data-bs-parent="#trackingAccordion">
                                <div class="accordion-body">
                                    Use your application ID to check status online, call our helpline, or visit our office. You'll also receive SMS updates at key processing stages.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#track2">
                                    What do the different status messages mean?
                                </button>
                            </h2>
                            <div id="track2" class="accordion-collapse collapse" data-bs-parent="#trackingAccordion">
                                <div class="accordion-body">
                                    "Submitted" - Application received, "Under Review" - Documents being verified, "Approved" - Ready for printing, "Printed" - Passport ready for collection/delivery, "Dispatched" - Sent for delivery.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#track3">
                                    Why is my application taking longer than expected?
                                </button>
                            </h2>
                            <div id="track3" class="accordion-collapse collapse" data-bs-parent="#trackingAccordion">
                                <div class="accordion-body">
                                    Delays can occur due to document verification issues, high application volume, or incomplete information. Contact us if processing exceeds the standard timeframe.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Delivery & Logistics FAQ -->
            <div class="faq-card delivery">
                <div class="card-body p-4">
                    <div class="d-flex align-items-start">
                        <div class="card-icon delivery-icon">
                            <i class="fas fa-truck"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h5 class="card-title">
                                Delivery & Logistics
                                <span class="badge bg-danger badge-counter">6 Questions</span>
                            </h5>
                            <p class="card-description">Information about passport delivery options and collection procedures.</p>
                        </div>
                    </div>

                    <div class="accordion mt-3" id="deliveryAccordion">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#del1">
                                    Can I have my passport delivered to my home?
                                </button>
                            </h2>
                            <div id="del1" class="accordion-collapse collapse" data-bs-parent="#deliveryAccordion">
                                <div class="accordion-body">
                                    Yes, home delivery is available for LKR 500 within Colombo and LKR 800 for other districts. Delivery takes 2-3 business days after printing.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#del2">
                                    How can I track my passport delivery?
                                </button>
                            </h2>
                            <div id="del2" class="accordion-collapse collapse" data-bs-parent="#deliveryAccordion">
                                <div class="accordion-body">
                                    Use the tracking number provided in your SMS notification. Track online through our delivery portal or call our logistics team for real-time updates.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#del3">
                                    What if I'm not home when delivery is attempted?
                                </button>
                            </h2>
                            <div id="del3" class="accordion-collapse collapse" data-bs-parent="#deliveryAccordion">
                                <div class="accordion-body">
                                    We'll attempt delivery twice. If unsuccessful, you can collect from our office or reschedule delivery. Additional fees may apply for rescheduling.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Ask Question Form -->
        <div class="col-lg-4">
            <div class="card h-100">
                <div class="card-header bg-primary text-white">
                    <h5><i class="fas fa-plus-circle me-2"></i>Ask a Question</h5>
                </div>
                <div class="card-body">
                    <form id="questionForm">
                        <div class="mb-3">
                            <label for="userName" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="userName" placeholder="Enter your full name" required>
                        </div>
                        <div class="mb-3">
                            <label for="subject" class="form-label">Subject</label>
                            <select class="form-control" id="subject" required>
                                <option value="">Select a subject</option>
                                <option value="Application Process">Application Process</option>
                                <option value="Payment & Fees">Payment & Fees</option>
                                <option value="Status Tracking">Status Tracking</option>
                                <option value="Delivery & Logistics">Delivery & Logistics</option>
                                <option value="Technical Support">Technical Support</option>
                                <option value="General Inquiry">General Inquiry</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="question" class="form-label">Your Question</label>
                            <textarea class="form-control" id="question" rows="3" placeholder="Enter your question here..." required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email (Optional)</label>
                            <input type="email" class="form-control" id="email" placeholder="your@email.com">
                        </div>
                        <button type="submit" class="btn btn-primary helpdesk-btn w-100">
                            <i class="fas fa-paper-plane me-2"></i>Submit Question
                        </button>
                    </form>
                </div>
            </div>

            <!-- Recent Questions -->
            <div class="card mt-4">
                <div class="card-header">
                    <h5><i class="fas fa-list me-2"></i>Recent Questions</h5>
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
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Load questions on page load
    document.addEventListener('DOMContentLoaded', function() {
        loadQuestions();
        checkStaffStatus();
    });

    // Map subject to category
    function mapSubjectToCategory(subject) {
        const mapping = {
            'Application Process': 'application',
            'Payment & Fees': 'payment',
            'Status Tracking': 'tracking',
            'Delivery & Logistics': 'delivery',
            'Technical Support': 'technical',
            'General Inquiry': 'general'
        };
        return mapping[subject] || 'general';
    }

    // Check if user is staff
    async function checkStaffStatus() {
        try {
            const response = await fetch('api/staff-login', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            if (response.ok) {
                const data = await response.json();
                if (data.loggedIn && data.section === 'helpdesk') {
                    showStaffInterface();
                }
            }
        } catch (error) {
            console.error('Error checking staff status:', error);
        }
    }

    // Show staff interface
    function showStaffInterface() {
        // Add staff-only elements
        const questionsCard = document.querySelector('.card.mt-4');
        if (questionsCard) {
            const staffSection = document.createElement('div');
            staffSection.className = 'card mt-4';
            staffSection.innerHTML = `
                    <div class="card-header bg-warning text-dark">
                        <h5><i class="fas fa-user-tie me-2"></i>Staff - Unanswered Questions</h5>
                    </div>
                    <div class="card-body">
                        <div id="unansweredQuestionsList">
                            <div class="text-center">
                                <div class="spinner-border text-warning" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                                <p class="mt-2">Loading unanswered questions...</p>
                            </div>
                        </div>
                    </div>
                `;
            questionsCard.parentNode.insertBefore(staffSection, questionsCard.nextSibling);
            loadUnansweredQuestions();
        }
    }

    // Submit question form
    document.getElementById('questionForm').addEventListener('submit', async function(e) {
        e.preventDefault();

        const userName = document.getElementById('userName').value.trim();
        const subject = document.getElementById('subject').value.trim();
        const question = document.getElementById('question').value.trim();
        const email = document.getElementById('email').value.trim();

        if (!userName) {
            alert('Please enter your name');
            return;
        }

        if (!subject) {
            alert('Please select a subject');
            return;
        }

        if (!question) {
            alert('Please enter a question');
            return;
        }

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
                    category: mapSubjectToCategory(subject)
                })
            });

            if (response.ok) {
                alert('Question submitted successfully!');
                document.getElementById('questionForm').reset();
                loadQuestions(); // Reload questions
            } else {
                alert('Failed to submit question');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Error submitting question');
        }
    });

    // Load questions from API
    async function loadQuestions() {
        try {
            const response = await fetch('api/questions');
            const data = await response.json();

            const questionsList = document.getElementById('questionsList');

            if (data.success && data.questions && data.questions.length > 0) {
                let html = '';
                data.questions.forEach(q => {
                    html += `
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h6 class="card-title mb-0">
                                            <i class="fas fa-question-circle text-primary me-2"></i>
                                            ${q.question}
                                        </h6>
                                        <span class="badge bg-primary">${q.subject}</span>
                                    </div>
                                    <p class="card-text">
                                        <strong>Answer:</strong> ${q.answer}
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            <i class="fas fa-user me-1"></i>
                                            Asked by: ${q.user_name || 'Anonymous'}
                                        </small>
                                        <small class="text-muted">
                                            <i class="fas fa-clock me-1"></i>
                                            ${q.created_at}
                                        </small>
                                    </div>
                                </div>
                            </div>
                        `;
                });
                questionsList.innerHTML = html;
            } else {
                questionsList.innerHTML = `
                        <div class="text-center text-muted">
                            <i class="fas fa-inbox fa-3x mb-3"></i>
                            <p>No answered questions yet. Be the first to ask!</p>
                        </div>
                    `;
            }
        } catch (error) {
            console.error('Error loading questions:', error);
            document.getElementById('questionsList').innerHTML = `
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Error loading questions. Please try again later.
                    </div>
                `;
        }
    }

    // Load unanswered questions for staff
    async function loadUnansweredQuestions() {
        try {
            const response = await fetch('api/questions', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    action: 'getUnanswered'
                })
            });

            const data = await response.json();
            const unansweredList = document.getElementById('unansweredQuestionsList');

            if (data.success && data.questions && data.questions.length > 0) {
                let html = '';
                data.questions.forEach(q => {
                    html += `
                            <div class="card mb-3 border-warning">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h6 class="card-title mb-0">
                                            <i class="fas fa-question-circle text-warning me-2"></i>
                                            ${q.question}
                                        </h6>
                                        <span class="badge bg-primary">${q.subject}</span>
                                    </div>
                                    <div class="mb-3">
                                        <small class="text-muted">
                                            <i class="fas fa-user me-1"></i>
                                            Asked by: ${q.user_name || 'Anonymous'}
                                        </small>
                                        <small class="text-muted ms-3">
                                            <i class="fas fa-clock me-1"></i>
                                            ${q.created_at}
                                        </small>
                                    </div>
                                    <div class="reply-form" id="replyForm${q.id}" style="display: none;">
                                        <textarea class="form-control mb-2" id="replyText${q.id}" rows="3" placeholder="Enter your answer..."></textarea>
                                        <div class="d-flex gap-2">
                                            <button class="btn btn-success btn-sm" onclick="submitReply(${q.id})">
                                                <i class="fas fa-check me-1"></i>Submit Answer
                                            </button>
                                            <button class="btn btn-secondary btn-sm" onclick="cancelReply(${q.id})">
                                                <i class="fas fa-times me-1"></i>Cancel
                                            </button>
                                        </div>
                                    </div>
                                    <button class="btn btn-primary btn-sm" onclick="showReplyForm(${q.id})">
                                        <i class="fas fa-reply me-1"></i>Reply
                                    </button>
                                </div>
                            </div>
                        `;
                });
                unansweredList.innerHTML = html;
            } else {
                unansweredList.innerHTML = `
                        <div class="text-center text-muted">
                            <i class="fas fa-check-circle fa-3x mb-3"></i>
                            <p>No unanswered questions!</p>
                        </div>
                    `;
            }
        } catch (error) {
            console.error('Error loading unanswered questions:', error);
            document.getElementById('unansweredQuestionsList').innerHTML = `
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Error loading unanswered questions. Please try again later.
                    </div>
                `;
        }
    }

    // Show reply form
    function showReplyForm(questionId) {
        document.getElementById(`replyForm${questionId}`).style.display = 'block';
    }

    // Cancel reply
    function cancelReply(questionId) {
        document.getElementById(`replyForm${questionId}`).style.display = 'none';
        document.getElementById(`replyText${questionId}`).value = '';
    }

    // Submit reply
    async function submitReply(questionId) {
        const answer = document.getElementById(`replyText${questionId}`).value.trim();

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
                    questionId: questionId,
                    answer: answer
                })
            });

            if (response.ok) {
                alert('Answer submitted successfully!');
                loadQuestions(); // Reload answered questions
                loadUnansweredQuestions(); // Reload unanswered questions
            } else {
                alert('Failed to submit answer');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Error submitting answer');
        }
    }

    // Get subject badge color
    function getSubjectBadgeColor(subject) {
        const colors = {
            'Application Process': 'primary',
            'Payment & Fees': 'success',
            'Status Tracking': 'info',
            'Delivery & Logistics': 'warning',
            'Technical Support': 'secondary',
            'General Inquiry': 'dark'
        };
        return colors[subject] || 'secondary';
    }

    // Format date
    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
    }
</script>
    <jsp:include page="includes/footer.jsp" />
</body>
</html>