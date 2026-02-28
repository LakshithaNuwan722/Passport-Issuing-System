-- Create test data for application review system
USE lanka_epassport_system;

-- Step 1: Check if we have applications
SELECT 'Current applications:' AS Info;
SELECT application_id, first_name, last_name FROM applications LIMIT 5;

-- Step 2: Create a payment transaction for the first application
-- (This will error if one already exists, that's OK)
INSERT INTO payment_transactions 
(application_id, payment_method, processing_type, processing_fee, service_fee, tax_amount, total_amount, transaction_status, payment_reference, transaction_date)
VALUES 
(1, 'credit_card', 'regular', 15000.00, 1500.00, 2625.00, 19125.00, 'completed', 'PAY123456', NOW());

-- Step 3: Verify the payment was created
SELECT 'Payment transactions created:' AS Info;
SELECT pt.transaction_id, pt.application_id, pt.transaction_status, pt.transaction_date,
       a.first_name, a.last_name
FROM payment_transactions pt
INNER JOIN applications a ON pt.application_id = a.application_id
WHERE pt.transaction_status = 'completed';

-- Step 4: Test the exact query from servlet
SELECT 'Applications that should appear in review dashboard:' AS Info;
SELECT a.application_id, a.first_name, a.last_name, a.email,
       pt.transaction_status, pt.transaction_date
FROM applications a 
INNER JOIN payment_transactions pt ON a.application_id = pt.application_id
WHERE pt.transaction_status = 'completed'
ORDER BY pt.transaction_date DESC;

SELECT 'TEST DATA CREATED! If you see applications above, rebuild and restart Tomcat.' AS Status;

