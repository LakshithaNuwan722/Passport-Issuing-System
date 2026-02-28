<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help Desk - Lanka Epassport Service</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand fw-bold d-flex align-items-center" href="index.jsp">
                <div class="me-3">
                    <i class="fas fa-passport"></i>
                </div>
                <div>
                    <span>Lanka Epassport Service</span>
                </div>
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="index.jsp">Home</a>
                <a class="nav-link active" href="helpdesk.jsp">Help Desk</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h2 class="mb-0">
                            <i class="fas fa-question-circle me-2"></i>
                            Help Desk & FAQ
                        </h2>
                    </div>
                    <div class="card-body">
                        <p class="lead">Welcome to our Help Desk! Find answers to common questions about passport services.</p>
                        
                        <div class="alert alert-success">
                            <strong>Success!</strong> The helpdesk.jsp page is now working correctly!
                        </div>

                        <h4>Frequently Asked Questions</h4>
                        <div class="accordion" id="faqAccordion">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                        How do I apply for a new passport?
                                    </button>
                                </h2>
                                <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        To apply for a new passport, visit our website and click on "New Application". 
                                        Fill out the online form with your personal details and upload required documents.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                        What documents do I need?
                                    </button>
                                </h2>
                                <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body">
                                        You need to upload: passport photo, birth certificate, address proof, and signature.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4">
                            <h5>Contact Support</h5>
                            <p>If you need further assistance, please contact us:</p>
                            <ul>
                                <li><strong>Phone:</strong> +94 11 234 5678</li>
                                <li><strong>Email:</strong> support@lankaepassport.lk</li>
                                <li><strong>Hours:</strong> 24/7 Support</li>
                            </ul>
                        </div>

                        <div class="mt-4">
                            <a href="index.jsp" class="btn btn-primary">
                                <i class="fas fa-home me-2"></i>Go to Home
                            </a>
                            <a href="application.jsp" class="btn btn-outline-primary">
                                <i class="fas fa-plus me-2"></i>New Application
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
