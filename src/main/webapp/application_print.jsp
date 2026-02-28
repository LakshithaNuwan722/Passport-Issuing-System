<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Print Section - Approved Applications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background-color: #f8f9fa; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar-custom { 
            background: linear-gradient(135deg, #667eea, #764ba2); 
        }
        .page-header { 
            background: linear-gradient(135deg, #667eea, #764ba2); 
            color: white; 
            padding: 3rem 0; 
            margin-bottom: 2rem; 
        }
        .print-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .table th {
            background-color: #667eea;
            color: white;
            border: none;
            font-weight: 600;
        }
        .table td {
            vertical-align: middle;
            border-color: #e9ecef;
        }
        .btn-print {
            background: linear-gradient(135deg, #28a745, #20c997);
            border: none;
            border-radius: 20px;
            padding: 8px 16px;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-print:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
        }
        .status-badge {
            font-size: 0.8rem;
            padding: 6px 12px;
            border-radius: 15px;
        }
        .loading-container {
            min-height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .no-data-container {
            min-height: 300px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #6c757d;
        }
        
        /* Print-specific styles */
        @media print {
            .navbar-custom,
            .page-header,
            .btn-print,
            .no-print {
                display: none !important;
            }
            body {
                background: white !important;
                font-size: 12px;
            }
            .print-table {
                box-shadow: none !important;
                border: 1px solid #000 !important;
            }
            .table th,
            .table td {
                border: 1px solid #000 !important;
                padding: 8px !important;
            }
            .container {
                max-width: none !important;
                margin: 0 !important;
                padding: 0 !important;
            }
        }
        
        /* Print modal styles */
        .print-modal .modal-content {
            border-radius: 10px;
        }
        .print-modal .modal-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-dark navbar-custom">
        <div class="container">
            <span class="navbar-brand">
                <i class="fas fa-passport me-2"></i>Lanka Epassport - Print Section
            </span>
            <div class="navbar-nav ms-auto">
                <a href="<%= request.getContextPath() %>/staff-login.jsp" class="nav-link me-3">
                    <i class="fas fa-users-cog me-1"></i>Staff Portal
                </a>
                <a href="<%= request.getContextPath() %>/login.jsp?section=print" class="nav-link">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-print me-2"></i>Approved Applications - Print Section</h1>
            <p class="lead">Ready for passport printing</p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <!-- Alerts -->
        <div id="alerts"></div>

        <!-- Loading State -->
        <div id="loading" class="loading-container d-none">
            <div class="text-center">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="mt-3">Loading approved applications...</p>
            </div>
        </div>

        <!-- Applications Table -->
        <div id="applicationsContainer" class="d-none">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4><i class="fas fa-list me-2"></i>Approved Applications</h4>
                <button class="btn btn-outline-primary no-print" onclick="printAllApplications()">
                    <i class="fas fa-print me-2"></i>Print All
                </button>
            </div>
            
            <div class="print-table">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th>Application #</th>
                            <th>Applicant Name</th>
                            <th>NIC Number</th>
                            <th>Passport Type</th>
                            <th>Submission Date</th>
                            <th>Approval Date</th>
                            <th class="no-print">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="applicationsTableBody">
                        <!-- Dynamic content will be inserted here -->
                    </tbody>
                </table>
            </div>
        </div>

        <!-- No Data State -->
        <div id="noApplications" class="no-data-container d-none">
            <i class="fas fa-inbox fa-4x mb-3"></i>
            <h4>No Approved Applications</h4>
            <p class="text-muted">There are currently no applications ready for printing.</p>
        </div>
    </div>

    <!-- Print Modal -->
    <div class="modal fade print-modal" id="printModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-print me-2"></i>Print Application Details
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="printModalBody">
                    <!-- Print content will be inserted here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="printCurrentApplication()">
                        <i class="fas fa-file-pdf me-2"></i>Generate Passport PDF
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        const basePath = '<%= request.getContextPath() %>';
        let currentApplication = null;

        // Load approved applications on page load
        document.addEventListener('DOMContentLoaded', function() {
            loadApprovedApplications();
        });

        // Fetch approved applications from backend
        async function loadApprovedApplications() {
            const loading = document.getElementById('loading');
            const container = document.getElementById('applicationsContainer');
            const noApps = document.getElementById('noApplications');

            loading.classList.remove('d-none');
            container.classList.add('d-none');
            noApps.classList.add('d-none');

            try {
                const response = await fetch(basePath + '/api/print-section');
                
                if (response.ok) {
                    const applications = await response.json();
                    
                    loading.classList.add('d-none');
                    
                    if (applications.length === 0) {
                        noApps.classList.remove('d-none');
                    } else {
                        populateApplicationsTable(applications);
                        container.classList.remove('d-none');
                    }
                } else {
                    throw new Error('Failed to load applications');
                }
            } catch (error) {
                console.error('Error loading applications:', error);
                loading.classList.add('d-none');
                showAlert('Error loading applications: ' + error.message, 'danger');
            }
        }

        // Populate the applications table
        function populateApplicationsTable(applications) {
            const tbody = document.getElementById('applicationsTableBody');
            tbody.innerHTML = '';

            applications.forEach(app => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td><strong>#${app.applicationId}</strong></td>
                    <td>${app.firstName} ${app.lastName}</td>
                    <td>${app.nicNumber}</td>
                    <td><span class="badge bg-info status-badge">${app.processingType}</span></td>
                            <td>${formatDate(app.paymentDate)}</td>
                    <td>${formatDate(app.finalReviewedAt)}</td>
                    <td class="no-print">
                        <button class="btn btn-print btn-sm" onclick="openPrintModal(${app.applicationId})">
                            <i class="fas fa-file-pdf me-1"></i>Generate PDF
                        </button>
                        <button class="btn btn-success btn-sm ms-2" onclick="markPrinted(${app.applicationId}, '${app.nicNumber}')">
                            <i class="fas fa-check me-1"></i>Printed
                        </button>
                    </td>
                `;
                tbody.appendChild(row);
            });
        }

        // Open print modal for specific application
        async function openPrintModal(applicationId) {
            try {
                const response = await fetch(basePath + '/api/print-section');
                if (response.ok) {
                    const applications = await response.json();
                    const app = applications.find(a => a.applicationId === applicationId);
                    
                    if (app) {
                        currentApplication = app;
                        populatePrintModal(app);
                        new bootstrap.Modal(document.getElementById('printModal')).show();
                    }
                }
            } catch (error) {
                console.error('Error loading application details:', error);
                showAlert('Error loading application details', 'danger');
            }
        }

        // Populate print modal content
        function populatePrintModal(app) {
            const modalBody = document.getElementById('printModalBody');
            modalBody.innerHTML = `
                <div class="row">
                    <div class="col-md-6">
                        <h6 class="text-primary mb-3"><i class="fas fa-user me-2"></i>Personal Information</h6>
                        <table class="table table-sm">
                            <tr><td><strong>Application #:</strong></td><td>#${app.applicationId}</td></tr>
                            <tr><td><strong>Name:</strong></td><td>${app.firstName} ${app.lastName}</td></tr>
                            <tr><td><strong>NIC:</strong></td><td>${app.nicNumber}</td></tr>
                            <tr><td><strong>Email:</strong></td><td>${app.email}</td></tr>
                            <tr><td><strong>DOB:</strong></td><td>${formatDate(app.dateOfBirth)}</td></tr>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h6 class="text-primary mb-3"><i class="fas fa-map-marker me-2"></i>Address Information</h6>
                        <table class="table table-sm">
                            <tr><td><strong>Address:</strong></td><td>${app.currentAddress}</td></tr>
                            <tr><td><strong>City:</strong></td><td>${app.city}</td></tr>
                            <tr><td><strong>Postal Code:</strong></td><td>${app.postalCode || 'N/A'}</td></tr>
                        </table>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <h6 class="text-primary mb-3"><i class="fas fa-passport me-2"></i>Application Details</h6>
                        <table class="table table-sm">
                            <tr><td><strong>Passport Type:</strong></td><td>${app.processingType}</td></tr>
                            <tr><td><strong>Payment Date:</strong></td><td>${formatDate(app.paymentDate)}</td></tr>
                            <tr><td><strong>Approval Date:</strong></td><td>${formatDate(app.finalReviewedAt)}</td></tr>
                            <tr><td><strong>Status:</strong></td><td><span class="badge bg-success">${app.finalApprovalStatus}</span></td></tr>
                        </table>
                    </div>
                </div>
            `;
        }

        // Generate PDF passport
        function printCurrentApplication() {
            if (currentApplication) {
                // Generate PDF passport
                const pdfUrl = basePath + '/api/passport-pdf?id=' + currentApplication.applicationId;
                
                // Open PDF in new window for printing
                const printWindow = window.open(pdfUrl, '_blank');
                
                // Close the modal
                bootstrap.Modal.getInstance(document.getElementById('printModal')).hide();
                
                // Show success message
                showAlert('Passport PDF generated successfully!', 'success');
            }
        }

        // Mark application as printed
        async function markPrinted(applicationId, nicNumber) {
            if (confirm('Are you sure you want to mark this application as printed?')) {
                try {
                    const response = await fetch(basePath + '/api/application-printed?applicationId=' + applicationId + '&nicNumber=' + encodeURIComponent(nicNumber), {
                        method: 'POST'
                    });

                    if (response.ok) {
                        const data = await response.json();
                        showAlert(data.message || 'Passport printed successfully!', 'success');
                        
                        // Remove the row immediately from the table
                        removeApplicationRow(applicationId);
                        
                        // Check if table is empty and show appropriate message
                        setTimeout(() => {
                            const tableBody = document.getElementById('applicationsTableBody');
                            const noApps = document.getElementById('noApplications');
                            const container = document.getElementById('applicationsContainer');
                            const printAllBtn = document.getElementById('printAllApplicationsBtn');
                            
                            if (tableBody.children.length === 0) {
                                container.classList.add('d-none');
                                noApps.classList.remove('d-none');
                                printAllBtn.classList.add('d-none');
                            }
                        }, 100);
                        
                    } else {
                        const error = await response.json();
                        throw new Error(error.error || 'Failed to mark application as printed');
                    }
                } catch (error) {
                    console.error('Error marking application as printed:', error);
                    showAlert('Error: ' + error.message, 'danger');
                }
            }
        }

        // Remove application row from table
        function removeApplicationRow(applicationId) {
            const tableBody = document.getElementById('applicationsTableBody');
            const rows = tableBody.getElementsByTagName('tr');
            
            for (let i = 0; i < rows.length; i++) {
                const row = rows[i];
                const button = row.querySelector(`button[onclick*="markPrinted(${applicationId}"]`);
                if (button) {
                    // Add fade out animation
                    row.style.transition = 'opacity 0.5s ease-out';
                    row.style.opacity = '0';
                    
                    // Remove row after animation
                    setTimeout(() => {
                        row.remove();
                    }, 500);
                    break;
                }
            }
        }

        // Print all applications
        function printAllApplications() {
            window.print();
        }

        // Format date for display
        function formatDate(dateString) {
            if (!dateString) return 'N/A';
            const date = new Date(dateString);
            return date.toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
        }

        // Show alert message
        function showAlert(message, type) {
            const alertsContainer = document.getElementById('alerts');
            const alert = document.createElement('div');
            alert.className = `alert alert-${type} alert-dismissible fade show`;
            alert.innerHTML = `
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;
            alertsContainer.appendChild(alert);
            
            // Auto-remove after 5 seconds
            setTimeout(() => {
                if (alert.parentNode) {
                    alert.remove();
                }
            }, 5000);
        }
    </script>
</body>
</html>
