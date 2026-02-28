<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Professional passport services in Sri Lanka. Fast, reliable, and secure passport processing with expert guidance.">
  <meta name="keywords" content="passport service, Sri Lanka passport, passport renewal, new passport, lost passport">
  <meta name="author" content="Lanka Epassport Service">
  <title>Staff Login - Lanka Epassport Service</title>

  <!-- Favicon -->

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- AOS Animation -->
  <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
  <!-- Custom CSS -->

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

    /* Government Hero Section */
    .hero-section {
      background: linear-gradient(135deg, var(--gov-primary) 0%, var(--gov-secondary) 100%);
      position: relative;
      overflow: hidden;
      min-height: 85vh;
      display: flex;
      align-items: center;
      padding: 120px 0 80px;
    }

    .hero-section::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(135deg, rgba(0, 51, 102, 0.3) 0%, rgba(0, 64, 128, 0.3) 100%);
      z-index: 1;
    }

    .hero-content {
      position: relative;
      z-index: 3;
    }

    .hero-image-container {
      position: relative;
      z-index: 2;
    }

    .hero-image {
      width: 100%;
      height: auto;
      border-radius: 8px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
      border: 3px solid var(--gov-accent);
      object-fit: cover;
      max-height: 500px;
    }

    .hero-image-wrapper {
      position: relative;
      padding: 1rem;
      background: rgba(255, 255, 255, 0.1);
      border-radius: 12px;
      backdrop-filter: blur(10px);
    }

    .hero-content h1 {
      font-size: 3rem;
      font-weight: 700;
      line-height: 1.3;
      color: var(--gov-white);
      margin-bottom: 1.5rem;
      letter-spacing: -0.5px;
    }

    .hero-content .lead {
      font-size: 1.25rem;
      color: rgba(255, 255, 255, 0.95);
      font-weight: 400;
      line-height: 1.7;
      margin-bottom: 2rem;
    }

    .hero-badge {
      display: inline-block;
      background: var(--gov-accent);
      color: var(--gov-primary);
      padding: 0.5rem 1.25rem;
      border-radius: 4px;
      font-weight: 600;
      font-size: 0.9rem;
      margin-bottom: 1.5rem;
      letter-spacing: 0.5px;
    }

    /* Government Video Section */
    .video-section {
      background: var(--gov-light);
      position: relative;
      padding: 60px 0;
      border-top: 3px solid var(--gov-accent);
      border-bottom: 3px solid var(--gov-accent);
    }

    .video-container {
      position: relative;
      max-width: 900px;
      margin: 0 auto;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
      background: #000;
      border: 3px solid var(--gov-primary);
    }

    .video-container video,
    .video-container iframe {
      width: 100%;
      height: auto;
      display: block;
    }

    /* Government Service Cards */
    .service-card {
      background: var(--gov-white);
      border-radius: 8px;
      border: 2px solid var(--gov-border);
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
      transition: all 0.3s ease;
      overflow: hidden;
      position: relative;
      height: 100%;
    }

    .service-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: var(--gov-primary);
      transform: scaleX(0);
      transition: transform 0.3s ease;
    }

    .service-card:hover::before {
      transform: scaleX(1);
    }

    .service-card:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
      border-color: var(--gov-primary);
    }

    .service-icon {
      width: 70px;
      height: 70px;
      background: var(--gov-primary);
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 1.25rem;
      color: var(--gov-white);
      font-size: 1.75rem;
      border: 2px solid var(--gov-accent);
    }


    /* Government Process Steps */
    .process-step {
      position: relative;
      padding: 2rem 1rem;
      text-align: center;
    }

    .step-number {
      width: 70px;
      height: 70px;
      background: var(--gov-primary);
      color: var(--gov-white);
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.75rem;
      font-weight: 700;
      margin: 0 auto 1.25rem;
      position: relative;
      z-index: 2;
      border: 3px solid var(--gov-accent);
    }

    .process-step::after {
      content: '';
      position: absolute;
      top: 35px;
      right: -50%;
      width: 100%;
      height: 3px;
      background: linear-gradient(90deg, var(--gov-primary), var(--gov-border));
      z-index: 1;
    }

    .process-step:last-child::after {
      display: none;
    }

    /* Government-Style Buttons */
    .btn-modern {
      border-radius: 4px;
      padding: 0.75rem 2rem;
      font-weight: 600;
      font-size: 1rem;
      transition: all 0.2s ease;
      border: 2px solid transparent;
      letter-spacing: 0.3px;
    }

    .btn-modern:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    .btn-primary {
      background: var(--gov-primary);
      border-color: var(--gov-primary);
      color: var(--gov-white);
    }

    .btn-primary:hover {
      background: var(--gov-secondary);
      border-color: var(--gov-secondary);
      color: var(--gov-white);
    }

    .btn-outline-light {
      border-color: var(--gov-white);
      color: var(--gov-white);
    }

    .btn-outline-light:hover {
      background: var(--gov-white);
      color: var(--gov-primary);
    }

    /* Government Contact Form */
    .contact-form {
      background: var(--gov-white);
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      border: 2px solid var(--gov-border);
    }

    .form-control {
      border-radius: 4px;
      border: 2px solid var(--gov-border);
      padding: 0.75rem 1rem;
      transition: all 0.2s ease;
      font-size: 0.95rem;
    }

    .form-control:focus {
      border-color: var(--gov-primary);
      box-shadow: 0 0 0 0.2rem rgba(0, 51, 102, 0.15);
      outline: none;
    }

    /* Government Testimonials */
    .testimonial-card {
      background: var(--gov-white);
      border-radius: 8px;
      padding: 2rem;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
      position: relative;
      margin: 1rem 0;
      border: 2px solid var(--gov-border);
      border-left: 4px solid var(--gov-primary);
    }

    .testimonial-card::before {
      content: '"';
      position: absolute;
      top: 10px;
      left: 20px;
      font-size: 3rem;
      color: var(--gov-primary);
      opacity: 0.2;
      font-weight: 700;
    }

    /* Government Footer */
    .footer {
      background: var(--gov-primary);
      color: var(--gov-white);
      border-top: 4px solid var(--gov-accent);
    }

    .footer h5, .footer h6 {
      color: var(--gov-white);
      font-weight: 600;
      margin-bottom: 1rem;
    }

    .footer a {
      color: rgba(255, 255, 255, 0.8);
      text-decoration: none;
      transition: color 0.2s ease;
    }

    .footer a:hover {
      color: var(--gov-accent);
    }

    .social-links a {
      display: inline-block;
      width: 40px;
      height: 40px;
      background: rgba(255, 255, 255, 0.1);
      border-radius: 4px;
      text-align: center;
      line-height: 40px;
      margin: 0 5px;
      transition: all 0.2s ease;
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .social-links a:hover {
      background: var(--gov-accent);
      color: var(--gov-primary);
      transform: translateY(-2px);
    }

    /* Section Styling */
    section {
      padding: 60px 0;
    }

    .section-title {
      font-size: 2.25rem;
      font-weight: 700;
      color: var(--gov-primary);
      margin-bottom: 1rem;
      text-align: center;
    }

    .section-subtitle {
      font-size: 1.1rem;
      color: var(--gov-text-light);
      text-align: center;
      margin-bottom: 3rem;
    }

    .bg-light {
      background-color: var(--gov-light) !important;
    }

    /* Trust Indicators */
    .trust-indicator {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      color: rgba(255, 255, 255, 0.95);
      font-size: 0.95rem;
    }

    .trust-indicator i {
      color: var(--gov-accent);
    }

    /* Government Badge */
    .badge {
      border-radius: 4px;
      padding: 0.4rem 0.8rem;
      font-weight: 600;
      font-size: 0.85rem;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
      .hero-content h1 {
        font-size: 2rem;
      }

      .hero-content .lead {
        font-size: 1.1rem;
      }

      .section-title {
        font-size: 1.75rem;
      }

      .process-step::after {
        display: none;
      }

      .brand-subtitle {
        display: none !important;
      }

      .navbar-brand {
        font-size: 1.1rem;
      }

      .hero-section {
        padding: 100px 0 60px;
      }

      .hero-image-wrapper {
        margin-top: 2rem;
      }
    }

    /* Loading Animation */
    .loading-animation {
      display: inline-block;
      width: 20px;
      height: 20px;
      border: 3px solid rgba(255,255,255,0.3);
      border-radius: 50%;
      border-top-color: #fff;
      animation: spin 1s ease-in-out infinite;
    }

    @keyframes spin {
      to { transform: rotate(360deg); }
    }

    /* Official Seal/Stamp Effect */
    .official-badge {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      padding: 0.5rem 1rem;
      background: var(--gov-white);
      border: 2px solid var(--gov-primary);
      border-radius: 4px;
      color: var(--gov-primary);
      font-weight: 600;
      font-size: 0.9rem;
    }

    .official-badge i {
      color: var(--gov-accent);
    }

    .staff-section {
        transition: all 0.3s ease;
        cursor: pointer;
    }
    .staff-section:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    }
    .staff-section.selected {
        border: 3px solid #0d6efd;
        background-color: #f8f9fa;
    }
    .back-btn {
        position: fixed;
        top: 20px;
        left: 20px;
        z-index: 1000;
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

<!-- Header -->
<div class="container-fluid page-header text-white py-4">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="display-5 fw-bold mb-0">
                    <i class="fas fa-user-tie me-3"></i>Staff Portal
                </h1>
                <p class="lead mb-0 mt-2">Access your department's secure workspace</p>
            </div>
            <div class="col-md-4 text-end">
                <img src="images/passport-icon.svg" alt="Staff Portal" style="height: 80px; opacity: 0.8;">
            </div>
        </div>
    </div>
</div>

<!-- Staff Sections Selection -->
<div class="container py-5">
    <div class="row g-4" id="staffSections">
        <div class="col-md-6 col-lg-3">
            <div class="card staff-section h-100 border-0 shadow-sm" data-section="application">
                <div class="card-body text-center p-4">
                    <div class="mb-3">
                        <i class="fas fa-file-alt fa-3x text-primary"></i>
                    </div>
                    <h5 class="card-title fw-bold">Application Section</h5>
                    <p class="card-text text-muted">
                        Process passport applications, review documents, and manage application status
                    </p>
                    <button class="btn btn-primary" onclick="selectSection('application')" id="applicationBtn">
                        Select Section
                    </button>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="card staff-section h-100 border-0 shadow-sm" data-section="payment">
                <div class="card-body text-center p-4">
                    <div class="mb-3">
                        <i class="fas fa-credit-card fa-3x text-success"></i>
                    </div>
                    <h5 class="card-title fw-bold">Payment Section</h5>
                    <p class="card-text text-muted">
                        Handle payment processing, refunds, and financial transactions
                    </p>
                    <button class="btn btn-success" onclick="selectSection('payment')">
                        Select Section
                    </button>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="card staff-section h-100 border-0 shadow-sm" data-section="print">
                <div class="card-body text-center p-4">
                    <div class="mb-3">
                        <i class="fas fa-print fa-3x text-secondary"></i>
                    </div>
                    <h5 class="card-title fw-bold">Print Section</h5>
                    <p class="card-text text-muted">
                        Manage passport printing, quality control, and production workflow
                    </p>
                    <button class="btn btn-secondary" onclick="selectSection('print')">
                        Select Section
                    </button>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="card staff-section h-100 border-0 shadow-sm" data-section="logistic">
                <div class="card-body text-center p-4">
                    <div class="mb-3">
                        <i class="fas fa-shipping-fast fa-3x text-warning"></i>
                    </div>
                    <h5 class="card-title fw-bold">Logistic Service</h5>
                    <p class="card-text text-muted">
                        Manage passport delivery, tracking, and logistics operations
                    </p>
                    <button class="btn btn-warning" onclick="selectSection('logistic')">
                        Select Section
                    </button>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="card staff-section h-100 border-0 shadow-sm" data-section="helpdesk">
                <div class="card-body text-center p-4">
                    <div class="mb-3">
                        <i class="fas fa-headset fa-3x text-info"></i>
                    </div>
                    <h5 class="card-title fw-bold">Help Desk</h5>
                    <p class="card-text text-muted">
                        Manage FAQ content and provide customer support
                    </p>
                    <button class="btn btn-info" onclick="selectSection('helpdesk')">
                        Select Section
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS Animation -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<!-- Custom JS -->

<script>
    function selectSection(section) {
        console.log('selectSection called with:', section);
        // Build absolute URL to login.jsp with encoded section and correct context path
        if (!section) {
            window.location.href = 'staff-login.jsp';
            return;
        }
        const basePath = '<%= request.getContextPath() %>' || '';
        const url = basePath + '/login.jsp?section=' + encodeURIComponent(section);
        console.log('Redirecting to:', url);
        window.location.href = url;
    }

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        console.log('DOM loaded, setting up click handlers');

        // Specific handler for Application Section button
        const applicationBtn = document.getElementById('applicationBtn');
        if (applicationBtn) {
            applicationBtn.addEventListener('click', function(e) {
                console.log('Application button clicked directly');
                e.stopPropagation(); // Prevent card click handler
                selectSection('application');
            });
        }

        // Add click handlers for section cards
        document.querySelectorAll('.staff-section').forEach(section => {
            section.addEventListener('click', function() {
                const sectionType = this.getAttribute('data-section');
                console.log('Card clicked, section:', sectionType);
                selectSection(sectionType);
            });
        });

        // Add click handlers for buttons
        document.querySelectorAll('button[onclick^="selectSection"]').forEach(button => {
            const onclickValue = button.getAttribute('onclick');
            console.log('Button found with onclick:', onclickValue);
        });

        console.log('Setup complete');
        });
    
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
    </script>
    </body>
</html>

