<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Professional passport services in Sri Lanka. Fast, reliable, and secure passport processing with expert guidance.">
  <meta name="keywords" content="passport service, Sri Lanka passport, passport renewal, new passport, lost passport">
  <meta name="author" content="Lanka Epassport Service">
  <title>Lanka Epassport Service - Professional Passport Issuing Service</title>

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
  </style>
</head>
<body>
<!-- Enhanced Professional Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNavbar">
  <div class="container">
    <!-- Enhanced Brand -->
    <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
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
          <a class="nav-link nav-link-modern active" href="#home">
            <i class="fas fa-home me-1 d-none d-sm-inline"></i>
            <span>Home</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-modern" href="#services">
            <i class="fas fa-cogs me-1 d-none d-sm-inline"></i>
            <span>Services</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-modern" href="#process">
            <i class="fas fa-route me-1 d-none d-sm-inline"></i>
            <span>Process</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-modern" href="#testimonials">
            <i class="fas fa-star me-1 d-none d-sm-inline"></i>
            <span>Testimonials</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-modern" href="helpdesk.jsp">
            <i class="fas fa-question-circle me-1 d-none d-sm-inline"></i>
            <span>Help Desk</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-modern" href="#contact">
            <i class="fas fa-envelope me-1 d-none d-sm-inline"></i>
            <span>Contact</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-modern" href="applications.jsp">
            <i class="fas fa-list me-1 d-none d-sm-inline"></i>
            <span>My Applications</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link nav-link-modern" href="application.jsp">
            <i class="fas fa-plus me-1 d-none d-sm-inline"></i>
            <span>New Application</span>
          </a>
        </li>

        <!-- Action Buttons -->
        <li class="nav-item ms-2">
            <a class="nav-link btn btn-primary btn-modern-nav" href="#apply">
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

<!-- Hero Section -->
<section id="home" class="hero-section">
  <div class="container position-relative">
    <div class="row align-items-center min-vh-100">
      <div class="col-lg-6" data-aos="fade-right" data-aos-duration="1000">
        <div class="hero-content">
          <div class="hero-badge">
            <i class="fas fa-shield-alt me-2"></i>Official Government Service
          </div>
          <h1 class="display-4 fw-bold text-white mb-4">
            Passport Issuing Service<br>Government of Sri Lanka
          </h1>
          <p class="lead text-white mb-4 fs-5">
            Secure, efficient, and reliable passport services for all Sri Lankan citizens.
            Apply online, track your application, and receive your passport with confidence.
          </p>
          <div class="d-flex gap-3 flex-wrap mb-4">
            <button type="button" class="btn btn-light btn-lg btn-modern" data-bs-toggle="modal" data-bs-target="#authModal">
              <i class="fas fa-file-alt me-2"></i>Apply for Passport
            </button>
            <a href="#services" class="btn btn-outline-light btn-lg btn-modern">
              <i class="fas fa-info-circle me-2"></i>View Services
            </a>
          </div>

          <!-- Trust Indicators -->
          <div class="mt-4 d-flex align-items-center gap-4 flex-wrap">
            <div class="trust-indicator">
              <i class="fas fa-shield-alt"></i>
              <span>Secure & Confidential</span>
            </div>
            <div class="trust-indicator">
              <i class="fas fa-clock"></i>
              <span>Efficient Processing</span>
            </div>
            <div class="trust-indicator">
              <i class="fas fa-check-circle"></i>
              <span>Government Certified</span>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6" data-aos="fade-left" data-aos-duration="1000">
        <div class="hero-image-container">
          <div class="hero-image-wrapper">
            <img src="images/home%20page%20image.png" alt="Passport Services - Government of Sri Lanka" class="hero-image">
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Video Section -->
<section class="video-section">
  <div class="container">
    <div class="text-center mb-5" data-aos="fade-up">
      <h2 class="section-title">
        <i class="fas fa-video me-2"></i>About the Sri Lankan Passport
      </h2>
      <p class="section-subtitle">Learn more about passport features and security</p>
    </div>
    <div class="row justify-content-center">
      <div class="col-lg-10" data-aos="fade-up" data-aos-delay="200">
        <div class="video-container">
          <!-- Option 1: Embedded YouTube Video -->
          <iframe 
            src="https://www.youtube.com/embed/zMSJZWIKbRs?rel=0&modestbranding=1" 
            frameborder="0" 
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
            allowfullscreen
            title="Sri Lankan Passport Information Video">
          </iframe>
          
          <!-- Option 2: Local Video File (Uncomment and use this if you have a local video file) -->
          <!--
          <video controls poster="images/passport-video-poster.jpg" class="w-100">
            <source src="videos/sri-lankan-passport.mp4" type="video/mp4">
            <source src="videos/sri-lankan-passport.webm" type="video/webm">
            Your browser does not support the video tag.
          </video>
          -->
        </div>
        <div class="text-center mt-4">
          <p class="text-muted">
            <i class="fas fa-info-circle me-2"></i>
            Official information about passport features, security, and application requirements
          </p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Services Section -->
<section id="services" class="py-5 bg-light">
  <div class="container">
    <div class="text-center mb-5" data-aos="fade-up">
      <h2 class="section-title">Our Services</h2>
      <p class="section-subtitle">Comprehensive passport services for all citizens</p>
    </div>
    <div class="row g-4">
      <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
        <div class="card service-card h-100">
          <div class="card-body text-center p-4">
            <div class="service-icon">
              <i class="fas fa-passport"></i>
            </div>
            <h5 class="card-title fw-bold">New Passport</h5>
            <p class="card-text text-muted">
              Apply for a new passport with our streamlined process and expert guidance.
            </p>
            <div class="d-flex justify-content-between align-items-center mb-3">
              <span class="badge bg-success">3-5 Days</span>
              <span class="text-primary fw-bold">Rs. 15,000</span>
            </div>
            <a href="#" class="btn btn-primary btn-modern w-100">
              <i class="fas fa-arrow-right me-2"></i>Learn More
            </a>
          </div>
        </div>
      </div>

      <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
        <div class="card service-card h-100">
          <div class="card-body text-center p-4">
            <div class="service-icon">
              <i class="fas fa-sync-alt"></i>
            </div>
            <h5 class="card-title fw-bold">Passport Renewal</h5>
            <p class="card-text text-muted">
              Quick and easy passport renewal service with minimal documentation.
            </p>
            <div class="d-flex justify-content-between align-items-center mb-3">
              <span class="badge bg-warning">5-7 Days</span>
              <span class="text-primary fw-bold">Rs. 12,000</span>
            </div>
            <a href="#" class="btn btn-primary btn-modern w-100">
              <i class="fas fa-arrow-right me-2"></i>Learn More
            </a>
          </div>
        </div>
      </div>

      <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
        <div class="card service-card h-100">
          <div class="card-body text-center p-4">
            <div class="service-icon">
              <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h5 class="card-title fw-bold">Lost Passport</h5>
            <p class="card-text text-muted">
              Emergency replacement for lost or stolen passports with priority processing.
            </p>
            <div class="d-flex justify-content-between align-items-center mb-3">
              <span class="badge bg-danger">1-2 Days</span>
              <span class="text-primary fw-bold">Rs. 20,000</span>
            </div>
            <a href="#" class="btn btn-primary btn-modern w-100">
              <i class="fas fa-arrow-right me-2"></i>Learn More
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Process Section -->
<section id="process" class="py-5">
  <div class="container">
    <div class="text-center mb-5" data-aos="fade-up">
      <h2 class="section-title">Application Process</h2>
      <p class="section-subtitle">Follow these simple steps to obtain your passport</p>
    </div>
    <div class="row g-4">
      <div class="col-md-3 text-center" data-aos="fade-up" data-aos-delay="100">
        <div class="process-step">
          <div class="step-number">1</div>
          <h5>Submit Application</h5>
          <p class="text-muted">Fill out the online form with your details</p>
        </div>
      </div>
      <div class="col-md-3 text-center" data-aos="fade-up" data-aos-delay="200">
        <div class="process-step">
          <div class="step-number">2</div>
          <h5>Document Verification</h5>
          <p class="text-muted">We verify all submitted documents</p>
        </div>
      </div>
      <div class="col-md-3 text-center" data-aos="fade-up" data-aos-delay="300">
        <div class="process-step">
          <div class="step-number">3</div>
          <h5>Processing</h5>
          <p class="text-muted">Your application is processed by authorities</p>
        </div>
      </div>
      <div class="col-md-3 text-center" data-aos="fade-up" data-aos-delay="400">
        <div class="process-step">
          <div class="step-number">4</div>
          <h5>Collection</h5>
          <p class="text-muted">Collect your passport from our office</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Testimonials Section -->
<section id="testimonials" class="py-5 bg-light">
  <div class="container">
    <div class="text-center mb-5" data-aos="fade-up">
      <h2 class="section-title">Citizen Feedback</h2>
      <p class="section-subtitle">Testimonials from citizens who have used our services</p>
    </div>
    <div class="row g-4">
      <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
        <div class="testimonial-card">
          <div class="d-flex align-items-center mb-3">
            <img src="https://via.placeholder.com/50x50/0d6efd/ffffff?text=JD"
                 alt="John Doe" class="rounded-circle me-3">
            <div>
              <h6 class="mb-0 fw-bold">John Doe</h6>
              <small class="text-muted">Business Traveler</small>
            </div>
          </div>
          <p class="mb-0">"Excellent service! Got my passport renewed in just 3 days. The staff was very professional and helpful throughout the process."</p>
          <div class="text-warning mt-2">
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
          </div>
        </div>
      </div>

      <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
        <div class="testimonial-card">
          <div class="d-flex align-items-center mb-3">
            <img src="https://via.placeholder.com/50x50/198754/ffffff?text=JS"
                 alt="Jane Smith" class="rounded-circle me-3">
            <div>
              <h6 class="mb-0 fw-bold">Jane Smith</h6>
              <small class="text-muted">Student</small>
            </div>
          </div>
          <p class="mb-0">"Very efficient and reliable service. They guided me through every step and made the application process so simple."</p>
          <div class="text-warning mt-2">
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
          </div>
        </div>
      </div>

      <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
        <div class="testimonial-card">
          <div class="d-flex align-items-center mb-3">
            <img src="https://via.placeholder.com/50x50/dc3545/ffffff?text=MB"
                 alt="Mike Brown" class="rounded-circle me-3">
            <div>
              <h6 class="mb-0 fw-bold">Mike Brown</h6>
              <small class="text-muted">Tourist</small>
            </div>
          </div>
          <p class="mb-0">"Outstanding experience! Lost my passport and they helped me get a replacement within 24 hours. Highly recommended!"</p>
          <div class="text-warning mt-2">
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</section>

<!-- Apply Now Section -->
<section id="apply" class="py-5 bg-primary text-white">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-lg-8" data-aos="fade-right">
        <h2 class="display-6 fw-bold mb-3">Apply for Your Passport</h2>
        <p class="lead mb-4">
          Begin your passport application process today. Our official portal provides
          secure and efficient services for all passport-related needs.
        </p>
        <div class="d-flex gap-3 flex-wrap">
          <button type="button" class="btn btn-light btn-lg btn-modern" data-bs-toggle="modal" data-bs-target="#authModal">
            <i class="fas fa-file-alt me-2"></i>Start Application
          </button>
          <a href="#contact" class="btn btn-outline-light btn-lg btn-modern">
            <i class="fas fa-phone me-2"></i>Contact Support
          </a>
        </div>
      </div>
      <div class="col-lg-4 text-center" data-aos="fade-left">
        <div class="official-badge">
          <i class="fas fa-certificate fa-3x"></i>
        </div>
        <p class="text-white mt-3 mb-0">Official Government Portal</p>
      </div>
    </div>
  </div>
</section>

<!-- Contact Section -->
<section id="contact" class="py-5">
  <div class="container">
    <div class="text-center mb-5" data-aos="fade-up">
      <h2 class="section-title">Contact Information</h2>
      <p class="section-subtitle">Reach out to our support team for assistance</p>
    </div>
    <div class="row g-4">
      <div class="col-lg-4" data-aos="fade-right">
        <div class="contact-info">
          <h5 class="fw-bold mb-4">Contact Information</h5>
          <div class="d-flex mb-4">
            <div class="bg-primary text-white rounded-circle p-3 me-3">
              <i class="fas fa-map-marker-alt"></i>
            </div>
            <div>
              <strong>Address:</strong><br>
              123 Main Street, Colombo 01, Sri Lanka
            </div>
          </div>
          <div class="d-flex mb-4">
            <div class="bg-success text-white rounded-circle p-3 me-3">
              <i class="fas fa-phone"></i>
            </div>
            <div>
              <strong>Phone:</strong><br>
              +94 11 234 5678
            </div>
          </div>
          <div class="d-flex mb-4">
            <div class="bg-info text-white rounded-circle p-3 me-3">
              <i class="fas fa-envelope"></i>
            </div>
            <div>
              <strong>Email:</strong><br>
              info@lankaepassport.lk
            </div>
          </div>

          <!-- Business Hours -->
          <div class="mt-4 p-3 bg-light rounded">
            <h6 class="fw-bold mb-2">Business Hours</h6>
            <p class="mb-1"><strong>Monday - Friday:</strong> 8:00 AM - 6:00 PM</p>
            <p class="mb-1"><strong>Saturday:</strong> 9:00 AM - 2:00 PM</p>
            <p class="mb-0"><strong>Sunday:</strong> Closed</p>
          </div>
        </div>
      </div>
      <div class="col-lg-8" data-aos="fade-left">
        <div class="contact-form">
          <div class="card-body p-4">
            <h5 class="fw-bold mb-4">Send us a Message</h5>
            <form id="contactForm">
              <div class="row g-3">
                <div class="col-md-6">
                  <label for="contactName" class="form-label">Full Name</label>
                  <input type="text" class="form-control" id="contactName" name="fullName" placeholder="Full Name" required>
                </div>
                <div class="col-md-6">
                  <label for="contactEmail" class="form-label">Email Address</label>
                  <input type="email" class="form-control" id="contactEmail" name="email" placeholder="Email Address" required>
                </div>
                <div class="col-12">
                  <label for="contactSubject" class="form-label">Subject</label>
                  <input type="text" class="form-control" id="contactSubject" name="subject" placeholder="Subject" required>
                </div>
                <div class="col-12">
                  <label for="contactMessage" class="form-label">Your Message</label>
                  <textarea class="form-control" id="contactMessage" name="message" rows="4" placeholder="Your Message" required></textarea>
                </div>
                <div class="col-12">
                  <button type="submit" class="btn btn-primary btn-modern w-100">
                    <i class="fas fa-paper-plane me-2"></i>Send Message
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Authentication Modal -->
<div class="modal fade auth-modal" id="authModal" tabindex="-1" aria-labelledby="authModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="authModalLabel">
          <i class="fas fa-user-lock me-2"></i>Authentication Required
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- Auth Tabs -->
        <ul class="nav nav-tabs auth-tabs mb-4" id="authTabs" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="login-tab" data-bs-toggle="tab" data-bs-target="#login" type="button" role="tab">
              <i class="fas fa-sign-in-alt me-2"></i>Login
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="register-tab" data-bs-toggle="tab" data-bs-target="#register" type="button" role="tab">
              <i class="fas fa-user-plus me-2"></i>Register
            </button>
          </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content" id="authTabContent">
          <!-- Login Tab -->
          <div class="tab-pane fade show active" id="login" role="tabpanel">
            <form id="loginForm">
              <div class="mb-3">
                <label for="loginNic" class="form-label">NIC Number</label>
                <input type="text" class="form-control" id="loginNic" placeholder="Enter your NIC number" required>
              </div>
              <div class="mb-3">
                <label for="loginPassword" class="form-label">Password</label>
                <input type="password" class="form-control" id="loginPassword" placeholder="Enter your password" required>
              </div>
              <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="rememberMe">
                <label class="form-check-label" for="rememberMe">Remember me</label>
              </div>
              <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-modern">
                  <i class="fas fa-sign-in-alt me-2"></i>Login
                </button>
              </div>
              <div class="text-center mt-3">
                <a href="#" class="text-decoration-none">Forgot Password?</a>
              </div>
            </form>
          </div>

          <!-- Register Tab -->
          <div class="tab-pane fade" id="register" role="tabpanel">
            <form id="registerForm">
              <div class="mb-3">
                <label for="regNicNumber" class="form-label">NIC Number</label>
                <input type="text" class="form-control" id="regNicNumber" placeholder="Enter your NIC number (12 digits or 9 digits + V)" required pattern="^(\d{12}|\d{9}[vV])$">
                <div class="form-text">
                  <i class="fas fa-info-circle me-1"></i>NIC must be 12 digits (e.g., 123456789012) or 9 digits + V (e.g., 123456789V)
                </div>
                <div class="invalid-feedback">
                  NIC must be 12 digits or 9 digits followed by V.
                </div>
              </div>
              <div class="mb-3">
                <label for="regEmail" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="regEmail" placeholder="Enter your email address" required>
                <div class="form-text">
                  <i class="fas fa-info-circle me-1"></i>Please enter a valid email address
                </div>
                <div class="invalid-feedback">
                  Please enter a valid email address.
                </div>
              </div>
              <div class="mb-3">
                <label for="regPassword" class="form-label">Password</label>
                <input type="password" class="form-control" id="regPassword" placeholder="Enter password (min 7 chars with letters & digits)" required minlength="7">
                <div class="form-text">
                  <i class="fas fa-info-circle me-1"></i>Password must be at least 7 characters and contain both letters and digits (e.g., pass1234)
                </div>
                <div class="invalid-feedback">
                  Password must be at least 7 characters and contain both letters and digits.
                </div>
              </div>
              <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                <label class="form-check-label" for="agreeTerms">
                  I agree to the <a href="#" class="text-decoration-none">Terms and Conditions</a>
                </label>
              </div>
              <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-modern">
                  <i class="fas fa-user-plus me-2"></i>Create Account
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Footer -->
<footer class="footer py-5">
  <div class="container">
    <div class="row g-4">
      <div class="col-lg-4">
        <h5 class="mb-3">
          <i class="fas fa-passport me-2"></i>
          Lanka Epassport Service
        </h5>
        <p class="text-muted mb-3">
          Official passport issuing service of the Government of Sri Lanka. 
          Providing secure, efficient, and reliable passport services for all citizens.
        </p>
        <div class="social-links">
          <a href="#" class="text-white"><i class="fab fa-facebook"></i></a>
          <a href="#" class="text-white"><i class="fab fa-twitter"></i></a>
          <a href="#" class="text-white"><i class="fab fa-linkedin"></i></a>
          <a href="#" class="text-white"><i class="fab fa-instagram"></i></a>
        </div>
      </div>
      <div class="col-lg-2">
        <h6 class="mb-3">Services</h6>
        <ul class="list-unstyled">
          <li><a href="#" class="text-muted text-decoration-none">New Passport</a></li>
          <li><a href="#" class="text-muted text-decoration-none">Passport Renewal</a></li>
          <li><a href="#" class="text-muted text-decoration-none">Lost Passport</a></li>
          <li><a href="#" class="text-muted text-decoration-none">Express Service</a></li>
        </ul>
      </div>
      <div class="col-lg-2">
        <h6 class="mb-3">Support</h6>
        <ul class="list-unstyled">
          <li><a href="#" class="text-muted text-decoration-none">Help Center</a></li>
          <li><a href="helpdesk.jsp" class="text-muted text-decoration-none">FAQ</a></li>
          <li><a href="#contact" class="text-muted text-decoration-none">Contact Us</a></li>
          <li><a href="#" class="text-muted text-decoration-none">Live Chat</a></li>
        </ul>
      </div>
      <div class="col-lg-4">
        <h6 class="mb-3">Newsletter</h6>
        <p class="text-muted mb-3">Subscribe to get updates on our services and special offers.</p>
        <div class="input-group">
          <label for="newsletterEmail" class="visually-hidden">Email Address</label>
          <input type="email" class="form-control" placeholder="Enter your email" id="newsletterEmail" name="email">
          <button class="btn btn-primary" type="button" onclick="subscribeNewsletter()">
            <i class="fas fa-paper-plane"></i>
          </button>
        </div>
        <small class="text-muted">Get updates on passport services and special offers</small>
      </div>
    </div>
    <hr class="my-4">
    <div class="row align-items-center">
      <div class="col-md-6">
        <small class="text-muted">&copy; 2024 Lanka Epassport Service - Government of Sri Lanka. All rights reserved.</small>
      </div>
      <div class="col-md-6 text-md-end">
        <small class="text-muted">
          <a href="#" class="text-muted text-decoration-none me-3">Privacy Policy</a>
          <a href="#" class="text-muted text-decoration-none me-3">Terms of Service</a>
          <a href="#" class="text-muted text-decoration-none">Cookie Policy</a>
        </small>
      </div>
    </div>
  </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<!-- AOS Animation -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<!-- Custom JS -->

<script>
  // Initialize AOS
  AOS.init({
    duration: 1000,
    once: true,
    offset: 100
  });

  // Enhanced Navbar scroll effect
  window.addEventListener('scroll', function() {
    const navbar = document.getElementById('mainNavbar');
    if (window.scrollY > 50) {
      navbar.classList.add('scrolled');
    } else {
      navbar.classList.remove('scrolled');
    }
  });

  // Active navigation link highlighting
  function updateActiveNavLink() {
    const sections = document.querySelectorAll('section[id]');
    const navLinks = document.querySelectorAll('.nav-link-modern');

    let current = '';
    sections.forEach(section => {
      const sectionTop = section.offsetTop;
      const sectionHeight = section.clientHeight;
      if (window.scrollY >= (sectionTop - 200)) {
        current = section.getAttribute('id');
      }
    });

    navLinks.forEach(link => {
      link.classList.remove('active');
      if (link.getAttribute('href') === `#${current}`) {
        link.classList.add('active');
      }
    });
  }

  // Update active link on scroll
  window.addEventListener('scroll', updateActiveNavLink);

  // Initialize active link
  updateActiveNavLink();

  // Auto-fill login form if remember me was previously selected
  const savedLogin = localStorage.getItem('lankaEpassportLogin');
  if (savedLogin) {
    try {
      const loginData = JSON.parse(savedLogin);
      document.getElementById('loginNic').value = loginData.nicNumber || '';
      document.getElementById('loginPassword').value = loginData.password || '';
      document.getElementById('rememberMe').checked = true;
    } catch (error) {
      console.error('Error parsing saved login data:', error);
      localStorage.removeItem('lankaEpassportLogin');
    }
  }

  // Smooth scroll with active link update
  document.querySelectorAll('.nav-link-modern[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        // Update active link
        document.querySelectorAll('.nav-link-modern').forEach(link => link.classList.remove('active'));
        this.classList.add('active');

        // Smooth scroll
        target.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      }
    });
  });

  // Mobile menu close on link click
  const mobileMenu = document.querySelector('.navbar-collapse');
  const mobileMenuLinks = document.querySelectorAll('.navbar-nav .nav-link');

  mobileMenuLinks.forEach(link => {
    link.addEventListener('click', () => {
      if (mobileMenu.classList.contains('show')) {
        const bsCollapse = new bootstrap.Collapse(mobileMenu);
        bsCollapse.hide();
      }
    });
  });


  // Form handling
  document.getElementById('contactForm')?.addEventListener('submit', function(e) {
    e.preventDefault();
    // Add your form submission logic here
    alert('Thank you for your message! We will get back to you soon.');
  });

  document.getElementById('loginForm')?.addEventListener('submit', async function(e) {
    e.preventDefault();

    const nicNumber = document.getElementById('loginNic').value;
    const password = document.getElementById('loginPassword').value;
    const rememberMe = document.getElementById('rememberMe').checked;

    try {
      const response = await fetch('<%= request.getContextPath() %>/api/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ nicNumber, password })
      });

      if (response.ok) {
        const userData = await response.json();

        // Store user info in localStorage
        localStorage.setItem('lankaEpassportUser', JSON.stringify({
          nicNumber: userData.nicNumber,
          email: userData.email,
          name: userData.firstName && userData.lastName ? `${userData.firstName} ${userData.lastName}` : userData.nicNumber,
          userId: userData.userId,
          firstName: userData.firstName,
          lastName: userData.lastName,
          dateOfBirth: userData.dateOfBirth,
          address: userData.address,
          city: userData.city,
          postalCode: userData.postalCode
        }));

        // If remember me is checked, save login credentials
        if (rememberMe) {
          localStorage.setItem('lankaEpassportLogin', JSON.stringify({
            nicNumber: nicNumber,
            password: password
          }));
        } else {
          // Clear any previously saved credentials
          localStorage.removeItem('lankaEpassportLogin');
        }

        // Close modal and redirect
        const modal = bootstrap.Modal.getInstance(document.getElementById('authModal'));
        modal.hide();

        // Redirect to applications page to view user's applications
        window.location.href = '<%= request.getContextPath() %>/applications.jsp';
      } else {
        alert('Login failed. Please check your credentials.');
      }
    } catch (error) {
      console.error('Login error:', error);
      alert('Login failed. Please try again.');
    }
  });

  document.getElementById('registerForm')?.addEventListener('submit', async function(e) {
    e.preventDefault();

    // Get form values
    const nicNumber = document.getElementById('regNicNumber').value;
    const email = document.getElementById('regEmail').value;
    const password = document.getElementById('regPassword').value;

    // Validate NIC number
    const nicPattern = /^(\d{12}|\d{9}[vV])$/;
    if (!nicPattern.test(nicNumber)) {
      alert('NIC must be 12 digits (e.g., 123456789012) or 9 digits + V (e.g., 123456789V)');
      document.getElementById('regNicNumber').focus();
      return;
    }

    // Validate email
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
      alert('Please enter a valid email address');
      document.getElementById('regEmail').focus();
      return;
    }

    // Validate password (must be at least 7 characters with both letters and digits)
    const passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d).{7,}$/;
    if (!passwordPattern.test(password)) {
      alert('Password must be at least 7 characters and contain both letters and digits (e.g., pass1234)');
      document.getElementById('regPassword').focus();
      return;
    }

    const userData = {
      nicNumber: nicNumber,
      email: email,
      password: password
    };

    try {
      const response = await fetch('<%= request.getContextPath() %>/api/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(userData)
      });

      const result = await response.json();

      if (response.ok) {
        alert('Registration successful! Please login with your NIC and password.');
        // Switch to login tab
        const loginTab = new bootstrap.Tab(document.getElementById('login-tab'));
        loginTab.show();
        // Pre-fill NIC
        document.getElementById('loginNic').value = userData.nicNumber;
      } else {
        alert(result.error || 'Registration failed. Please try again.');
      }
    } catch (error) {
      console.error('Registration error:', error);
      alert('Registration failed. Please try again.');
    }
  });

  // Real-time NIC validation for registration
  document.getElementById('regNicNumber')?.addEventListener('input', function() {
    const nic = this.value;
    const nicPattern = /^(\d{12}|\d{9}[vV])$/;

    if (nic.length === 0) {
      this.setCustomValidity('');
      this.classList.remove('is-valid', 'is-invalid');
    } else if (nicPattern.test(nic)) {
      this.setCustomValidity('');
      this.classList.remove('is-invalid');
      this.classList.add('is-valid');
    } else {
      this.setCustomValidity('NIC must be 12 digits or 9 digits followed by V.');
      this.classList.remove('is-valid');
      this.classList.add('is-invalid');
    }
  });

  // Real-time email validation for registration
  document.getElementById('regEmail')?.addEventListener('input', function() {
    const email = this.value;
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (email.length === 0) {
      this.setCustomValidity('');
      this.classList.remove('is-valid', 'is-invalid');
    } else if (emailPattern.test(email)) {
      this.setCustomValidity('');
      this.classList.remove('is-invalid');
      this.classList.add('is-valid');
    } else {
      this.setCustomValidity('Please enter a valid email address.');
      this.classList.remove('is-valid');
      this.classList.add('is-invalid');
    }
  });

  // Real-time password validation for registration
  document.getElementById('regPassword')?.addEventListener('input', function() {
    const password = this.value;
    const passwordPattern = /^(?=.*[a-zA-Z])(?=.*\d).{7,}$/;

    if (password.length === 0) {
      this.setCustomValidity('');
      this.classList.remove('is-valid', 'is-invalid');
    } else if (passwordPattern.test(password)) {
      this.setCustomValidity('');
      this.classList.remove('is-invalid');
      this.classList.add('is-valid');
    } else {
      this.setCustomValidity('Password must be at least 7 characters and contain both letters and digits.');
      this.classList.remove('is-valid');
      this.classList.add('is-invalid');
    }
  });

  // Newsletter subscription
  function subscribeNewsletter() {
    const email = document.getElementById('newsletterEmail').value;
    if (email && email.includes('@')) {
      alert('Thank you for subscribing to our newsletter!');
      document.getElementById('newsletterEmail').value = '';
    } else {
      alert('Please enter a valid email address.');
    }
  }
</script>
</body>
</html>