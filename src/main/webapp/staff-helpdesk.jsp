<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Helpdesk Management - Lanka Epassport Service</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

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

        /* Staff Helpdesk specific styles */
        .staff-header {
            background: linear-gradient(135deg, var(--gov-primary), var(--gov-info));
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }

        .management-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: none;
            transition: all 0.3s ease;
        }

        .management-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .faq-item {
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }

        .faq-item:hover {
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .category-badge {
            font-size: 0.8rem;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-weight: 500;
        }

        .btn-action {
            padding: 0.4rem 0.8rem;
            font-size: 0.85rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            transform: translateY(-2px);
        }

        .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
        }

        .modal-header {
            background: linear-gradient(135deg, var(--gov-primary), var(--gov-info));
            color: white;
            border-radius: 15px 15px 0 0;
        }

        .stats-card {
            background: linear-gradient(135deg, var(--gov-success), #20c997);
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .search-box {
            border-radius: 25px;
            border: 2px solid #e9ecef;
            padding: 0.8rem 1.5rem;
            transition: all 0.3s ease;
        }

        .search-box:focus {
            border-color: var(--gov-primary);
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
        }

        .alert {
            border-radius: 10px;
            border: none;
        }

        .table {
            border-radius: 10px;
            overflow: hidden;
        }

        .table thead th {
            background: var(--gov-primary);
            color: white;
            border: none;
            font-weight: 600;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .loading-spinner {
            display: none;
        }

        .loading-spinner.show {
            display: inline-block;
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
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-5 fw-bold mb-3">
                        <i class="fas fa-headset me-3"></i>
                        Helpdesk Management
                    </h1>
                    <p class="lead mb-0">Manage FAQ content and customer support information</p>
                </div>
                <div class="col-md-4 text-end">
                    <button class="btn btn-light btn-lg" data-bs-toggle="modal" data-bs-target="#addFaqModal">
                        <i class="fas fa-plus me-2"></i>Add New FAQ
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- Statistics Cards -->
        <div class="row mb-4" data-aos="fade-up">
            <div class="col-md-3">
                <div class="stats-card">
                    <div class="stats-number" id="totalFaqs">0</div>
                    <div>Total FAQs</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card" style="background: linear-gradient(135deg, var(--info-color), #17a2b8);">
                    <div class="stats-number" id="activeFaqs">0</div>
                    <div>Active FAQs</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card" style="background: linear-gradient(135deg, var(--warning-color), #fd7e14);">
                    <div class="stats-number" id="categoriesCount">0</div>
                    <div>Categories</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card" style="background: linear-gradient(135deg, var(--secondary-color), #6f42c1);">
                    <div class="stats-number" id="recentUpdates">0</div>
                    <div>Recent Updates</div>
                </div>
            </div>
        </div>

        <!-- Search and Filter -->
        <div class="row mb-4" data-aos="fade-up" data-aos-delay="100">
            <div class="col-md-8">
                <div class="position-relative">
                    <input type="text" class="form-control search-box" id="searchFaq" placeholder="Search FAQs by question or answer...">
                    <i class="fas fa-search position-absolute" style="right: 1.5rem; top: 50%; transform: translateY(-50%); color: #6c757d;"></i>
                </div>
            </div>
            <div class="col-md-4">
                <select class="form-select" id="categoryFilter">
                    <option value="">All Categories</option>
                    <option value="application">Application Process</option>
                    <option value="documents">Documents</option>
                    <option value="payment">Payment & Fees</option>
                    <option value="processing">Processing Times</option>
                    <option value="technical">Technical Support</option>
                </select>
            </div>
        </div>

        <!-- FAQ Management Table -->
        <div class="management-card" data-aos="fade-up" data-aos-delay="200">
            <div class="card-header bg-white border-0 py-3">
                <h5 class="mb-0">
                    <i class="fas fa-list me-2"></i>FAQ Management
                </h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th width="5%">ID</th>
                                <th width="30%">Question</th>
                                <th width="20%">Category</th>
                                <th width="15%">Status</th>
                                <th width="15%">Created</th>
                                <th width="15%">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="faqTableBody">
                            <!-- FAQ items will be loaded here -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Add FAQ Modal -->
    <div class="modal fade" id="addFaqModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-plus me-2"></i>Add New FAQ
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addFaqForm">
                        <div class="mb-3">
                            <label for="faqQuestion" class="form-label">Question</label>
                            <textarea class="form-control" id="faqQuestion" rows="2" placeholder="Enter the FAQ question..." required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="faqAnswer" class="form-label">Answer</label>
                            <textarea class="form-control" id="faqAnswer" rows="4" placeholder="Enter the detailed answer..." required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="faqCategory" class="form-label">Category</label>
                            <select class="form-select" id="faqCategory" required>
                                <option value="">Select Category</option>
                                <option value="application">Application Process</option>
                                <option value="documents">Documents</option>
                                <option value="payment">Payment & Fees</option>
                                <option value="processing">Processing Times</option>
                                <option value="technical">Technical Support</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="faqActive" checked>
                                <label class="form-check-label" for="faqActive">
                                    Active (visible to public)
                                </label>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="addFaq()">
                        <span class="loading-spinner spinner-border spinner-border-sm me-2"></span>
                        <i class="fas fa-save me-2"></i>Add FAQ
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit FAQ Modal -->
    <div class="modal fade" id="editFaqModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-edit me-2"></i>Edit FAQ
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="editFaqForm">
                        <input type="hidden" id="editFaqId">
                        <div class="mb-3">
                            <label for="editFaqQuestion" class="form-label">Question</label>
                            <textarea class="form-control" id="editFaqQuestion" rows="2" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="editFaqAnswer" class="form-label">Answer</label>
                            <textarea class="form-control" id="editFaqAnswer" rows="4" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="editFaqCategory" class="form-label">Category</label>
                            <select class="form-select" id="editFaqCategory" required>
                                <option value="application">Application Process</option>
                                <option value="documents">Documents</option>
                                <option value="payment">Payment & Fees</option>
                                <option value="processing">Processing Times</option>
                                <option value="technical">Technical Support</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="editFaqActive">
                                <label class="form-check-label" for="editFaqActive">
                                    Active (visible to public)
                                </label>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="updateFaq()">
                        <span class="loading-spinner spinner-border spinner-border-sm me-2"></span>
                        <i class="fas fa-save me-2"></i>Update FAQ
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Alert Container -->
    <div id="alertContainer" class="position-fixed" style="top: 100px; right: 20px; z-index: 1050;"></div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- AOS Animation -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

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

        // Global variables
        let faqData = [];
        let currentStaffUsername = '';

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            checkStaffAuth();
            loadFaqs();
            setupEventListeners();
        });

        // Check staff authentication
        async function checkStaffAuth() {
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
                        currentStaffUsername = data.username;
                        document.getElementById('staffUsername').textContent = data.username;
                    } else {
                        window.location.href = 'staff-login.jsp';
                    }
                } else {
                    window.location.href = 'staff-login.jsp';
                }
            } catch (error) {
                console.error('Auth check failed:', error);
                window.location.href = 'staff-login.jsp';
            }
        }

        // Load FAQs from database
        async function loadFaqs() {
            try {
                const response = await fetch('HelpdeskServlet?action=getFaqs', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                if (response.ok) {
                    const data = await response.json();
                    faqData = data.faqs || [];
                    displayFaqs(faqData);
                    updateStatistics();
                } else {
                    showAlert('Failed to load FAQs', 'danger');
                }
            } catch (error) {
                console.error('Error loading FAQs:', error);
                showAlert('Error loading FAQs', 'danger');
            }
        }

        // Display FAQs in table
        function displayFaqs(faqs) {
            const tbody = document.getElementById('faqTableBody');
            tbody.innerHTML = '';

            if (faqs.length === 0) {
                tbody.innerHTML = `
                    <tr>
                        <td colspan="6" class="text-center py-4 text-muted">
                            <i class="fas fa-inbox fa-2x mb-3 d-block"></i>
                            No FAQs found
                        </td>
                    </tr>
                `;
                return;
            }

            faqs.forEach(faq => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${faq.faq_id}</td>
                    <td>
                        <div class="fw-semibold">${truncateText(faq.question, 60)}</div>
                        <small class="text-muted">${truncateText(faq.answer, 80)}</small>
                    </td>
                    <td>
                        <span class="category-badge badge bg-${getCategoryColor(faq.category)}">
                            ${getCategoryName(faq.category)}
                        </span>
                    </td>
                    <td>
                        <span class="badge bg-${faq.is_active ? 'success' : 'secondary'}">
                            ${faq.is_active ? 'Active' : 'Inactive'}
                        </span>
                    </td>
                    <td>
                        <small>${formatDate(faq.created_at)}</small>
                    </td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary btn-action me-1" onclick="editFaq(${faq.faq_id})" title="Edit">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-${faq.is_active ? 'warning' : 'success'} btn-action me-1" onclick="toggleFaqStatus(${faq.faq_id}, ${faq.is_active})" title="${faq.is_active ? 'Deactivate' : 'Activate'}">
                            <i class="fas fa-${faq.is_active ? 'eye-slash' : 'eye'}"></i>
                        </button>
                        <button class="btn btn-sm btn-outline-danger btn-action" onclick="deleteFaq(${faq.faq_id})" title="Delete">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                `;
                tbody.appendChild(row);
            });
        }

        // Update statistics
        function updateStatistics() {
            const totalFaqs = faqData.length;
            const activeFaqs = faqData.filter(faq => faq.is_active).length;
            const categories = [...new Set(faqData.map(faq => faq.category))].length;
            const recentUpdates = faqData.filter(faq => {
                const createdDate = new Date(faq.created_at);
                const weekAgo = new Date();
                weekAgo.setDate(weekAgo.getDate() - 7);
                return createdDate > weekAgo;
            }).length;

            document.getElementById('totalFaqs').textContent = totalFaqs;
            document.getElementById('activeFaqs').textContent = activeFaqs;
            document.getElementById('categoriesCount').textContent = categories;
            document.getElementById('recentUpdates').textContent = recentUpdates;
        }

        // Setup event listeners
        function setupEventListeners() {
            // Search functionality
            document.getElementById('searchFaq').addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                const filteredFaqs = faqData.filter(faq => 
                    faq.question.toLowerCase().includes(searchTerm) || 
                    faq.answer.toLowerCase().includes(searchTerm)
                );
                displayFaqs(filteredFaqs);
            });

            // Category filter
            document.getElementById('categoryFilter').addEventListener('change', function() {
                const category = this.value;
                const filteredFaqs = category ? faqData.filter(faq => faq.category === category) : faqData;
                displayFaqs(filteredFaqs);
            });
        }

        // Add new FAQ
        async function addFaq() {
            const question = document.getElementById('faqQuestion').value.trim();
            const answer = document.getElementById('faqAnswer').value.trim();
            const category = document.getElementById('faqCategory').value;
            const isActive = document.getElementById('faqActive').checked;

            if (!question || !answer || !category) {
                showAlert('Please fill in all required fields', 'warning');
                return;
            }

            const loadingSpinner = document.querySelector('#addFaqModal .loading-spinner');
            loadingSpinner.classList.add('show');

            try {
                const response = await fetch('HelpdeskServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        action: 'addFaq',
                        question: question,
                        answer: answer,
                        category: category,
                        is_active: isActive
                    })
                });

                if (response.ok) {
                    const data = await response.json();
                    if (data.success) {
                        showAlert('FAQ added successfully', 'success');
                        document.getElementById('addFaqForm').reset();
                        bootstrap.Modal.getInstance(document.getElementById('addFaqModal')).hide();
                        loadFaqs();
                    } else {
                        showAlert(data.message || 'Failed to add FAQ', 'danger');
                    }
                } else {
                    showAlert('Failed to add FAQ', 'danger');
                }
            } catch (error) {
                console.error('Error adding FAQ:', error);
                showAlert('Error adding FAQ', 'danger');
            } finally {
                loadingSpinner.classList.remove('show');
            }
        }

        // Edit FAQ
        function editFaq(faqId) {
            const faq = faqData.find(f => f.faq_id === faqId);
            if (!faq) return;

            document.getElementById('editFaqId').value = faq.faq_id;
            document.getElementById('editFaqQuestion').value = faq.question;
            document.getElementById('editFaqAnswer').value = faq.answer;
            document.getElementById('editFaqCategory').value = faq.category;
            document.getElementById('editFaqActive').checked = faq.is_active;

            new bootstrap.Modal(document.getElementById('editFaqModal')).show();
        }

        // Update FAQ
        async function updateFaq() {
            const faqId = document.getElementById('editFaqId').value;
            const question = document.getElementById('editFaqQuestion').value.trim();
            const answer = document.getElementById('editFaqAnswer').value.trim();
            const category = document.getElementById('editFaqCategory').value;
            const isActive = document.getElementById('editFaqActive').checked;

            if (!question || !answer || !category) {
                showAlert('Please fill in all required fields', 'warning');
                return;
            }

            const loadingSpinner = document.querySelector('#editFaqModal .loading-spinner');
            loadingSpinner.classList.add('show');

            try {
                const response = await fetch('HelpdeskServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        action: 'updateFaq',
                        faq_id: faqId,
                        question: question,
                        answer: answer,
                        category: category,
                        is_active: isActive
                    })
                });

                if (response.ok) {
                    const data = await response.json();
                    if (data.success) {
                        showAlert('FAQ updated successfully', 'success');
                        bootstrap.Modal.getInstance(document.getElementById('editFaqModal')).hide();
                        loadFaqs();
                    } else {
                        showAlert(data.message || 'Failed to update FAQ', 'danger');
                    }
                } else {
                    showAlert('Failed to update FAQ', 'danger');
                }
            } catch (error) {
                console.error('Error updating FAQ:', error);
                showAlert('Error updating FAQ', 'danger');
            } finally {
                loadingSpinner.classList.remove('show');
            }
        }

        // Toggle FAQ status
        async function toggleFaqStatus(faqId, currentStatus) {
            try {
                const response = await fetch('HelpdeskServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        action: 'toggleStatus',
                        faq_id: faqId,
                        is_active: !currentStatus
                    })
                });

                if (response.ok) {
                    const data = await response.json();
                    if (data.success) {
                        showAlert(`FAQ ${!currentStatus ? 'activated' : 'deactivated'} successfully`, 'success');
                        loadFaqs();
                    } else {
                        showAlert(data.message || 'Failed to update FAQ status', 'danger');
                    }
                } else {
                    showAlert('Failed to update FAQ status', 'danger');
                }
            } catch (error) {
                console.error('Error toggling FAQ status:', error);
                showAlert('Error updating FAQ status', 'danger');
            }
        }

        // Delete FAQ
        async function deleteFaq(faqId) {
            if (!confirm('Are you sure you want to delete this FAQ? This action cannot be undone.')) {
                return;
            }

            try {
                const response = await fetch('HelpdeskServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        action: 'deleteFaq',
                        faq_id: faqId
                    })
                });

                if (response.ok) {
                    const data = await response.json();
                    if (data.success) {
                        showAlert('FAQ deleted successfully', 'success');
                        loadFaqs();
                    } else {
                        showAlert(data.message || 'Failed to delete FAQ', 'danger');
                    }
                } else {
                    showAlert('Failed to delete FAQ', 'danger');
                }
            } catch (error) {
                console.error('Error deleting FAQ:', error);
                showAlert('Error deleting FAQ', 'danger');
            }
        }

        // Logout function
        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                fetch('api/staff-login', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ action: 'logout' })
                }).then(() => {
                    window.location.href = 'staff-login.jsp';
                });
            }
        }

        // Utility functions
        function truncateText(text, maxLength) {
            return text.length > maxLength ? text.substring(0, maxLength) + '...' : text;
        }

        function getCategoryColor(category) {
            const colors = {
                'application': 'primary',
                'documents': 'info',
                'payment': 'success',
                'processing': 'warning',
                'technical': 'secondary'
            };
            return colors[category] || 'secondary';
        }

        function getCategoryName(category) {
            const names = {
                'application': 'Application',
                'documents': 'Documents',
                'payment': 'Payment',
                'processing': 'Processing',
                'technical': 'Technical'
            };
            return names[category] || category;
        }

        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        }

        function showAlert(message, type) {
            const alertContainer = document.getElementById('alertContainer');
            const alertId = 'alert-' + Date.now();
            
            const alertHtml = `
                <div class="alert alert-${type} alert-dismissible fade show" id="${alertId}" role="alert">
                    <i class="fas fa-${type === 'success' ? 'check-circle' : type === 'danger' ? 'exclamation-circle' : 'info-circle'} me-2"></i>
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            `;
            
            alertContainer.insertAdjacentHTML('beforeend', alertHtml);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                const alertElement = document.getElementById(alertId);
                if (alertElement) {
                    alertElement.remove();
                }
            }, 5000);
        }
    </script>
</body>
</html>
