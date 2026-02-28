-- Database setup script for questions table
-- Run this script to ensure the questions table has the correct structure

-- Drop and recreate the questions table to ensure correct structure
DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
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

-- Insert a test question to verify the structure
INSERT INTO questions (question, subject, category, user_name, user_email) 
VALUES ('Test question', 'General Inquiry', 'general', 'Test User', 'test@example.com');

-- Verify the table structure
DESCRIBE questions;

-- Check the test data
SELECT * FROM questions;
