-- ==========================================
--  SCHOOL MANAGEMENT SYSTEM (MySQL)
--  Designed for Primary & Secondary Schools
--  Customized for Ethiopian school structure
-- ==========================================

-- ========================
-- USERS AND ROLES SECTION
-- ========================

CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(50) UNIQUE NOT NULL,
password_hash VARCHAR(255) NOT NULL,
role ENUM('Director','Vice_Academic_Director','HomeRoom_Teacher','Teacher','Secretary','Student','Parent') NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =====================
-- STUDENT INFORMATION
-- =====================

CREATE TABLE students (
id INT AUTO_INCREMENT PRIMARY KEY,
student_uid VARCHAR(10) UNIQUE NOT NULL, -- Example: SU0001
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
gender ENUM('Male','Female') NOT NULL,
date_of_birth DATE,
grade_level VARCHAR(20),
section VARCHAR(10),
parent_id INT,
home_room_teacher_id INT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (parent_id) REFERENCES users(id) ON DELETE SET NULL,
FOREIGN KEY (home_room_teacher_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ==================
-- TEACHER INFORMATION
-- ==================

CREATE TABLE teachers (
id INT AUTO_INCREMENT PRIMARY KEY,
teacher_uid VARCHAR(10) UNIQUE NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
subject_specialization VARCHAR(100),
user_id INT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===============
-- SUBJECTS TABLE
-- ===============

CREATE TABLE subjects (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
code VARCHAR(20) UNIQUE NOT NULL,
grade_level VARCHAR(20),
teacher_id INT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- =====================
-- CLASS ASSIGNMENTS
-- =====================

CREATE TABLE class_assignments (
id INT AUTO_INCREMENT PRIMARY KEY,
teacher_id INT NOT NULL,
subject_id INT NOT NULL,
grade_level VARCHAR(20),
section VARCHAR(10),
academic_year VARCHAR(10),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE CASCADE,
FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==================
-- WEIGHT SETTINGS
-- ==================

CREATE TABLE weight_settings (
id INT AUTO_INCREMENT PRIMARY KEY,
teacher_id INT NOT NULL,
subject_id INT NOT NULL,
term ENUM('Term_1','Term_2','Term_3') NOT NULL,
mid_term_weight FLOAT DEFAULT 0,
assignment_1_weight FLOAT DEFAULT 0,
assignment_2_weight FLOAT DEFAULT 0,
quiz_weight FLOAT DEFAULT 0,
attendance_weight FLOAT DEFAULT 0,
final_exam_weight FLOAT DEFAULT 0,
CHECK (
mid_term_weight + assignment_1_weight + assignment_2_weight +
quiz_weight + attendance_weight + final_exam_weight = 100
),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE CASCADE,
FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- =================
-- ASSESSMENTS TABLE
-- =================

CREATE TABLE assessments (
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT NOT NULL,
subject_id INT NOT NULL,
teacher_id INT NOT NULL,
term ENUM('Term_1','Term_2','Term_3') NOT NULL,
mid_term FLOAT DEFAULT 0,
assignment_1 FLOAT DEFAULT 0,
assignment_2 FLOAT DEFAULT 0,
quiz FLOAT DEFAULT 0,
attendance_score FLOAT DEFAULT 0,
final_exam FLOAT DEFAULT 0,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ================
-- GRADES TABLE
-- ================

CREATE TABLE grades (
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT NOT NULL,
subject_id INT NOT NULL,
term ENUM('Term_1','Term_2','Term_3') NOT NULL,
final_score FLOAT DEFAULT 0,
verified_by INT,
approved_by INT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL,
FOREIGN KEY (approved_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ===============
-- FEEDBACK TABLE
-- ===============

CREATE TABLE feedbacks (
id INT AUTO_INCREMENT PRIMARY KEY,
parent_id INT NOT NULL,
student_id INT NOT NULL,
home_room_teacher_id INT NOT NULL,
content TEXT NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (parent_id) REFERENCES users(id) ON DELETE CASCADE,
FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
FOREIGN KEY (home_room_teacher_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==================
-- ATTENDANCE TABLE
-- ==================

CREATE TABLE attendance (
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT NOT NULL,
subject_id INT NOT NULL,
date DATE NOT NULL,
status ENUM('Present','Absent','Late') NOT NULL,
recorded_by INT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
FOREIGN KEY (recorded_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ==========================
-- SYSTEM LOGS / AUDIT TABLE
-- ==========================

CREATE TABLE activity_logs (
id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
activity TEXT,
ip_address VARCHAR(50),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ====================
-- END OF DATABASE SCHEMA
-- ====================

-- Notes:
-- 1. Teachers can customize assessment weights in `weight_settings`.
-- 2. Assessments hold raw scores for each evaluation type.
-- 3. Final scores are computed (via backend logic) and stored in `grades`.
-- 4. Feedback from parents is visible to homeroom teachers.
-- 5. `ON DELETE CASCADE` ensures clean data management.
-- 6. System is ready for multi-role access control via `users.role`.
