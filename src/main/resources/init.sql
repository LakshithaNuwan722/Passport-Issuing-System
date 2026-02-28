CREATE DATABASE IF NOT EXISTS lanka_epassport_system;
USE lanka_epassport_system;

CREATE TABLE IF NOT EXISTS login_credentials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nic_number VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    nic_number VARCHAR(20) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    current_address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    processing_type ENUM('regular', 'express') NOT NULL,
    biometric_date DATE,
    payment_status ENUM('pending', 'paid', 'failed', 'refunded') DEFAULT 'pending',
    payment_date DATETIME NULL,
    status ENUM('submitted', 'payment_verified', 'approved', 'rejected') DEFAULT 'submitted',

    FOREIGN KEY (nic_number) REFERENCES login_credentials(nic_number)
);

CREATE TABLE IF NOT EXISTS application_documents (
    document_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL,
    document_type ENUM('passport_photo', 'birth_certificate', 'address_proof', 'signature') NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    file_size INT NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    FOREIGN KEY (application_id) REFERENCES applications(application_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS application_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL UNIQUE,
    personal_info_approved BOOLEAN DEFAULT FALSE,
    personal_info_reviewed_by VARCHAR(100) NULL,
    personal_info_reviewed_at DATETIME NULL,
    
    address_info_approved BOOLEAN DEFAULT FALSE,
    address_info_reviewed_by VARCHAR(100) NULL,
    address_info_reviewed_at DATETIME NULL,
    
    documents_approved BOOLEAN DEFAULT FALSE,
    documents_reviewed_by VARCHAR(100) NULL,
    documents_reviewed_at DATETIME NULL,
    
    biometric_completed BOOLEAN DEFAULT FALSE,
    biometric_reviewed_by VARCHAR(100) NULL,
    biometric_reviewed_at DATETIME NULL,
    
    final_approval_status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    final_reviewed_by VARCHAR(100) NULL,
    final_reviewed_at DATETIME NULL,
    rejection_reason TEXT NULL,
    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (application_id) REFERENCES applications(application_id) ON DELETE CASCADE
);

CREATE TABLE staff_credentials (
                                   staff_id INT PRIMARY KEY AUTO_INCREMENT,
                                   username VARCHAR(100) UNIQUE NOT NULL,
                                   password VARCHAR(255) NOT NULL,
                                   section VARCHAR(50) NOT NULL,
                                   is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS payment_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL,
    payment_method ENUM('credit_card', 'debit_card', 'bank_transfer', 'paypal') NOT NULL,
    processing_type ENUM('regular', 'express') NOT NULL,
    processing_fee DECIMAL(10,2) NOT NULL,
    service_fee DECIMAL(10,2) NOT NULL,
    tax_amount DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    transaction_status ENUM('pending', 'completed', 'failed', 'cancelled') DEFAULT 'pending',
    payment_reference VARCHAR(100) NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes TEXT NULL,
    
    FOREIGN KEY (application_id) REFERENCES applications(application_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS helpdesk_faq (
    faq_id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    category VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_by VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES staff_credentials(username)
);

CREATE TABLE IF NOT EXISTS applications_printed (
    printed_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL,
    nic_number VARCHAR(20) NOT NULL,
    status VARCHAR(50) DEFAULT 'printed',
    printed_by VARCHAR(100) NULL,
    printed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES applications(application_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS deliveries (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL,
    tracking_number VARCHAR(50) NOT NULL UNIQUE,
    delivery_date DATETIME NOT NULL,
    recipient_name VARCHAR(200) NOT NULL,
    recipient_id_verification VARCHAR(100) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES applications(application_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    subject VARCHAR(200) NOT NULL,
    answer TEXT NULL,
    category VARCHAR(50) DEFAULT 'general',
    user_name VARCHAR(200) NULL,
    user_email VARCHAR(100) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO staff_credentials (username, password, section, is_active) VALUES
                                                                           ('staff_application','111','application', TRUE),
                                                                           ('staff_payment','222','payment', TRUE),
                                                                           ('staff_print','333','print', TRUE),
                                                                           ('staff_logistic','444','logistic', TRUE),
                                                                           ('staff_helpdesk','555','helpdesk', TRUE);

-- Insert some sample FAQ data
INSERT INTO helpdesk_faq (question, answer, category, created_by) VALUES
('How do I apply for a new passport?', 'To apply for a new passport, follow these steps: 1) Visit our website and click on "New Application" 2) Create an account using your NIC number and email 3) Fill out the online application form with your personal details 4) Upload required documents 5) Select your preferred processing type 6) Book a biometric appointment 7) Submit your application and make payment', 'application', 'staff_helpdesk'),
('What are the passport fees?', 'Our passport service fees are: New Passport (Regular): Rs. 15,000, New Passport (Express): Rs. 20,000, Passport Renewal (Regular): Rs. 12,000, Passport Renewal (Express): Rs. 17,000, Lost Passport Replacement: Rs. 20,000', 'payment', 'staff_helpdesk'),
('What documents do I need to upload?', 'You need to upload: Passport Size Photo (2MB max, JPG/PNG), Birth Certificate (5MB max, PDF), Address Proof (5MB max, PDF), Signature (2MB max, JPG/PNG)', 'documents', 'staff_helpdesk'),
('How long does it take to process a passport?', 'Processing times vary: Regular Processing: 7-10 business days, Express Processing: 3-5 business days, Lost Passport Replacement: 1-2 business days', 'processing', 'staff_helpdesk');

