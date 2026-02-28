<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Professional passport services in Sri Lanka. Fast, reliable, and secure passport processing with expert guidance.">
  <meta name="keywords" content="passport service, Sri Lanka passport, passport renewal, new passport, lost passport">
  <meta name="author" content="Lanka Epassport Service">
  <title>Logistic Service - Lanka Epassport</title>

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
        .hero {
            background: linear-gradient(135deg, #FFB703 0%, #FB8500 100%);
            color: white;
            padding: 3rem 0;
            border-radius: 0 0 1rem 1rem;
        }
        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .logistic-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            overflow: hidden;
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            position: relative;
        }
        
        .logistic-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 16px 48px rgba(0,0,0,0.15);
        }
        
        .logistic-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--card-color), var(--card-color-light));
        }
        
        .logistic-card.pending {
            --card-color: #ffc107;
            --card-color-light: #ffed4e;
        }
        
        .logistic-card.in-transit {
            --card-color: #28a745;
            --card-color-light: #34ce57;
        }
        
        .logistic-card.delivered {
            --card-color: #007bff;
            --card-color-light: #4dabf7;
        }
        
        .card-icon.pending-icon {
            background: linear-gradient(135deg, #ffc107, #ffed4e);
            color: #856404;
        }
        
        .card-icon.in-transit-icon {
            background: linear-gradient(135deg, #28a745, #34ce57);
            color: white;
        }
        
        .card-icon.delivered-icon {
            background: linear-gradient(135deg, #007bff, #4dabf7);
            color: white;
        }
        
        .logistic-card:hover .card-icon {
            transform: scale(1.1);
        }
        
        .card-title {
            font-weight: 700;
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }
        
        .card-description {
            color: #6c757d;
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 1rem;
        }
        
        .logistic-btn {
            border-radius: 12px;
            padding: 0.5rem 1.25rem;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            border: none;
            position: relative;
            overflow: hidden;
        }
        
        .logistic-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .logistic-btn:hover::before {
            left: 100%;
        }
        
        .logistic-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }
        
        .badge-counter {
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
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

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-truck me-2"></i>Logistic Service</h1>
            <p class="lead">Manage dispatching, tracking, and delivery confirmations</p>
        </div>
    </div>

    <!-- Main Content -->
    <main class="container mb-5">
        <div class="row g-3">
            <div class="col-md-4">
                <div class="card h-100 logistic-card pending">
                    <div class="card-body d-flex align-items-start p-4">
                        <div class="card-icon pending-icon">
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                        <div class="flex-grow-1">
                            <h5 class="card-title">
                                Pending Dispatches 
                                <span id="pendingCount" class="badge bg-warning text-dark badge-counter d-none"></span>
                            </h5>
                            <p class="card-description">View approved passports awaiting dispatch.</p>
                            <a href="#" class="btn btn-warning logistic-btn" onclick="openPendingModal(event)">
                                <i class="fas fa-eye me-2"></i>View Details
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        <div class="col-md-4">
            <div class="card h-100 logistic-card in-transit">
                <div class="card-body d-flex align-items-start p-4">
                    <div class="card-icon in-transit-icon">
                        <i class="fas fa-truck"></i>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="card-title">In Transit</h5>
                        <p class="card-description">Track in-progress deliveries and monitor status.</p>
                        <a href="#" class="btn btn-success logistic-btn" onclick="openInTransitModal(event)">
                            <i class="fas fa-location-arrow me-2"></i>Track Now
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 logistic-card delivered">
                <div class="card-body d-flex align-items-start p-4">
                    <div class="card-icon delivered-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="card-title">Delivered</h5>
                        <p class="card-description">Confirm handover and receipt of completed deliveries.</p>
                        <a href="#" class="btn btn-primary logistic-btn" onclick="openDeliveredModal(event)">
                            <i class="fas fa-clipboard-check me-2"></i>Confirm
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Pending Modal -->
<div class="modal fade" id="pendingModal" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><i class="fas fa-clipboard-list me-2"></i>Pending Dispatches</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="pendingLoading" class="text-center py-4 d-none">
          <div class="spinner-border text-warning" role="status"></div>
          <div class="mt-2">Loading...</div>
        </div>
        <div class="table-responsive">
          <table class="table table-sm align-middle">
            <thead>
              <tr>
                <th>Application #</th>
                <th>Applicant</th>
                <th>NIC</th>
                <th>Printed At</th>
                <th>Address</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody id="pendingTbody"></tbody>
          </table>
        </div>
        <div id="pendingEmpty" class="alert alert-info d-none">No pending dispatches.</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Delivery Modal -->
<div class="modal fade" id="deliveryModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><i class="fas fa-truck me-2"></i>Delivery Form</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="deliveryForm">
          <input type="hidden" id="deliveryApplicationId" name="applicationId">
          
          <div class="row mb-3">
            <div class="col-md-6">
              <label for="applicationIdDisplay" class="form-label">Application ID</label>
              <input type="text" class="form-control" id="applicationIdDisplay" readonly>
            </div>
            <div class="col-md-6">
              <label for="trackingNumber" class="form-label">Tracking Number <span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="trackingNumber" name="trackingNumber" required minlength="8" maxlength="10" pattern="^[A-Za-z0-9]{8,10}$">
              <div class="form-text">
                <i class="fas fa-info-circle me-1"></i>Tracking number must be 8-10 alphanumeric characters
              </div>
              <div class="invalid-feedback">
                Tracking number must be 8-10 characters (letters and numbers only).
              </div>
            </div>
          </div>
          
          <div class="row mb-3">
            <div class="col-md-6">
              <label for="deliveryDate" class="form-label">Delivery Date/Time <span class="text-danger">*</span></label>
              <input type="datetime-local" class="form-control" id="deliveryDate" name="deliveryDate" required>
            </div>
            <div class="col-md-6">
              <label for="recipientName" class="form-label">Recipient Name <span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="recipientName" name="recipientName" required>
            </div>
          </div>
          
          <div class="row mb-3">
            <div class="col-md-6">
              <label for="recipientIdVerification" class="form-label">ID Verification (NIC) <span class="text-danger">*</span></label>
              <input type="text" class="form-control" id="recipientIdVerification" name="recipientIdVerification" required pattern="^(\d{12}|\d{9}[vV])$">
              <div class="form-text">
                <i class="fas fa-info-circle me-1"></i>NIC must be 12 digits (e.g., 123456789012) or 9 digits + V (e.g., 123456789V)
              </div>
              <div class="invalid-feedback">
                NIC must be 12 digits or 9 digits followed by V.
              </div>
            </div>
            <div class="col-md-6">
              <!-- Empty column for layout balance -->
            </div>
          </div>
          
          <div class="mb-3">
            <label for="notes" class="form-label">Notes</label>
            <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="Optional delivery notes..."></textarea>
          </div>
          
          <div id="deliveryAlert" class="alert d-none" role="alert"></div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-success" onclick="submitDelivery()">
          <i class="fas fa-check me-1"></i>Submit Delivery
        </button>
      </div>
    </div>
  </div>
</div>

<!-- In Transit Modal -->
<div class="modal fade" id="inTransitModal" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><i class="fas fa-truck me-2"></i>In Transit Deliveries</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="inTransitLoading" class="text-center py-4 d-none">
          <div class="spinner-border text-success" role="status"></div>
          <div class="mt-2">Loading...</div>
        </div>
        <div class="table-responsive">
          <table class="table table-sm align-middle">
            <thead>
              <tr>
                <th>Application #</th>
                <th>Applicant</th>
                <th>Tracking #</th>
                <th>Delivery Date</th>
                <th>Recipient</th>
                <th>Status</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody id="inTransitTbody"></tbody>
          </table>
        </div>
        <div id="inTransitEmpty" class="alert alert-info d-none">No deliveries in transit.</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Delivered Modal -->
<div class="modal fade" id="deliveredModal" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><i class="fas fa-check-circle me-2"></i>Delivered Applications</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div id="deliveredLoading" class="text-center py-4 d-none">
          <div class="spinner-border text-primary" role="status"></div>
          <div class="mt-2">Loading...</div>
        </div>
        <div class="table-responsive">
          <table class="table table-sm align-middle">
            <thead>
              <tr>
                <th>Application #</th>
                <th>Applicant</th>
                <th>Tracking #</th>
                <th>Delivery Date</th>
                <th>Recipient</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody id="deliveredTbody"></tbody>
          </table>
        </div>
        <div id="deliveredEmpty" class="alert alert-info d-none">No delivered applications.</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
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

const basePath = '<%= request.getContextPath() %>';

async function fetchPending(){
  try{ 
    const res = await fetch(basePath + '/api/pending-dispatches');
    if(!res.ok) throw new Error('Failed to load');
    return await res.json();
  }catch(e){ console.error(e); return []; }
}

async function refreshPendingCount(){
  const data = await fetchPending();
  const badge = document.getElementById('pendingCount');
  if(data.length>0){ badge.textContent = data.length; badge.classList.remove('d-none'); }
  else { badge.classList.add('d-none'); }
}

async function openPendingModal(ev){
  ev.preventDefault();
  document.getElementById('pendingLoading').classList.remove('d-none');
  const tbody = document.getElementById('pendingTbody');
  tbody.innerHTML='';
  const data = await fetchPending();
  document.getElementById('pendingLoading').classList.add('d-none');
  const empty = document.getElementById('pendingEmpty');
  if(data.length===0){ empty.classList.remove('d-none'); }
  else { empty.classList.add('d-none'); }
  data.forEach(row=>{
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>#${row.applicationId}</td>
                    <td>${row.firstName} ${row.lastName}</td>
                    <td>${row.nicNumber}</td>
                    <td>${new Date(row.printedAt).toLocaleString()}</td>
                    <td>${row.currentAddress}, ${row.city} ${row.postalCode||''}</td>
                    <td><button class="btn btn-sm btn-success" onclick="openDeliveryModal(${row.applicationId})"><i class="fas fa-truck me-1"></i>Deliver</button></td>`;
    tbody.appendChild(tr);
  });
  new bootstrap.Modal(document.getElementById('pendingModal')).show();
}

function openDeliveryModal(applicationId) {
  console.log('Opening delivery modal for application ID:', applicationId);
  
  // Manually clear form fields instead of using reset()
  document.getElementById('trackingNumber').value = '';
  document.getElementById('deliveryDate').value = '';
  document.getElementById('recipientName').value = '';
  document.getElementById('recipientIdVerification').value = '';
  document.getElementById('notes').value = '';
  
  // Set application ID (database stores clean numbers, no # manipulation needed)
  document.getElementById('deliveryApplicationId').value = applicationId;
  document.getElementById('applicationIdDisplay').value = '#' + applicationId;
  document.getElementById('deliveryAlert').classList.add('d-none');
  
  // Debug: Check if the hidden field has the value
  console.log('Hidden field value after setting:', document.getElementById('deliveryApplicationId').value);
  
  // Set current date/time as default
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  document.getElementById('deliveryDate').value = `${year}-${month}-${day}T${hours}:${minutes}`;
  
  new bootstrap.Modal(document.getElementById('deliveryModal')).show();
}

async function submitDelivery() {
  const form = document.getElementById('deliveryForm');
  const formData = new FormData(form);
  const alertDiv = document.getElementById('deliveryAlert');
  
  // Custom validation checks
  const trackingNumber = document.getElementById('trackingNumber').value.trim();
  const nicVerification = document.getElementById('recipientIdVerification').value.trim();
  
  // Validate tracking number
  if (trackingNumber.length < 8 || trackingNumber.length > 10) {
    alertDiv.className = 'alert alert-danger';
    alertDiv.textContent = 'Tracking number must be 8-10 characters long.';
    alertDiv.classList.remove('d-none');
    return;
  }
  
  if (!/^[A-Za-z0-9]{8,10}$/.test(trackingNumber)) {
    alertDiv.className = 'alert alert-danger';
    alertDiv.textContent = 'Tracking number must contain only letters and numbers.';
    alertDiv.classList.remove('d-none');
    return;
  }
  
  // Validate NIC
  if (!/^(\d{12}|\d{9}[vV])$/.test(nicVerification)) {
    alertDiv.className = 'alert alert-danger';
    alertDiv.textContent = 'NIC must be 12 digits or 9 digits followed by V.';
    alertDiv.classList.remove('d-none');
    return;
  }
  
  // Debug: Log form data
  console.log('=== FORM SUBMISSION DEBUG ===');
  console.log('Form data being sent:');
  for (let [key, value] of formData.entries()) {
    console.log(key + ': ' + value + ' (type: ' + typeof value + ')');
  }
  
  // Debug: Check hidden field value before submission
  const hiddenField = document.getElementById('deliveryApplicationId');
  console.log('Hidden field element:', hiddenField);
  console.log('Hidden field value:', hiddenField.value);
  console.log('Hidden field name:', hiddenField.name);
  console.log('Hidden field type:', hiddenField.type);
  
  // Debug: Check if applicationId is in formData
  console.log('applicationId in FormData:', formData.get('applicationId'));
  console.log('applicationId type:', typeof formData.get('applicationId'));
  
  // Validate form
  if (!form.checkValidity()) {
    form.reportValidity();
    return;
  }
  
  try {
    // Debug: Log the exact URL being called
    console.log('Calling URL:', basePath + '/api/delivery');
    
    const response = await fetch(basePath + '/api/delivery', {
      method: 'POST',
      body: formData
      // Note: Don't set Content-Type header - let browser set it automatically for FormData
    });
    
    const result = await response.json();
    
    if (response.ok && result.success) {
      alertDiv.className = 'alert alert-success';
      alertDiv.textContent = result.message || 'Delivery record created successfully!';
      alertDiv.classList.remove('d-none');
      
      // Clear form and close modal after 2 seconds
      setTimeout(() => {
        bootstrap.Modal.getInstance(document.getElementById('deliveryModal')).hide();
        // Refresh pending dispatches
        refreshPendingCount();
        // Close the pending dispatches modal if open
        const pendingModalEl = document.getElementById('pendingModal');
        if (pendingModalEl) {
          const pendingModal = bootstrap.Modal.getInstance(pendingModalEl);
          if (pendingModal) {
            pendingModal.hide();
          }
        }
      }, 2000);
    } else {
      alertDiv.className = 'alert alert-danger';
      alertDiv.textContent = result.error || 'Failed to create delivery record';
      alertDiv.classList.remove('d-none');
    }
  } catch (error) {
    alertDiv.className = 'alert alert-danger';
    alertDiv.textContent = 'Network error: ' + error.message;
    alertDiv.classList.remove('d-none');
  }
}

async function fetchInTransit(){
  try{ 
    const res = await fetch(basePath + '/api/in-transit');
    if(!res.ok) throw new Error('Failed to load');
    return await res.json();
  }catch(e){ console.error(e); return []; }
}

async function openInTransitModal(ev){
  ev.preventDefault();
  document.getElementById('inTransitLoading').classList.remove('d-none');
  const tbody = document.getElementById('inTransitTbody');
  tbody.innerHTML='';
  const data = await fetchInTransit();
  document.getElementById('inTransitLoading').classList.add('d-none');
  const empty = document.getElementById('inTransitEmpty');
  if(data.length===0){ empty.classList.remove('d-none'); }
  else { empty.classList.add('d-none'); }
  data.forEach(row=>{
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>#${row.applicationId}</td>
                    <td>${row.firstName} ${row.lastName}</td>
                    <td><span class="badge bg-info">${row.trackingNumber}</span></td>
                    <td>${new Date(row.deliveryDate).toLocaleString()}</td>
                    <td>${row.recipientName}</td>
                    <td><span class="badge bg-warning">In Transit</span></td>
                    <td><button class="btn btn-sm btn-primary" onclick="markAsDelivered(${row.applicationId})"><i class="fas fa-check me-1"></i>Delivered</button></td>`;
    tbody.appendChild(tr);
  });
  new bootstrap.Modal(document.getElementById('inTransitModal')).show();
}

async function fetchDelivered(){
  try{ 
    const res = await fetch(basePath + '/api/delivered');
    if(!res.ok) throw new Error('Failed to load');
    return await res.json();
  }catch(e){ console.error(e); return []; }
}

async function openDeliveredModal(ev){
  ev.preventDefault();
  document.getElementById('deliveredLoading').classList.remove('d-none');
  const tbody = document.getElementById('deliveredTbody');
  tbody.innerHTML='';
  const data = await fetchDelivered();
  document.getElementById('deliveredLoading').classList.add('d-none');
  const empty = document.getElementById('deliveredEmpty');
  if(data.length===0){ empty.classList.remove('d-none'); }
  else { empty.classList.add('d-none'); }
  data.forEach(row=>{
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>#${row.applicationId}</td>
                    <td>${row.firstName} ${row.lastName}</td>
                    <td><span class="badge bg-info">${row.trackingNumber}</span></td>
                    <td>${new Date(row.deliveryDate).toLocaleString()}</td>
                    <td>${row.recipientName}</td>
                    <td><span class="badge bg-success">Delivered</span></td>`;
    tbody.appendChild(tr);
  });
  new bootstrap.Modal(document.getElementById('deliveredModal')).show();
}

async function markAsDelivered(applicationId) {
  if (confirm('Are you sure you want to mark this application as delivered?')) {
    try {
      const formData = new FormData();
      formData.append('action', 'mark_delivered');
      formData.append('applicationId', applicationId);
      
      const response = await fetch(basePath + '/api/delivery', {
        method: 'POST',
        body: formData
      });
      
      const result = await response.json();
      
      if (response.ok && result.success) {
        alert('Application marked as delivered successfully!');
        // Refresh the in-transit modal
        const inTransitModalEl = document.getElementById('inTransitModal');
        if (inTransitModalEl) {
          const inTransitModal = bootstrap.Modal.getInstance(inTransitModalEl);
          if (inTransitModal) {
            inTransitModal.hide();
            // Reopen to refresh data
            setTimeout(() => {
              openInTransitModal({preventDefault: () => {}});
            }, 300);
          }
        }
      } else {
        alert('Error: ' + (result.error || 'Failed to mark as delivered'));
      }
    } catch (error) {
      alert('Network error: ' + error.message);
    }
  }
}

// Real-time validation for tracking number
document.addEventListener('DOMContentLoaded', function() {
  const trackingNumberField = document.getElementById('trackingNumber');
  const nicField = document.getElementById('recipientIdVerification');
  
  if (trackingNumberField) {
    trackingNumberField.addEventListener('input', function() {
      const value = this.value.trim();
      const trackingPattern = /^[A-Za-z0-9]{8,10}$/;
      
      if (value.length === 0) {
        this.setCustomValidity('');
        this.classList.remove('is-valid', 'is-invalid');
      } else if (value.length >= 8 && value.length <= 10 && trackingPattern.test(value)) {
        this.setCustomValidity('');
        this.classList.remove('is-invalid');
        this.classList.add('is-valid');
      } else {
        this.setCustomValidity('Tracking number must be 8-10 characters (letters and numbers only).');
        this.classList.remove('is-valid');
        this.classList.add('is-invalid');
      }
    });
  }
  
  if (nicField) {
    nicField.addEventListener('input', function() {
      const value = this.value.trim();
      const nicPattern = /^(\d{12}|\d{9}[vV])$/;
      
      if (value.length === 0) {
        this.setCustomValidity('');
        this.classList.remove('is-valid', 'is-invalid');
      } else if (nicPattern.test(value)) {
        this.setCustomValidity('');
        this.classList.remove('is-invalid');
        this.classList.add('is-valid');
      } else {
        this.setCustomValidity('NIC must be 12 digits or 9 digits followed by V.');
        this.classList.remove('is-valid');
        this.classList.add('is-invalid');
      }
    });
  }
  
  refreshPendingCount();
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
