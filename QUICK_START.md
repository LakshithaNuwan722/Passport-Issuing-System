# Quick Start Guide - Application Review System

## 🚀 Get Started in 3 Steps

### Step 1: Run Database Migration (Required!)

Choose ONE method:

**Method A - Command Line:**
```bash
mysql -u root -p lanka_epassport_system < src/main/resources/migrate_to_separate_review_table.sql
```

**Method B - MySQL Workbench/phpMyAdmin:**
1. Open your MySQL client
2. Select `lanka_epassport_system` database
3. Copy and paste contents of `src/main/resources/migrate_to_separate_review_table.sql`
4. Execute

**Method C - Manual (Simple):**
```sql
USE lanka_epassport_system;

-- Add status column
ALTER TABLE applications 
ADD COLUMN status ENUM('submitted', 'payment_verified', 'approved', 'rejected') DEFAULT 'submitted' 
AFTER payment_date;

-- Create reviews table  
CREATE TABLE application_reviews (
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
```

### Step 2: Create Test Data

```sql
-- Set application to payment_verified for testing
UPDATE applications 
SET status = 'payment_verified', 
    payment_status = 'paid',
    payment_date = NOW()
WHERE application_id = 1;

-- Verify
SELECT application_id, first_name, last_name, status, payment_status 
FROM applications 
WHERE payment_status = 'paid' AND status = 'payment_verified';
```

### Step 3: Rebuild & Test

1. **Rebuild in IntelliJ IDEA:**
   - Build → Rebuild Project

2. **Restart Tomcat**

3. **Open browser and test:**
   ```
   http://localhost:8081/Passport_Issuing_war_exploded/login.jsp?section=application
   ```
   
4. **Login:**
   - Username: `staff_application`
   - Password: `111`

5. **You should see:**
   - ✅ Application Review Dashboard
   - ✅ Payment-verified applications list
   - ✅ "View & Review" buttons

## What to Expect

### Dashboard View:
- Lists all applications with `payment_status='paid'` AND `status='payment_verified'`
- Shows: Application ID, Name, NIC, Processing Type
- Clear filter indicator showing only payment-verified apps

### Review Modal:
1. **Personal Information** - Approve/Reject
2. **Address Information** - Approve/Reject  
3. **Documents** - View and Approve/Reject (with image previews & PDF downloads)
4. **Biometric Appointment** - Mark Completed/Not Completed (only after sections 1-3 approved)
5. **Final Approval** - Grant/Reject (only after all sections complete)

### Progress Tracking:
- Visual progress indicator
- Color-coded approval states (green=approved, yellow=pending)
- Real-time updates after each action

## Verify It Works

After approving an application, check the database:

```sql
-- See review data
SELECT * FROM application_reviews WHERE application_id = 1;

-- See updated status
SELECT application_id, status FROM applications WHERE application_id = 1;

-- Full join view
SELECT a.application_id, a.first_name, a.status,
       r.personal_info_approved, r.address_info_approved, 
       r.documents_approved, r.biometric_completed,
       r.final_approval_status
FROM applications a
LEFT JOIN application_reviews r ON a.application_id = r.application_id
WHERE a.application_id = 1;
```

## Troubleshooting

### ❌ "No applications found"
```sql
-- Check if any exist
SELECT * FROM applications WHERE payment_status='paid';

-- If not, create one:
UPDATE applications SET status='payment_verified', payment_status='paid' WHERE application_id=1;
```

### ❌ Page shows blank/404
1. Check Tomcat logs for errors
2. Rebuild project: Build → Rebuild Project
3. Restart Tomcat
4. Clear browser cache

### ❌ "Table 'application_reviews' doesn't exist"
Run the migration script (Step 1)

### ❌ SQL errors about columns
The migration adds the `status` column and creates the `application_reviews` table. Make sure it ran successfully:
```sql
DESCRIBE applications;
DESCRIBE application_reviews;
```

## Need Help?

1. Check `UPDATED_MIGRATION_GUIDE.md` for detailed migration instructions
2. Check `IMPLEMENTATION_SUMMARY.md` for complete technical details
3. Check server logs at: `[TOMCAT]/logs/catalina.out`

---

**Ready?** Start with Step 1 above! 🚀

