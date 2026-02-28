<%--
  Created by IntelliJ IDEA.
  User: Lakshitha
  Date: 9/28/2025
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passport Application - Lanka Epassport Service</title>

    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="images/favicon.svg">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Government Style CSS -->
    <link rel="stylesheet" href="assets/css/government-style.css">

    <style>
        /* Document Upload Styling */
        .upload-area {
            border: 2px dashed #dee2e6;
            border-radius: 10px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            background: #f8f9fa;
        }

        .upload-area:hover {
            border-color: var(--bs-primary);
            background: #e9ecef;
        }

        .upload-placeholder {
            color: #6c757d;
        }

        .upload-preview {
            text-align: center;
        }

        .upload-preview img {
            max-width: 150px;
            max-height: 150px;
            object-fit: cover;
        }

        /* Biometric Booking Styling */
        .time-slot {
            padding: 0.5rem 1rem;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: white;
        }

        .time-slot:hover {
            border-color: var(--bs-primary);
            background: #f8f9fa;
        }

        .time-slot.selected {
            background: var(--bs-primary);
            color: white;
            border-color: var(--bs-primary);
        }

        .time-slot.available {
            border-color: #28a745;
            color: #28a745;
        }

        .time-slot.unavailable {
            border-color: #dc3545;
            color: #dc3545;
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Form Enhancement */
        .form-control:focus,
        .form-select:focus {
            border-color: var(--bs-primary);
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .alert {
            border-radius: 10px;
            border: none;
        }

        /* Form Validation Styling */
        .form-text {
            font-size: 0.875rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }

        .form-text i {
            color: var(--bs-primary);
        }

        .form-control.is-valid,
        .form-control.is-invalid {
            background-image: none;
        }

        .form-control.is-valid {
            border-color: #198754;
            box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25);
        }

        .form-control.is-invalid {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }

        .validation-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 5;
        }

        .field-wrapper {
            position: relative;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <!-- Navigation removed - using header include -->
                <ul class="navbar-nav ms-auto d-none">
                    <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="applications.jsp">My Applications</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="application.jsp">New Application</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="helpdesk.jsp">Help Desk</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp#contact">Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Application Form Section -->
<section class="py-5" style="margin-top: 80px;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="text-center mb-5">
                    <h1 class="display-5 fw-bold text-primary">Passport Application Form</h1>
                    <p class="lead text-muted">Complete the form below to apply for your passport</p>
                </div>

                <!-- User Info Card -->
                <div class="card border-0 shadow mb-4" id="userInfoCard" style="display: none;">
                    <div class="card-body p-4">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h6 class="mb-1 text-primary">
                                    <i class="fas fa-user me-2"></i>Welcome back!
                                </h6>
                                <p class="mb-0 text-muted" id="userInfoText"></p>
                            </div>
                            <div class="col-md-4 text-md-end">
                                <button class="btn btn-outline-secondary btn-sm" onclick="logout()">
                                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow">
                    <div class="card-body p-4">
                        <form id="passportForm" action="${pageContext.request.contextPath}/api/applications" method="post" enctype="multipart/form-data" class="needs-validation" novalidate onsubmit="return submitForm(event)">
                            <!-- Personal Information -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="text-primary mb-3">
                                        <i class="fas fa-user me-2"></i>Personal Information
                                    </h5>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="firstName" class="form-label">First Name *</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" required>
                                    <div class="invalid-feedback">
                                        Please enter your first name.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="lastName" class="form-label">Last Name *</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" required>
                                    <div class="invalid-feedback">
                                        Please enter your last name.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="nic" class="form-label">NIC Number *</label>
                                    <input type="text" class="form-control" id="nic" name="nic" maxlength="12" required>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle me-1"></i>Format: 12 digits or 9 digits + V/v
                                    </div>
                                    <div class="invalid-feedback">
                                        Please enter a valid NIC number (12 digits or 9 digits followed by V).
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="dob" class="form-label">Date of Birth *</label>
                                    <input type="date" class="form-control" id="dob" name="dob" required>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle me-1"></i>Must be at least 18 years old
                                    </div>
                                    <div class="invalid-feedback">
                                        Please enter a valid date of birth (must be at least 18 years old).
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">Email Address *</label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                    <div class="invalid-feedback">
                                        Please enter a valid email address.
                                    </div>
                                </div>
                            </div>

                            <!-- Address Information -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="text-primary mb-3">
                                        <i class="fas fa-map-marker-alt me-2"></i>Address Information
                                    </h5>
                                </div>
                                <div class="col-12 mb-3">
                                    <label for="address" class="form-label">Current Address *</label>
                                    <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                                    <div class="invalid-feedback">
                                        Please enter your current address.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="city" class="form-label">City *</label>
                                    <input type="text" class="form-control" id="city" name="city" required>
                                    <div class="invalid-feedback">
                                        Please enter your city.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="postalCode" class="form-label">Postal Code</label>
                                    <input type="text" class="form-control" id="postalCode" name="postalCode" pattern="[0-9]*" inputmode="numeric" placeholder="Enter postal code (digits only)">
                                    <div class="form-text">
                                        <i class="fas fa-info-circle me-1"></i>Enter digits only (e.g., 10000)
                                    </div>
                                    <div class="invalid-feedback">
                                        Postal code must contain only digits.
                                    </div>
                                </div>
                            </div>

                            <!-- Document Upload -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="text-primary mb-3">
                                        <i class="fas fa-file-upload me-2"></i>Document Upload
                                    </h5>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="passportPhoto" class="form-label">Passport Size Photo *</label>
                                    <div class="upload-area" id="photoUploadArea">
                                        <input type="file" class="form-control" id="passportPhoto" name="passportPhoto" accept="image/*" required style="display: none;">
                                        <div class="upload-placeholder" onclick="document.getElementById('passportPhoto').click()">
                                            <i class="fas fa-camera fa-2x text-muted mb-2"></i>
                                            <p class="mb-1">Click to upload photo</p>
                                            <small class="text-muted">JPG, PNG (Max: 2MB)</small>
                                        </div>
                                        <div class="upload-preview" id="photoPreview" style="display: none;">
                                            <img id="photoPreviewImg" src="" alt="Photo Preview" class="img-thumbnail">
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-2" onclick="removePhoto()">
                                                <i class="fas fa-trash me-1"></i>Remove
                                            </button>
                                        </div>
                                    </div>
                                    <div class="invalid-feedback">
                                        Please upload your passport size photo.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="birthCertificate" class="form-label">Birth Certificate (PDF) *</label>
                                    <div class="upload-area" id="certificateUploadArea">
                                        <input type="file" class="form-control" id="birthCertificate" name="birthCertificate" accept=".pdf" required style="display: none;">
                                        <div class="upload-placeholder" onclick="document.getElementById('birthCertificate').click()">
                                            <i class="fas fa-file-pdf fa-2x text-muted mb-2"></i>
                                            <p class="mb-1">Click to upload PDF</p>
                                            <small class="text-muted">PDF only (Max: 5MB)</small>
                                        </div>
                                        <div class="upload-preview" id="certificatePreview" style="display: none;">
                                            <i class="fas fa-file-pdf fa-2x text-success mb-2"></i>
                                            <p class="mb-1" id="certificateFileName"></p>
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-2" onclick="removeCertificate()">
                                                <i class="fas fa-trash me-1"></i>Remove
                                            </button>
                                        </div>
                                    </div>
                                    <div class="invalid-feedback">
                                        Please upload your birth certificate.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="addressProof" class="form-label">Address Proof (PDF) *</label>
                                    <div class="upload-area" id="addressProofUploadArea">
                                        <input type="file" class="form-control" id="addressProof" name="addressProof" accept=".pdf" required style="display: none;">
                                        <div class="upload-placeholder" onclick="document.getElementById('addressProof').click()">
                                            <i class="fas fa-file-pdf fa-2x text-muted mb-2"></i>
                                            <p class="mb-1">Click to upload PDF</p>
                                            <small class="text-muted">PDF only (Max: 5MB)</small>
                                        </div>
                                        <div class="upload-preview" id="addressProofPreview" style="display: none;">
                                            <i class="fas fa-file-pdf fa-2x text-success mb-2"></i>
                                            <p class="mb-1" id="addressProofFileName"></p>
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-2" onclick="removeAddressProof()">
                                                <i class="fas fa-trash me-1"></i>Remove
                                            </button>
                                        </div>
                                    </div>
                                    <div class="invalid-feedback">
                                        Please upload your address proof.
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="signature" class="form-label">Signature Image *</label>
                                    <div class="upload-area" id="signatureUploadArea">
                                        <input type="file" class="form-control" id="signature" name="signature" accept="image/*" required style="display: none;">
                                        <div class="upload-placeholder" onclick="document.getElementById('signature').click()">
                                            <i class="fas fa-signature fa-2x text-muted mb-2"></i>
                                            <p class="mb-1">Click to upload signature</p>
                                            <small class="text-muted">JPG, PNG (Max: 2MB)</small>
                                        </div>
                                        <div class="upload-preview" id="signaturePreview" style="display: none;">
                                            <img id="signaturePreviewImg" src="" alt="Signature Preview" class="img-thumbnail">
                                            <button type="button" class="btn btn-sm btn-outline-danger mt-2" onclick="removeSignature()">
                                                <i class="fas fa-trash me-1"></i>Remove
                                            </button>
                                        </div>
                                    </div>
                                    <div class="invalid-feedback">
                                        Please upload your signature image.
                                    </div>
                                </div>
                            </div>

                            <!-- Passport Details -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="text-primary mb-3">
                                        <i class="fas fa-passport me-2"></i>Passport Details
                                    </h5>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="processingType" class="form-label">Processing Type *</label>
                                    <select class="form-select" id="processingType" name="processingType" required onchange="updateBiometricDates()">
                                        <option value="">Select Processing Type</option>
                                        <option value="regular">Regular (7-10 days)</option>
                                        <option value="express">Express (3-5 days)</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a processing type.
                                    </div>
                                </div>
                            </div>

                            <!-- Biometric Booking -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h5 class="text-primary mb-3">
                                        <i class="fas fa-fingerprint me-2"></i>Biometric Appointment Booking
                                    </h5>
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <strong>Note:</strong> Biometric appointment is mandatory for passport processing.
                                        <span id="biometricNote">Please select a processing type first.</span>
                                    </div>
                                    <div class="alert alert-warning">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        <strong>Important:</strong>
                                        <ul class="mb-0 mt-2">
                                            <li><strong>Express Processing:</strong> Only 2 days available for booking (next 2 days)</li>
                                            <li><strong>Regular Processing:</strong> Can only book on 4th or 5th day from applying</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="biometricDate" class="form-label">Preferred Date *</label>
                                    <input type="date" class="form-control" id="biometricDate" name="biometricDate" required disabled>
                                    <div class="invalid-feedback">
                                        Please select a preferred date for biometric appointment.
                                    </div>
                                    <small class="text-muted" id="dateRangeInfo"></small>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="biometricTime" class="form-label">Preferred Time *</label>
                                    <select class="form-select" id="biometricTime" name="biometricTime" required disabled>
                                        <option value="">Select Time Slot</option>
                                        <option value="09:00">09:00 AM</option>
                                        <option value="10:00">10:00 AM</option>
                                        <option value="11:00">11:00 AM</option>
                                        <option value="12:00">12:00 PM</option>
                                        <option value="14:00">02:00 PM</option>
                                        <option value="15:00">03:00 PM</option>
                                        <option value="16:00">04:00 PM</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a preferred time for biometric appointment.
                                    </div>
                                </div>
                                <div class="col-12 mb-3">
                                    <div class="card bg-light border-0">
                                        <div class="card-body">
                                            <h6 class="card-title text-primary">
                                                <i class="fas fa-calendar-check me-2"></i>Available Time Slots
                                            </h6>
                                            <div id="availableSlots" class="d-flex flex-wrap gap-2">
                                                <!-- Available slots will be populated dynamically -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>



                            <!-- Terms and Conditions -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="termsCheck" required>
                                        <label class="form-check-label" for="termsCheck">
                                            I agree to the <a href="#" class="text-primary">Terms and Conditions</a> and
                                            <a href="#" class="text-primary">Privacy Policy</a> *
                                        </label>
                                        <div class="invalid-feedback">
                                            You must agree before submitting.
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Submit Buttons -->
                            <div class="row">
                                <div class="col-12 text-center">
                                    <button type="submit" class="btn btn-primary btn-lg me-3">
                                        <i class="fas fa-paper-plane me-2"></i>Submit Application
                                    </button>
                                    <button type="reset" class="btn btn-outline-secondary btn-lg">
                                        <i class="fas fa-undo me-2"></i>Reset Form
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

<!-- Form Validation Script -->
<script>
    // Check authentication status
    function checkAuth() {
        const savedUser = localStorage.getItem('lankaEpassportUser');
        if (!savedUser) {
            // Not authenticated - allow viewing with example data but disable submission
            setGuestMode();
            return;
        }

        // User is authenticated, show user info
        const user = JSON.parse(savedUser);
        const userInfoCard = document.getElementById('userInfoCard');
        const userInfoText = document.getElementById('userInfoText');

        if (userInfoCard && userInfoText) {
            userInfoText.textContent = `Signed in as: ${user.name} (${user.email})`;
            userInfoCard.style.display = 'block';
        }

        // Pre-fill form with user data if available
        if (user.firstName) {
            document.getElementById('firstName').value = user.firstName;
        }
        if (user.lastName) {
            document.getElementById('lastName').value = user.lastName;
        }
        if (user.nicNumber) {
            document.getElementById('nic').value = user.nicNumber;
        }
        if (user.dateOfBirth) {
            // Validate the user's date of birth to ensure it's over 18
            const userDob = new Date(user.dateOfBirth);
            const today = new Date();
            let age = today.getFullYear() - userDob.getFullYear();
            const monthDiff = today.getMonth() - userDob.getMonth();

            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < userDob.getDate())) {
                age--;
            }

            if (age >= 18) {
                document.getElementById('dob').value = user.dateOfBirth;
            } else {
                console.log('User DOB from localStorage is under 18, not auto-filling');
            }
        }
        if (user.email) {
            document.getElementById('email').value = user.email;
        }
        if (user.address) {
            document.getElementById('address').value = user.address;
        }
        if (user.city) {
            document.getElementById('city').value = user.city;
        }
        if (user.postalCode) {
            document.getElementById('postalCode').value = user.postalCode;
        }
    }

    // Set guest mode - read-only with example data
    function setGuestMode() {
        // Show guest info card
        const userInfoCard = document.getElementById('userInfoCard');
        const userInfoText = document.getElementById('userInfoText');

        if (userInfoCard && userInfoText) {
            userInfoText.innerHTML = `
                <div class="alert alert-info mb-2">
                    <i class="fas fa-info-circle me-2"></i>
                    <strong>Viewing Mode:</strong> You are viewing a sample application form.
                    <a href="<%= request.getContextPath() %>/index.jsp" class="alert-link">Sign in</a> to submit your own application.
                </div>
            `;
            userInfoCard.style.display = 'block';
        }

        // Disable all form inputs
        const formInputs = document.querySelectorAll('#passportForm input, #passportForm textarea, #passportForm select');
        formInputs.forEach(input => {
            input.disabled = true;
            input.style.opacity = '0.6';
        });

        // Hide submit buttons and show login prompt
        const submitButtons = document.querySelectorAll('#passportForm button[type="submit"], #passportForm button[type="reset"]');
        submitButtons.forEach(button => {
            button.style.display = 'none';
        });

        // Add login button
        const buttonContainer = document.querySelector('#passportForm .row:last-child .col-12.text-center');
        if (buttonContainer) {
            buttonContainer.innerHTML = `
                <div class="alert alert-warning">
                    <i class="fas fa-lock me-2"></i>
                    <strong>Login Required:</strong> Please sign in to submit an application.
                    <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-primary btn-sm ms-2">
                        <i class="fas fa-sign-in-alt me-1"></i>Sign In
                    </a>
                </div>
            `;
        }

        // Disable file upload areas
        const uploadAreas = document.querySelectorAll('.upload-area');
        uploadAreas.forEach(area => {
            area.style.pointerEvents = 'none';
            area.style.opacity = '0.6';
        });
    }

    // Logout function
    async function logout() {
        try {
            const response = await fetch('<%= request.getContextPath() %>/api/logout', {
                method: 'POST'
            });
            // Even if it fails, proceed with client-side logout
        } catch (error) {
            console.error('Logout error:', error);
        }

        localStorage.removeItem('lankaEpassportUser');
        showNotification('Logged out successfully', 'success');
        setTimeout(() => {
            window.location.href = '<%= request.getContextPath() %>/index.jsp';
        }, 1500);
    }

    // Check for edit application parameter
    async function checkForEditApplication() {
        const urlParams = new URLSearchParams(window.location.search);
        const editId = urlParams.get('edit');
        if (editId) {
            try {
                const response = await fetch(basePath + `/api/applications?id=${editId}`);
                if (response.ok) {
                    const application = await response.json();
                    populateFormForEdit(application);
                    showNotification('Editing application. Make your changes and submit.', 'info');
                } else if (response.status === 404) {
                    showNotification('Application not found.', 'error');
                } else {
                    showNotification('Failed to load application for editing.', 'error');
                }
            } catch (error) {
                console.error('Error checking for edit application:', error);
                showNotification('Failed to load application for editing.', 'error');
            }
        }
    }

    function populateFormForEdit(application) {
        // Populate personal information
        document.getElementById('firstName').value = application.firstName || '';
        document.getElementById('lastName').value = application.lastName || '';
        document.getElementById('nic').value = application.nicNumber || '';
        document.getElementById('dob').value = application.dateOfBirth || '';
        document.getElementById('email').value = application.email || '';

        // Populate address
        const addressParts = application.address ? application.address.split(', ') : [];
        document.getElementById('address').value = addressParts[0] || '';
        document.getElementById('city').value = addressParts[1] || '';

        // Populate appointment date
        document.getElementById('biometricDate').value = application.appointmentDate || '';

        // Store application ID for update
        document.getElementById('passportForm').setAttribute('data-edit-id', application.applicationId);

        // Change submit button text
        const submitBtn = document.querySelector('#passportForm button[type="submit"]');
        if (submitBtn) {
            submitBtn.innerHTML = '<i class="fas fa-save me-2"></i>Update Application';
        }
    }

    // Check if user already has an application
    async function checkExistingApplication() {
        const savedUser = localStorage.getItem('lankaEpassportUser');
        if (!savedUser) return;

        const user = JSON.parse(savedUser);
        if (!user.nicNumber) return;

        try {
            const basePath = '<%= request.getContextPath() %>' || '';
            const response = await fetch(`${basePath}/api/applications?nic=${user.nicNumber}`);

            if (response.ok) {
                const applications = await response.json();
                if (applications.length > 0) {
                    // User already has an application, redirect to edit page
                    const application = applications[0];
                    showNotification('You already have a passport application. Redirecting to update your application...', 'info');
                    setTimeout(() => {
                        window.location.href = `<%= request.getContextPath() %>/application.jsp?edit=${application.applicationId}`;
                    }, 2000);
                    return true;
                }
            }
        } catch (error) {
            console.error('Error checking existing application:', error);
        }
        return false;
    }

    // Check auth when page loads
    document.addEventListener('DOMContentLoaded', async function() {
        fillDefaultValues();
        checkAuth();

        // Check if user already has an application before proceeding
        const hasExisting = await checkExistingApplication();
        if (!hasExisting) {
            checkForEditApplication();
            setupFormPersistence();
        }
    });

    // Setup form persistence - save data as user types
    function setupFormPersistence() {
        const formFields = [
            'firstName', 'lastName', 'nic', 'dob', 'email',
            'address', 'city', 'postalCode', 'processingType',
            'biometricDate', 'biometricTime'
        ];

        formFields.forEach(fieldId => {
            const element = document.getElementById(fieldId);
            if (element) {
                element.addEventListener('input', saveFormData);
                element.addEventListener('change', saveFormData);
            }
        });
    }

    // Fill default/example values for better UX
    function fillDefaultValues() {
        // First, try to restore saved form data from sessionStorage
        restoreFormData();

        // Only fill example values if user is not logged in and no saved data exists
        const savedUser = localStorage.getItem('lankaEpassportUser');
        const isLoggedIn = savedUser && JSON.parse(savedUser);
        const savedFormData = sessionStorage.getItem('passportApplicationForm');

        if (!isLoggedIn && !savedFormData) {
            const firstName = document.getElementById('firstName');
            const lastName = document.getElementById('lastName');
            const email = document.getElementById('email');
            const address = document.getElementById('address');
            const city = document.getElementById('city');
            const nic = document.getElementById('nic');
            const dob = document.getElementById('dob');

            // Fill with example values if fields are empty (ensure valid age)
            if (!firstName.value) firstName.value = 'John';
            if (!lastName.value) lastName.value = 'Doe';
            if (!email.value) email.value = 'john.doe@example.com';
            if (!address.value) address.value = '123 Main Street, Colombo 01';
            if (!city.value) city.value = 'Colombo';
            if (!nic.value) nic.value = '123456789012';
            if (!dob.value) {
                // Set example date that ensures user is over 18 (25 years ago)
                const exampleDate = new Date();
                exampleDate.setFullYear(exampleDate.getFullYear() - 25);
                dob.value = exampleDate.toISOString().split('T')[0];
            }
        }
    }

    // Save form data to sessionStorage as user types
    function saveFormData() {
        const formData = {
            firstName: document.getElementById('firstName')?.value || '',
            lastName: document.getElementById('lastName')?.value || '',
            nic: document.getElementById('nic')?.value || '',
            dob: document.getElementById('dob')?.value || '',
            email: document.getElementById('email')?.value || '',
            address: document.getElementById('address')?.value || '',
            city: document.getElementById('city')?.value || '',
            postalCode: document.getElementById('postalCode')?.value || '',
            processingType: document.getElementById('processingType')?.value || '',
            biometricDate: document.getElementById('biometricDate')?.value || '',
            biometricTime: document.getElementById('biometricTime')?.value || ''
        };
        sessionStorage.setItem('passportApplicationForm', JSON.stringify(formData));
    }

    // Restore form data from sessionStorage
    function restoreFormData() {
        const savedData = sessionStorage.getItem('passportApplicationForm');
        if (savedData) {
            try {
                const formData = JSON.parse(savedData);
                Object.keys(formData).forEach(key => {
                    const element = document.getElementById(key);
                    if (element && formData[key]) {
                        element.value = formData[key];
                    }
                });
            } catch (error) {
                console.error('Error restoring form data:', error);
                sessionStorage.removeItem('passportApplicationForm');
            }
        }
    }

    // Clear saved form data after successful submission
    function clearSavedFormData() {
        sessionStorage.removeItem('passportApplicationForm');
    }

    // Enhanced Form validation
    document.getElementById('passportForm').addEventListener('submit', async function(event) {
        event.preventDefault();

        const formEl = this;

        // Validate all required fields
        const isValid = validateForm();
        this.classList.add('was-validated');

        if (!isValid) {
            showNotification('Please correct the errors in the form before submitting.', 'error');
            return;
        }

        // Resolve context path for correct API base regardless of deployment path
        const basePath = '<%= request.getContextPath() %>' || '';

        const editId = this.getAttribute('data-edit-id');
        const isEdit = editId !== null;

        // Create FormData for multipart submission
        const formData = new FormData();

        // Add form fields with validation
        const firstName = document.getElementById('firstName')?.value?.trim() || '';
        const lastName = document.getElementById('lastName')?.value?.trim() || '';
        const nic = document.getElementById('nic')?.value?.trim() || '';
        const dob = document.getElementById('dob')?.value || '';
        const email = document.getElementById('email')?.value?.trim() || '';
        const address = document.getElementById('address')?.value?.trim() || '';
        const city = document.getElementById('city')?.value?.trim() || '';
        const postalCode = document.getElementById('postalCode')?.value?.trim() || '';
        const processingType = document.getElementById('processingType')?.value || '';
        const biometricDate = document.getElementById('biometricDate')?.value || '';
        const biometricTime = document.getElementById('biometricTime')?.value || '';

        // Validate required fields before sending
        if (!firstName || !lastName || !nic || !dob || !email || !address || !city || !processingType || !biometricDate) {
            showNotification('Please fill in all required fields before submitting.', 'error');
            return;
        }

        formData.append('firstName', firstName);
        formData.append('lastName', lastName);
        formData.append('nic', nic);
        formData.append('dob', dob);
        formData.append('email', email);
        formData.append('address', address);
        formData.append('city', city);
        formData.append('postalCode', postalCode);
        formData.append('processingType', processingType);
        formData.append('biometricDate', biometricDate);
        formData.append('biometricTime', biometricTime);
        formData.append('notes', 'Application submitted via web form');

        // Add file uploads
        const passportPhoto = document.getElementById('passportPhoto').files[0];
        const birthCertificate = document.getElementById('birthCertificate').files[0];
        const addressProof = document.getElementById('addressProof').files[0];
        const signature = document.getElementById('signature').files[0];

        if (passportPhoto) formData.append('passportPhoto', passportPhoto);
        if (birthCertificate) formData.append('birthCertificate', birthCertificate);
        if (addressProof) formData.append('addressProof', addressProof);
        if (signature) formData.append('signature', signature);

        try {
            console.log('Submitting form data...');
            console.log('Form Data Contents:');
            for (let pair of formData.entries()) {
                console.log(pair[0] + ': ' + pair[1]);
            }

            const apiUrl = isEdit ? `${basePath}/api/applications?id=${editId}` : `${basePath}/api/applications`;
            console.log('API URL:', apiUrl);

            const res = await fetch(apiUrl, {
                method: isEdit ? 'PUT' : 'POST',
                body: formData // No Content-Type header needed for FormData
            });

            console.log('Response status:', res.status);

            if (res.ok) {
                const message = isEdit ? 'Application updated successfully!' : 'Successfully submitted!';
                showNotification(message, 'success');

                // Update localStorage with the submitted data for future auto-fill
                if (!isEdit) {
                    const savedUser = localStorage.getItem('lankaEpassportUser');
                    if (savedUser) {
                        const user = JSON.parse(savedUser);
                        user.firstName = document.getElementById('firstName')?.value || user.firstName;
                        user.lastName = document.getElementById('lastName')?.value || user.lastName;
                        user.dateOfBirth = document.getElementById('dob')?.value || user.dateOfBirth;
                        user.address = document.getElementById('address')?.value || user.address;
                        user.city = document.getElementById('city')?.value || user.city;
                        user.postalCode = document.getElementById('postalCode')?.value || user.postalCode;
                        localStorage.setItem('lankaEpassportUser', JSON.stringify(user));
                    }
                    // Clear session-stored form data after successful submission
                    clearSavedFormData();
                }

                // Redirect to view page
                if (isEdit) {
                    window.location.href = `<%= request.getContextPath() %>/view.jsp?id=${editId}`;
                } else {
                    window.location.href = '<%= request.getContextPath() %>/applications.jsp';
                }
            } else {
                let errorMessage = 'Please try again.';
                try {
                    const errorData = await res.json();
                    if (errorData && errorData.error) {
                        errorMessage = errorData.error;
                    }
                } catch (jsonError) {
                    const text = await res.text();
                    if (text) {
                        errorMessage = text;
                    }
                }
                console.error('Submission failed', res.status, errorMessage);
                showNotification(`Submission failed (${res.status}): ${errorMessage}`, 'error');
            }
        } catch (err) {
            console.error('Network error submitting application', err);
            showNotification('Network error submitting application. Please try again.', 'error');
        }
    });

    // Comprehensive form validation function
    function validateForm() {
        let isValid = true;
        console.log('Validating form...');

        // Validate NIC
        const nic = document.getElementById('nic').value;
        console.log('NIC value:', nic);
        const newNicPattern = /^\d{12}$/;
        const oldNicPattern = /^\d{9}[Vv]$/;
        if (!newNicPattern.test(nic) && !oldNicPattern.test(nic)) {
            console.log('NIC validation failed');
            document.getElementById('nic').classList.add('is-invalid');
            isValid = false;
        } else {
            console.log('NIC validation passed');
        }


        // Validate Date of Birth with accurate age requirement
        const dob = document.getElementById('dob').value;
        if (dob) {
            const dobDate = new Date(dob + 'T00:00:00'); // Ensure start of day
            const today = new Date();

            console.log('DOB validation - Input:', dob);
            console.log('DOB validation - Parsed date:', dobDate);
            console.log('DOB validation - Today:', today);

            // Check if date is in future
            if (dobDate > today) {
                console.log('DOB validation failed: Future date');
                document.getElementById('dob').classList.add('is-invalid');
                isValid = false;
            } else {
                // Calculate age accurately
                let age = today.getFullYear() - dobDate.getFullYear();
                const monthDiff = today.getMonth() - dobDate.getMonth();

                // Adjust age if birthday hasn't occurred this year
                if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dobDate.getDate())) {
                    age--;
                }

                console.log('DOB validation - Calculated age:', age);

                if (age < 18) {
                    console.log('DOB validation failed: Under 18 years old (age: ' + age + ')');
                    document.getElementById('dob').classList.add('is-invalid');
                    isValid = false;
                } else if (age > 100) {
                    console.log('DOB validation failed: Over 100 years old (age: ' + age + ')');
                    document.getElementById('dob').classList.add('is-invalid');
                    isValid = false;
                } else {
                    console.log('DOB validation passed (age: ' + age + ')');
                }
            }
        } else {
            console.log('DOB validation failed: Empty field');
            document.getElementById('dob').classList.add('is-invalid');
            isValid = false;
        }

        // Validate other required fields
        const requiredFields = ['firstName', 'lastName', 'email', 'address', 'city'];
        requiredFields.forEach(fieldId => {
            const field = document.getElementById(fieldId);
            if (!field.value.trim()) {
                console.log(`Required field ${fieldId} is empty`);
                field.classList.add('is-invalid');
                isValid = false;
            }
        });

        console.log('Form validation result:', isValid);
        return isValid;
    }

    // Enhanced NIC validation
    document.getElementById('nic').addEventListener('input', function() {
        const nic = this.value.toUpperCase().trim();
        this.value = nic; // Auto-capitalize and trim

        const newNicPattern = /^\d{12}$/;
        const oldNicPattern = /^\d{9}[V]$/;

        if (nic.length === 0) {
            this.setCustomValidity('');
            this.classList.remove('is-valid', 'is-invalid');
        } else if (newNicPattern.test(nic) || oldNicPattern.test(nic)) {
            this.setCustomValidity('');
            this.classList.remove('is-invalid');
            this.classList.add('is-valid');
        } else {
            this.setCustomValidity('Please enter a valid NIC: 12 digits or 9 digits followed by V.');
            this.classList.remove('is-valid');
            this.classList.add('is-invalid');
        }
    });


    // Postal Code validation - only allow digits
    document.getElementById('postalCode').addEventListener('input', function() {
        const postalCode = this.value;
        
        // Remove any non-digit characters
        const digitsOnly = postalCode.replace(/[^0-9]/g, '');
        this.value = digitsOnly;
        
        // Validate if field has content
        if (postalCode.length === 0) {
            this.setCustomValidity('');
            this.classList.remove('is-valid', 'is-invalid');
        } else if (/^[0-9]+$/.test(postalCode)) {
            this.setCustomValidity('');
            this.classList.remove('is-invalid');
            this.classList.add('is-valid');
        } else {
            this.setCustomValidity('Postal code must contain only digits.');
            this.classList.remove('is-valid');
            this.classList.add('is-invalid');
        }
    });

    // Enhanced Date of Birth validation with age requirement
    document.getElementById('dob').addEventListener('change', function() {
        const dobValue = this.value;

        if (dobValue === '') {
            this.setCustomValidity('');
            this.classList.remove('is-valid', 'is-invalid');
            return;
        }

        const dob = new Date(dobValue + 'T00:00:00'); // Ensure start of day
        const today = new Date();

        console.log('Real-time DOB validation - Input:', dobValue);
        console.log('Real-time DOB validation - Parsed date:', dob);
        console.log('Real-time DOB validation - Today:', today);

        // Check if date is in future
        if (dob > today) {
            this.setCustomValidity('Date of birth cannot be in the future');
            this.classList.remove('is-valid');
            this.classList.add('is-invalid');
            return;
        }

        // Calculate age accurately
        let age = today.getFullYear() - dob.getFullYear();
        const monthDiff = today.getMonth() - dob.getMonth();

        // Adjust age if birthday hasn't occurred this year
        if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
            age--;
        }

        console.log('Real-time DOB validation - Calculated age:', age);

        if (age < 18) {
            this.setCustomValidity('You must be at least 18 years old to apply for a passport');
            this.classList.remove('is-valid');
            this.classList.add('is-invalid');
        } else if (age > 100) {
            this.setCustomValidity('Please enter a valid date of birth (not more than 100 years old)');
            this.classList.remove('is-valid');
            this.classList.add('is-invalid');
        } else {
            this.setCustomValidity('');
            this.classList.remove('is-invalid');
            this.classList.add('is-valid');
        }
    });

    // Real-time validation feedback
    function addValidationFeedback(fieldId, message, isValid) {
        const field = document.getElementById(fieldId);
        const feedback = field.parentNode.querySelector('.validation-feedback');

        if (feedback) {
            feedback.remove();
        }

        const feedbackDiv = document.createElement('div');
        feedbackDiv.className = `validation-feedback ${isValid ? 'valid-feedback' : 'invalid-feedback'}`;
        feedbackDiv.textContent = message;

        field.parentNode.appendChild(feedbackDiv);
    }

    // Notification function (if not already defined)
    function showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `alert alert-${type == 'error' ? 'danger' : type} alert-dismissible fade show position-fixed`;
        notification.style.cssText = 'top: 100px; right: 20px; z-index: 9999; min-width: 300px;';
        notification.innerHTML = `
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;

        document.body.appendChild(notification);

        // Auto-remove after 5 seconds
        setTimeout(() => {
            if (notification.parentNode) {
                notification.remove();
            }
        }, 5000);
    }

    // Document Upload Functions
    document.getElementById('passportPhoto').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            if (file.size > 2 * 1024 * 1024) { // 2MB limit
                showNotification('Photo file size must be less than 2MB', 'error');
                this.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('photoPreviewImg').src = e.target.result;
                document.getElementById('photoPreview').style.display = 'block';
                document.querySelector('#photoUploadArea .upload-placeholder').style.display = 'none';
            };
            reader.readAsDataURL(file);
        }
    });

    document.getElementById('birthCertificate').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            if (file.size > 5 * 1024 * 1024) { // 5MB limit
                showNotification('PDF file size must be less than 5MB', 'error');
                this.value = '';
                return;
            }

            if (!file.type.includes('pdf')) {
                showNotification('Please upload a PDF file', 'error');
                this.value = '';
                return;
            }

            document.getElementById('certificateFileName').textContent = file.name;
            document.getElementById('certificatePreview').style.display = 'block';
            document.querySelector('#certificateUploadArea .upload-placeholder').style.display = 'none';
        }
    });

    function removePhoto() {
        document.getElementById('passportPhoto').value = '';
        document.getElementById('photoPreview').style.display = 'none';
        document.querySelector('#photoUploadArea .upload-placeholder').style.display = 'block';
    }

    function removeCertificate() {
        document.getElementById('birthCertificate').value = '';
        document.getElementById('certificatePreview').style.display = 'none';
        document.querySelector('#certificateUploadArea .upload-placeholder').style.display = 'block';
    }

    document.getElementById('addressProof').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            if (file.size > 5 * 1024 * 1024) { // 5MB limit
                showNotification('PDF file size must be less than 5MB', 'error');
                this.value = '';
                return;
            }

            if (!file.type.includes('pdf')) {
                showNotification('Please upload a PDF file', 'error');
                this.value = '';
                return;
            }

            document.getElementById('addressProofFileName').textContent = file.name;
            document.getElementById('addressProofPreview').style.display = 'block';
            document.querySelector('#addressProofUploadArea .upload-placeholder').style.display = 'none';
        }
    });

    document.getElementById('signature').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            if (file.size > 2 * 1024 * 1024) { // 2MB limit
                showNotification('Signature file size must be less than 2MB', 'error');
                this.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('signaturePreviewImg').src = e.target.result;
                document.getElementById('signaturePreview').style.display = 'block';
                document.querySelector('#signatureUploadArea .upload-placeholder').style.display = 'none';
            };
            reader.readAsDataURL(file);
        }
    });

    function removeAddressProof() {
        document.getElementById('addressProof').value = '';
        document.getElementById('addressProofPreview').style.display = 'none';
        document.querySelector('#addressProofUploadArea .upload-placeholder').style.display = 'block';
    }

    function removeSignature() {
        document.getElementById('signature').value = '';
        document.getElementById('signaturePreview').style.display = 'none';
        document.querySelector('#signatureUploadArea .upload-placeholder').style.display = 'block';
    }

    // Biometric Booking Functions
    function updateBiometricDates() {
        const processingType = document.getElementById('processingType').value;
        const biometricDate = document.getElementById('biometricDate');
        const biometricTime = document.getElementById('biometricTime');
        const biometricNote = document.getElementById('biometricNote');
        const dateRangeInfo = document.getElementById('dateRangeInfo');

        if (!processingType) {
            biometricDate.disabled = true;
            biometricTime.disabled = true;
            biometricNote.textContent = 'Please select a processing type first.';
            dateRangeInfo.textContent = '';
            return;
        }

        // Enable date and time selection
        biometricDate.disabled = false;
        biometricTime.disabled = false;

        // Set date restrictions based on processing type
        const today = new Date();
        let minDate = new Date();
        let maxDate = new Date();

        if (processingType === 'express') {
            // Express: Only 2 days to select from (next 2 days)
            minDate.setDate(today.getDate() + 2);
            maxDate.setDate(today.getDate() + 3);
            biometricNote.textContent = 'Express processing: You can select from next 2 days only.';
            dateRangeInfo.textContent = 'Available dates: Next 2 days only (limited selection)';
        } else {
            // Regular: Can only book on 4th or 5th day from applying (after 3 days delay)
            minDate.setDate(today.getDate() + 4);
            maxDate.setDate(today.getDate() + 5);
            biometricNote.textContent = 'Regular processing: You can only book on 4th or 5th day from applying.';
            dateRangeInfo.textContent = 'Available dates: 4th and 5th day from applying only';
        }

        // Format dates for input min/max attributes
        const minDateStr = minDate.toISOString().split('T')[0];
        const maxDateStr = maxDate.toISOString().split('T')[0];

        biometricDate.min = minDateStr;
        biometricDate.max = maxDateStr;

        // Update available time slots
        updateAvailableTimeSlots();
    }

    function updateAvailableTimeSlots() {
        const availableSlots = document.getElementById('availableSlots');
        const timeSlots = [
            { time: '09:00', label: '09:00 AM' },
            { time: '10:00', label: '10:00 AM' },
            { time: '11:00', label: '11:00 AM' },
            { time: '12:00', label: '12:00 PM' },
            { time: '14:00', label: '02:00 PM' },
            { time: '15:00', label: '03:00 PM' },
            { time: '16:00', label: '04:00 PM' }
        ];

        availableSlots.innerHTML = '';

        timeSlots.forEach(slot => {
            const slotElement = document.createElement('div');
            slotElement.className = 'time-slot available';
            slotElement.textContent = slot.label;
            slotElement.onclick = function() {
                // Remove previous selection
                document.querySelectorAll('.time-slot.selected').forEach(el => el.classList.remove('selected'));
                // Select this slot
                this.classList.add('selected');
                document.getElementById('biometricTime').value = slot.time;
            };
            availableSlots.appendChild(slotElement);
        });
    }

    // Initialize biometric booking
    document.addEventListener('DOMContentLoaded', function() {
        updateBiometricDates();

        // Set date restrictions for Date of Birth field
        setDateRestrictions();
    });

    // Set date restrictions for Date of Birth
    function setDateRestrictions() {
        const dobField = document.getElementById('dob');
        if (dobField) {
            const today = new Date();

            // Set max date to today (cannot select future dates)
            const maxDate = new Date(today.getTime() - (24 * 60 * 60 * 1000)); // Yesterday to be safe
            dobField.max = maxDate.toISOString().split('T')[0];

            // Set min date to approximately 100 years ago (reasonable limit)
            const minDate = new Date(today.getFullYear() - 100, today.getMonth(), today.getDate());
            dobField.min = minDate.toISOString().split('T')[0];

            console.log('Date restrictions set:', {
                max: dobField.max,
                min: dobField.min,
                today: today.toISOString().split('T')[0]
            });
        }
    }
    
    // Handle form submission
    function submitForm(event) {
        event.preventDefault();
        
        const form = document.getElementById('passportForm');
        
        // Check form validity
        if (!form.checkValidity()) {
            event.stopPropagation();
            form.classList.add('was-validated');
            return false;
        }
        
        // Create FormData object
        const formData = new FormData(form);
        
        // Submit form using fetch API
        fetch(form.action, {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.applicationId) {
                // Success message
                Swal.fire({
                    title: 'Success!',
                    text: 'Your application has been submitted successfully. Application ID: ' + data.applicationId,
                    icon: 'success',
                    confirmButtonText: 'OK'
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Redirect to applications page
                        window.location.href = '${pageContext.request.contextPath}/applications.jsp';
                    }
                });
            } else {
                // Error message
                Swal.fire({
                    title: 'Error!',
                    text: data.error || 'Failed to submit application. Please try again.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            }
        })
        .catch(error => {
            // Network or other error
            Swal.fire({
                title: 'Error!',
                text: 'An unexpected error occurred. Please try again later.',
                icon: 'error',
                confirmButtonText: 'OK'
            });
            console.error('Error:', error);
        });
        
        return false;
    }
</script>

<!-- SweetAlert2 for beautiful popups -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11">    </script>
    <jsp:include page="includes/footer.jsp" />
</body>
</html>