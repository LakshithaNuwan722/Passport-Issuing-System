<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Lanka Epassport Service</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Government Style CSS -->
    <link rel="stylesheet" href="assets/css/government-style.css">

    <style>
        .login-container {
            min-height: calc(100vh - 200px);
            padding: 2rem 0;
        }
        .login-card {
            border: 2px solid var(--gov-border);
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .login-header {
            background: linear-gradient(135deg, var(--gov-primary) 0%, var(--gov-secondary) 100%);
            border-radius: 8px 8px 0 0;
            color: white;
            border-bottom: 3px solid var(--gov-accent);
        }
        .btn-login {
            background: var(--gov-primary);
            border: none;
            border-radius: 4px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.2s ease;
        }
        .btn-login:hover {
            background: var(--gov-secondary);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        .login-footer {
            background: var(--gov-light);
            border-top: 2px solid var(--gov-border);
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="container login-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-4 col-lg-5 col-md-6 col-sm-8">
                    <div class="card login-card">
                        <div class="card-header login-header text-center py-4">
                            <h3 class="mb-2">
                                <i class="fas fa-passport me-2"></i>Lanka Epassport Service
                            </h3>
                            <p class="mb-0 opacity-75">Welcome back! Please sign in to your account</p>
                        </div>

                        <div class="card-body p-4">
                            <!-- Error Message -->
                            <div id="loginError" class="alert alert-danger d-none mb-3">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <span id="errorMessage"></span>
                            </div>

                            <!-- Success Message -->
                            <div id="loginSuccess" class="alert alert-success d-none mb-3">
                                <i class="fas fa-check-circle me-2"></i>
                                <span id="successMessage"></span>
                            </div>

                            <form id="loginForm" onsubmit="handleLogin(event)">
                                <div class="mb-3">
                                    <label for="username" class="form-label fw-semibold">
                                        <i class="fas fa-user me-2"></i>Username
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-user text-muted"></i>
                                        </span>
                                        <input type="text"
                                               class="form-control"
                                               id="username"
                                               name="username"
                                               placeholder="Enter your username"
                                               required
                                               autocomplete="username">
                                    </div>
                                    <!-- Default username indicator -->
                                    <div id="usernameHelp" class="form-text" style="display: none;">
                                        <i class="fas fa-info-circle me-1"></i>
                                        <span id="usernameHelpText"></span>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="password" class="form-label fw-semibold">
                                        <i class="fas fa-lock me-2"></i>Password
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light">
                                            <i class="fas fa-lock text-muted"></i>
                                        </span>
                                        <input type="password"
                                               class="form-control"
                                               id="password"
                                               name="password"
                                               placeholder="Enter your password"
                                               required
                                               autocomplete="current-password">
                                    </div>
                                </div>

                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                                    <label class="form-check-label" for="rememberMe">
                                        Remember me
                                    </label>
                                </div>

                                <button type="submit" class="btn btn-login w-100 mb-3" id="loginBtn">
                                    <i class="fas fa-sign-in-alt me-2"></i>Sign In
                                </button>

                                <div class="text-center">
                                    <a href="forgot-password.jsp" class="text-decoration-none">
                                        Forgot your password?
                                    </a>
                                </div>
                            </form>
                        </div>

                        <div class="card-footer login-footer text-center py-3">
                            <small class="text-muted">
                                Don't have an account?
                                <a href="register.jsp" class="text-decoration-none fw-semibold">Sign up here</a>
                            </small>
                        </div>
                    </div>

                    <!-- Quick Access Links -->
                    <div class="text-center mt-4">
                        <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-home me-2"></i>Back to Home
                        </a>
                        <a href="<%= request.getContextPath() %>/staff-login.jsp" class="btn btn-outline-primary btn-sm ms-2">
                            <i class="fas fa-user-tie me-2"></i>Staff Login
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script>
        // Get section parameter from URL
        function getSectionFromURL() {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get('section') || 'general';
        }

        // Update login form based on section (display purposes only)
        function updateLoginForm(section) {
            const sectionInfo = {
                'application': {
                    title: 'Application Section Login',
                    subtitle: 'Process passport applications and manage status',
                    buttonText: 'Login to Application Section',
                    buttonClass: 'btn-primary',
                    apiEndpoint: 'api/staff-login',
                    defaultUsername: 'staff_application'
                },
                'payment': {
                    title: 'Payment Section Login',
                    subtitle: 'Handle payment processing and transactions',
                    buttonText: 'Login to Payment Section',
                    buttonClass: 'btn-success',
                    apiEndpoint: 'api/staff-login',
                    defaultUsername: 'staff_payment'
                },
                'print': {
                    title: 'Print Section Login',
                    subtitle: 'Manage passport printing and quality control',
                    buttonText: 'Login to Print Section',
                    buttonClass: 'btn-secondary',
                    apiEndpoint: 'api/staff-login',
                    defaultUsername: 'staff_print'
                },
                'logistic': {
                    title: 'Logistic Service Login',
                    subtitle: 'Manage passport delivery and tracking',
                    buttonText: 'Login to Logistic Service',
                    buttonClass: 'btn-warning',
                    apiEndpoint: 'api/staff-login',
                    defaultUsername: 'staff_logistic'
                },
                'helpdesk': {
                    title: 'Help Desk Login',
                    subtitle: 'Provide customer support and resolve inquiries',
                    buttonText: 'Login to Help Desk',
                    buttonClass: 'btn-info',
                    apiEndpoint: 'api/staff-login',
                    defaultUsername: 'staff_helpdesk'
                },
                'general': {
                    title: 'Login - Lanka Epassport Service',
                    subtitle: 'Welcome back! Please sign in to your account',
                    buttonText: 'Sign In',
                    buttonClass: 'btn-login',
                    apiEndpoint: 'api/login',
                    defaultUsername: ''
                }
            };

            const info = sectionInfo[section] || sectionInfo['general'];

            // Update page title
            document.title = info.title + ' - Lanka Epassport Service';

            // Update header
            document.querySelector('.login-header h3').innerHTML =
                `<i class="fas fa-passport me-2"></i>${info.title}`;
            document.querySelector('.login-header p').textContent = info.subtitle;

            // Update button
            const loginBtn = document.getElementById('loginBtn');
            loginBtn.innerHTML = `<i class="fas fa-sign-in-alt me-2"></i>${info.buttonText}`;
            loginBtn.className = `btn w-100 mb-3 ${info.buttonClass}`;

            // Pre-fill username field with default username
            const usernameField = document.getElementById('username');
            if (usernameField && info.defaultUsername) {
                usernameField.value = info.defaultUsername;
                usernameField.style.backgroundColor = '#fff3cd'; // Light yellow background
                usernameField.style.borderColor = '#ffc107'; // Warning color border
                usernameField.title = 'Default username pre-filled. You can change it if needed.';

                // Show help text with default credentials
                const helpDiv = document.getElementById('usernameHelp');
                const helpText = document.getElementById('usernameHelpText');

                // Get default password for the section
                const defaultPasswords = {
                    'application': '111',
                    'payment': '222',
                    'print': '333',
                    'logistic': '444',
                    'helpdesk': '555'
                };

                const defaultPassword = defaultPasswords[section] || '';
                if (defaultPassword) {
                    helpText.innerHTML = `Default credentials: <strong>${info.defaultUsername}</strong> / <strong>${defaultPassword}</strong>`;
                    helpDiv.style.display = 'block';
                }

                // Remove highlighting after 5 seconds
                setTimeout(() => {
                    usernameField.style.backgroundColor = '';
                    usernameField.style.borderColor = '';
                    usernameField.title = '';
                    helpDiv.style.display = 'none';
                }, 5000);
            }

            // Do not append hidden section field; authentication should only use username and password
        }

        // Login handling function
        async function handleLogin(event) {
            event.preventDefault();

            const form = event.target;
            // Only include username and password in the request
            const rawFormData = new FormData(form);
            const username = rawFormData.get('username');
            const password = rawFormData.get('password');
            const section = getSectionFromURL();
            

            // Show loading state
            const submitBtn = document.getElementById('loginBtn');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Signing in...';
            submitBtn.disabled = true;

            // Hide any existing messages
            hideMessages();

            try {
                const sectionInfo = {
                    'application': { apiEndpoint: 'api/staff-login' },
                    'payment': { apiEndpoint: 'api/staff-login' },
                    'print': { apiEndpoint: 'api/staff-login' },
                    'logistic': { apiEndpoint: 'api/staff-login' },
                    'helpdesk': { apiEndpoint: 'api/staff-login' },
                    'general': { apiEndpoint: 'api/login' }
                };

                const apiEndpoint = sectionInfo[section]?.apiEndpoint || 'api/login';

                const response = await fetch(apiEndpoint, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ username, password })
                });

                const data = await response.json();

                if (response.ok && data.success) {
                    // Login successful
                    showSuccess(data.message || 'Login successful! Redirecting...');

                    // Determine redirect URL based on section
                    let redirectUrl = data.redirectUrl || '<%= request.getContextPath() %>/applications.jsp';
                    
                    // If this is application section staff, redirect to application review page
                    if (section === 'application') {
                        redirectUrl = '<%= request.getContextPath() %>/application_review.jsp';
                    }
                    
                    // If this is print section staff, redirect to print section page
                    if (section === 'print') {
                        redirectUrl = '<%= request.getContextPath() %>/application_print.jsp';
                    }

                    // If this is logistic section staff, redirect to logistic service page
                    if (section === 'logistic') {
                        redirectUrl = '<%= request.getContextPath() %>/logistic_service.jsp';
                    }

                    // If this is helpdesk section staff, redirect to helpdesk page
                    if (section === 'helpdesk') {
                        redirectUrl = '<%= request.getContextPath() %>/helpdesk.jsp';
                    }

                    // Redirect after short delay
                    setTimeout(() => {
                        window.location.href = redirectUrl;
                    }, 1500);

                } else {
                    // Login failed
                    showError(data.error || 'Invalid username or password. Please try again.');
                }

            } catch (error) {
                console.error('Login error:', error);
                showError('Network error. Please check your connection and try again.');
            } finally {
                // Reset button state
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            }
        }

        // Initialize page based on section
        document.addEventListener('DOMContentLoaded', function() {
            const section = getSectionFromURL();
            updateLoginForm(section);

            // Auto-hide messages after 5 seconds
            setTimeout(() => {
                hideMessages();
            }, 5000);
        });

        function showError(message) {
            const errorDiv = document.getElementById('loginError');
            const errorMessage = document.getElementById('errorMessage');
            errorMessage.textContent = message;
            errorDiv.classList.remove('d-none');
        }

        function showSuccess(message) {
            const successDiv = document.getElementById('loginSuccess');
            const successMessage = document.getElementById('successMessage');
            successMessage.textContent = message;
            successDiv.classList.remove('d-none');
        }

        function hideMessages() {
            document.getElementById('loginError').classList.add('d-none');
            document.getElementById('loginSuccess').classList.add('d-none');
        }
    </script>
</body>
</html>