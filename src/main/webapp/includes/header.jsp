<!-- Government-Style Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNavbar">
  <div class="container">
    <!-- Brand -->
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
</script>

