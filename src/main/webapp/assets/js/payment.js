// Payment Management System JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Initialize the application
    initializePaymentForm();
    initializeHistoryPage();
});

// Payment Form Functions
function initializePaymentForm() {
    const paymentForm = document.getElementById('paymentForm');
    if (paymentForm) {
        paymentForm.addEventListener('submit', handlePaymentSubmit);
        
        // Add real-time validation
        const cardNumberInput = document.getElementById('cardNumber');
        if (cardNumberInput) {
            cardNumberInput.addEventListener('input', formatCardNumber);
        }
        
        const expiryInput = document.getElementById('expiry');
        if (expiryInput) {
            expiryInput.addEventListener('input', formatExpiry);
        }
        
        const cvvInput = document.getElementById('cvv');
        if (cvvInput) {
            cvvInput.addEventListener('input', formatCVV);
        }
    }
}

function handlePaymentSubmit(event) {
    event.preventDefault();
    
    const formData = new FormData(event.target);
    const cardNumber = formData.get('cardNumber');
    const expiry = formData.get('expiry');
    const cvv = formData.get('cvv');
    const amount = parseFloat(formData.get('amount'));
    
    // Client-side validation
    if (!validateCardNumber(cardNumber)) {
        alert('Please enter a valid card number.\n\nValid test cards:\n• Visa: 4111 1111 1111 1111\n• Mastercard: 5555 5555 5555 4444\n• Amex: 3782 8224 6310 005');
        return;
    }
    
    if (!validateExpiry(expiry)) {
        alert('Please enter a valid expiry date (MM/YY)');
        return;
    }
    
    if (!validateCVV(cvv)) {
        alert('Please enter a valid CVV (3-4 digits)');
        return;
    }
    
    if (amount <= 0) {
        alert('Please enter a valid amount');
        return;
    }
    
    // Show loading state
    const submitButton = event.target.querySelector('button[type="submit"]');
    const originalText = submitButton.textContent;
    submitButton.textContent = 'Processing...';
    submitButton.disabled = true;
    
    // Submit the form
    event.target.submit();
}

function formatCardNumber(event) {
    let value = event.target.value.replace(/\s/g, '').replace(/[^0-9]/gi, '');
    let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
    if (formattedValue.length > 19) {
        formattedValue = formattedValue.substr(0, 19);
    }
    event.target.value = formattedValue;
}

function formatExpiry(event) {
    let value = event.target.value.replace(/\D/g, '');
    if (value.length >= 2) {
        value = value.substring(0, 2) + '/' + value.substring(2, 4);
    }
    event.target.value = value;
}

function formatCVV(event) {
    let value = event.target.value.replace(/\D/g, '');
    if (value.length > 4) {
        value = value.substring(0, 4);
    }
    event.target.value = value;
}

function validateCardNumber(cardNumber) {
    // Remove spaces and non-digits
    const digits = cardNumber.replace(/\s/g, '').replace(/\D/g, '');
    
    // Debug logging
    console.log('Card number input:', cardNumber);
    console.log('Digits only:', digits);
    console.log('Length:', digits.length);
    
    // Check if it's a valid length (13-19 digits)
    if (digits.length < 13 || digits.length > 19) {
        console.log('Invalid length:', digits.length);
        return false;
    }
    
    // Luhn algorithm validation
    let sum = 0;
    let alternate = false;
    
    for (let i = digits.length - 1; i >= 0; i--) {
        let n = parseInt(digits.charAt(i), 10);
        
        if (alternate) {
            n *= 2;
            if (n > 9) {
                n = (n % 10) + 1;
            }
        }
        
        sum += n;
        alternate = !alternate;
    }
    
    const isValid = (sum % 10) === 0;
    console.log('Luhn sum:', sum, 'Valid:', isValid);
    return isValid;
}

function validateExpiry(expiry) {
    const regex = /^(0[1-9]|1[0-2])\/\d{2}$/;
    if (!regex.test(expiry)) {
        return false;
    }
    
    const [month, year] = expiry.split('/');
    const currentDate = new Date();
    const currentYear = currentDate.getFullYear() % 100;
    const currentMonth = currentDate.getMonth() + 1;
    
    const expYear = parseInt(year, 10);
    const expMonth = parseInt(month, 10);
    
    if (expYear < currentYear || (expYear === currentYear && expMonth < currentMonth)) {
        return false;
    }
    
    return true;
}

function validateCVV(cvv) {
    const regex = /^\d{3,4}$/;
    return regex.test(cvv);
}

// History Page Functions
function initializeHistoryPage() {
    const searchForm = document.getElementById('searchForm');
    if (searchForm) {
        searchForm.addEventListener('submit', handleHistorySearch);
    }
}

function handleHistorySearch(event) {
    event.preventDefault();
    
    const formData = new FormData(event.target);
    const applicantId = formData.get('applicantId');
    
    if (!applicantId) {
        alert('Please enter an Applicant ID');
        return;
    }
    
    // Show loading state
    showLoading();
    
    // Simulate API call (replace with actual API call)
    setTimeout(() => {
        hideLoading();
        // For demo purposes, show a message that no API is implemented
        showNoResults();
    }, 1000);
}

function showLoading() {
    document.getElementById('loading').style.display = 'block';
    document.getElementById('noResults').style.display = 'none';
    document.getElementById('results').style.display = 'none';
}

function hideLoading() {
    document.getElementById('loading').style.display = 'none';
}

function showNoResults() {
    document.getElementById('noResults').style.display = 'block';
    document.getElementById('results').style.display = 'none';
}

function showResults(payments) {
    const resultsDiv = document.getElementById('results');
    const tableBody = document.getElementById('paymentTableBody');
    
    // Clear existing rows
    tableBody.innerHTML = '';
    
    // Add payment rows
    payments.forEach(payment => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${payment.paymentId}</td>
            <td>$${payment.amount.toFixed(2)}</td>
            <td>${formatDate(payment.paymentDate)}</td>
            <td><span class="status ${payment.status.toLowerCase()}">${payment.status}</span></td>
            <td>${payment.referenceNo}</td>
            <td>${payment.serviceType}</td>
        `;
        tableBody.appendChild(row);
    });
    
    resultsDiv.style.display = 'block';
    document.getElementById('noResults').style.display = 'none';
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString() + ' ' + date.toLocaleTimeString();
}

// Utility Functions
function showNotification(message, type = 'info') {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.textContent = message;
    
    // Style the notification
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 20px;
        background-color: ${type === 'error' ? '#e74c3c' : type === 'success' ? '#27ae60' : '#3498db'};
        color: white;
        border-radius: 4px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        z-index: 1000;
        animation: slideIn 0.3s ease-out;
    `;
    
    // Add to page
    document.body.appendChild(notification);
    
    // Remove after 3 seconds
    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease-in';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }, 3000);
}

// Add CSS animations
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);
