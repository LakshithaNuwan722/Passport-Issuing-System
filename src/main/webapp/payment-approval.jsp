<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.example.passport_issuing.dao.Database" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Approval System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
            max-width: 1400px;
            margin: 0 auto;
        }
        .table thead { background: #667eea; color: white; }
        .status-completed { background: #fff3cd; color: #856404; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
        .status-verified { background: #d4edda; color: #155724; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
        .status-pending { background: #e7e7e7; color: #666; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
        .status-rejected { background: #f8d7da; color: #721c24; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
        .status-failed { background: #f8d7da; color: #721c24; padding: 5px 10px; border-radius: 20px; font-weight: bold; display: inline-block; }
  </style>
</head>
<body>
    <div class="container-box">
        <div class="row align-items-center mb-3">
            <div class="col-md-8">
                <h1><i class="fas fa-credit-card me-3"></i>Payment Approval System</h1>
                <p class="text-muted mb-0">Staff Payment Management Portal</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="staff-login.jsp" class="btn btn-primary">
                    <i class="fas fa-user-tie me-2"></i>Staff Portal
                </a>
                <a href="index.jsp" class="btn btn-outline-secondary ms-2">
                    <i class="fas fa-home me-2"></i>Home
                </a>
            </div>
        </div>
        <hr>
        
        <%
        // Display success/error messages
        String msg = request.getParameter("msg");
        if ("verified".equals(msg)) {
            out.println("<div class='alert alert-success alert-dismissible fade show'>");
            out.println("<strong><i class='fas fa-check-circle'></i> Verified!</strong> Payment has been approved and verified successfully.");
            out.println("<button type='button' class='btn-close' data-bs-dismiss='alert'></button></div>");
        } else if ("approved".equals(msg)) {
            out.println("<div class='alert alert-success alert-dismissible fade show'>");
            out.println("<strong><i class='fas fa-check-circle'></i> Success!</strong> Payment approved successfully.");
            out.println("<button type='button' class='btn-close' data-bs-dismiss='alert'></button></div>");
        } else if ("rejected".equals(msg)) {
            out.println("<div class='alert alert-danger alert-dismissible fade show'>");
            out.println("<strong><i class='fas fa-times-circle'></i> Payment Rejected!</strong> The payment has been rejected by staff.");
            out.println("<button type='button' class='btn-close' data-bs-dismiss='alert'></button></div>");
        } else if ("error".equals(msg)) {
            out.println("<div class='alert alert-danger alert-dismissible fade show'>");
            out.println("<strong><i class='fas fa-times-circle'></i> Error!</strong> An error occurred while processing the payment.");
            out.println("<button type='button' class='btn-close' data-bs-dismiss='alert'></button></div>");
        }
        %>
        
        <%
            String filterStatus = request.getParameter("filter");
            if (filterStatus == null) filterStatus = "all";
            
            List<Map<String, String>> payments = new ArrayList<>();
            int totalCount = 0;
            
            try (Connection conn = Database.getConnection()) {
                StringBuilder sql = new StringBuilder(
                    "SELECT pt.transaction_id, pt.application_id, pt.payment_method, pt.processing_type, " +
                    "pt.total_amount, pt.payment_reference, pt.transaction_date, pt.transaction_status, " +
                    "a.first_name, a.last_name, a.nic_number, a.email " +
                    "FROM payment_transactions pt " +
                    "LEFT JOIN applications a ON pt.application_id = a.application_id " +
                    "WHERE 1=1"
                );
                
                if ("pending".equals(filterStatus)) {
                    sql.append(" AND pt.transaction_status = 'pending'");
                } else if ("completed".equals(filterStatus)) {
                    sql.append(" AND pt.transaction_status = 'completed'");
                } else if ("verified".equals(filterStatus)) {
                    sql.append(" AND pt.transaction_status = 'verified'");
                } else if ("approved".equals(filterStatus)) {
                    sql.append(" AND pt.transaction_status = 'verified'");
                } else if ("rejected".equals(filterStatus)) {
                    sql.append(" AND pt.transaction_status = 'rejected'");
                }
                
                sql.append(" ORDER BY pt.transaction_date DESC");
                
                try (PreparedStatement stmt = conn.prepareStatement(sql.toString());
                     ResultSet rs = stmt.executeQuery()) {
                    
                    while (rs.next()) {
                        Map<String, String> payment = new HashMap<>();
                        payment.put("transactionId", String.valueOf(rs.getInt("transaction_id")));
                        payment.put("applicationId", String.valueOf(rs.getInt("application_id")));
                        payment.put("paymentMethod", rs.getString("payment_method"));
                        payment.put("processingType", rs.getString("processing_type"));
                        payment.put("totalAmount", String.format("%.2f", rs.getDouble("total_amount")));
                        payment.put("paymentReference", rs.getString("payment_reference"));
                        payment.put("transactionDate", rs.getString("transaction_date"));
                        payment.put("status", rs.getString("transaction_status"));
                        
                        String firstName = rs.getString("first_name");
                        String lastName = rs.getString("last_name");
                        payment.put("applicantName", (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : ""));
                        payment.put("nic", rs.getString("nic_number"));
                        payment.put("email", rs.getString("email"));
                        
                        payments.add(payment);
                        totalCount++;
                    }
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger'>Database Error: " + e.getMessage() + "</div>");
                e.printStackTrace();
            }
        %>
        
        <!-- Filter Buttons -->
        <div class="btn-group mb-4" role="group">
            <a href="?filter=all" class="btn <%= "all".equals(filterStatus) ? "btn-primary" : "btn-outline-primary" %>">
                <i class="fas fa-list"></i> All
            </a>
            <a href="?filter=completed" class="btn <%= "completed".equals(filterStatus) ? "btn-warning" : "btn-outline-warning" %>">
                <i class="fas fa-clock"></i> Needs Review
            </a>
            <a href="?filter=verified" class="btn <%= "verified".equals(filterStatus) || "approved".equals(filterStatus) ? "btn-success" : "btn-outline-success" %>">
                <i class="fas fa-check-circle"></i> Verified
            </a>
            <a href="?filter=rejected" class="btn <%= "rejected".equals(filterStatus) ? "btn-danger" : "btn-outline-danger" %>">
                <i class="fas fa-times-circle"></i> Rejected
            </a>
            <a href="?filter=pending" class="btn <%= "pending".equals(filterStatus) ? "btn-secondary" : "btn-outline-secondary" %>">
                <i class="fas fa-hourglass-half"></i> Awaiting Payment
            </a>
        </div>
            
        <div class="alert alert-success">
            <strong><i class="fas fa-check-circle"></i> Found <%= totalCount %> payment records</strong>
            </div>
            
        <% if (totalCount == 0) { %>
            <div class="alert alert-warning">
                <i class="fas fa-info-circle"></i> No payments found for filter: <strong><%= filterStatus %></strong>
            </div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-hover table-bordered">
                        <thead>
                            <tr>
                            <th>Trans ID</th>
                            <th>App ID</th>
                                <th>Applicant</th>
                            <th>NIC</th>
                            <th>Payment Method</th>
                            <th>Amount (LKR)</th>
                                <th>Reference</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                    <tbody>
                        <% for (Map<String, String> p : payments) { 
                            String statusClass = "status-" + p.get("status");
                        %>
                        <tr>
                            <td><%= p.get("transactionId") %></td>
                            <td>#<%= p.get("applicationId") %></td>
                            <td><%= p.get("applicantName") %></td>
                            <td><small><%= p.get("nic") %></small></td>
                            <td><%= p.get("paymentMethod") %></td>
                            <td><strong><%= p.get("totalAmount") %></strong></td>
                            <td><small><%= p.get("paymentReference") %></small></td>
                            <td><small><%= p.get("transactionDate") %></small></td>
                            <td><span class="<%= statusClass %>"><%= p.get("status").toUpperCase() %></span></td>
                            <td>
                                <% if ("completed".equals(p.get("status"))) { %>
                                    <button class="btn btn-sm btn-success" onclick="approvePayment('<%= p.get("transactionId") %>')">
                                        <i class="fas fa-check"></i> Verify
                                    </button>
                                    <button class="btn btn-sm btn-danger" onclick="rejectPayment('<%= p.get("transactionId") %>')">
                                        <i class="fas fa-times"></i> Reject
                                    </button>
                                <% } else if ("verified".equals(p.get("status"))) { %>
                                    <a href="payment-invoice.jsp?transactionId=<%= p.get("paymentReference") %>&applicationId=<%= p.get("applicationId") %>" 
                                       class="btn btn-sm btn-primary" target="_blank">
                                        <i class="fas fa-file-invoice"></i> Invoice
                                    </a>
                                    <span class="badge bg-success ms-1"><i class="fas fa-check-circle"></i> Verified</span>
                                <% } else if ("rejected".equals(p.get("status"))) { %>
                                    <span class="badge bg-danger"><i class="fas fa-times-circle"></i> Rejected by Staff</span>
                                <% } else if ("pending".equals(p.get("status"))) { %>
                                    <span class="badge bg-secondary"><i class="fas fa-hourglass-half"></i> Awaiting Payment</span>
                                <% } else { %>
                                    <span class="text-muted">No actions</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
            </div>
        <% } %>
        
        <hr>
        <p class="text-muted text-center">
            <small>Payment Approval System v1.0 | E-Passport Department</small>
        </p>
    </div>
    
    <!-- Approve Modal -->
    <div class="modal fade" id="approveModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title"><i class="fas fa-check-circle me-2"></i>Verify and Approve Payment</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to verify and approve this payment?</p>
                    <p><strong>This action will:</strong></p>
                    <ul>
                        <li>Mark the payment as <strong>verified</strong> (staff approved)</li>
                        <li>Update the application payment status to <strong>paid</strong></li>
                        <li>Allow the applicant to view their payment invoice</li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-success" id="confirmApprove">
                        <i class="fas fa-check"></i> Verify Payment
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Reject Modal -->
    <div class="modal fade" id="rejectModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title"><i class="fas fa-times-circle me-2"></i>Reject Payment</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to reject this payment?</p>
                    <p><strong>This action will:</strong></p>
                    <ul>
                        <li>Mark the payment as <strong>failed</strong></li>
                        <li>The payment will need to be resubmitted by the applicant</li>
                    </ul>
                    <div class="mb-3">
                        <label class="form-label">Reason for rejection (optional):</label>
                        <textarea class="form-control" id="rejectNotes" rows="3" placeholder="Enter reason for rejection..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmReject">
                        <i class="fas fa-times"></i> Reject Payment
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let currentTransactionId = null;
        
        function approvePayment(txId) {
            currentTransactionId = txId;
            const modal = new bootstrap.Modal(document.getElementById('approveModal'));
            modal.show();
        }
        
        function rejectPayment(txId) {
            currentTransactionId = txId;
            document.getElementById('rejectNotes').value = '';
            const modal = new bootstrap.Modal(document.getElementById('rejectModal'));
            modal.show();
        }
        
        document.getElementById('confirmApprove').addEventListener('click', function() {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'payment-action-handler.jsp';
            
            const txIdInput = document.createElement('input');
            txIdInput.type = 'hidden';
            txIdInput.name = 'transactionId';
            txIdInput.value = currentTransactionId;
            form.appendChild(txIdInput);
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'approve';
            form.appendChild(actionInput);
            
            document.body.appendChild(form);
            form.submit();
        });
        
        document.getElementById('confirmReject').addEventListener('click', function() {
            const notes = document.getElementById('rejectNotes').value;
            
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'payment-action-handler.jsp';
            
            const txIdInput = document.createElement('input');
            txIdInput.type = 'hidden';
            txIdInput.name = 'transactionId';
            txIdInput.value = currentTransactionId;
            form.appendChild(txIdInput);
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'reject';
            form.appendChild(actionInput);
            
            const notesInput = document.createElement('input');
            notesInput.type = 'hidden';
            notesInput.name = 'notes';
            notesInput.value = notes;
            form.appendChild(notesInput);
            
            document.body.appendChild(form);
            form.submit();
        });
    </script>
</body>
</html>
