<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help Desk - Lanka Epassport Service</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #0d6efd;
            --secondary-color: #6c757d;
            --accent-color: #ffc107;
            --success-color: #198754;
            --info-color: #0dcaf0;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --dark-color: #212529;
            --light-color: #f8f9fa;
        }

        /* Navigation Styles */
        .navbar {
            -webkit-backdrop-filter: blur(15px);
            backdrop-filter: blur(15px);
            background: linear-gradient(135deg, rgba(13, 110, 253, 0.95) 0%, rgba(10, 88, 202, 0.95) 100%) !important;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 1rem 0;
        }

        .navbar-brand {
            font-size: 1.5rem;
            transition: all 0.3s ease;
        }

        .brand-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .brand-icon:hover {
            transform: rotate(5deg) scale(1.05);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .nav-link-modern {
            position: relative;
            padding: 0.75rem 1.25rem !important;
            margin: 0 0.25rem;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
            letter-spacing: 0.3px;
        }

        .nav-link-modern::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, #ffffff, #ffc107);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link-modern:hover::before,
        .nav-link-modern.active::before {
            width: 80%;
        }

        .nav-link-modern:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        .nav-link-modern.active {
            background: rgba(255, 255, 255, 0.15);
            color: #ffffff !important;
        }

        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            overflow: hidden;
            padding: 120px 0 80px;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }

        /* FAQ Styles */
        .faq-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .faq-item {
            border-bottom: 1px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .faq-item:last-child {
            border-bottom: none;
        }

        .faq-question {
            background: none;
            border: none;
            width: 100%;
            padding: 1.5rem;
            text-align: left;
            font-weight: 600;
            font-size: 1.1rem;
            color: var(--dark-color);
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .faq-question:hover {
            background: #f8f9fa;
            color: var(--primary-color);
        }

        .faq-question.active {
            background: var(--primary-color);
            color: white;
        }

        .faq-icon {
            transition: transform 0.3s ease;
            font-size: 1.2rem;
        }

        .faq-question.active .faq-icon {
            transform: rotate(180deg);
        }

        .faq-answer {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
            background: #f8f9fa;
        }

        .faq-answer.active {
            max-height: 500px;
        }

        .faq-answer-content {
            padding: 1.5rem;
            color: #6c757d;
            line-height: 1.6;
        }

        /* Search Box */
        .search-container {
            position: relative;
            margin-bottom: 2rem;
        }

        .search-box {
            width: 100%;
            padding: 1rem 1.5rem;
            border: 2px solid #e9ecef;
            border-radius: 50px;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .search-box:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
        }

        .search-icon {
            position: absolute;
            right: 1.5rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-size: 1.2rem;
        }

        /* Category Tabs */
        .category-tabs {
            background: white;
            border-radius: 15px;
            padding: 1rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .category-tab {
            background: none;
            border: none;
            padding: 0.75rem 1.5rem;
            margin: 0.25rem;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .category-tab:hover {
            background: #f8f9fa;
            color: var(--primary-color);
        }

        .category-tab.active {
            background: var(--primary-color);
            color: white;
        }

        /* Contact Card */
        .contact-card {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .contact-card h4 {
            margin-bottom: 1rem;
        }

        .contact-info {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 1.5rem;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Live Chat Button */
        .live-chat-btn {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 60px;
            height: 60px;
            background: var(--success-color);
            color: white;
            border: none;
            border-radius: 50%;
            font-size: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .live-chat-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-section {
                padding: 100px 0 60px;
            }
            
            .contact-info {
                flex-direction: column;
                gap: 1rem;
            }
            
            .category-tabs {
                padding: 0.5rem;
            }
            
            .category-tab {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }
        }

        /* Animation for FAQ items */
        .faq-item.hidden {
            display: none;
        }

        .faq-item.fade-in {
            animation: fadeIn 0.3s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Question Form Styles */
        .question-item {
            transition: all 0.3s ease;
            border-left: 4px solid var(--primary-color) !important;
        }

        .question-item:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }

        .answer-section {
            border-left: 3px solid var(--success-color);
        }

        .btn-group .btn.active {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        /* Form Enhancement */
        .form-control:focus,
        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
        }

        .form-control.is-valid {
            border-color: #198754;
            box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25);
        }

        .form-control.is-invalid {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand fw-bold d-flex align-items-center" href="index.jsp">
                <div class="brand-icon me-3">
                    <i class="fas fa-passport"></i>
                </div>
                <div class="brand-text">
                    <span class="brand-title">Lanka Epassport Service</span>
                    <small class="brand-subtitle d-none d-sm-block">Professional & Reliable</small>
                </div>
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

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
                        <a class="nav-link nav-link-modern active" href="helpdesk.jsp">
                            <i class="fas fa-question-circle me-1 d-none d-sm-inline"></i>
                            <span>Help Desk</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-link-modern" href="index.jsp#contact">
                            <i class="fas fa-envelope me-1 d-none d-sm-inline"></i>
                            <span>Contact</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container position-relative">
            <div class="row align-items-center">
                <div class="col-lg-8" data-aos="fade-right" data-aos-duration="1000">
                    <h1 class="display-4 fw-bold text-white mb-4">
                        <i class="fas fa-question-circle me-3"></i>
                        Help Desk & FAQ
                    </h1>
                    <p class="lead text-white mb-4 fs-5">
                        Find answers to common questions about passport services, application process, 
                        and get support from our expert team.
                    </p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="#faq-section" class="btn btn-light btn-lg">
                            <i class="fas fa-search me-2"></i>Browse FAQ
                        </a>
                        <a href="#ask-question" class="btn btn-outline-light btn-lg">
                            <i class="fas fa-question-circle me-2"></i>Ask Question
                        </a>
                        <a href="#contact-support" class="btn btn-outline-light btn-lg">
                            <i class="fas fa-headset me-2"></i>Contact Support
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 text-center" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="200">
                    <i class="fas fa-headset fa-5x text-white opacity-75"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section id="faq-section" class="py-5">
        <div class="container">
            <!-- Search Box -->
            <div class="search-container" data-aos="fade-up">
                <div class="position-relative">
                    <input type="text" class="search-box" id="faqSearch" placeholder="Search for questions or topics...">
                    <i class="fas fa-search search-icon"></i>
                </div>
            </div>

            <!-- Category Tabs -->
            <div class="category-tabs" data-aos="fade-up" data-aos-delay="100">
                <div class="text-center mb-3">
                    <h6 class="text-muted mb-0">Browse by Category</h6>
                </div>
                <div class="d-flex flex-wrap justify-content-center">
                    <button class="category-tab active" data-category="all">All Questions</button>
                    <button class="category-tab" data-category="application">Application Process</button>
                    <button class="category-tab" data-category="documents">Documents</button>
                    <button class="category-tab" data-category="payment">Payment & Fees</button>
                    <button class="category-tab" data-category="processing">Processing Times</button>
                    <button class="category-tab" data-category="technical">Technical Support</button>
                </div>
            </div>

            <!-- FAQ Items -->
            <div class="faq-container" data-aos="fade-up" data-aos-delay="200">
                
                <!-- Application Process FAQs -->
                <div class="faq-item" data-category="application">
                    <button class="faq-question">
                        <span>How do I apply for a new passport?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>To apply for a new passport, follow these steps:</p>
                            <ol>
                                <li>Visit our website and click on "New Application"</li>
                                <li>Create an account using your NIC number and email</li>
                                <li>Fill out the online application form with your personal details</li>
                                <li>Upload required documents (passport photo, birth certificate, address proof, signature)</li>
                                <li>Select your preferred processing type (Regular or Express)</li>
                                <li>Book a biometric appointment</li>
                                <li>Submit your application and make payment</li>
                            </ol>
                            <p><strong>Note:</strong> You must be at least 18 years old to apply for a passport.</p>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="application">
                    <button class="faq-question">
                        <span>What is the difference between Regular and Express processing?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p><strong>Regular Processing:</strong></p>
                            <ul>
                                <li>Processing time: 7-10 business days</li>
                                <li>Cost: Rs. 15,000</li>
                                <li>Biometric appointment: Can be booked on 4th or 5th day from application</li>
                            </ul>
                            <p><strong>Express Processing:</strong></p>
                            <ul>
                                <li>Processing time: 3-5 business days</li>
                                <li>Cost: Rs. 20,000</li>
                                <li>Biometric appointment: Limited to next 2 days only</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="application">
                    <button class="faq-question">
                        <span>Can I edit my application after submission?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>Yes, you can edit your application before it's processed. Here's how:</p>
                            <ol>
                                <li>Log in to your account</li>
                                <li>Go to "My Applications"</li>
                                <li>Click on "Edit" next to your application</li>
                                <li>Make the necessary changes</li>
                                <li>Resubmit the application</li>
                            </ol>
                            <p><strong>Important:</strong> Once your application is under processing, changes cannot be made. Please review all details carefully before submission.</p>
                        </div>
                    </div>
                </div>

                <!-- Documents FAQs -->
                <div class="faq-item" data-category="documents">
                    <button class="faq-question">
                        <span>What documents do I need to upload?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>You need to upload the following documents:</p>
                            <ul>
                                <li><strong>Passport Size Photo:</strong> Recent color photograph (2MB max, JPG/PNG)</li>
                                <li><strong>Birth Certificate:</strong> Official birth certificate (5MB max, PDF)</li>
                                <li><strong>Address Proof:</strong> Utility bill, bank statement, or government document (5MB max, PDF)</li>
                                <li><strong>Signature:</strong> Your signature on white background (2MB max, JPG/PNG)</li>
                            </ul>
                            <p><strong>Photo Requirements:</strong></p>
                            <ul>
                                <li>Size: 35mm x 45mm</li>
                                <li>White background</li>
                                <li>Front-facing, no glasses or head covering</li>
                                <li>Neutral expression</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="documents">
                    <button class="faq-question">
                        <span>What if I don't have a birth certificate?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>If you don't have a birth certificate, you can provide alternative documents:</p>
                            <ul>
                                <li>School leaving certificate</li>
                                <li>Baptismal certificate</li>
                                <li>Affidavit from parents or guardians</li>
                                <li>Any official document showing your date of birth</li>
                            </ul>
                            <p><strong>Note:</strong> All alternative documents must be officially certified and clearly show your date of birth.</p>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="documents">
                    <button class="faq-question">
                        <span>What file formats are accepted for document uploads?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>We accept the following file formats:</p>
                            <ul>
                                <li><strong>Images:</strong> JPG, JPEG, PNG (for photos and signatures)</li>
                                <li><strong>Documents:</strong> PDF (for certificates and address proof)</li>
                            </ul>
                            <p><strong>File Size Limits:</strong></p>
                            <ul>
                                <li>Images: Maximum 2MB</li>
                                <li>PDF documents: Maximum 5MB</li>
                            </ul>
                            <p>Make sure your documents are clear, readable, and not password-protected.</p>
                        </div>
                    </div>
                </div>

                <!-- Payment FAQs -->
                <div class="faq-item" data-category="payment">
                    <button class="faq-question">
                        <span>What are the passport fees?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>Our passport service fees are as follows:</p>
                            <ul>
                                <li><strong>New Passport (Regular):</strong> Rs. 15,000</li>
                                <li><strong>New Passport (Express):</strong> Rs. 20,000</li>
                                <li><strong>Passport Renewal (Regular):</strong> Rs. 12,000</li>
                                <li><strong>Passport Renewal (Express):</strong> Rs. 17,000</li>
                                <li><strong>Lost Passport Replacement:</strong> Rs. 20,000</li>
                            </ul>
                            <p><strong>Additional Services:</strong></p>
                            <ul>
                                <li>Document verification: Rs. 500</li>
                                <li>Express delivery: Rs. 1,000</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="payment">
                    <button class="faq-question">
                        <span>What payment methods do you accept?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>We accept the following payment methods:</p>
                            <ul>
                                <li>Credit Cards (Visa, MasterCard, American Express)</li>
                                <li>Debit Cards</li>
                                <li>Bank Transfers</li>
                                <li>Mobile Payments (mCash, FriMi)</li>
                                <li>Cash payments at our office</li>
                            </ul>
                            <p><strong>Note:</strong> All online payments are processed securely through our payment gateway. You will receive a payment confirmation email after successful payment.</p>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="payment">
                    <button class="faq-question">
                        <span>Can I get a refund if I cancel my application?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>Refund policy depends on the stage of your application:</p>
                            <ul>
                                <li><strong>Before Processing:</strong> Full refund minus Rs. 500 processing fee</li>
                                <li><strong>During Processing:</strong> 50% refund</li>
                                <li><strong>After Processing:</strong> No refund</li>
                            </ul>
                            <p>To request a refund, contact our support team with your application ID. Refunds are processed within 5-7 business days.</p>
                        </div>
                    </div>
                </div>

                <!-- Processing Times FAQs -->
                <div class="faq-item" data-category="processing">
                    <button class="faq-question">
                        <span>How long does it take to process a passport?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>Processing times vary based on the service type:</p>
                            <ul>
                                <li><strong>Regular Processing:</strong> 7-10 business days</li>
                                <li><strong>Express Processing:</strong> 3-5 business days</li>
                                <li><strong>Lost Passport Replacement:</strong> 1-2 business days</li>
                            </ul>
                            <p><strong>Note:</strong> Processing times start after your biometric appointment. Delays may occur during peak periods or if additional verification is required.</p>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="processing">
                    <button class="faq-question">
                        <span>How can I track my application status?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>You can track your application in several ways:</p>
                            <ol>
                                <li><strong>Online:</strong> Log in to your account and check "My Applications"</li>
                                <li><strong>Email:</strong> You'll receive status updates via email</li>
                                <li><strong>SMS:</strong> Text notifications for important updates</li>
                                <li><strong>Phone:</strong> Call our support line with your application ID</li>
                            </ol>
                            <p><strong>Application Statuses:</strong></p>
                            <ul>
                                <li>Submitted → Under Review → Processing → Ready for Collection</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="processing">
                    <button class="faq-question">
                        <span>What happens during the biometric appointment?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>During your biometric appointment, we will:</p>
                            <ul>
                                <li>Capture your fingerprints (all 10 fingers)</li>
                                <li>Take a digital photograph</li>
                                <li>Verify your identity documents</li>
                                <li>Confirm your personal details</li>
                                <li>Process your application for passport issuance</li>
                            </ul>
                            <p><strong>What to bring:</strong></p>
                            <ul>
                                <li>Original NIC or valid ID</li>
                                <li>Application confirmation email</li>
                                <li>All original documents uploaded</li>
                            </ul>
                            <p><strong>Duration:</strong> Approximately 30-45 minutes</p>
                        </div>
                    </div>
                </div>

                <!-- Technical Support FAQs -->
                <div class="faq-item" data-category="technical">
                    <button class="faq-question">
                        <span>I'm having trouble uploading documents. What should I do?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>If you're experiencing upload issues, try these solutions:</p>
                            <ol>
                                <li><strong>Check file size:</strong> Ensure files are under the size limit (2MB for images, 5MB for PDFs)</li>
                                <li><strong>Check file format:</strong> Use only JPG, PNG, or PDF formats</li>
                                <li><strong>Clear browser cache:</strong> Refresh the page or clear your browser cache</li>
                                <li><strong>Try different browser:</strong> Switch to Chrome, Firefox, or Safari</li>
                                <li><strong>Check internet connection:</strong> Ensure stable internet connection</li>
                            </ol>
                            <p>If problems persist, contact our technical support team.</p>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="technical">
                    <button class="faq-question">
                        <span>I forgot my password. How can I reset it?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>To reset your password:</p>
                            <ol>
                                <li>Go to the login page</li>
                                <li>Click "Forgot Password?"</li>
                                <li>Enter your NIC number and email address</li>
                                <li>Check your email for reset instructions</li>
                                <li>Follow the link to create a new password</li>
                            </ol>
                            <p><strong>Note:</strong> Your password must be exactly 6 digits. If you don't receive the email, check your spam folder or contact support.</p>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="technical">
                    <button class="faq-question">
                        <span>Is my personal information secure?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>Yes, we take your privacy and security very seriously:</p>
                            <ul>
                                <li><strong>SSL Encryption:</strong> All data is encrypted during transmission</li>
                                <li><strong>Secure Servers:</strong> Your information is stored on secure, encrypted servers</li>
                                <li><strong>Access Control:</strong> Only authorized personnel can access your data</li>
                                <li><strong>Regular Audits:</strong> We conduct regular security audits</li>
                                <li><strong>Data Protection:</strong> We comply with all data protection regulations</li>
                            </ul>
                            <p>We never share your personal information with third parties without your consent, except as required by law.</p>
                        </div>
                    </div>
                </div>

                <!-- General FAQs -->
                <div class="faq-item" data-category="application">
                    <button class="faq-question">
                        <span>What should I do if I lose my passport?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>If you lose your passport, follow these steps immediately:</p>
                            <ol>
                                <li><strong>Report to Police:</strong> File a police report about the lost passport</li>
                                <li><strong>Contact Embassy:</strong> If abroad, contact the nearest Sri Lankan embassy</li>
                                <li><strong>Apply for Replacement:</strong> Submit a new application with police report</li>
                                <li><strong>Emergency Travel:</strong> Apply for emergency travel document if needed</li>
                            </ol>
                            <p><strong>Required Documents for Lost Passport:</strong></p>
                            <ul>
                                <li>Police report</li>
                                <li>Copy of lost passport (if available)</li>
                                <li>All standard passport application documents</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="faq-item" data-category="application">
                    <button class="faq-question">
                        <span>Can I apply for a passport if I'm under 18?</span>
                        <i class="fas fa-chevron-down faq-icon"></i>
                    </button>
                    <div class="faq-answer">
                        <div class="faq-answer-content">
                            <p>Yes, minors can apply for passports with additional requirements:</p>
                            <ul>
                                <li><strong>Parental Consent:</strong> Both parents must provide written consent</li>
                                <li><strong>Guardian Application:</strong> Application must be submitted by parent/guardian</li>
                                <li><strong>Additional Documents:</strong> Parent's ID and consent forms required</li>
                                <li><strong>Biometric Appointment:</strong> Minor must attend with parent/guardian</li>
                            </ul>
                            <p><strong>Note:</strong> For minors under 16, passport validity is limited to 5 years instead of 10 years.</p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- Ask Question Section -->
    <section id="ask-question" class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="text-center mb-5" data-aos="fade-up">
                        <h2 class="display-5 fw-bold text-primary">Ask a Question</h2>
                        <p class="lead text-muted">Can't find what you're looking for? Submit your question and our support team will get back to you.</p>
                    </div>

                    <div class="card border-0 shadow" data-aos="fade-up" data-aos-delay="100">
                        <div class="card-body p-4">
                            <form id="questionForm" class="needs-validation" novalidate>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="questionName" class="form-label">Full Name *</label>
                                        <input type="text" class="form-control" id="questionName" name="name" required>
                                        <div class="invalid-feedback">Please enter your full name.</div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="questionEmail" class="form-label">Email Address *</label>
                                        <input type="email" class="form-control" id="questionEmail" name="email" required>
                                        <div class="invalid-feedback">Please enter a valid email address.</div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="questionNic" class="form-label">NIC Number (Optional)</label>
                                        <input type="text" class="form-control" id="questionNic" name="nicNumber" maxlength="12">
                                        <div class="form-text">Enter your NIC if you have an existing application</div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="questionCategory" class="form-label">Category *</label>
                                        <select class="form-select" id="questionCategory" name="category" required>
                                            <option value="">Select Category</option>
                                            <option value="application">Application Process</option>
                                            <option value="documents">Documents</option>
                                            <option value="payment">Payment & Fees</option>
                                            <option value="processing">Processing Times</option>
                                            <option value="technical">Technical Support</option>
                                            <option value="general">General Inquiry</option>
                                        </select>
                                        <div class="invalid-feedback">Please select a category.</div>
                                    </div>
                                    <div class="col-12">
                                        <label for="questionSubject" class="form-label">Subject *</label>
                                        <input type="text" class="form-control" id="questionSubject" name="subject" required>
                                        <div class="invalid-feedback">Please enter a subject for your question.</div>
                                    </div>
                                    <div class="col-12">
                                        <label for="questionText" class="form-label">Your Question *</label>
                                        <textarea class="form-control" id="questionText" name="question" rows="5" required></textarea>
                                        <div class="invalid-feedback">Please enter your question.</div>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary btn-lg w-100">
                                            <i class="fas fa-paper-plane me-2"></i>Submit Question
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

    <!-- User Questions Display Section -->
    <section id="user-questions" class="py-5 bg-light">
        <div class="container">
            <div class="text-center mb-5" data-aos="fade-up">
                <h2 class="display-5 fw-bold text-primary">Recent Questions</h2>
                <p class="lead text-muted">Browse questions asked by other users and their answers</p>
            </div>

            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="card border-0 shadow" data-aos="fade-up" data-aos-delay="100">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0">
                                    <i class="fas fa-question-circle me-2"></i>Community Questions
                                </h5>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="filterQuestions('all')">All</button>
                                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="filterQuestions('answered')">Answered</button>
                                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="filterQuestions('pending')">Pending</button>
                                </div>
                            </div>
                            
                            <div id="questionsList">
                                <div class="text-center py-4">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                    <p class="mt-2 text-muted">Loading questions...</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Support Section -->
    <section id="contact-support" class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="contact-card" data-aos="fade-up">
                        <h4><i class="fas fa-headset me-2"></i>Still Need Help?</h4>
                        <p class="mb-4">Our support team is here to assist you with any questions or concerns.</p>
                        
                        <div class="contact-info">
                            <div class="contact-item">
                                <i class="fas fa-phone"></i>
                                <span>+94 11 234 5678</span>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-envelope"></i>
                                <span>support@lankaepassport.lk</span>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-clock"></i>
                                <span>24/7 Support</span>
                            </div>
                        </div>

                        <div class="mt-4">
                            <a href="index.jsp#contact" class="btn btn-light btn-lg me-3">
                                <i class="fas fa-envelope me-2"></i>Send Message
                            </a>
                            <button class="btn btn-outline-light btn-lg" onclick="openLiveChat()">
                                <i class="fas fa-comments me-2"></i>Live Chat
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Live Chat Button -->
    <button class="live-chat-btn" onclick="openLiveChat()" title="Live Chat Support">
        <i class="fas fa-comments"></i>
    </button>

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
    <!-- AOS Animation -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

    <script>
        // Get context path for API calls
        const contextPath = '<%= request.getContextPath() %>';
        
        // Initialize AOS
        AOS.init({
            duration: 1000,
            once: true,
            offset: 100
        });

        // FAQ Functionality
        document.addEventListener('DOMContentLoaded', function() {
            const faqQuestions = document.querySelectorAll('.faq-question');
            const categoryTabs = document.querySelectorAll('.category-tab');
            const searchBox = document.getElementById('faqSearch');
            const faqItems = document.querySelectorAll('.faq-item');

            // FAQ Toggle Functionality
            faqQuestions.forEach(question => {
                question.addEventListener('click', function() {
                    const answer = this.nextElementSibling;
                    const icon = this.querySelector('.faq-icon');
                    
                    // Close all other FAQs
                    faqQuestions.forEach(otherQuestion => {
                        if (otherQuestion !== this) {
                            otherQuestion.classList.remove('active');
                            otherQuestion.nextElementSibling.classList.remove('active');
                        }
                    });
                    
                    // Toggle current FAQ
                    this.classList.toggle('active');
                    answer.classList.toggle('active');
                });
            });

            // Category Filter Functionality
            categoryTabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    const category = this.getAttribute('data-category');
                    
                    // Update active tab
                    categoryTabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                    
                    // Filter FAQ items
                    faqItems.forEach(item => {
                        const itemCategory = item.getAttribute('data-category');
                        if (category === 'all' || itemCategory === category) {
                            item.classList.remove('hidden');
                            item.classList.add('fade-in');
                        } else {
                            item.classList.add('hidden');
                            item.classList.remove('fade-in');
                        }
                    });
                });
            });

            // Search Functionality
            searchBox.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                
                faqItems.forEach(item => {
                    const question = item.querySelector('.faq-question span').textContent.toLowerCase();
                    const answer = item.querySelector('.faq-answer-content').textContent.toLowerCase();
                    
                    if (question.includes(searchTerm) || answer.includes(searchTerm)) {
                        item.classList.remove('hidden');
                        item.classList.add('fade-in');
                    } else {
                        item.classList.add('hidden');
                        item.classList.remove('fade-in');
                    }
                });
            });

            // Smooth scroll for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        });

        // Live Chat Functionality
        function openLiveChat() {
            // Create a simple chat modal
            const chatModal = document.createElement('div');
            chatModal.className = 'modal fade';
            chatModal.id = 'liveChatModal';
            chatModal.innerHTML = `
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title">
                                <i class="fas fa-comments me-2"></i>Live Chat Support
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="chat-container" style="height: 400px; overflow-y: auto; border: 1px solid #dee2e6; padding: 1rem; margin-bottom: 1rem;">
                                <div class="chat-message bot-message mb-3">
                                    <div class="d-flex align-items-start">
                                        <div class="bg-primary text-white rounded-circle p-2 me-2">
                                            <i class="fas fa-robot"></i>
                                        </div>
                                        <div class="bg-light p-3 rounded">
                                            <p class="mb-0">Hello! I'm your virtual assistant. How can I help you today?</p>
                                            <small class="text-muted">Just now</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="input-group">
                                <input type="text" class="form-control" id="chatInput" placeholder="Type your message...">
                                <button class="btn btn-primary" type="button" onclick="sendMessage()">
                                    <i class="fas fa-paper-plane"></i>
                                </button>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i>
                                For complex issues, our human support team is available 24/7
                            </small>
                        </div>
                    </div>
                </div>
            `;
            
            document.body.appendChild(chatModal);
            const modal = new bootstrap.Modal(chatModal);
            modal.show();
            
            // Focus on input
            setTimeout(() => {
                document.getElementById('chatInput').focus();
            }, 500);
            
            // Remove modal from DOM when hidden
            chatModal.addEventListener('hidden.bs.modal', function() {
                chatModal.remove();
            });
        }

        function sendMessage() {
            const input = document.getElementById('chatInput');
            const message = input.value.trim();
            
            if (message) {
                const chatContainer = document.querySelector('.chat-container');
                
                // Add user message
                const userMessage = document.createElement('div');
                userMessage.className = 'chat-message user-message mb-3';
                userMessage.innerHTML = `
                    <div class="d-flex align-items-start justify-content-end">
                        <div class="bg-primary text-white p-3 rounded">
                            <p class="mb-0">${message}</p>
                            <small class="text-white-50">Just now</small>
                        </div>
                        <div class="bg-secondary text-white rounded-circle p-2 ms-2">
                            <i class="fas fa-user"></i>
                        </div>
                    </div>
                `;
                chatContainer.appendChild(userMessage);
                
                // Clear input
                input.value = '';
                
                // Scroll to bottom
                chatContainer.scrollTop = chatContainer.scrollHeight;
                
                // Simulate bot response
                setTimeout(() => {
                    const botResponse = getBotResponse(message);
                    const botMessage = document.createElement('div');
                    botMessage.className = 'chat-message bot-message mb-3';
                    botMessage.innerHTML = `
                        <div class="d-flex align-items-start">
                            <div class="bg-primary text-white rounded-circle p-2 me-2">
                                <i class="fas fa-robot"></i>
                            </div>
                            <div class="bg-light p-3 rounded">
                                <p class="mb-0">${botResponse}</p>
                                <small class="text-muted">Just now</small>
                            </div>
                        </div>
                    `;
                    chatContainer.appendChild(botMessage);
                    chatContainer.scrollTop = chatContainer.scrollHeight;
                }, 1000);
            }
        }

        function getBotResponse(message) {
            const responses = {
                'hello': 'Hello! How can I help you with your passport application today?',
                'application': 'For passport applications, you can start by clicking "New Application" on our website. Do you need help with any specific part of the process?',
                'documents': 'You need to upload: passport photo, birth certificate, address proof, and signature. All files should be clear and under the size limits.',
                'payment': 'We accept credit cards, debit cards, bank transfers, and mobile payments. Regular processing costs Rs. 15,000 and Express costs Rs. 20,000.',
                'time': 'Regular processing takes 7-10 days, Express takes 3-5 days. Processing starts after your biometric appointment.',
                'help': 'I can help you with application process, document requirements, payment, processing times, and technical issues. What specific help do you need?'
            };
            
            const lowerMessage = message.toLowerCase();
            
            for (const [key, response] of Object.entries(responses)) {
                if (lowerMessage.includes(key)) {
                    return response;
                }
            }
            
            return 'I understand you need help. For specific questions about passport applications, document requirements, or technical issues, please contact our support team at +94 11 234 5678 or email support@lankaepassport.lk';
        }

        // Handle Enter key in chat input
        document.addEventListener('keypress', function(e) {
            if (e.target.id === 'chatInput' && e.key === 'Enter') {
                sendMessage();
            }
        });

        // Question Form Functionality
        document.getElementById('questionForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const form = this;
            const formData = new FormData(form);
            
            // Check form validity
            if (!form.checkValidity()) {
                e.stopPropagation();
                form.classList.add('was-validated');
                return;
            }
            
            // Get user data from localStorage if available
            const savedUser = localStorage.getItem('lankaEpassportUser');
            if (savedUser) {
                const user = JSON.parse(savedUser);
                formData.set('nicNumber', user.nicNumber || '');
                formData.set('name', user.name || formData.get('name'));
                formData.set('email', user.email || formData.get('email'));
            }
            
            try {
                const response = await fetch(contextPath + '/api/questions', {
                    method: 'POST',
                    body: formData
                });
                
                const result = await response.json();
                
                if (response.ok) {
                    showNotification('Question submitted successfully! We will get back to you soon.', 'success');
                    form.reset();
                    form.classList.remove('was-validated');
                    loadQuestions(); // Refresh questions list
                } else {
                    showNotification(result.error || 'Failed to submit question. Please try again.', 'error');
                }
            } catch (error) {
                console.error('Error submitting question:', error);
                showNotification('Network error. Please try again.', 'error');
            }
        });

        // Load and display questions
        async function loadQuestions(status = 'all') {
            const questionsList = document.getElementById('questionsList');
            
            try {
                const url = status === 'all' ? 
                    contextPath + '/api/questions' : 
                    contextPath + '/api/questions?status=' + status;
                
                const response = await fetch(url);
                const questions = await response.json();
                
                if (questions.length === 0) {
                    questionsList.innerHTML = `
                        <div class="text-center py-4">
                            <i class="fas fa-question-circle fa-3x text-muted mb-3"></i>
                            <p class="text-muted">No questions found.</p>
                        </div>
                    `;
                    return;
                }
                
                questionsList.innerHTML = questions.map(question => `
                    <div class="question-item mb-4 p-3 border rounded">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div>
                                <h6 class="mb-1 fw-bold">${escapeHtml(question.subject)}</h6>
                                <small class="text-muted">
                                    <i class="fas fa-user me-1"></i>${escapeHtml(question.name)}
                                    <span class="mx-2">•</span>
                                    <i class="fas fa-tag me-1"></i>${escapeHtml(question.category)}
                                    <span class="mx-2">•</span>
                                    <i class="fas fa-clock me-1"></i>${formatDate(question.createdAt)}
                                </small>
                            </div>
                            <span class="badge ${getStatusBadgeClass(question.status)}">${question.status}</span>
                        </div>
                        <p class="mb-2">${escapeHtml(question.question)}</p>
                        ${question.answer ? `
                            <div class="answer-section bg-light p-3 rounded mt-3">
                                <h6 class="text-success mb-2">
                                    <i class="fas fa-check-circle me-1"></i>Answer
                                </h6>
                                <p class="mb-0">${escapeHtml(question.answer)}</p>
                                <small class="text-muted">
                                    Answered by ${escapeHtml(question.answeredBy || 'Support Team')} on ${formatDate(question.answeredAt)}
                                </small>
                            </div>
                        ` : `
                            <div class="text-muted">
                                <i class="fas fa-clock me-1"></i>Waiting for response...
                            </div>
                        `}
                    </div>
                `).join('');
                
            } catch (error) {
                console.error('Error loading questions:', error);
                questionsList.innerHTML = `
                    <div class="text-center py-4">
                        <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                        <p class="text-muted">Failed to load questions. Please try again later.</p>
                    </div>
                `;
            }
        }

        // Filter questions by status
        function filterQuestions(status) {
            // Update button states
            document.querySelectorAll('#user-questions .btn-group button').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            loadQuestions(status);
        }

        // Utility functions
        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

        function formatDate(dateString) {
            if (!dateString) return '';
            const date = new Date(dateString);
            return date.toLocaleDateString() + ' ' + date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        }

        function getStatusBadgeClass(status) {
            switch(status) {
                case 'answered': return 'bg-success';
                case 'pending': return 'bg-warning';
                case 'closed': return 'bg-secondary';
                default: return 'bg-primary';
            }
        }

        // Notification function
        function showNotification(message, type = 'info') {
            // Create notification element
            const notification = document.createElement('div');
            notification.className = `alert alert-${type === 'error' ? 'danger' : type === 'success' ? 'success' : 'info'} alert-dismissible fade show position-fixed`;
            notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
            notification.innerHTML = `
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            
            // Add to body
            document.body.appendChild(notification);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                if (notification.parentNode) {
                    notification.remove();
                }
            }, 5000);
        }

        // Load questions when page loads
        document.addEventListener('DOMContentLoaded', function() {
            loadQuestions();
        });
    </script>
</body>
</html>
