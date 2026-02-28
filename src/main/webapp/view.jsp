<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Application - Lanka Epassport Service</title>

    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="images/favicon.svg">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">

    <style>
        .card {
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .alert {
            border-radius: 10px;
            border: none;
        }

        .status-badge {
            font-size: 0.9rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
        }

        .document-preview {
            max-width: 100px;
            max-height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <i class="fas fa-passport me-2"></i>
            Lanka Epassport Service
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="application.jsp">New Application</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="applications.jsp">My Applications</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp#contact">Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<section class="py-5" style="margin-top: 80px;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <!-- Page Header -->
                <div class="text-center mb-5">
                    <h1 class="display-5 fw-bold text-primary">
                        <i class="fas fa-eye me-3"></i>View Application
                    </h1>
                    <p class="lead text-muted">Detailed view of your passport application</p>
                </div>

                <!-- Loading Spinner -->
                <div class="text-center d-none" id="loadingSpinner">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-2 text-muted">Loading application details...</p>
                </div>

                <!-- Application Details Card -->
                <div id="applicationDetails" class="d-none">
                    <!-- Application will be loaded here -->
                </div>

                <!-- No Application Message -->
                <div class="text-center d-none" id="noApplication">
                    <i class="fas fa-file-alt fa-3x text-muted mb-3"></i>
                    <h4 class="text-muted">Application Not Found</h4>
                    <p class="text-muted">The requested application could not be found.</p>
                    <a href="<%= request.getContextPath() %>/applications.jsp" class="btn btn-primary">
                        <i class="fas fa-arrow-left me-2"></i>Back to My Applications
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

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
    // Get application ID from URL parameters
    const urlParams = new URLSearchParams(window.location.search);
    const applicationId = urlParams.get('id');

    if (!applicationId) {
        showNoApplication();
        return;
    }

    // Load application details
    async function loadApplicationDetails(id) {
        const loadingSpinner = document.getElementById('loadingSpinner');
        const applicationDetails = document.getElementById('applicationDetails');
        const noApplication = document.getElementById('noApplication');

        loadingSpinner.classList.remove('d-none');
        applicationDetails.classList.add('d-none');
        noApplication.classList.add('d-none');

        try {
            const basePath = '<%= request.getContextPath() %>' || '';
            // Include NIC to enforce ownership on server
            const savedUser = localStorage.getItem('lankaEpassportUser');
            const nicParam = savedUser ? (JSON.parse(savedUser).nicNumber || JSON.parse(savedUser).nic || '') : '';
            const nicQuery = nicParam ? `&nic=${encodeURIComponent(nicParam)}` : '';
            const response = await fetch(`${basePath}/api/applications?id=${id}${nicQuery}`);

            if (response.ok) {
                const application = await response.json();
                displayApplicationDetails(application);
            } else {
                // Show specific messages for common auth/data errors
                if (response.status === 403) {
                    console.warn('Forbidden: application does not belong to the current user');
                }
                showNoApplication();
            }
        } catch (error) {
            console.error('Error loading application:', error);
            showNoApplication();
        }
    }

    function displayApplicationDetails(application) {
        const applicationDetails = document.getElementById('applicationDetails');
        const loadingSpinner = document.getElementById('loadingSpinner');

        loadingSpinner.classList.add('d-none');
        applicationDetails.classList.remove('d-none');

        const statusClass = getStatusClass(application.status);
        const statusText = capitalizeFirst(application.status || 'Submitted');

        let documentsHtml = '';
        if (application.documents && application.documents.length > 0) {
            documentsHtml = application.documents.map(doc => `
                <div class="col-md-6 mb-3">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-file-${getDocumentIcon(doc.documentType)} fa-2x text-primary mb-2"></i>
                            <h6 class="card-title">${formatDocumentType(doc.documentType)}</h6>
                            <p class="card-text small text-muted">${doc.fileName}</p>
                            <small class="text-muted">Size: ${(doc.fileSize / 1024).toFixed(1)} KB</small>
                        </div>
                    </div>
                </div>
            `).join('');
        } else {
            documentsHtml = '<div class="col-12"><p class="text-muted text-center">No documents uploaded yet.</p></div>';
        }

        applicationDetails.innerHTML = `
            <div class="card border-0 shadow">
                <div class="card-header bg-primary text-white">
                    <div class="d-flex justify-content-between align-items-center">
                        <h4 class="mb-0">
                            <i class="fas fa-file-alt me-2"></i>Application #${application.applicationId}
                        </h4>
                        <span class="badge ${statusClass} status-badge">${statusText}</span>
                    </div>
                </div>
                <div class="card-body p-4">
                    <!-- Personal Information -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-user me-2"></i>Personal Information
                            </h5>
                        </div>
                        <div class="col-md-6">
                            <p class="mb-2"><strong>Full Name:</strong> ${application.firstName} ${application.lastName}</p>
                            <p class="mb-2"><strong>NIC Number:</strong> ${application.nicNumber}</p>
                            <p class="mb-2"><strong>Email:</strong> ${application.email}</p>
                        </div>
                        <div class="col-md-6">
                            <p class="mb-2"><strong>Date of Birth:</strong> ${formatDate(application.dateOfBirth)}</p>
                            <p class="mb-2"><strong>Processing Type:</strong> ${capitalizeFirst(application.processingType)}</p>
                            <p class="mb-2"><strong>Biometric Date:</strong> ${formatDate(application.biometricDate) || 'Not scheduled'}</p>
                        </div>
                    </div>

                    <!-- Address Information -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-map-marker-alt me-2"></i>Address Information
                            </h5>
                        </div>
                        <div class="col-md-12">
                            <p class="mb-2"><strong>Current Address:</strong> ${application.currentAddress}</p>
                            <p class="mb-2"><strong>City:</strong> ${application.city}</p>
                            <p class="mb-2"><strong>Postal Code:</strong> ${application.postalCode || 'N/A'}</p>
                        </div>
                    </div>

                    <!-- Documents -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <h5 class="text-primary mb-3">
                                <i class="fas fa-file-upload me-2"></i>Uploaded Documents
                            </h5>
                        </div>
                        ${documentsHtml}
                    </div>

                    <!-- Action Buttons -->
                    <div class="row">
                        <div class="col-12 text-center">
                            <a href="<%= request.getContextPath() %>/application.jsp?edit=${application.applicationId}" class="btn btn-warning me-3">
                                <i class="fas fa-edit me-2"></i>Update Application
                            </a>
                            <a href="<%= request.getContextPath() %>/applications.jsp" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Back to Applications
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        `;
    }

    function showNoApplication() {
        const loadingSpinner = document.getElementById('loadingSpinner');
        const noApplication = document.getElementById('noApplication');

        loadingSpinner.classList.add('d-none');
        noApplication.classList.remove('d-none');
    }

    function getStatusClass(status) {
        switch (status?.toLowerCase()) {
            case 'approved': return 'bg-success';
            case 'rejected': return 'bg-danger';
            case 'processing': return 'bg-warning';
            case 'submitted': return 'bg-info';
            default: return 'bg-secondary';
        }
    }

    function getDocumentIcon(docType) {
        switch (docType) {
            case 'passport_photo': return 'camera';
            case 'birth_certificate': return 'file-pdf';
            case 'address_proof': return 'file-pdf';
            case 'signature': return 'signature';
            default: return 'file';
        }
    }

    function formatDocumentType(docType) {
        return docType.split('_').map(word =>
            word.charAt(0).toUpperCase() + word.slice(1)
        ).join(' ');
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

    // Load application details when page loads
    document.addEventListener('DOMContentLoaded', function() {
        loadApplicationDetails(applicationId);
    });
</script>
</body>
</html>