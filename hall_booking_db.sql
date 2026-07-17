CREATE DATABASE IF NOT EXISTS hall_booking_db;
USE hall_booking_db;

DROP TABLE IF EXISTS booking_receipts;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS halls;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN','CUSTOMER') NOT NULL DEFAULT 'CUSTOMER',
    phone VARCHAR(20),
    status ENUM('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE halls (
    hall_id INT AUTO_INCREMENT PRIMARY KEY,
    hall_name VARCHAR(100) NOT NULL,
    location VARCHAR(150) NOT NULL,
    capacity INT NOT NULL,
    description TEXT,
    hourly_rate DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status ENUM('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    hall_id INT NOT NULL,
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    purpose VARCHAR(255) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    booking_status ENUM('PENDING','CONFIRMED','CANCELLED') NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (hall_id) REFERENCES halls(hall_id) ON DELETE CASCADE
);

CREATE TABLE booking_receipts (
    receipt_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    receipt_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10,2) NOT NULL,
    receipt_number VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
);

INSERT INTO users (name, email, password, role, phone) VALUES
('System Admin', 'admin@example.com', 'admin123', 'ADMIN', '0123456789'),
('Demo Customer', 'customer@example.com', 'customer123', 'CUSTOMER', '0198765432');

INSERT INTO halls (hall_name, location, capacity, description, hourly_rate, status) VALUES
('Main Hall', 'Block A', 200, 'Suitable for seminar and official event.', 150.00, 'ACTIVE'),
('Mini Hall', 'Block B', 80, 'Suitable for workshop and small meeting.', 80.00, 'ACTIVE'),
('Training Hall', 'Block C', 40, 'Suitable for training and class session.', 50.00, 'ACTIVE');
