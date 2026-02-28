# Application Review System - Implementation Complete

## Overview
A comprehensive application review system has been successfully implemented for the Lanka Epassport Service. This system allows application section staff to review payment-verified applications through a structured workflow with section-by-section approvals.

## What Was Implemented

### 1. Database Changes (init.sql)
- Added `status` column with values: 'submitted', 'payment_verified', 'approved', 'rejected'
- Added approval tracking columns:
  - `personal_info_approved` (BOOLEAN)
  - `address_info_approved` (BOOLEAN)
  - `documents_approved` (BOOLEAN)
  - `biometric_completed` (BOOLEAN)
- Added `reviewed_by` (VARCHAR) to track which staff member reviewed
- Added `review_date` (DATETIME) to track when the review was completed

### 2. Backend Implementation

#### Application.java Model (Updated)
- Added fields for all new database columns
- Added getters and setters for approval tracking
- Added support for review metadata

#### ApplicationReviewServlet.java (New)
Location: `src/main/java/com/example/passport_issuing/controller/ApplicationReviewServlet.java`

**Endpoints:**
- **GET** `/api/application-review`
  - `?status=payment_verified` - Get all payment-verified applications (default)
  - `?id={applicationId}` - Get specific application with documents
  
- **POST** `/api/application-review`
  - Parameters: `applicationId`, `action` (approve/reject), `section` (personal_info/address_info/documents/biometric)
  - Handles section-by-section approvals
  
- **PUT** `/api/application-review`
  - Parameters: `applicationId`, `action` (approve/reject)
  - Handles final approval/rejection of entire application

#### StaffLoginServlet.java (Updated)
- Modified redirect URL for application section to point to `application_review.jsp`

### 3. Frontend Implementation

#### application_review.jsp (New)
Location: `src/main/webapp/application_review.jsp`

**Features:**
1. **Dashboard View**
   - Lists all payment-verified applications
   - Shows key applicant information
   - "View & Review" button for each application

2. **Application Review Modal**
   - **Progress Indicator**: Visual progress showing which sections are completed
   
   - **Section 1: Personal Information**
     - Displays: First Name, Last Name, NIC, DOB, Email
     - Approve/Reject buttons
     - Visual indication when approved
   
   - **Section 2: Address Information**
     - Displays: Current Address, City, Postal Code
     - Approve/Reject buttons
     - Visual indication when approved
   
   - **Section 3: Documents**
     - Displays all 4 required documents:
       - Passport Size Photo (with image preview)
       - Birth Certificate PDF (with download link)
       - Address Proof PDF (with download link)
       - Signature Image (with image preview)
     - Approve/Reject buttons for entire document section
     - Visual indication when approved
   
   - **Section 4: Biometric Appointment**
     - Displays: Appointment Date, Processing Type
     - "Completed" / "Not Completed" buttons
     - Only enabled after all 3 previous sections are approved
   
   - **Final Approval Section**
     - "Grant Final Approval" button (only enabled when all sections + biometric are complete)
     - "Reject Application" button (always available)
     - Updates application status to 'approved' or 'rejected'

#### login.jsp (Updated)
- Modified to redirect application section staff to `application_review.jsp` after successful login

## How to Test the Complete Workflow

### Prerequisites
1. Ensure the database is updated with the new schema
2. Deploy the updated application to your server
3. Restart the application server

### Step 1: Login as Application Section Staff
1. Navigate to: `http://localhost:8081/Passport_Issuing_war_exploded/login.jsp?section=application`
2. Use credentials:
   - **Username:** `staff_application`
   - **Password:** `111`
3. Click "Login to Application Section"
4. You should be redirected to `application_review.jsp`

### Step 2: View Applications
1. The dashboard will load all payment-verified applications
2. If no applications are shown:
   - First, you need to create test applications
   - Set their status to 'payment_verified' in the database:
   ```sql
   UPDATE applications SET status = 'payment_verified' WHERE application_id = [ID];
   ```

### Step 3: Review an Application
1. Click "View & Review" button on any application
2. A modal will open showing all application details

### Step 4: Approve Sections (In Order)
1. **Personal Information Section:**
   - Review the applicant's personal details
   - Click "Approve" button
   - The section will turn green and show "Approved" badge
   
2. **Address Information Section:**
   - Review the address details
   - Click "Approve" button
   - The section will turn green and show "Approved" badge
   
3. **Documents Section:**
   - View each document (preview images, download PDFs)
   - Click "Approve Documents" button
   - The section will turn green and show "Approved" badge

4. **Biometric Appointment Section:**
   - This section becomes enabled after all above sections are approved
   - Review appointment details
   - Click "Completed" button to mark biometric as done

### Step 5: Final Approval
1. After all sections are approved and biometric is completed:
   - The "Grant Final Approval" button becomes enabled
2. Click "Grant Final Approval"
3. Confirm the action
4. The application status will be updated to 'approved'
5. The modal will close and the application list will refresh
6. The approved application will no longer appear in the payment-verified list

### Alternative: Reject Application
- At any point, you can click "Reject Application" button
- This will set the application status to 'rejected'
- The application will be removed from the review list

## Testing with SQL

### Create Test Data
```sql
-- Set an application to payment_verified status for testing
UPDATE applications 
SET status = 'payment_verified', 
    payment_status = 'paid',
    payment_date = NOW()
WHERE application_id = 1;
```

### Check Approval Status
```sql
-- View approval status of applications
SELECT 
    application_id,
    first_name,
    last_name,
    status,
    personal_info_approved,
    address_info_approved,
    documents_approved,
    biometric_completed,
    reviewed_by,
    review_date
FROM applications
WHERE status = 'payment_verified';
```

### Reset Application for Re-testing
```sql
-- Reset an application back to payment_verified with all sections unapproved
UPDATE applications 
SET 
    status = 'payment_verified',
    personal_info_approved = FALSE,
    address_info_approved = FALSE,
    documents_approved = FALSE,
    biometric_completed = FALSE,
    reviewed_by = NULL,
    review_date = NULL
WHERE application_id = 1;
```

## Key Features

### Security
- Staff authentication required (session-based)
- Only application section staff can access the review page
- All actions are logged with staff username and timestamp

### User Experience
- Responsive Bootstrap 5 design
- Color-coded approval states (green=approved, yellow=pending)
- Progress indicator showing workflow status
- Document preview for images (passport photo, signature)
- Download links for PDFs (birth certificate, address proof)
- Real-time updates after each action
- Confirmation dialogs for critical actions

### Workflow Logic
1. All three main sections (Personal, Address, Documents) must be approved first
2. Biometric section only becomes enabled after the first three are approved
3. Final approval button only becomes enabled when ALL sections including biometric are complete
4. Staff can reject at any point, which immediately changes application status

## API Endpoints Summary

### GET /api/application-review
- **Purpose:** Fetch applications for review
- **Parameters:** 
  - `status` (optional, default: payment_verified)
  - `id` (optional, for specific application)
- **Response:** JSON array of applications with documents

### POST /api/application-review
- **Purpose:** Approve/reject individual sections
- **Parameters:**
  - `applicationId` (required)
  - `action` (required: approve/reject)
  - `section` (required: personal_info/address_info/documents/biometric)
- **Response:** Success/error message

### PUT /api/application-review
- **Purpose:** Final approval/rejection of application
- **Parameters:**
  - `applicationId` (required)
  - `action` (required: approve/reject)
- **Response:** Success/error message with new status

## Files Modified/Created

### Created:
1. `src/main/java/com/example/passport_issuing/controller/ApplicationReviewServlet.java`
2. `src/main/webapp/application_review.jsp`

### Modified:
1. `src/main/resources/init.sql`
2. `src/main/java/com/example/passport_issuing/model/Application.java`
3. `src/main/java/com/example/passport_issuing/controller/StaffLoginServlet.java`
4. `src/main/webapp/login.jsp`

## Troubleshooting

### Issue: "No Applications Found"
**Solution:** Ensure you have applications with status='payment_verified' in the database

### Issue: Can't Access Review Page
**Solution:** 
- Verify you're logged in with correct staff credentials
- Check session is active
- Ensure servlet mapping is correct

### Issue: Documents Not Displaying
**Solution:**
- Verify file paths in database are correct
- Ensure files exist in the uploads directory
- Check file permissions

### Issue: Approval Buttons Not Working
**Solution:**
- Check browser console for JavaScript errors
- Verify servlet endpoints are accessible
- Ensure staff session is active

## Next Steps / Future Enhancements

1. Add rejection reason field for tracking why applications are rejected
2. Add email notifications when applications are approved/rejected
3. Add filter/search functionality on the dashboard
4. Add pagination for large numbers of applications
5. Add audit trail/history of all approval actions
6. Add ability to add comments during review
7. Export approved applications report

## Support

For issues or questions:
1. Check browser console for JavaScript errors
2. Check application server logs for Java exceptions
3. Verify database schema matches the updated init.sql
4. Ensure all files are deployed correctly

---

**Implementation Status:** ✅ COMPLETE

All features have been implemented and are ready for testing.

