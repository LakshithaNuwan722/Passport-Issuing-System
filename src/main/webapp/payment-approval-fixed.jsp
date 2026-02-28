<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String staffUsername = "Guest Staff";
    if (session != null && session.getAttribute("staffUsername") != null) {
        staffUsername = (String) session.getAttribute("staffUsername");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Approval Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .main-container {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .header-section {
            border-bottom: 3px solid #667eea;
            padding-bottom: 1rem;
            margin-bottom: 2rem;
        }
        
        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .status-pending { background: #fff3cd; color: #856404; }
        .status-completed { background: #d4edda; color: #155724; }
        .status-failed { background: #f8d7da; color: #721c24; }
        
        .loading-box {
            text-align: center;
            padding: 3rem;
        }
        
        .error-box {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            padding: 1rem;
            border-radius: 5px;
            margin: 1rem 0;
        }
        
        .filter-btn {
            margin: 0 0.25rem 0.5rem 0;
        }
    </style>
</head>
<body>
    <!-- Debug Info -->
    <div class="main-container" id="debugInfo" style="background: #fff3cd; margin-bottom: 1rem; display: none;">
        <h5>🔍 Debug Information</h5>
        <div id="debugContent"></div>
    </div>
    
    <div class="main-container">
        <!-- Header -->
        <div class="header-section">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2><i class="fas fa-credit-card me-2"></i>Payment Approval Dashboard</h2>
                    <p class="text-muted mb-0">Staff: <strong><%= staffUsername %></strong></p>
                </div>
                <div class="col-md-4 text-end">
                    <button class="btn btn-sm btn-outline-primary" onclick="loadPayments(currentFilter)">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button>
                    <button class="btn btn-sm btn-outline-secondary" onclick="toggleDebug()">
                        <i class="fas fa-bug"></i> Debug
                    </button>
                    <a href="index.jsp" class="btn btn-sm btn-outline-danger">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Filters -->
        <div class="mb-3">
            <button class="btn btn-outline-primary filter-btn" onclick="filterPayments('pending')">
                <i class="fas fa-clock"></i> Pending
            </button>
            <button class="btn btn-outline-primary filter-btn" onclick="filterPayments('approved')">
                <i class="fas fa-check-circle"></i> Approved
            </button>
            <button class="btn btn-outline-primary filter-btn" onclick="filterPayments('rejected')">
                <i class="fas fa-times-circle"></i> Rejected
            </button>
            <button class="btn btn-primary filter-btn" onclick="filterPayments('all')">
                <i class="fas fa-list"></i> All
            </button>
        </div>
        
        <!-- Search -->
        <div class="mb-3">
            <div class="input-group">
                <input type="text" class="form-control" id="searchInput" placeholder="Search by Application ID or Reference...">
                <button class="btn btn-primary" onclick="searchPayments()">
                    <i class="fas fa-search"></i> Search
                </button>
                <button class="btn btn-secondary" onclick="clearSearch()">
                    <i class="fas fa-eraser"></i> Clear
                </button>
            </div>
        </div>
        
        <!-- Error Display -->
        <div id="errorDisplay" style="display: none;"></div>
        
        <!-- Loading -->
        <div id="loadingBox" class="loading-box">
            <div class="spinner-border text-primary" role="status"></div>
            <p class="mt-2">Loading payments...</p>
        </div>
        
        <!-- Payments Table -->
        <div id="paymentsTable" style="display: none;">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-primary">
                        <tr>
                            <th>Trans ID</th>
                            <th>App ID</th>
                            <th>Applicant</th>
                            <th>NIC</th>
                            <th>Amount</th>
                            <th>Reference</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="paymentsBody">
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- No Data -->
        <div id="noDataBox" style="display: none; text-align: center; padding: 3rem;">
            <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
            <p class="h5">No payments found</p>
        </div>
    </div>
    
    <!-- View Modal -->
    <div class="modal fade" id="viewModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Payment Details</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="viewModalBody"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Action Modal -->
    <div class="modal fade" id="actionModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" id="actionModalHeader">
                    <h5 class="modal-title" id="actionModalTitle"></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p id="actionMessage"></p>
                    <div class="mb-3">
                        <label class="form-label">Notes/Comments <span id="notesReq"></span>:</label>
                        <textarea class="form-control" id="actionNotes" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="confirmBtn" onclick="confirmAction()">Confirm</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        console.log('=== Payment Approval Page Loaded ===');
        
        let currentFilter = 'all';  // Show all by default
        let allPayments = [];
        let currentTransactionId = null;
        let currentAction = null;
        const contextPath = '<%= request.getContextPath() %>';
        
        console.log('Context Path:', contextPath);
        
        // Auto-load on page ready
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM Content Loaded');
            console.log('Loading ALL payments (you have 6 completed records)...');
            loadPayments('all');  // Load ALL since your data is all completed
        });
        
        function toggleDebug() {
            const debugDiv = document.getElementById('debugInfo');
            debugDiv.style.display = debugDiv.style.display === 'none' ? 'block' : 'none';
        }
        
        function showDebug(message) {
            const debugDiv = document.getElementById('debugContent');
            debugDiv.innerHTML += '<p>' + new Date().toLocaleTimeString() + ': ' + message + '</p>';
        }
        
        function loadPayments(status) {
            console.log('Loading payments with status:', status);
            showDebug('Loading payments: ' + status);
            currentFilter = status;
            
            document.getElementById('loadingBox').style.display = 'block';
            document.getElementById('paymentsTable').style.display = 'none';
            document.getElementById('noDataBox').style.display = 'none';
            document.getElementById('errorDisplay').style.display = 'none';
            
            const url = contextPath + '/PaymentApproval?status=' + status;
            console.log('Fetching:', url);
            showDebug('Fetch URL: ' + url);
            
            fetch(url)
                .then(response => {
                    console.log('Response status:', response.status);
                    showDebug('Response status: ' + response.status);
                    if (!response.ok) {
                        throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Received data:', data);
                    showDebug('Received ' + (Array.isArray(data) ? data.length : 0) + ' records');
                    allPayments = data;
                    displayPayments(data);
                })
                .catch(error => {
                    console.error('Error:', error);
                    showDebug('ERROR: ' + error.message);
                    showError('Failed to load payments: ' + error.message);
                    document.getElementById('loadingBox').style.display = 'none';
                });
        }
        
        function displayPayments(payments) {
            console.log('Displaying', payments.length, 'payments');
            document.getElementById('loadingBox').style.display = 'none';
            
            if (!payments || payments.length === 0) {
                document.getElementById('noDataBox').style.display = 'block';
                return;
            }
            
            document.getElementById('paymentsTable').style.display = 'block';
            const tbody = document.getElementById('paymentsBody');
            tbody.innerHTML = '';
            
            payments.forEach(p => {
                const tr = document.createElement('tr');
                
                let statusClass = 'pending';
                if (p.status === 'completed') statusClass = 'completed';
                if (p.status === 'failed') statusClass = 'failed';
                
                let actions = '<button class="btn btn-sm btn-primary" onclick="viewPayment(' + p.transactionId + ')"><i class="fas fa-eye"></i> View</button> ';
                
                if (p.status === 'pending') {
                    actions += '<button class="btn btn-sm btn-success" onclick="openActionModal(' + p.transactionId + ', \'approve\')"><i class="fas fa-check"></i> Approve</button> ';
                    actions += '<button class="btn btn-sm btn-danger" onclick="openActionModal(' + p.transactionId + ', \'reject\')"><i class="fas fa-times"></i> Reject</button>';
                } else if (p.status === 'completed') {
                    actions += '<a href="payment-invoice.jsp?transactionId=' + p.paymentReference + '&applicationId=' + p.applicationId + '" class="btn btn-sm btn-info" target="_blank"><i class="fas fa-file-invoice"></i> Invoice</a>';
                }
                
                tr.innerHTML = `
                    <td>${p.transactionId}</td>
                    <td>#${p.applicationId}</td>
                    <td>${p.applicantName}</td>
                    <td>${p.nic}</td>
                    <td>LKR ${parseFloat(p.totalAmount).toFixed(2)}</td>
                    <td><small>${p.paymentReference || 'N/A'}</small></td>
                    <td><small>${formatDate(p.transactionDate)}</small></td>
                    <td><span class="status-badge status-${statusClass}">${p.status.toUpperCase()}</span></td>
                    <td>${actions}</td>
                `;
                tbody.appendChild(tr);
            });
        }
        
        function filterPayments(status) {
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.className = 'btn btn-outline-primary filter-btn';
            });
            event.target.className = 'btn btn-primary filter-btn';
            loadPayments(status);
        }
        
        function searchPayments() {
            const term = document.getElementById('searchInput').value.trim();
            if (!term) {
                loadPayments(currentFilter);
                return;
            }
            
            const url = contextPath + '/PaymentApproval?status=' + currentFilter + '&search=' + encodeURIComponent(term);
            console.log('Searching:', url);
            
            fetch(url)
                .then(response => response.json())
                .then(data => {
                    allPayments = data;
                    displayPayments(data);
                })
                .catch(error => {
                    showError('Search failed: ' + error.message);
                });
        }
        
        function clearSearch() {
            document.getElementById('searchInput').value = '';
            loadPayments(currentFilter);
        }
        
        function viewPayment(transactionId) {
            const payment = allPayments.find(p => p.transactionId === transactionId);
            if (!payment) return;
            
            document.getElementById('viewModalBody').innerHTML = `
                <div class="row">
                    <div class="col-6"><strong>Transaction ID:</strong></div>
                    <div class="col-6">${payment.transactionId}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Application ID:</strong></div>
                    <div class="col-6">#${payment.applicationId}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Applicant:</strong></div>
                    <div class="col-6">${payment.applicantName}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>NIC:</strong></div>
                    <div class="col-6">${payment.nic}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Email:</strong></div>
                    <div class="col-6">${payment.email}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Payment Reference:</strong></div>
                    <div class="col-6">${payment.paymentReference || 'N/A'}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Processing Type:</strong></div>
                    <div class="col-6">${payment.processingType}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Processing Fee:</strong></div>
                    <div class="col-6">LKR ${parseFloat(payment.processingFee).toFixed(2)}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Service Fee:</strong></div>
                    <div class="col-6">LKR ${parseFloat(payment.serviceFee).toFixed(2)}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Tax:</strong></div>
                    <div class="col-6">LKR ${parseFloat(payment.taxAmount).toFixed(2)}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Total Amount:</strong></div>
                    <div class="col-6"><strong>LKR ${parseFloat(payment.totalAmount).toFixed(2)}</strong></div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Date:</strong></div>
                    <div class="col-6">${formatDate(payment.transactionDate)}</div>
                </div>
                <div class="row mt-2">
                    <div class="col-6"><strong>Status:</strong></div>
                    <div class="col-6"><span class="status-badge status-${payment.status}">${payment.status.toUpperCase()}</span></div>
                </div>
                ${payment.notes ? '<div class="row mt-3"><div class="col-12"><strong>Notes:</strong><p class="mt-2 p-2 bg-light">' + payment.notes + '</p></div></div>' : ''}
            `;
            
            new bootstrap.Modal(document.getElementById('viewModal')).show();
        }
        
        function openActionModal(transactionId, action) {
            currentTransactionId = transactionId;
            currentAction = action;
            document.getElementById('actionNotes').value = '';
            
            const header = document.getElementById('actionModalHeader');
            const title = document.getElementById('actionModalTitle');
            const message = document.getElementById('actionMessage');
            const btn = document.getElementById('confirmBtn');
            const notesReq = document.getElementById('notesReq');
            
            if (action === 'approve') {
                header.style.background = '#28a745';
                title.textContent = 'Approve Payment';
                message.textContent = 'Are you sure you want to approve this payment?';
                btn.className = 'btn btn-success';
                notesReq.textContent = '(Optional)';
            } else {
                header.style.background = '#dc3545';
                title.textContent = 'Reject Payment';
                message.textContent = 'Please provide a reason for rejecting this payment.';
                btn.className = 'btn btn-danger';
                notesReq.textContent = '(Required)';
            }
            
            new bootstrap.Modal(document.getElementById('actionModal')).show();
        }
        
        function confirmAction() {
            const notes = document.getElementById('actionNotes').value.trim();
            
            if (currentAction === 'reject' && !notes) {
                alert('Please provide a reason for rejection');
                return;
            }
            
            const btn = document.getElementById('confirmBtn');
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm"></span> Processing...';
            
            const formData = new URLSearchParams();
            formData.append('transactionId', currentTransactionId);
            formData.append('action', currentAction);
            formData.append('notes', notes);
            
            fetch(contextPath + '/PaymentApproval', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    bootstrap.Modal.getInstance(document.getElementById('actionModal')).hide();
                    loadPayments(currentFilter);
                } else {
                    alert('Error: ' + data.message);
                }
            })
            .catch(error => {
                alert('Error: ' + error.message);
            })
            .finally(() => {
                btn.disabled = false;
                btn.textContent = 'Confirm';
            });
        }
        
        function showError(message) {
            const errorDiv = document.getElementById('errorDisplay');
            errorDiv.innerHTML = '<div class="error-box"><i class="fas fa-exclamation-triangle"></i> ' + message + '</div>';
            errorDiv.style.display = 'block';
        }
        
        function formatDate(dateStr) {
            if (!dateStr) return 'N/A';
            const date = new Date(dateStr);
            return date.toLocaleString();
        }
    </script>
</body>
</html>

