-- Create application_reviews table
-- Copy and paste this into MySQL Workbench and execute

USE lanka_epassport_system;

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

-- Verify it was created
DESCRIBE application_reviews;

-- Also create test data if needed
UPDATE applications 
SET status = 'payment_verified', 
    payment_status = 'paid',
    payment_date = NOW()
WHERE application_id = 1;

-- Check the test data
SELECT application_id, first_name, last_name, status, payment_status 
FROM applications 
WHERE payment_status = 'paid' AND status = 'payment_verified';

SELECT 'Table created successfully! Now rebuild your project and restart Tomcat.' AS Status;

