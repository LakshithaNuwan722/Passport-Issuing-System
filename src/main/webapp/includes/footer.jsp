<!-- Footer -->
<footer class="footer py-5">
  <div class="container">
    <div class="row g-4">
      <div class="col-lg-4">
        <h5 class="mb-3">
          <i class="fas fa-passport me-2"></i>
          Lanka Epassport Service
        </h5>
        <p class="text-muted mb-3">
          Official passport issuing service of the Government of Sri Lanka. 
          Providing secure, efficient, and reliable passport services for all citizens.
        </p>
        <div class="social-links">
          <a href="#" class="text-white"><i class="fab fa-facebook"></i></a>
          <a href="#" class="text-white"><i class="fab fa-twitter"></i></a>
          <a href="#" class="text-white"><i class="fab fa-linkedin"></i></a>
          <a href="#" class="text-white"><i class="fab fa-instagram"></i></a>
        </div>
      </div>
      <div class="col-lg-2">
        <h6 class="mb-3">Services</h6>
        <ul class="list-unstyled">
          <li><a href="application.jsp" class="text-muted text-decoration-none">New Passport</a></li>
          <li><a href="application.jsp" class="text-muted text-decoration-none">Passport Renewal</a></li>
          <li><a href="application.jsp" class="text-muted text-decoration-none">Lost Passport</a></li>
          <li><a href="application.jsp" class="text-muted text-decoration-none">Express Service</a></li>
        </ul>
      </div>
      <div class="col-lg-2">
        <h6 class="mb-3">Support</h6>
        <ul class="list-unstyled">
          <li><a href="helpdesk.jsp" class="text-muted text-decoration-none">Help Center</a></li>
          <li><a href="helpdesk.jsp" class="text-muted text-decoration-none">FAQ</a></li>
          <li><a href="index.jsp#contact" class="text-muted text-decoration-none">Contact Us</a></li>
          <li><a href="helpdesk.jsp" class="text-muted text-decoration-none">Live Chat</a></li>
        </ul>
      </div>
      <div class="col-lg-4">
        <h6 class="mb-3">Newsletter</h6>
        <p class="text-muted mb-3">Subscribe to get updates on our services and special offers.</p>
        <div class="input-group">
          <label for="newsletterEmail" class="visually-hidden">Email Address</label>
          <input type="email" class="form-control" placeholder="Enter your email" id="newsletterEmail" name="email">
          <button class="btn btn-primary" type="button" onclick="subscribeNewsletter()">
            <i class="fas fa-paper-plane"></i>
          </button>
        </div>
        <small class="text-muted">Get updates on passport services and special offers</small>
      </div>
    </div>
    <hr class="my-4">
    <div class="row align-items-center">
      <div class="col-md-6">
        <small class="text-muted">&copy; 2024 Lanka Epassport Service - Government of Sri Lanka. All rights reserved.</small>
      </div>
      <div class="col-md-6 text-md-end">
        <small class="text-muted">
          <a href="#" class="text-muted text-decoration-none me-3">Privacy Policy</a>
          <a href="#" class="text-muted text-decoration-none me-3">Terms of Service</a>
          <a href="#" class="text-muted text-decoration-none">Cookie Policy</a>
        </small>
      </div>
    </div>
  </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- AOS Animation (if needed) -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
  // Initialize AOS if available
  if (typeof AOS !== 'undefined') {
    AOS.init({
      duration: 1000,
      once: true,
      offset: 100
    });
  }

  // Newsletter subscription
  function subscribeNewsletter() {
    const email = document.getElementById('newsletterEmail').value;
    if (email && email.includes('@')) {
      alert('Thank you for subscribing to our newsletter!');
      document.getElementById('newsletterEmail').value = '';
    } else {
      alert('Please enter a valid email address.');
    }
  }
</script>

