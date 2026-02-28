<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Application Review Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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

    /* Application Review specific styles */
    body {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px;
    }
    .container-box {
        background: white;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        max-width: 1400px;
        margin: 0 auto;
    }
    .app-card {
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 1.5rem;
        transition: transform 0.2s;
    }
    .app-card:hover { transform: translateY(-3px); }
    .section-card { border-left: 4px solid #667eea; margin-bottom: 1.5rem; }
    .section-card.approved { border-left-color: #28a745; background-color: #f0f9f4; }
    .doc-preview { max-width: 150px; max-height: 150px; border-radius: 8px; cursor: pointer; }
    .doc-item { padding: 1rem; border: 1px solid #e0e0e0; border-radius: 8px; margin-bottom: 1rem; }
    .status-pending { background: #e7e7e7; color: #666; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
    .status-approved { background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
    .status-rejected { background: #f8d7da; color: #721c24; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
    .status-verified { background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }

    /* Enhanced Modal Styling */
    .modal-content {
        border: none;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        border-radius: 20px;
    }

    .modal-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
        border-radius: 20px 20px 0 0 !important;
        padding: 1.5rem 2rem;
    }

    .modal-body {
        padding: 2rem;
        background: #f8f9fa;
    }

    /* Enhanced Section Cards */
    .section-card {
        border: none;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        margin-bottom: 1.5rem;
        transition: all 0.3s ease;
    }

    .section-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    }

    .section-card .card-header {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        border-bottom: 2px solid #667eea;
        padding: 1rem 1.5rem;
        font-weight: 600;
    }

    .section-card.approved .card-header {
        background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        border-bottom: 2px solid #28a745;
    }

    .section-card.approved {
        border: 2px solid #28a745;
    }

    /* Animated Status Badges */
    .badge {
        padding: 0.5rem 1rem;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 600;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
    }

    .badge:hover {
        transform: scale(1.1);
    }

    /* Info Display Styling */
    .info-row {
        display: flex;
        padding: 0.75rem 0;
        border-bottom: 1px solid #e9ecef;
    }

    .info-row:last-child {
        border-bottom: none;
    }

    .info-label {
        font-weight: 600;
        color: #495057;
        min-width: 150px;
    }

    .info-value {
        color: #212529;
    }

    /* Enhanced Buttons */
    .btn {
        border-radius: 10px;
        padding: 0.6rem 1.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    /* Final Approval Section */
    .final-approval-section {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        padding: 2rem;
        border-radius: 15px;
        border: 3px solid #667eea;
        margin-top: 2rem;
        box-shadow: 0 5px 20px rgba(102, 126, 234, 0.2);
    }

    /* Document Preview Enhancement */
    .doc-item {
        padding: 1.25rem;
        border: 2px solid #e0e0e0;
        border-radius: 12px;
        margin-bottom: 1rem;
        background: white;
        transition: all 0.3s ease;
    }

    .doc-item:hover {
        border-color: #667eea;
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.15);
    }

    .doc-preview {
        max-width: 150px;
        max-height: 150px;
        border-radius: 10px;
        cursor: pointer;
        border: 3px solid #e9ecef;
        transition: all 0.3s ease;
    }

    .doc-preview:hover {
        border-color: #667eea;
        transform: scale(1.05);
    }
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container-box {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 1400px;
            margin: 0 auto;
        }
        .app-card { 
            border-radius: 10px; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
            margin-bottom: 1.5rem; 
            transition: transform 0.2s; 
        }
        .app-card:hover { transform: translateY(-3px); }
        .section-card { border-left: 4px solid #667eea; margin-bottom: 1.5rem; }
        .section-card.approved { border-left-color: #28a745; background-color: #f0f9f4; }
        .doc-preview { max-width: 150px; max-height: 150px; border-radius: 8px; cursor: pointer; }
        .doc-item { padding: 1rem; border: 1px solid #e0e0e0; border-radius: 8px; margin-bottom: 1rem; }
        .status-pending { background: #e7e7e7; color: #666; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
        .status-approved { background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
        .status-rejected { background: #f8d7da; color: #721c24; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
        .status-verified { background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
        
        /* Enhanced Modal Styling */
        .modal-content {
            border: none;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            border-radius: 20px;
        }

        .modal-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
            border-radius: 20px 20px 0 0 !important;
            padding: 1.5rem 2rem;
        }

        .modal-body {
            padding: 2rem;
            background: #f8f9fa;
        }

        /* Enhanced Section Cards */
        .section-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .section-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .section-card .card-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-bottom: 2px solid #667eea;
            padding: 1rem 1.5rem;
            font-weight: 600;
        }

        .section-card.approved .card-header {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            border-bottom: 2px solid #28a745;
        }

        .section-card.approved {
            border: 2px solid #28a745;
        }

        /* Animated Status Badges */
        .badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .badge:hover {
            transform: scale(1.1);
        }

        /* Info Display Styling */
        .info-row {
            display: flex;
            padding: 0.75rem 0;
            border-bottom: 1px solid #e9ecef;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #495057;
            min-width: 150px;
        }

        .info-value {
            color: #212529;
        }

        /* Enhanced Buttons */
        .btn {
            border-radius: 10px;
            padding: 0.6rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        /* Final Approval Section */
        .final-approval-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 2rem;
            border-radius: 15px;
            border: 3px solid #667eea;
            margin-top: 2rem;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.2);
        }

        /* Document Preview Enhancement */
        .doc-item {
            padding: 1.25rem;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            margin-bottom: 1rem;
            background: white;
            transition: all 0.3s ease;
        }

        .doc-item:hover {
            border-color: #667eea;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.15);
        }

        .doc-preview {
            max-width: 150px;
            max-height: 150px;
            border-radius: 10px;
            cursor: pointer;
            border: 3px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .doc-preview:hover {
            border-color: #667eea;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container-box">
        <div class="row align-items-center mb-3">
            <div class="col-md-8">
                <h1><i class="fas fa-clipboard-check me-3"></i>Application Review System</h1>
                <p class="text-muted mb-0">Staff Application Management Portal</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="staff-login.jsp" class="btn btn-primary">
                    <i class="fas fa-user-tie me-2"></i>Staff Portal
                </a>
                <a href="index.jsp" class="btn btn-outline-secondary ms-2">
                    <i class="fas fa-home me-2"></i>Home
                </a>
            </div>
        </div>
        <hr>
        
        <div id="alerts"></div>
        
        <!-- Filter Buttons -->
        <div class="btn-group mb-4" role="group">
            <button class="btn btn-primary" onclick="filterApps('all')">
                <i class="fas fa-list"></i> All
            </button>
            <button class="btn btn-outline-warning" onclick="filterApps('pending')">
                <i class="fas fa-clock"></i> Pending Review
            </button>
            <button class="btn btn-outline-success" onclick="filterApps('approved')">
                <i class="fas fa-check-circle"></i> Approved
            </button>
            <button class="btn btn-outline-danger" onclick="filterApps('rejected')">
                <i class="fas fa-times-circle"></i> Rejected
            </button>
        </div>
        
        <div id="loading" class="text-center d-none">
            <div class="spinner-border"></div>
            <p>Loading...</p>
        </div>
        
        <div id="apps"></div>
        <div id="noApps" class="text-center d-none">
            <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
            <h4>No Applications</h4>
        </div>
        
        <hr>
        <p class="text-muted text-center">
            <small>Application Review System v1.0 | E-Passport Department</small>
        </p>
    </div>

<div class="modal" id="reviewModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="mb-0"><i class="fas fa-file-alt me-2"></i>Review Application <span id="appNum"></span></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                
                <!-- Personal Information Section -->
                <div class="card section-card" id="sec1">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h6 class="mb-0"><i class="fas fa-user me-2 text-primary"></i>Personal Information</h6>
                        <span class="badge bg-warning" id="stat1">Pending</span>
                    </div>
                    <div class="card-body">
                        <div class="info-row">
                            <span class="info-label">First Name:</span>
                            <span class="info-value" id="fn"></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Last Name:</span>
                            <span class="info-value" id="ln"></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">NIC Number:</span>
                            <span class="info-value" id="nic"></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Date of Birth:</span>
                            <span class="info-value" id="dob"></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Email Address:</span>
                            <span class="info-value" id="em"></span>
                        </div>
                        <div id="btn1" class="d-flex gap-3 mt-4 justify-content-center">
                            <button class="btn btn-success px-4" onclick="approveSec('personal_info')">
                                <i class="fas fa-check-circle me-2"></i>Approve
                            </button>
                            <button class="btn btn-danger px-4" onclick="rejectSec('personal_info')">
                                <i class="fas fa-times-circle me-2"></i>Reject
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Address Information Section -->
                <div class="card section-card" id="sec2">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h6 class="mb-0"><i class="fas fa-map-marker-alt me-2 text-info"></i>Address Information</h6>
                        <span class="badge bg-warning" id="stat2">Pending</span>
                    </div>
                    <div class="card-body">
                        <div class="info-row">
                            <span class="info-label">Address:</span>
                            <span class="info-value" id="addr"></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">City:</span>
                            <span class="info-value" id="city"></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Postal Code:</span>
                            <span class="info-value" id="postal"></span>
                        </div>
                        <div id="btn2" class="d-flex gap-3 mt-4 justify-content-center">
                            <button class="btn btn-success px-4" onclick="approveSec('address_info')">
                                <i class="fas fa-check-circle me-2"></i>Approve
                            </button>
                            <button class="btn btn-danger px-4" onclick="rejectSec('address_info')">
                                <i class="fas fa-times-circle me-2"></i>Reject
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Documents Section -->
                <div class="card section-card" id="sec3">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h6 class="mb-0"><i class="fas fa-file-alt me-2 text-warning"></i>Documents</h6>
                        <span class="badge bg-warning" id="stat3">Pending</span>
                    </div>
                    <div class="card-body">
                        <div id="docs"></div>
                        <div id="btn3" class="d-flex gap-3 mt-4 justify-content-center">
                            <button class="btn btn-success px-4" onclick="approveSec('documents')">
                                <i class="fas fa-check-circle me-2"></i>Approve Documents
                            </button>
                            <button class="btn btn-danger px-4" onclick="rejectSec('documents')">
                                <i class="fas fa-times-circle me-2"></i>Reject Documents
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Biometric Appointment Section -->
                <div class="card section-card" id="sec4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h6 class="mb-0"><i class="fas fa-fingerprint me-2 text-success"></i>Biometric Appointment</h6>
                        <span class="badge bg-warning" id="stat4">Pending</span>
                    </div>
                    <div class="card-body">
                        <div class="info-row">
                            <span class="info-label">Appointment Date:</span>
                            <span class="info-value" id="biodate"></span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Processing Type:</span>
                            <span class="info-value" id="ptype"></span>
                        </div>
                        <div class="alert alert-info mb-3">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>Note:</strong> Mark completed after biometric appointment
                        </div>
                        <div id="btn4" class="d-flex gap-3 mt-4 justify-content-center">
                            <button class="btn btn-success px-4" onclick="approveSec('biometric')" disabled id="bioComp">
                                <i class="fas fa-check-circle me-2"></i>Completed
                            </button>
                            <button class="btn btn-secondary px-4" onclick="rejectSec('biometric')" disabled id="bioNot">
                                <i class="fas fa-times-circle me-2"></i>Not Completed
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Final Approval Section -->
                <div class="final-approval-section">
                    <h5 class="text-center mb-4">
                        <i class="fas fa-stamp me-2"></i>Final Approval
                    </h5>
                    <div class="alert alert-warning mb-4">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Note:</strong> All sections must be approved before final approval
                    </div>
                    <div class="d-flex gap-3 justify-content-center">
                        <button class="btn btn-success btn-lg px-5" onclick="finalApp()" disabled id="finalBtn">
                            <i class="fas fa-check-double me-2"></i>Grant Final Approval
                        </button>
                        <button class="btn btn-danger btn-lg px-5" onclick="finalRej()">
                            <i class="fas fa-ban me-2"></i>Reject Application
                        </button>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
let currId=null;
let currentFilter='all';
const bp='<%=request.getContextPath()%>';

function filterApps(filter) {
    currentFilter = filter;
    // Update active button state
    document.querySelectorAll('.btn-group button').forEach(btn => {
        btn.classList.remove('btn-primary', 'btn-warning', 'btn-success', 'btn-danger');
        btn.classList.add('btn-outline-primary', 'btn-outline-warning', 'btn-outline-success', 'btn-outline-danger');
    });
    
    // Set active button
    const activeBtn = document.querySelector(`button[onclick="filterApps('${filter}')"]`);
    if (activeBtn) {
        activeBtn.classList.remove('btn-outline-primary', 'btn-outline-warning', 'btn-outline-success', 'btn-outline-danger');
        if (filter === 'all') activeBtn.classList.add('btn-primary');
        else if (filter === 'pending') activeBtn.classList.add('btn-warning');
        else if (filter === 'approved') activeBtn.classList.add('btn-success');
        else if (filter === 'rejected') activeBtn.classList.add('btn-danger');
    }
    
    loadData();
}

async function loadData(){
const l=document.getElementById('loading'),a=document.getElementById('apps'),n=document.getElementById('noApps');
l.classList.remove('d-none');a.innerHTML='';n.classList.add('d-none');
try{
const r=await fetch(bp+'/api/application-review');
if(r.ok){
const d=await r.json();
l.classList.add('d-none');

// Filter applications based on currentFilter
let filteredApps = d;
if (currentFilter !== 'all') {
    filteredApps = d.filter(app => {
        const status = app.status ? app.status.toLowerCase() : 'pending';
        if (currentFilter === 'pending') return status === 'pending' || status === 'under_review';
        if (currentFilter === 'approved') return status === 'approved' || status === 'verified';
        if (currentFilter === 'rejected') return status === 'rejected';
        return true;
    });
}

if(filteredApps.length===0){
    n.classList.remove('d-none');
}else{
    // Add count indicator
    const countAlert = document.createElement('div');
    countAlert.className = 'alert alert-success mb-3';
    countAlert.innerHTML = `<strong><i class="fas fa-check-circle"></i> Found ${filteredApps.length} application records</strong>`;
    a.appendChild(countAlert);
    
    filteredApps.forEach(x=>{
        const c=document.createElement('div');
        c.className='card app-card';
        
        // Determine status class
        let statusClass = 'status-pending';
        let statusText = x.status || 'Pending';
        if (x.status) {
            const status = x.status.toLowerCase();
            if (status === 'approved' || status === 'verified') {
                statusClass = 'status-approved';
                statusText = 'Approved';
            } else if (status === 'rejected') {
                statusClass = 'status-rejected';
                statusText = 'Rejected';
            }
        }
        
        c.innerHTML='<div class="card-body"><div class="row"><div class="col-md-8"><h5>Application #'+x.applicationId+' <span class="'+statusClass+'">'+statusText.toUpperCase()+'</span></h5><p><strong>Name:</strong> '+x.firstName+' '+x.lastName+'</p><p><strong>NIC:</strong> '+x.nicNumber+'</p><p><strong>Email:</strong> '+x.email+'</p></div><div class="col-md-4 text-end"><button class="btn btn-primary" onclick="viewApp('+x.applicationId+')">View & Review</button></div></div></div>';
        a.appendChild(c);
    });
}
}else{showMsg('Failed to load','danger');}
}catch(e){showMsg('Error: '+e.message,'danger');l.classList.add('d-none');}
}

async function viewApp(id){
currId=id;
try{
const r=await fetch(bp+'/api/application-review?id='+id);
if(r.ok){
const d=await r.json();
if(d&&d.length>0){
fillModal(d[0]);
new bootstrap.Modal(document.getElementById('reviewModal')).show();
}
}else{showMsg('Failed','danger');}
}catch(e){showMsg('Error: '+e.message,'danger');}
}

function fillModal(a){
document.getElementById('appNum').textContent='#'+a.applicationId;
document.getElementById('fn').textContent=a.firstName;
document.getElementById('ln').textContent=a.lastName;
document.getElementById('nic').textContent=a.nicNumber;
document.getElementById('dob').textContent=fmtDate(a.dateOfBirth);
document.getElementById('em').textContent=a.email;
document.getElementById('addr').textContent=a.currentAddress;
document.getElementById('city').textContent=a.city;
document.getElementById('postal').textContent=a.postalCode||'N/A';
document.getElementById('biodate').textContent=fmtDate(a.biometricDate);
document.getElementById('ptype').textContent=a.processingType;
updStat(1,a.personalInfoApproved);
updStat(2,a.addressInfoApproved);
updStat(3,a.documentsApproved);
updStat(4,a.biometricCompleted);
showDocs(a.documents||[]);
const all3=a.personalInfoApproved&&a.addressInfoApproved&&a.documentsApproved;
document.getElementById('bioComp').disabled=!all3;
document.getElementById('bioNot').disabled=!all3;
document.getElementById('finalBtn').disabled=!(all3&&a.biometricCompleted);
}

function updStat(n,ok){
const s=document.getElementById('stat'+n),c=document.getElementById('sec'+n),b=document.getElementById('btn'+n);
if(ok){s.className='badge bg-success';s.textContent='Approved';c.classList.add('approved');if(b)b.style.display='none';}
else{s.className='badge bg-warning';s.textContent='Pending';c.classList.remove('approved');if(b)b.style.display='flex';}
}

function showDocs(docs){
const c=document.getElementById('docs');
c.innerHTML='';
const t={'passport_photo':'Passport Photo','birth_certificate':'Birth Certificate','address_proof':'Address Proof','signature':'Signature'};
Object.keys(t).forEach(k=>{
const d=docs.find(x=>x.documentType===k);
const di=document.createElement('div');
di.className='doc-item';
if(d){
const isImg=d.mimeType&&d.mimeType.startsWith('image/');
const fp=bp+'/'+d.filePath;
if(isImg){
di.innerHTML='<div class="row align-items-center"><div class="col-md-3"><strong>'+t[k]+'</strong></div><div class="col-md-6 text-center"><img src="'+fp+'" class="doc-preview img-thumbnail" onerror="this.onerror=null;this.src=\'data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22150%22 height=%22150%22%3E%3Crect fill=%22%23eee%22 width=%22150%22 height=%22150%22/%3E%3Ctext x=%2250%25%22 y=%2250%25%22 text-anchor=%22middle%22 dy=%22.3em%22 fill=%22%23999%22%3EImage Missing%3C/text%3E%3C/svg%3E\';this.style.cursor=\'not-allowed\'" onclick="window.open(\''+fp+'\',\'_blank\')"></div><div class="col-md-3"><a href="'+fp+'" class="btn btn-sm btn-primary" target="_blank" download>Download</a><br><button class="btn btn-sm btn-secondary mt-2" onclick="window.open(\''+fp+'\',\'_blank\')">View</button></div></div>';
}else{
di.innerHTML='<div class="row align-items-center"><div class="col-md-3"><strong>'+t[k]+'</strong></div><div class="col-md-6 text-center"><i class="fas fa-file-pdf fa-3x text-danger"></i><br><small>'+d.fileName+'</small></div><div class="col-md-3"><a href="'+fp+'" class="btn btn-sm btn-primary" target="_blank" download>Download</a><br><button class="btn btn-sm btn-secondary mt-2" onclick="window.open(\''+fp+'\',\'_blank\')">View</button></div></div>';
}
}else{
di.innerHTML='<div class="text-muted text-center"><i class="fas fa-file fa-2x"></i><br><strong>'+t[k]+'</strong><br><small>Not uploaded</small></div>';
}
c.appendChild(di);
});
}

async function approveSec(sec){
if(!currId)return;
try{
const f=new URLSearchParams();
f.append('applicationId',currId);
f.append('action','approve');
f.append('section',sec);
const r=await fetch(bp+'/api/application-review',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:f});
if(r.ok){showMsg('Section approved!','success');await viewApp(currId);}
else{showMsg('Failed','danger');}
}catch(e){showMsg('Error: '+e.message,'danger');}
}

async function rejectSec(sec){
if(!currId||!confirm('Reject?'))return;
try{
const f=new URLSearchParams();
f.append('applicationId',currId);
f.append('action','reject');
f.append('section',sec);
const r=await fetch(bp+'/api/application-review',{method:'POST',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:f});
if(r.ok){showMsg('Rejected','warning');await viewApp(currId);}
}catch(e){showMsg('Error','danger');}
}

async function finalApp(){
if(!currId||!confirm('Grant final approval?'))return;
try{
const f=new URLSearchParams();
f.append('applicationId',currId);
f.append('action','approve');
const r=await fetch(bp+'/api/application-review',{method:'PUT',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:f});
if(r.ok){
showMsg('APPLICATION APPROVED! Status saved to database.','success');
bootstrap.Modal.getInstance(document.getElementById('reviewModal')).hide();
setTimeout(()=>{
    // Switch to approved filter to show the approved application
    filterApps('approved');
    showMsg('Application approved and moved to Approved section','success');
},2000);
}else{const e=await r.json().catch(()=>({}));showMsg('Failed: '+(e.error||'Unknown'),'danger');}
}catch(e){showMsg('Error: '+e.message,'danger');}
}

async function finalRej(){
if(!currId||!confirm('Reject application?'))return;
try{
const f=new URLSearchParams();
f.append('applicationId',currId);
f.append('action','reject');
const r=await fetch(bp+'/api/application-review',{method:'PUT',headers:{'Content-Type':'application/x-www-form-urlencoded'},body:f});
if(r.ok){
showMsg('Application REJECTED','warning');
bootstrap.Modal.getInstance(document.getElementById('reviewModal')).hide();
setTimeout(()=>{
    // Switch to rejected filter to show the rejected application
    filterApps('rejected');
    showMsg('Application rejected and moved to Rejected section','warning');
},2000);
}else{showMsg('Failed','danger');}
}catch(e){showMsg('Error','danger');}
}

function fmtDate(d){
if(!d)return'N/A';
return new Date(d).toLocaleDateString('en-US',{year:'numeric',month:'long',day:'numeric'});
}

function showMsg(msg,type){
const a=document.createElement('div');
a.className='alert alert-'+type+' alert-dismissible fade show';
a.innerHTML=msg+'<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
document.getElementById('alerts').appendChild(a);
setTimeout(()=>a.remove(),5000);
}

document.addEventListener('DOMContentLoaded', function() {
    loadData();
    const params = new URLSearchParams(window.location.search);
    const id = params.get('id');
    if (id) {
        setTimeout(() => {
            const num = parseInt(id, 10);
            if (!isNaN(num)) {
                viewApp(num);
            }
        }, 300);
    }
});
</script>
</body>
</html>
