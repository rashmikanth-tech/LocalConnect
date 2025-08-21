
CREATE DATABASE localconnect;
USE localconnect;


CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    role ENUM('user', 'provider')
);

CREATE TABLE services (
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    service_name VARCHAR(100),
    location VARCHAR(100),
    contact VARCHAR(20),
    description TEXT,
    posted_by VARCHAR(100)
);

ALTER TABLE services ADD posted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE services ADD status ENUM('active', 'inactive') DEFAULT 'active';



SELECT * FROM services;

SELECT * FROM services WHERE status='active';
SELECT * FROM services WHERE service_name LIKE '%Plumber%';

ALTER TABLE services ADD COLUMN posted_by_id INT;
DESCRIBE services;
ALTER TABLE users ADD mobile VARCHAR(15);

CREATE TABLE service_bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    service_id INT,
    user_id INT,
    status VARCHAR(20), -- pending, accepted, rejected
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE service_bookings
MODIFY status VARCHAR(20) DEFAULT 'pending';

ALTER TABLE service_bookings
MODIFY service_id INT NOT NULL,
MODIFY user_id INT NOT NULL;


ALTER TABLE service_bookings
ADD CONSTRAINT fk_service
FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE;

ALTER TABLE service_bookings
ADD CONSTRAINT fk_user
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

SELECT id, service_name, posted_by_id FROM services;

ALTER TABLE service_bookings ADD COLUMN cancel_request BOOLEAN DEFAULT FALSE;



CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    user_id INT,
    provider_id INT,
    comment TEXT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT id, service_name, posted_by_id FROM services WHERE posted_by_id IS NULL;

SELECT AVG(rating) AS avgRating, COUNT(*) AS totalReviews
FROM reviews
WHERE provider_id = 1;

ALTER TABLE service_bookings ADD COLUMN reviewed BOOLEAN DEFAULT FALSE;

ALTER TABLE reviews
ADD CONSTRAINT fk_review_booking FOREIGN KEY (booking_id) REFERENCES service_bookings(id) ON DELETE CASCADE;

ALTER TABLE reviews
ADD CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE reviews
ADD CONSTRAINT fk_review_provider FOREIGN KEY (provider_id) REFERENCES users(id) ON DELETE CASCADE;

-- Get average rating and review count for a provider
-- SELECT AVG(rating) AS avgRating, COUNT(*) AS totalReviews
-- FROM reviews
-- WHERE provider_id = 1;

-- -- Get all reviews for a provider (including reviewer name)
-- SELECT r.*, u.name AS reviewer_name
-- FROM reviews r
-- JOIN users u ON r.user_id = u.id
-- WHERE r.provider_id = 1
-- ORDER BY r.created_at DESC;AA








