<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Application</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<nav class="navbar navbar-dark bg-primary mb-3">
  <div class="container-fluid">
    <a class="navbar-brand" href="#"><i class="fas fa-id-card me-2"></i>Edit Application</a>
    <a href="<%= request.getContextPath() %>/applications.jsp" class="btn btn-sm btn-light">Back</a>
  </div>
</nav>
<div class="container mb-5">
  <div id="alertBox"></div>
  <div id="statusBadge" class="mb-3"></div>

  <form id="editForm" enctype="multipart/form-data">
    <input type="hidden" name="applicationId" id="applicationId">

    <ul class="nav nav-tabs" id="editTabs" role="tablist">
      <li class="nav-item" role="presentation"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tabPersonal" type="button">Personal</button></li>
      <li class="nav-item" role="presentation"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tabAddress" type="button">Address</button></li>
      <li class="nav-item" role="presentation"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tabDocs" type="button">Documents</button></li>
    </ul>
    <div class="tab-content border border-top-0 p-3 rounded-bottom">
      <div class="tab-pane fade show active" id="tabPersonal">
        <div class="row g-3">
          <div class="col-md-6"><label class="form-label">First Name</label><input class="form-control" name="firstName" id="firstName" required></div>
          <div class="col-md-6"><label class="form-label">Last Name</label><input class="form-control" name="lastName" id="lastName" required></div>
          <div class="col-md-6"><label class="form-label">NIC Number</label><input class="form-control" name="nicNumber" id="nicNumber" readonly style="background-color: #f8f9fa; cursor: not-allowed;"><small class="text-muted"><i class="fas fa-lock me-1"></i>NIC cannot be changed after application submission</small></div>
          <div class="col-md-6"><label class="form-label">Date of Birth</label><input type="date" class="form-control" name="dateOfBirth" id="dateOfBirth"></div>
          <div class="col-md-12"><label class="form-label">Email</label><input type="email" class="form-control" name="email" id="email" required></div>
        </div>
      </div>
      <div class="tab-pane fade" id="tabAddress">
        <div class="row g-3">
          <div class="col-md-12"><label class="form-label">Current Address</label><textarea class="form-control" name="currentAddress" id="currentAddress" rows="3"></textarea></div>
          <div class="col-md-6"><label class="form-label">City</label><input class="form-control" name="city" id="city"></div>
          <div class="col-md-6"><label class="form-label">Postal Code</label><input class="form-control" name="postalCode" id="postalCode"></div>
        </div>
      </div>
      <div class="tab-pane fade" id="tabDocs">
        <div class="row g-4">
          <div class="col-md-6">
            <label class="form-label">Passport Photo</label>
            <input type="file" class="form-control" name="passport_photo" accept="image/*">
          </div>
          <div class="col-md-6">
            <label class="form-label">Birth Certificate</label>
            <input type="file" class="form-control" name="birth_certificate" accept="application/pdf,image/*">
          </div>
          <div class="col-md-6">
            <label class="form-label">Address Proof</label>
            <input type="file" class="form-control" name="address_proof" accept="application/pdf,image/*">
          </div>
          <div class="col-md-6">
            <label class="form-label">Signature</label>
            <input type="file" class="form-control" name="signature" accept="image/*">
          </div>
        </div>
      </div>
    </div>

    <div class="mt-3 d-flex justify-content-end">
      <button type="submit" class="btn btn-primary" id="saveBtn"><i class="fas fa-save me-2"></i>Save Changes</button>
    </div>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
const bp = '<%= request.getContextPath() %>';

function showAlert(msg, type='info'){
  const box=document.getElementById('alertBox');
  const div=document.createElement('div');
  div.className=`alert alert-${type} alert-dismissible fade show`;
  div.innerHTML=`${msg}<button type="button" class="btn-close" data-bs-dismiss="alert"></button>`;
  box.appendChild(div);
  setTimeout(()=>div.remove(),5000);
}

function setLocked(locked){
  document.querySelectorAll('#editForm input, #editForm textarea, #editForm button[type=submit]').forEach(el=>{
    if(el.id==='applicationId' || el.id==='nicNumber') return; // Keep NIC always read-only
    el.disabled=locked;
  });
}

async function loadData(){
  const id = new URLSearchParams(window.location.search).get('id');
  if(!id){ showAlert('Missing application id','danger'); return; }
  document.getElementById('applicationId').value = id;
  try{
    const r = await fetch(bp + '/api/user/application?id=' + encodeURIComponent(id));
    if(!r.ok){ const e=await r.json().catch(()=>({})); throw new Error(e.error||'Failed to load'); }
    const d = await r.json();
    document.getElementById('firstName').value = d.firstName||'';
    document.getElementById('lastName').value = d.lastName||'';
    document.getElementById('nicNumber').value = d.nicNumber||'';
    if(d.dateOfBirth){ const dt=new Date(d.dateOfBirth); document.getElementById('dateOfBirth').value=dt.toISOString().slice(0,10); }
    document.getElementById('email').value = d.email||'';
    document.getElementById('currentAddress').value = d.currentAddress||'';
    document.getElementById('city').value = d.city||'';
    document.getElementById('postalCode').value = d.postalCode||'';
    const status = (d.status||'').toLowerCase();
    const badge = document.getElementById('statusBadge');
    badge.innerHTML = `<span class="badge ${status==='payment_verified'?'bg-primary':'bg-secondary'}">Status: ${d.status}</span>`;
    if(status==='payment_verified' || status==='approved' || status==='printed' || status==='delivered' || status==='rejected'){
      setLocked(true);
      showAlert('Editing is disabled after payment verification.','warning');
    }
  }catch(e){ showAlert(e.message,'danger'); }
}

async function saveData(ev){
  ev.preventDefault();
  const form = document.getElementById('editForm');
  const fd = new FormData(form);
  try{
    const r = await fetch(bp + '/api/user/application', { method:'POST', body: fd });
    const data = await r.json().catch(()=>({}));
    if(!r.ok){ throw new Error(data.error||'Failed to save'); }
    showAlert(data.message||'Saved','success');
    // Redirect back to applications list after a short delay
    setTimeout(() => { window.location.href = bp + '/applications.jsp'; }, 1500);
  }catch(e){ showAlert(e.message,'danger'); }
}

document.getElementById('editForm').addEventListener('submit', saveData);
document.addEventListener('DOMContentLoaded', loadData);
</script>
</body>
</html>
