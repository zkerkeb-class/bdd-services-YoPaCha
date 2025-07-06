-- Database initialization script for StoryGenerator

-- Create database (run as superuser)
-- CREATE DATABASE storygenerator;

-- Connect to the database and create tables
\c storygenerator;

-- Execute the schema
\i schema.sql;

-- Insert default subscription types data
INSERT INTO userSubscriptions (user_id, subscription_type, stories_limit, stories_used, last_renewal_date, next_renewal_date) VALUES
(1, 'free', 5, 0, CURRENT_DATE, CURRENT_DATE + INTERVAL '30 days'),
(2, 'basic', 50, 0, CURRENT_DATE, CURRENT_DATE + INTERVAL '30 days'),
(3, 'premium', 200, 0, CURRENT_DATE, CURRENT_DATE + INTERVAL '30 days')
ON CONFLICT DO NOTHING;

-- Sample users for testing (passwords should be hashed in real implementation)
INSERT INTO users (email, password_hash, username) VALUES
('test@example.com', '$2b$10$sample_hash_here', 'testuser'),
('premium@example.com', '$2b$10$sample_hash_here', 'premiumuser'),
('basic@example.com', '$2b$10$sample_hash_here', 'basicuser')
ON CONFLICT DO NOTHING;