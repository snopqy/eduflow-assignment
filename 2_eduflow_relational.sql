-- ข้อที่ 4 สร้างตารางในฐานข้อมูลเชิงสัมพันธ์ จำนวน 3 Class
CREATE DATABASE IF NOT EXISTS eduflow_db;
USE eduflow_db;

-- 1. Table: users (ผู้ใช้งาน - Entity 1)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, -- Constraint: UNIQUE email
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Learner', 'Content Creator') NOT NULL DEFAULT 'Learner',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Table: categories (หมวดหมู่สื่อ - Entity 2)
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- 3. Table: contents (สื่อการเรียนรู้ดิจิทัล - Entity 3)
CREATE TABLE contents (
    content_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    content_type ENUM('Video', 'PDF', 'Text/Article', 'Audio') NOT NULL,
    status ENUM('Draft', 'Pending Review', 'Published') DEFAULT 'Draft',
    creator_id INT NOT NULL,
    category_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (creator_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE RESTRICT
);

-- ข้อ 4.1 เพิ่มข้อมูลตัวอย่างจำนวน 2 แถวในแต่ละตารางที่สร้าง
INSERT INTO users (username, email, password_hash, role) VALUES 
('somchai_learner', 'somchai@example.com', 'hashed_pass_1', 'Learner'),
('ajarn_creator', 'ajarn@example.com', 'hashed_pass_2', 'Content Creator');

INSERT INTO categories (category_name, description) VALUES 
('Programming & Tech', 'เนื้อหาเกี่ยวกับการเขียนโปรแกรมคอมพิวเตอร์และเทคโนโลยี'),
('Data Science & AI', 'เนื้อหาเกี่ยวกับวิทยาการข้อมูลและปัญญาประดิษฐ์');

INSERT INTO contents (title, description, content_type, status, creator_id, category_id) VALUES 
('Python for Beginners 2024', 'เรียนรู้พื้นฐาน Python ตั้งแต่เริ่มต้น เหมาะสำหรับผู้เรียนใหม่', 'Video', 'Published', 2, 1),
('Introduction to Machine Learning', 'เอกสาร PDF แนะนำแนวคิดของ Machine Learning เบื้องต้น', 'PDF', 'Published', 2, 2);
