<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Application Review - Simple Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
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
  </style>
</head>
<body>
    <div class="container mt-5">
        <h1>Application Review Dashboard</h1>
        <p>Testing if page loads...</p>
        
        <div id="status" class="alert alert-info">Loading...</div>
        <div id="applications"></div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        console.log('JavaScript is running!');
        document.getElementById('status').textContent = 'JavaScript works!';
        
        const basePath = '<%= request.getContextPath() %>';
        console.log('Base path:', basePath);
        
        // Load applications
        async function loadData() {
            try {
                console.log('Fetching from:', basePath + '/api/application-review');
                const response = await fetch(basePath + '/api/application-review');
                console.log('Response status:', response.status);
                
                if (response.ok) {
                    const data = await response.json();
                    console.log('Data received:', data);
                    
                    document.getElementById('status').textContent = `Loaded ${data.length} applications`;
                    
                    const appDiv = document.getElementById('applications');
                    data.forEach(app => {
                        const card = document.createElement('div');
                        card.className = 'card mb-3';
                        card.innerHTML = `
                            <div class="card-body">
                                <h5>Application #${app.applicationId}</h5>
                                <p><strong>Name:</strong> ${app.firstName} ${app.lastName}</p>
                                <p><strong>Email:</strong> ${app.email}</p>
                                <p><strong>Status:</strong> ${app.status || 'N/A'}</p>
                                <button class="btn btn-primary btn-sm" onclick="alert('View app ${app.applicationId}')">View Details</button>
                            </div>
                        `;
                        appDiv.appendChild(card);
                    });
                } else {
                    document.getElementById('status').textContent = 'Error: ' + response.status;
                }
            } catch (error) {
                console.error('Error:', error);
                document.getElementById('status').textContent = 'Error: ' + error.message;
            }
        }
        
        // Load on page ready
        document.addEventListener('DOMContentLoaded', loadData);
    </script>
</body>
</html>

