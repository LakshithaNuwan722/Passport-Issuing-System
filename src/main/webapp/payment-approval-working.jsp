<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Approval - Working Version</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
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
        }
        .status-completed { background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-weight: bold; }
        .status-pending { background: #fff3cd; color: #856404; padding: 5px 10px; border-radius: 20px; font-weight: bold; }
        .status-failed { background: #f8d7da; color: #721c24; padding: 5px 10px; border-radius: 20px; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container-box">
        <h1><i class="fas fa-credit-card me-2"></i>Payment Approval System</h1>
        <p class="text-muted">Real Working Version</p>
        <hr>
        
        <div class="btn-group mb-3" role="group">
            <button class="btn btn-primary" onclick="loadPayments('all')">All</button>
            <button class="btn btn-outline-primary" onclick="loadPayments('pending')">Pending</button>
            <button class="btn btn-outline-primary" onclick="loadPayments('approved')">Approved</button>
            <button class="btn btn-outline-primary" onclick="loadPayments('rejected')">Rejected</button>
        </div>
        
        <div id="loading" class="text-center py-5">
            <div class="spinner-border text-primary" role="status"></div>
            <p class="mt-2">Loading payments...</p>
        </div>
        
        <div id="error" class="alert alert-danger" style="display:none;"></div>
        
        <div id="content" style="display:none;">
            <div class="alert alert-success" id="recordCount"></div>
            <div class="table-responsive">
                <table class="table table-hover table-bordered">
                    <thead class="table-primary">
                        <tr>
                            <th>Trans ID</th>
                            <th>App ID</th>
                            <th>Applicant</th>
                            <th>Payment Method</th>
                            <th>Amount (LKR)</th>
                            <th>Reference</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="tbody"></tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Details Modal -->
    <div class="modal fade" id="detailsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Payment Details</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="modalBody"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Approve/Reject Modal -->
    <div class="modal fade" id="actionModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" id="actionHeader">
                    <h5 class="modal-title" id="actionTitle"></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <textarea class="form-control" id="actionNotes" rows="3" placeholder="Enter notes..."></textarea>
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
        const ctx = '<%= request.getContextPath() %>';
        let allPayments = [];
        let currentTxId = null;
        let currentAction = null;
        
        // Auto-load all payments on page load
        window.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded, context:', ctx);
            loadPayments('all');
        });
        
        function loadPayments(status) {
            console.log('Loading payments:', status);
            document.getElementById('loading').style.display = 'block';
            document.getElementById('content').style.display = 'none';
            document.getElementById('error').style.display = 'none';
            
            fetch(ctx + '/PaymentApproval?status=' + status)
                .then(response => {
                    console.log('Response status:', response.status);
                    if (!response.ok) throw new Error('HTTP ' + response.status);
                    return response.json();
                })
                .then(data => {
                    console.log('Received data:', data);
                    allPayments = data;
                    displayPayments(data);
                })
                .catch(error => {
                    console.error('Error:', error);
                    document.getElementById('loading').style.display = 'none';
                    document.getElementById('error').textContent = 'Error loading payments: ' + error.message;
                    document.getElementById('error').style.display = 'block';
                });
        }
        
        function displayPayments(payments) {
            document.getElementById('loading').style.display = 'none';
            
            if (!payments || payments.length === 0) {
                document.getElementById('error').textContent = 'No payments found';
                document.getElementById('error').style.display = 'block';
                return;
            }
            
            document.getElementById('content').style.display = 'block';
            document.getElementById('recordCount').textContent = 'Found ' + payments.length + ' payment records';
            
            const tbody = document.getElementById('tbody');
            tbody.innerHTML = '';
            
            payments.forEach(p => {
                const row = document.createElement('tr');
                
                let statusClass = 'status-pending';
                if (p.status === 'completed') statusClass = 'status-completed';
                if (p.status === 'failed') statusClass = 'status-failed';
                
                let actions = '<button class="btn btn-sm btn-info" onclick="viewDetails(' + p.transactionId + ')"><i class="fas fa-eye"></i> View</button> ';
                
                if (p.status === 'pending') {
                    actions += '<button class="btn btn-sm btn-success" onclick="openAction(' + p.transactionId + ', \'approve\')"><i class="fas fa-check"></i> Approve</button> ';
                    actions += '<button class="btn btn-sm btn-danger" onclick="openAction(' + p.transactionId + ', \'reject\')"><i class="fas fa-times"></i> Reject</button>';
                } else if (p.status === 'completed') {
                    actions += '<a href="payment-invoice.jsp?transactionId=' + p.paymentReference + '&applicationId=' + p.applicationId + '" class="btn btn-sm btn-primary" target="_blank"><i class="fas fa-file-invoice"></i> Invoice</a>';
                }
                
                row.innerHTML = 
                    '<td>' + p.transactionId + '</td>' +
                    '<td>#' + p.applicationId + '</td>' +
                    '<td>' + p.applicantName + '<br><small>' + p.nic + '</small></td>' +
                    '<td>' + p.paymentMethod + '</td>' +
                    '<td>' + parseFloat(p.totalAmount).toFixed(2) + '</td>' +
                    '<td><small>' + (p.paymentReference || 'N/A') + '</small></td>' +
                    '<td><small>' + p.transactionDate + '</small></td>' +
                    '<td><span class="' + statusClass + '">' + p.status.toUpperCase() + '</span></td>' +
                    '<td>' + actions + '</td>';
                
                tbody.appendChild(row);
            });
        }
        
        function viewDetails(txId) {
            const p = allPayments.find(payment => payment.transactionId === txId);
            if (!p) return;
            
            document.getElementById('modalBody').innerHTML = 
                '<div class="row mb-2"><div class="col-6"><strong>Transaction ID:</strong></div><div class="col-6">' + p.transactionId + '</div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>Application ID:</strong></div><div class="col-6">#' + p.applicationId + '</div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>Applicant:</strong></div><div class="col-6">' + p.applicantName + '</div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>NIC:</strong></div><div class="col-6">' + p.nic + '</div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>Email:</strong></div><div class="col-6">' + p.email + '</div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>Payment Method:</strong></div><div class="col-6">' + p.paymentMethod + '</div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>Processing Type:</strong></div><div class="col-6">' + p.processingType + '</div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>Processing Fee:</strong></div><div class="col-6">LKR ' + parseFloat(p.processingFee).toFixed(2) + '</div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>Service Fee:</strong></div><div class="col-6">LKR ' + parseFloat(p.serviceFee).toFixed(2) + '</div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>Tax:</strong></div><div class="col-6">LKR ' + parseFloat(p.taxAmount).toFixed(2) + '</div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>Total Amount:</strong></div><div class="col-6"><strong>LKR ' + parseFloat(p.totalAmount).toFixed(2) + '</strong></div></div>' +
                '<div class="row mb-2"><div class="col-6"><strong>Status:</strong></div><div class="col-6"><span class="status-' + p.status + '">' + p.status.toUpperCase() + '</span></div></div>' +
                (p.notes ? '<div class="row mb-2"><div class="col-12"><strong>Notes:</strong><p class="mt-2 p-2 bg-light">' + p.notes + '</p></div></div>' : '');
            
            new bootstrap.Modal(document.getElementById('detailsModal')).show();
        }
        
        function openAction(txId, action) {
            currentTxId = txId;
            currentAction = action;
            document.getElementById('actionNotes').value = '';
            
            const header = document.getElementById('actionHeader');
            const title = document.getElementById('actionTitle');
            const btn = document.getElementById('confirmBtn');
            
            if (action === 'approve') {
                header.style.background = '#28a745';
                title.textContent = 'Approve Payment';
                btn.className = 'btn btn-success';
                btn.textContent = 'Approve';
            } else {
                header.style.background = '#dc3545';
                title.textContent = 'Reject Payment';
                btn.className = 'btn btn-danger';
                btn.textContent = 'Reject';
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
            btn.textContent = 'Processing...';
            
            const formData = new URLSearchParams();
            formData.append('transactionId', currentTxId);
            formData.append('action', currentAction);
            formData.append('notes', notes);
            
            fetch(ctx + '/PaymentApproval', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                alert(data.success ? data.message : 'Error: ' + data.message);
                if (data.success) {
                    bootstrap.Modal.getInstance(document.getElementById('actionModal')).hide();
                    loadPayments('all');
                }
            })
            .catch(error => alert('Error: ' + error.message))
            .finally(() => {
                btn.disabled = false;
                btn.textContent = currentAction === 'approve' ? 'Approve' : 'Reject';
            });
        }
    </script>
</body>
</html>

