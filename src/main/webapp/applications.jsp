<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Applications - Lanka Epassport Service</title>

    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="images/favicon.svg">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        .card {
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .alert {
            border-radius: 10px;
            border: none;
        }

        .application-card {
            transition: transform 0.2s;
        }

        .application-card:hover {
            transform: translateY(-2px);
        }


        /* Navigation Button Styling - Consistent for all buttons */
        .navbar-nav .btn {
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.3);
            font-weight: 500;
            text-decoration: none;
        }

        .navbar-nav .btn:hover:not(:disabled) {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }

        /* Outline Light Buttons (Home, Helpdesk, Contact, View Details) */
        .navbar-nav .btn-outline-light {
            border-color: rgba(255, 255, 255, 0.5);
            color: white;
        }

        .navbar-nav .btn-outline-light:hover {
            background-color: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.8);
            color: white;
        }

        /* Success Button (New Application) */
        .navbar-nav .btn-success {
            background-color: #198754;
            border-color: #198754;
        }

        .navbar-nav .btn-success:hover {
            background-color: #157347;
            border-color: #146c43;
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(25, 135, 84, 0.3);
        }

        /* Danger Button (Logout) */
        .navbar-nav .btn-outline-danger {
            border-color: rgba(220, 53, 69, 0.5);
            color: #dc3545;
        }

        .navbar-nav .btn-outline-danger:hover {
            background-color: #dc3545;
            border-color: #dc3545;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(220, 53, 69, 0.3);
        }

        /* Disabled Button State */
        .navbar-nav .btn:disabled {
            opacity: 0.7;
            cursor: default;
            transform: none;
            box-shadow: none;
        }

        /* Modern Progress Tracker Styles */
        .progress-tracker-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            position: relative;
            overflow: hidden;
            border-radius: 25px;
            margin: 2rem 0;
            box-shadow: 0 20px 60px rgba(102, 126, 234, 0.3);
        }

        .progress-tracker-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.15)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.15)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,255,255,0.15)"/><circle cx="10" cy="50" r="0.5" fill="rgba(255,255,255,0.15)"/><circle cx="90" cy="50" r="0.5" fill="rgba(255,255,255,0.15)"/><circle cx="50" cy="90" r="0.5" fill="rgba(255,255,255,0.15)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.2;
        }

        .progress-header-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 3rem 2rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .progress-header-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 70px rgba(0, 0, 0, 0.15);
        }

        .header-icon {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            border: 2px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
        }

        .progress-header-card:hover .header-icon {
            transform: scale(1.1);
            background: rgba(255, 255, 255, 0.25);
        }

        .progress-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .progress-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 1rem;
        }

        .progress-badge .badge {
            font-size: 0.9rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
        }

        .overview-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .overview-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
        }

        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin-right: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .card-content h4 {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 700;
            color: #333;
        }

        .card-content p {
            margin: 0;
            color: #666;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .timeline-container {
            position: relative;
            max-width: 800px;
            margin: 0 auto;
        }

        .timeline {
            position: relative;
            padding-left: 50px;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 25px;
            top: 0;
            bottom: 0;
            width: 3px;
            background: linear-gradient(to bottom, #28a745, #ffc107, #dc3545);
            border-radius: 2px;
        }

        .timeline-item {
            position: relative;
            margin-bottom: 2rem;
            opacity: 0.6;
            transition: all 0.3s ease;
        }

        .timeline-item.active {
            opacity: 1;
        }

        .timeline-item.completed {
            opacity: 1;
        }

        .timeline-marker {
            position: absolute;
            left: -50px;
            top: 0;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .marker-circle {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(145deg, #ffffff, #f8f9fa);
            border: 3px solid rgba(102, 126, 234, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: #6c757d;
            transition: all 0.4s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .marker-circle::before {
            content: '';
            position: absolute;
            top: -3px;
            left: -3px;
            right: -3px;
            bottom: -3px;
            border-radius: 50%;
            background: linear-gradient(45deg, #667eea, #764ba2);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: -1;
        }

        .timeline-item.active .marker-circle {
            background: linear-gradient(145deg, #667eea, #764ba2);
            border-color: #667eea;
            color: white !important;
            transform: scale(1.15);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .timeline-item.active .marker-circle::before {
            opacity: 1;
        }

        .timeline-item.completed .marker-circle {
            background: linear-gradient(145deg, #667eea, #764ba2);
            border-color: #667eea;
            color: white !important;
            transform: scale(1.15);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .timeline-item.completed .marker-circle::before {
            background: linear-gradient(45deg, #667eea, #764ba2);
            opacity: 1;
        }

        .timeline-card {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(102, 126, 234, 0.1);
            overflow: hidden;
            transition: all 0.4s ease;
            position: relative;
        }

        .timeline-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .timeline-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 20px 60px rgba(102, 126, 234, 0.15);
        }

        .timeline-card:hover::before {
            opacity: 1;
        }

        .timeline-item.active .timeline-card {
            box-shadow: 0 15px 50px rgba(102, 126, 234, 0.25);
            transform: translateY(-5px);
            border-color: rgba(102, 126, 234, 0.3);
        }

        .timeline-item.active .timeline-card::before {
            opacity: 1;
        }

        .timeline-item.completed .timeline-card {
            box-shadow: 0 15px 50px rgba(102, 126, 234, 0.25);
            transform: translateY(-5px);
            border-color: rgba(102, 126, 234, 0.3);
        }

        .timeline-item.completed .timeline-card::before {
            background: linear-gradient(90deg, #667eea, #764ba2);
            opacity: 1;
        }

        .timeline-card .card-header {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #dee2e6;
            display: flex;
            justify-content: between;
            align-items: center;
        }

        .timeline-card .card-header h5 {
            margin: 0;
            font-weight: 600;
            color: #333;
        }

        .step-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .step-badge.active {
            background: #007bff;
            color: white;
        }

        .step-badge.completed {
            background: #28a745;
            color: white;
        }

        .step-badge.pending {
            background: #ffc107;
            color: #212529;
        }

        .timeline-card .card-body {
            padding: 1.5rem;
        }

        .timeline-card .card-body p {
            color: #555;
            margin-bottom: 0.5rem;
            line-height: 1.5;
        }

        .step-details {
            margin-top: 0.75rem;
            padding-top: 0.75rem;
            border-top: 1px solid #f8f9fa;
        }

        .progress-container {
            max-width: 600px;
            margin: 0 auto;
        }

        .progress-wrapper {
            position: relative;
        }

        .progress-bar-custom {
            height: 12px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: inset 0 2px 8px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea, #764ba2, #f093fb, #f5576c);
            border-radius: 10px;
            width: 0%;
            transition: width 1s ease;
            position: relative;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(102, 126, 234, 0.4);
        }

        .progress-fill::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            animation: shimmer 2s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .progress-labels {
            display: flex;
            justify-content: space-between;
            margin-top: 0.5rem;
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .progress-header-card {
                padding: 1.5rem;
            }

            .progress-title {
                font-size: 2rem;
            }

            .overview-card {
                padding: 1rem;
                margin-bottom: 1rem;
            }

            .card-icon {
                width: 50px;
                height: 50px;
                font-size: 1.2rem;
                margin-right: 0.75rem;
            }

            .card-content h4 {
                font-size: 1.5rem;
            }

            .timeline {
                padding-left: 40px;
            }

            .timeline::before {
                left: 20px;
            }

            .timeline-marker {
                left: -40px;
                width: 40px;
                height: 40px;
            }

            .marker-circle {
                width: 40px;
                height: 40px;
                font-size: 1rem;
            }

            .timeline-card .card-header {
                padding: 0.75rem 1rem;
            }

            .timeline-card .card-body {
                padding: 1rem;
            }

            .progress-container {
                margin: 0 1rem;
            }
        }

        @media (max-width: 576px) {
            .progress-title {
                font-size: 1.8rem;
            }

            .overview-card {
                flex-direction: column;
                text-align: center;
            }

            .card-icon {
                margin-right: 0;
                margin-bottom: 0.5rem;
            }

            .timeline {
                padding-left: 30px;
            }

            .timeline::before {
                left: 15px;
                width: 2px;
            }

            .timeline-marker {
                left: -30px;
                width: 30px;
                height: 30px;
            }

            .marker-circle {
                width: 30px;
                height: 30px;
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1><i class="fas fa-passport me-2"></i>My Applications</h1>
                <p class="lead mb-0">Track, view, and manage all your passport applications in one place</p>
            </div>
            <div class="col-md-4 text-md-end">
                <a href="<%= request.getContextPath() %>/helpdesk.jsp" class="btn btn-light btn-lg">
                    <i class="fas fa-question-circle me-2"></i>Visit Helpdesk
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Main Content -->
<main class="container mb-5">
    <!-- Modern Passport Application Progress Tracker -->
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <!-- Header -->
            <div class="text-center mb-5">
                <div class="progress-header-card">
                    <div class="header-icon mb-3">
                        <i class="fas fa-passport"></i>
                    </div>
                    <h2 class="progress-title">Passport Application Progress</h2>
                    <p class="progress-subtitle">Track your application journey in real-time</p>
                    <div class="progress-badge">
                        <span class="badge bg-primary" id="overallStatus">Processing</span>
                    </div>
                </div>
            </div>

            <!-- Progress Overview Cards -->
            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <div class="overview-card">
                        <div class="card-icon">
                            <i class="fas fa-tasks"></i>
                        </div>
                        <div class="card-content">
                            <h4 id="currentStep">Step 1</h4>
                            <p>Current Stage</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="overview-card">
                        <div class="card-icon">
                            <i class="fas fa-percentage"></i>
                        </div>
                        <div class="card-content">
                            <h4 id="completionRate">17%</h4>
                            <p>Complete</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="overview-card">
                        <div class="card-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="card-content">
                            <h4 id="estimatedTime">5-7 days</h4>
                            <p>Est. Time</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Smart Horizontal Stepper -->
            <div class="process-container">
                <div class="process-progress-bar">
                    <div class="progress-line" id="processProgressLine"></div>
                </div>
                <div class="d-flex justify-content-between align-items-start process-steps flex-wrap gap-3">
                    <div class="process-step text-center" data-status="submitted" data-step="1">
                        <div class="step-circle bg-white text-primary">
                            <i class="fas fa-file-upload"></i>
                            <span class="step-number">1</span>
                        </div>
                        <div class="step-label">Application Submitted</div>
                        <div class="step-info text-muted small">We received your application</div>
                    </div>
                    <div class="process-step text-center" data-status="payment_completed" data-step="2">
                        <div class="step-circle bg-white text-primary">
                            <i class="fas fa-credit-card"></i>
                            <span class="step-number">2</span>
                        </div>
                        <div class="step-label">Payment Processing</div>
                        <div class="step-info text-muted small">Fee verification</div>
                    </div>
                    <div class="process-step text-center" data-status="processing" data-step="3">
                        <div class="step-circle bg-white text-primary">
                            <i class="fas fa-search"></i>
                            <span class="step-number">3</span>
                        </div>
                        <div class="step-label">Document Verification</div>
                        <div class="step-info text-muted small">Identity and documents check</div>
                    </div>
                    <div class="process-step text-center" data-status="approved" data-step="4">
                        <div class="step-circle bg-white text-primary">
                            <i class="fas fa-check-circle"></i>
                            <span class="step-number">4</span>
                        </div>
                        <div class="step-label">Application Approved</div>
                        <div class="step-info text-muted small">Application approved</div>
                    </div>
                    <div class="process-step text-center" data-status="printed" data-step="5">
                        <div class="step-circle bg-white text-primary">
                            <i class="fas fa-print"></i>
                            <span class="step-number">5</span>
                        </div>
                        <div class="step-label">Passport Printing</div>
                        <div class="step-info text-muted small">Security printing</div>
                    </div>
                    <div class="process-step text-center" data-status="delivered" data-step="6">
                        <div class="step-circle bg-white text-primary">
                            <i class="fas fa-box-open"></i>
                            <span class="step-number">6</span>
                        </div>
                        <div class="step-label">Ready for Collection</div>
                        <div class="step-info text-muted small">Collect at center</div>
                    </div>
                </div>
            </div>

            <!-- Progress Bar -->
            <div class="progress-container mt-4">
                <div class="progress-wrapper">
                    <div class="progress-bar-custom">
                        <div class="progress-fill" id="progressFill"></div>
                    </div>
                    <div class="progress-labels">
                        <span>0%</span>
                        <span>100%</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bottom Application Details Section -->
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <!-- Page Header -->

            <!-- Application Details Section -->
            <div class="application-details-section">
                <!-- Session Timer at Top -->
                <div class="session-timer-header mb-4">
                    <div class="timer-container">
                        <div class="d-flex align-items-center justify-content-center mb-2">
                            <i class="fas fa-clock text-primary me-2"></i>
                            <span class="fw-bold">Session expires in:</span>
                            <span id="timerText" class="ms-2 text-primary">12 hours</span>
                        </div>
                        <div class="timer-display bg-dark text-white text-center py-2 px-3 rounded mx-auto" style="width: fit-content;">
                            <i class="fas fa-stopwatch me-2"></i>
                            <span id="sessionTimer">12:00:00</span>
                        </div>
                    </div>
                </div>

                <!-- Success Alert -->
                <div class="alert alert-success d-none" id="successAlert" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <strong>Success!</strong> <span id="successMessage"></span>
                </div>

                <!-- Error Alert -->
                <div class="alert alert-danger d-none" id="errorAlert" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <strong>Error!</strong> <span id="errorMessage"></span>
                </div>

                <!-- Loading Spinner -->
                <div class="text-center d-none" id="loadingSpinner">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-2 text-muted">Loading applications...</p>
                </div>

                <!-- Applications List -->
                <div id="applicationsList" class="d-none">
                    <!-- Applications will be loaded here -->
                </div>

                <!-- No Applications Message -->
                <div class="text-center d-none" id="noApplications">
                    <i class="fas fa-file-alt fa-3x text-muted mb-3"></i>
                    <h4 class="text-muted">No Applications Found</h4>
                    <p class="text-muted">You haven't submitted any passport applications yet.</p>
                    <a href="application.jsp" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Submit Your First Application
                    </a>
                </div>

                <!-- Debug Test Button -->
                <div class="text-center mt-3">
                    <button class="btn btn-outline-info btn-sm" onclick="testPaymentRedirect()">
                        <i class="fas fa-bug me-1"></i>Test Payment Redirect
                    </button>
                    <a href="fresh-payment.jsp?applicationId=123" class="btn btn-outline-success btn-sm ms-2">
                        <i class="fas fa-external-link-alt me-1"></i>Direct Link Test
                    </a>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Additional CSS for new layout -->
<style>
    .application-details-section {
        background-color: #f8f9fa;
        border-radius: 15px;
        padding: 2rem;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
    }

    .process-container {
        position: relative;
        padding: 20px 0;
    }

    .process-progress-bar {
        position: absolute;
        top: 50%;
        left: 0;
        right: 0;
        height: 6px;
        background: rgba(102, 126, 234, 0.1);
        border-radius: 10px;
        z-index: 1;
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .progress-line {
        height: 100%;
        background: linear-gradient(90deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
        border-radius: 10px;
        transition: width 0.8s ease;
        width: 0%;
        position: relative;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
    }

    .progress-line::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
        animation: progressShimmer 2s infinite;
    }

    @keyframes progressShimmer {
        0% { left: -100%; }
        100% { left: 100%; }
    }

    .process-steps {
        position: relative;
        z-index: 2;
    }

    .process-step {
        position: relative;
        flex: 1;
        min-width: 140px;
        transition: all 0.4s ease;
        cursor: pointer;
    }

    .step-circle {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto;
        font-size: 1.8rem;
        transition: all 0.4s ease;
        position: relative;
        border: 3px solid rgba(102, 126, 234, 0.2);
        background: linear-gradient(145deg, #ffffff, #f8f9fa);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        color: #6c757d;
    }

    .step-circle::before {
        content: '';
        position: absolute;
        top: -3px;
        left: -3px;
        right: -3px;
        bottom: -3px;
        border-radius: 50%;
        background: linear-gradient(45deg, #667eea, #764ba2);
        opacity: 0;
        transition: opacity 0.3s ease;
        z-index: -1;
    }

    .step-number {
        position: absolute;
        bottom: -8px;
        right: -8px;
        background: linear-gradient(145deg, #667eea, #764ba2);
        color: white;
        border: 3px solid white;
        border-radius: 50%;
        width: 28px;
        height: 28px;
        font-size: 0.8rem;
        font-weight: bold;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        transition: all 0.3s ease;
    }

    .process-step:hover .step-circle {
        transform: translateY(-8px) scale(1.05);
        box-shadow: 0 15px 40px rgba(102, 126, 234, 0.2);
        border-color: rgba(102, 126, 234, 0.4);
    }

    .process-step:hover .step-circle::before {
        opacity: 0.1;
    }

    .process-step:hover .step-number {
        transform: scale(1.1);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
    }

    .process-step.active .step-circle {
        background: linear-gradient(145deg, #667eea, #764ba2);
        color: white !important;
        transform: translateY(-5px) scale(1.1);
        box-shadow: 0 15px 40px rgba(102, 126, 234, 0.3);
        border-color: #667eea;
    }

    .process-step.active .step-circle::before {
        opacity: 1;
    }

    .process-step.completed .step-circle {
        background: linear-gradient(145deg, #667eea, #764ba2);
        color: white !important;
        transform: translateY(-5px) scale(1.1);
        box-shadow: 0 15px 40px rgba(102, 126, 234, 0.3);
        border-color: #667eea;
    }

    .process-step.completed .step-circle::before {
        background: linear-gradient(45deg, #667eea, #764ba2);
        opacity: 1;
    }

    .process-step.completed .step-number {
        background: linear-gradient(145deg, #667eea, #764ba2);
        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
    }

    .step-label {
        font-size: 1rem;
        font-weight: 700;
        margin-top: 1.2rem;
        line-height: 1.3;
        color: #2c3e50;
        transition: all 0.3s ease;
    }

    .step-info {
        font-size: 0.85rem;
        color: #6c757d;
        margin-top: 0.5rem;
        opacity: 0;
        transition: all 0.3s ease;
        font-weight: 500;
        line-height: 1.4;
    }

    .process-step:hover .step-label {
        color: #667eea;
        transform: translateY(-2px);
    }

    .process-step:hover .step-info {
        opacity: 1;
        color: #495057;
        transform: translateY(-2px);
    }

    .process-step.active .step-label {
        color: #667eea;
        font-weight: 800;
    }

    .process-step.active .step-info {
        opacity: 1;
        color: #667eea;
    }

    .process-step.completed .step-label {
        color: #667eea;
        font-weight: 800;
    }

    .process-step.completed .step-info {
        opacity: 1;
        color: #667eea;
    }

    .stat-card {
        background-color: #fff;
        border-radius: 10px;
        padding: 1rem;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        transition: transform 0.2s ease;
    }

    .stat-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    /* Timer Styles */
    .timer-container {
        transition: all 0.3s ease;
    }

    .timer-display {
        font-family: 'Courier New', monospace;
        font-size: 1.2rem;
        font-weight: bold;
        border-radius: 8px;
        transition: all 0.3s ease;
        min-width: 150px;
    }

    .timer-warning {
        animation: timerWarning 1s ease-in-out infinite alternate;
    }

    .timer-critical {
        animation: timerCritical 0.5s ease-in-out infinite alternate;
    }

    @keyframes timerWarning {
        from { background-color: #ffc107; color: #000; }
        to { background-color: #fd7e14; color: #fff; }
    }

    @keyframes timerCritical {
        from { background-color: #fd7e14; color: #fff; }
        to { background-color: #dc3545; color: #fff; }
    }

    .timer-expired {
        font-size: 0.9rem;
        padding: 0.5rem;
    }

    /* Session Timer Header Styles */
    .session-timer-header {
        background-color: #f8f9fa;
        border-radius: 10px;
        padding: 1rem;
        border-left: 4px solid #007bff;
    }

    .session-expired-container {
        max-width: 600px;
        margin: 0 auto;
    }

    .expired-actions .btn {
        min-width: 150px;
    }

    .status-legend {
        border: 1px solid #e9ecef;
        font-size: 0.8rem;
    }

    .status-legend small {
        font-weight: 500;
    }

    @media (max-width: 768px) {
        .process-step {
            min-width: 100px;
        }

        .step-circle {
            width: 60px;
            height: 60px;
            font-size: 1.4rem;
        }

        .step-number {
            width: 20px;
            height: 20px;
            font-size: 0.7rem;
        }

        .process-progress-bar {
            height: 3px;
        }

        .stat-card {
            margin-bottom: 1rem;
        }

        .status-legend {
            flex-direction: column;
            gap: 0.5rem;
        }
    }
</style>

<!-- Footer -->
<footer class="bg-dark text-white py-4">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h6 class="mb-0">
                    <i class="fas fa-passport me-2"></i>
                    Lanka Epassport Service
                </h6>
                <small class="text-muted">Professional passport services in Sri Lanka</small>
            </div>
            <div class="col-md-6 text-md-end">
                <div class="social-links">
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-linkedin"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>
        <hr class="my-3">
        <div class="text-center">
            <small class="text-muted">&copy; 2024 Lanka Epassport Service. All rights reserved.</small>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JS -->
<script src="js/script.js"></script>

<script>
    // Get user NIC from localStorage or session
    function getUserNic() {
        const savedUser = localStorage.getItem('lankaEpassportUser');
        if (savedUser) {
            const user = JSON.parse(savedUser);
            return user.nicNumber || user.nic;
        }
        return null;
    }

    // Load applications
    async function loadApplications() {
        const loadingSpinner = document.getElementById('loadingSpinner');
        const applicationsList = document.getElementById('applicationsList');
        const noApplications = document.getElementById('noApplications');

        loadingSpinner.classList.remove('d-none');

        try {
            const basePath = '<%= request.getContextPath() %>' || '';
            const nic = getUserNic();
            let url = basePath + '/api/applications';
            if (nic) {
                url += '?nic=' + encodeURIComponent(nic);
            }

            const response = await fetch(url);

            if (response.ok) {
                const applications = await response.json();

                loadingSpinner.classList.add('d-none');

                if (applications.length === 0) {
                    noApplications.classList.remove('d-none');
                } else {
                    applicationsList.classList.remove('d-none');
                    displayApplications(applications);
                }
            } else {
                const error = await response.json();
                showError(error.error || 'Failed to load applications');
            }
        } catch (error) {
            console.error('Error loading applications:', error);
            showError('Network error while loading applications');
        }
    }

    function displayApplications(applications) {
        const applicationsList = document.getElementById('applicationsList');
        applicationsList.innerHTML = '';

        applications.forEach(app => {
            const card = createApplicationCard(app);
            applicationsList.appendChild(card);
        });

        // Refresh top timeline to reflect latest most-advanced status
        updateAllProcessStatuses();
    }

    function createApplicationCard(app) {
        const card = document.createElement('div');
        card.className = 'card application-card mb-4';

        const statusClass = getStatusClass(app.status);
        const statusText = getStatusInfo(app.status).display;
        const statusInfo = getStatusInfo(app.status);

        // Debug logging
        console.log('Creating card for application:', app.applicationId, 'Status:', app.status);

        // Check if user was logged in before
        const savedUser = localStorage.getItem('lankaEpassportUser');
        const isLoggedIn = savedUser && JSON.parse(savedUser);

        let personalInfoHtml = '';
        let addressInfoHtml = '';

        if (isLoggedIn) {
            // Show personal information and address details only if logged in
            personalInfoHtml =
                '<div class="col-md-6">' +
                '<p class="mb-1"><strong>First Name:</strong> ' + app.firstName + '</p>' +
                '<p class="mb-1"><strong>Last Name:</strong> ' + app.lastName + '</p>' +
                '<p class="mb-1"><strong>NIC:</strong> ' + app.nicNumber + '</p>' +
                '<p class="mb-1"><strong>DOB:</strong> ' + formatDate(app.dateOfBirth) + '</p>' +
                '<p class="mb-1"><strong>Email:</strong> ' + app.email + '</p>' +
                '</div>' +
                '<div class="col-md-6">' +
                '<p class="mb-1"><strong>Current Address:</strong> ' + app.currentAddress + '</p>' +
                '<p class="mb-1"><strong>City:</strong> ' + app.city + '</p>' +
                '<p class="mb-1"><strong>Postal Code:</strong> ' + app.postalCode + '</p>' +
                '<p class="mb-1"><strong>Processing Type:</strong> ' + capitalizeFirst(app.processingType) + '</p>' +
                '<p class="mb-1"><strong>Biometric Date:</strong> ' + (formatDate(app.biometricDate) || 'Not scheduled') + '</p>' +
                '</div>';
        } else {
            // Show limited information for non-logged in users
            personalInfoHtml =
                '<div class="col-md-6">' +
                '<p class="mb-1"><strong>Name:</strong> ' + app.firstName + ' ' + app.lastName + '</p>' +
                '<p class="mb-1"><strong>Email:</strong> ' + app.email + '</p>' +
                '<p class="mb-1"><strong>Processing Type:</strong> ' + capitalizeFirst(app.processingType) + '</p>' +
                '</div>' +
                '<div class="col-md-6">' +
                '<p class="mb-1"><strong>Biometric Date:</strong> ' + (formatDate(app.biometricDate) || 'Not scheduled') + '</p>' +
                '<p class="mb-1"><strong>Documents:</strong> ' + (app.documents ? app.documents.length : 0) + ' uploaded</p>' +
                '</div>';
        }

        card.innerHTML =
            '<div class="card-header d-flex justify-content-between align-items-center">' +
            '<h5 class="mb-0">Application #' + app.applicationId + '</h5>' +
            '<span class="badge ' + statusClass + ' status-badge">' + statusText + '</span>' +
            '</div>' +
            '<div class="card-body">' +
            // Show all details directly without collapsed/expanded views
            '<div class="row">' +
            personalInfoHtml +
            '</div>' +
            '<div class="mt-3">' +
            '<div class="d-flex justify-content-between align-items-center mb-1">' +
            '<small class="text-muted">Progress</small>' +
            '<small class="fw-semibold">' + statusInfo.percent + '%</small>' +
            '</div>' +
            '<div class="progress" style="height:8px;">' +
            '<div class="progress-bar ' + statusInfo.progressBarClass + '" role="progressbar" style="width: ' + statusInfo.percent + '%;" aria-valuenow="' + statusInfo.percent + '" aria-valuemin="0" aria-valuemax="100"></div>' +
            '</div>' +
            '<div class="d-flex justify-content-between mt-1">' +
            '<small class="text-muted">Submitted</small>' +
            '<small class="text-muted">' + statusInfo.display + '</small>' +
            '<small class="text-muted">Complete</small>' +
            '</div>' +
            '</div>' +
            '<div class="d-flex justify-content-end mt-3">' +
            '<button class="btn btn-warning me-2" onclick="editApplication(' + app.applicationId + ')">' +
            '<i class="fas fa-edit me-1"></i>Update' +
            '</button>' +
            // Payment button - show for submitted applications, or always show for testing
            (app.status === 'submitted' || true ?
                (console.log('Creating Pay Now button for application:', app.applicationId, 'Status:', app.status),
                '<button class="btn btn-success me-2" onclick="processPayment(' + app.applicationId + ')" title="Pay for Application #' + app.applicationId + ' (Status: ' + app.status + ')">' +
                '<i class="fas fa-credit-card me-1"></i>Pay Now' +
                '</button>') :
                (console.log('Skipping Pay Now button for application:', app.applicationId, 'Status:', app.status), '')) +
            '<button class="btn btn-danger" onclick="deleteApplication(' + app.applicationId + ')">' +
            '<i class="fas fa-trash me-1"></i>Delete' +
            '</button>' +
            '</div>' +
            '</div>';

        return card;
    }

    function getStatusClass(status) {
        switch ((status || '').toLowerCase()) {
            case 'draft': return 'bg-secondary';
            case 'submitted': return 'bg-info';
            case 'processing': return 'bg-warning';
            case 'approved': return 'bg-success';
            case 'payment_completed': return 'bg-primary';
            case 'printed': return 'bg-info';
            case 'delivered': return 'bg-success';
            case 'rejected': return 'bg-danger';
            default: return 'bg-secondary';
        }
    }

    function getStatusInfo(status) {
        const key = (status || 'submitted').toLowerCase();
        // Known pipeline (top timeline supports these extra steps too)
        const map = {
            'draft':            { display: 'Draft', percent: 5,  progressBarClass: 'bg-secondary' },
            'submitted':        { display: 'Submitted', percent: 17, progressBarClass: 'bg-info' },
            'processing':       { display: 'Processing', percent: 33, progressBarClass: 'bg-warning' },
            'approved':         { display: 'Approved', percent: 50, progressBarClass: 'bg-success' },
            'payment_completed':{ display: 'Payment Verified', percent: 67, progressBarClass: 'bg-primary' },
            'printed':          { display: 'Printing', percent: 83, progressBarClass: 'bg-info' },
            'delivered':        { display: 'Ready for Collection', percent: 100, progressBarClass: 'bg-success' },
            'rejected':         { display: 'Rejected', percent: 100, progressBarClass: 'bg-danger' }
        };
        return map[key] || map['submitted'];
    }

    function editApplication(id) {
        window.location.href = '<%= request.getContextPath() %>/editApplication.jsp?id=' + id;
    }

    function processPayment(applicationId) {
        console.log('processPayment called with applicationId:', applicationId);

        // Validate applicationId
        if (!applicationId || applicationId === 'undefined' || applicationId === 'null') {
            alert('Invalid application ID. Please try again.');
            return;
        }

        // Show loading state
        const button = event.target;
        const originalText = button.innerHTML;
        button.disabled = true;
        button.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Redirecting...';

        // Redirect to payment gateway page with application ID
        try {
            window.location.href = 'fresh-payment.jsp?applicationId=' + applicationId;
        } catch (error) {
            console.error('Error redirecting to payment gateway:', error);
            alert('Error redirecting to payment page. Please try again.');
            button.disabled = false;
            button.innerHTML = originalText;
        }
    }


    async function deleteApplication(id) {
        if (!confirm('Are you sure you want to delete this application? This action cannot be undone.')) {
            return;
        }

        try {
            const basePath = '<%= request.getContextPath() %>' || '';
            const response = await fetch(basePath + '/api/applications?id=' + id, {
                method: 'DELETE'
            });

            if (response.ok) {
                showSuccess('Application deleted successfully');
                setTimeout(() => {
                    loadApplications(); // Reload the list
                }, 1500);
            } else {
                const error = await response.json().catch(() => ({}));
                showError(error.error || 'Failed to delete application');
            }
        } catch (e) {
            console.error('Delete error:', e);
            showError('Network error while deleting application');
        }
    }

    function formatDate(dateString) {
        if (!dateString) return 'N/A';
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
    }

    function capitalizeFirst(str) {
        if (!str) return '';
        return str.charAt(0).toUpperCase() + str.slice(1);
    }

    function showSuccess(message) {
        const successAlert = document.getElementById('successAlert');
        const successMessage = document.getElementById('successMessage');
        successMessage.textContent = message;
        successAlert.classList.remove('d-none');
        setTimeout(() => successAlert.classList.add('d-none'), 5000);
    }

    function showError(message) {
        const loadingSpinner = document.getElementById('loadingSpinner');
        const errorAlert = document.getElementById('errorAlert');
        const errorMessage = document.getElementById('errorMessage');

        loadingSpinner.classList.add('d-none');
        errorMessage.textContent = message;
        errorAlert.classList.remove('d-none');
    }

    // Modern timeline progress tracker
    function updateProcessStatus(currentStatus) {
        console.log('updateProcessStatus called with:', currentStatus); // Debug log

        // Reset legacy vertical timeline if present
        document.querySelectorAll('.timeline-item').forEach(item => {
            item.classList.remove('active', 'completed');
        });

        // Reset new horizontal process steps
        document.querySelectorAll('.process-step').forEach(step => {
            step.classList.remove('active', 'completed');
        });

        // Define the status order with enhanced data
        const statusOrder = [
            { key: 'submitted', label: 'Application Submitted', step: 1, progress: 17 },
            { key: 'payment_completed', label: 'Payment Processing', step: 2, progress: 33 },
            { key: 'processing', label: 'Document Verification', step: 3, progress: 50 },
            { key: 'approved', label: 'Application Approved', step: 4, progress: 67 },
            { key: 'printed', label: 'Passport Printing', step: 5, progress: 83 },
            { key: 'delivered', label: 'Ready for Collection', step: 6, progress: 100 }
        ];

        const currentIndex = statusOrder.findIndex(status => status.key === currentStatus?.toLowerCase());
        console.log('Found currentIndex:', currentIndex, 'for status:', currentStatus); // Debug log

        if (currentIndex === -1) {
            // Default to submitted if status not found
            console.log('Status not found, defaulting to submitted'); // Debug log
            updateTimelineProgress(0, statusOrder);
            return;
        }

        // Update overall stats and both progress visuals
        updateTimelineProgress(currentIndex, statusOrder);

        // Update horizontal stepper states
        document.querySelectorAll('.process-step').forEach(step => {
            const stepKey = step.getAttribute('data-status');
            const index = statusOrder.findIndex(s => s.key === stepKey);
            console.log('Processing step:', stepKey, 'index:', index, 'currentIndex:', currentIndex); // Debug log

            if (index < 0) return;
            if (index < currentIndex) {
                step.classList.add('completed');
                console.log('Marked step as completed:', stepKey); // Debug log
            } else if (index === currentIndex) {
                step.classList.add('active');
                console.log('Marked step as active:', stepKey); // Debug log
            }
        });

        // Mark completed and current steps
        document.querySelectorAll('.timeline-item').forEach((item, index) => {
            const badge = item.querySelector('.step-badge');

            if (index < currentIndex) {
                item.classList.add('completed');
                if (badge) {
                    badge.textContent = 'Completed';
                    badge.className = 'step-badge completed';
                }
            } else if (index === currentIndex) {
                item.classList.add('active');
                if (badge) {
                    badge.textContent = 'Active';
                    badge.className = 'step-badge active';
                }
            } else {
                if (badge) {
                    badge.textContent = 'Pending';
                    badge.className = 'step-badge pending';
                }
            }
        });
    }

    function updateTimelineProgress(currentIndex, statusOrder) {
        console.log('updateTimelineProgress called with currentIndex:', currentIndex); // Debug log

        const progress = statusOrder[currentIndex]?.progress || 0;
        const progressFill = document.getElementById('progressFill');
        const processProgressLine = document.getElementById('processProgressLine');

        console.log('Progress:', progress); // Debug log

        // Animate progress bar
        if (progressFill) {
            animateProgressBar(progressFill, progress);
        }

        if (processProgressLine) {
            processProgressLine.style.width = progress + '%';
        }

        // Update statistics with null checks
        const currentStepElement = document.getElementById('currentStep');
        const completionRateElement = document.getElementById('completionRate');
        const estimatedTimeElement = document.getElementById('estimatedTime');
        const overallStatusElement = document.getElementById('overallStatus');

        if (currentStepElement) {
            const stepNumber = statusOrder[currentIndex] ? statusOrder[currentIndex].step : 1;
            currentStepElement.textContent = 'Step ' + stepNumber;
            console.log('Updated currentStep to:', 'Step ' + stepNumber); // Debug log
        }
        if (completionRateElement) {
            completionRateElement.textContent = progress + '%';
        }

        // Update overall status badge
        if (overallStatusElement) {
            const statusLabels = ['Submitted', 'Payment', 'Processing', 'Approved', 'Printing', 'Ready'];
            const statusClasses = ['bg-primary', 'bg-warning', 'bg-info', 'bg-success', 'bg-secondary', 'bg-success'];
            overallStatusElement.textContent = statusLabels[currentIndex] || 'Processing';
            overallStatusElement.className = 'badge ' + (statusClasses[currentIndex] || 'bg-primary');
            console.log('Updated overall status to:', statusLabels[currentIndex]); // Debug log
        }

        // Update estimated time based on current step
        const timeEstimates = ['1-2 days', '2-3 days', '3-4 days', '4-5 days', '5-7 days', 'Delivered'];
        if (estimatedTimeElement) {
            const estimatedTime = timeEstimates[currentIndex] || '5-7 days';
            estimatedTimeElement.textContent = estimatedTime;
        }
    }

    function animateProgressBar(element, targetWidth) {
        if (!element) return;

        let startWidth = 0;
        const duration = 1000; // 1 second
        const increment = targetWidth / (duration / 16); // 60fps

        function animate() {
            startWidth += increment;
            if (startWidth >= targetWidth) {
                element.style.width = targetWidth + '%';
            } else {
                element.style.width = startWidth + '%';
                requestAnimationFrame(animate);
            }
        }

        animate();
    }

    // Update process status for all applications
    function updateAllProcessStatuses() {
        const applications = document.querySelectorAll('.application-card');
        if (applications.length === 0) return;

        // Get the most advanced status from all applications
        let mostAdvancedStatus = 'submitted';
        const statusPriority = ['submitted', 'payment_completed', 'processing', 'approved', 'printed', 'delivered'];

        applications.forEach(card => {
            const statusBadge = card.querySelector('.status-badge');
            if (statusBadge) {
                const statusText = statusBadge.textContent.trim().toLowerCase();
                console.log('Found status text:', statusText); // Debug log

                // Map display text to status keys
                const statusMap = {
                    'submitted': 'submitted',
                    'processing': 'processing',
                    'approved': 'approved',
                    'payment completed': 'payment_completed',
                    'payment verified': 'payment_completed',
                    'printing': 'printed',
                    'printed': 'printed',
                    'delivered': 'delivered',
                    'ready for collection': 'delivered'
                };

                const status = statusMap[statusText] || 'submitted';
                console.log('Mapped status:', status); // Debug log

                const currentIndex = statusPriority.indexOf(status);
                const advancedIndex = statusPriority.indexOf(mostAdvancedStatus);

                if (currentIndex > advancedIndex) {
                    mostAdvancedStatus = status;
                    console.log('New most advanced status:', mostAdvancedStatus); // Debug log
                }
            }
        });

        console.log('Final most advanced status:', mostAdvancedStatus); // Debug log
        updateProcessStatus(mostAdvancedStatus);
    }

    // Initialize tooltips when page loads
    function initializeTooltips() {
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    }

    // 12-hour session timer functionality
    let sessionTimer = null;
    let sessionEndTime = null;

    function startSessionTimer() {
        // Set end time to 12 hours from now
        sessionEndTime = new Date().getTime() + (12 * 60 * 60 * 1000);

        sessionTimer = setInterval(function() {
            const now = new Date().getTime();
            const distance = sessionEndTime - now;

            if (distance <= 0) {
                // Timer expired - hide application details section
                clearInterval(sessionTimer);
                hideApplicationDetailsSection();
                return;
            }

            // Calculate time remaining
            const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);

            // Update timer display
            updateTimerDisplay(hours, minutes, seconds);
        }, 1000);
    }

    function updateTimerDisplay(hours, minutes, seconds) {
        // Format time display
        const timeString = String(hours).padStart(2, '0') + ':' +
            String(minutes).padStart(2, '0') + ':' +
            String(seconds).padStart(2, '0');

        const timerElement = document.getElementById('sessionTimer');
        const timerTextElement = document.getElementById('timerText');

        if (timerElement) {
            timerElement.textContent = timeString;
        }

        if (timerTextElement) {
            if (hours > 0) {
                timerTextElement.textContent = hours + ' hour' + (hours > 1 ? 's' : '');
            } else if (minutes > 0) {
                timerTextElement.textContent = minutes + ' minute' + (minutes > 1 ? 's' : '');
            } else {
                timerTextElement.textContent = seconds + ' second' + (seconds > 1 ? 's' : '');
            }
        }

        // Change color based on remaining time
        const timerContainer = document.querySelector('.timer-container');
        if (timerContainer) {
            if (hours === 0 && minutes < 30) {
                timerContainer.classList.add('timer-warning');
            }
            if (hours === 0 && minutes < 5) {
                timerContainer.classList.add('timer-critical');
            }
        }
    }

    function hideApplicationDetailsSection() {
        const applicationSection = document.querySelector('.application-details-section');
        const timerContainer = document.querySelector('.timer-container');

        if (applicationSection) {
            applicationSection.innerHTML = `
                <div class="text-center py-5">
                    <div class="session-expired-container">
                        <i class="fas fa-clock fa-4x text-muted mb-4"></i>
                        <h4 class="text-muted">Session Expired</h4>
                        <p class="text-muted mb-4">Your 12-hour session has expired for security reasons.</p>
                        <div class="expired-actions">
                            <button class="btn btn-primary me-2" onclick="window.location.reload()">
                                <i class="fas fa-refresh me-2"></i>Start New Session
                            </button>
                            <a href="index.jsp" class="btn btn-outline-secondary">
                                <i class="fas fa-home me-2"></i>Go to Home
                            </a>
                        </div>
                        <div class="mt-3">
                            <small class="text-muted">For your security, please start a new session to continue managing your applications.</small>
                        </div>
                    </div>
                </div>
            `;
        }

        if (timerContainer) {
            timerContainer.innerHTML = `
                <div class="timer-expired text-center">
                    <i class="fas fa-exclamation-triangle text-danger me-2"></i>
                    <span class="text-danger fw-bold">Session Expired</span>
                </div>
            `;
        }
    }

    // Test function to manually trigger payment
    function testPaymentRedirect() {
        console.log('Testing payment redirect...');
        const testApplicationId = '123'; // Test application ID
        processPayment(testApplicationId);
    }

    // Make test function available globally
    window.testPaymentRedirect = testPaymentRedirect;

    // Logout function
    function logout() {
        try {
            // Clear user data from localStorage
            localStorage.removeItem('lankaEpassportUser');
            localStorage.removeItem('lankaEpassportLogin');

            // Show logout confirmation
            showSuccess('Logged out successfully');

            // Redirect to home page immediately
            window.location.href = '<%= request.getContextPath() %>/index.jsp';
        } catch (error) {
            console.error('Logout error:', error);
            // Even if there's an error, still try to redirect
            window.location.href = '<%= request.getContextPath() %>/index.jsp';
        }
    }


    // Load applications when page loads
    document.addEventListener('DOMContentLoaded', function() {
        loadApplications();
        initializeTooltips();
        startSessionTimer(); // Start the 12-hour timer

        // Update process status periodically for real-time feel
        setInterval(() => {
            if (document.querySelectorAll('.application-card').length > 0) {
                updateAllProcessStatuses();
            }
        }, 5000); // Update every 5 seconds
    });
</script>
    <jsp:include page="includes/footer.jsp" />
</body>
</html>