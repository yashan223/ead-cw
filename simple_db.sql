-- Simple Database Schema for Admin and User Login System
-- Author: Yashan Perera
-- Date: July 6, 2025

-- Drop database if exists and create new one
DROP DATABASE IF EXISTS deepEAD;
CREATE DATABASE deepEAD;
USE deepEAD;

-- Users table for authentication (matching existing structure)
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `user_type` varchar(30) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert default admin and user accounts
INSERT INTO `users` (`username`, `password`, `user_type`, `full_name`, `email`, `phone`, `is_active`) VALUES
('admin', 'admin123', 'Administrator', 'System Administrator', 'admin@example.com', '0711111111', 1),
('user', 'user123', 'User', 'Demo User', 'user@example.com', '0722222222', 1);

-- --------------------------------------------------------

-- Students table
CREATE TABLE `students` (
  `student_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_number` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `grade` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `parent_name` varchar(100) DEFAULT NULL,
  `parent_phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `student_number` (`student_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample student data
INSERT INTO `students` (`student_number`, `first_name`, `last_name`, `grade`, `phone`, `email`, `parent_name`, `parent_phone`, `address`, `is_active`) VALUES
('S0001', 'John', 'Doe', 'Grade 10', '0771234567', 'john.doe@email.com', 'Jane Doe', '0771234568', '123 Main Street, Colombo', 1),
('S0002', 'Alice', 'Smith', 'Grade 4', '0771234569', 'alice.smith@email.com', 'Bob Smith', '0771234570', '456 Oak Avenue, Kandy', 1);

-- --------------------------------------------------------

-- Teachers table
CREATE TABLE `teachers` (
  `teacher_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `grade` varchar(20) NOT NULL,
  `qualification` varchar(200) NOT NULL,
  `experience_years` int(11) DEFAULT 0,
  `salary` decimal(10,2) NOT NULL,
  `date_registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Active','Inactive') DEFAULT 'Active',
  PRIMARY KEY (`teacher_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample teacher data
INSERT INTO `teachers` (`first_name`, `last_name`, `email`, `phone`, `subject`, `grade`, `qualification`, `experience_years`, `salary`, `status`) VALUES
('Michael', 'Johnson', 'michael.johnson@school.edu', '0771234571', 'Mathematics', 'Grade 10', 'BSc Mathematics, BEd', 5, 55000.00, 'Active'),
('Sarah', 'Williams', 'sarah.williams@school.edu', '0771234572', 'English', 'Grade 4', 'BA English Literature, TESOL', 3, 45000.00, 'Active');

-- --------------------------------------------------------

-- Teacher Subject Assignments table
CREATE TABLE `teacher_subject_assignments` (
  `assignment_id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(11) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `grade` varchar(20) NOT NULL,
  `schedule` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `date_assigned` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`assignment_id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `idx_subject_grade` (`subject`, `grade`),
  CONSTRAINT `fk_teacher_assignment` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample assignment data
INSERT INTO `teacher_subject_assignments` (`teacher_id`, `subject`, `grade`, `schedule`, `remarks`, `is_active`) VALUES
(1, 'Mathematics', 'Grade 10', 'Mon-Wed-Fri 9:00-10:00', 'Advanced Mathematics curriculum', 1),
(2, 'English', 'Grade 4', 'Tue-Thu 10:00-11:00', 'Basic English comprehension', 1);

-- --------------------------------------------------------

-- Student Class Enrollments table
CREATE TABLE `student_class_enrollments` (
  `enrollment_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `enrollment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Active','Inactive','Pending','Completed','Dropped') DEFAULT 'Active',
  `grade_achieved` varchar(5) DEFAULT NULL,
  `attendance_percentage` decimal(5,2) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`enrollment_id`),
  KEY `student_id` (`student_id`),
  KEY `assignment_id` (`assignment_id`),
  KEY `idx_student_status` (`student_id`, `status`),
  KEY `idx_enrollment_date` (`enrollment_date`),
  CONSTRAINT `fk_student_enrollment` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_assignment_enrollment` FOREIGN KEY (`assignment_id`) REFERENCES `teacher_subject_assignments` (`assignment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample enrollment data
INSERT INTO `student_class_enrollments` (`student_id`, `assignment_id`, `status`, `attendance_percentage`, `remarks`) VALUES
(1, 1, 'Active', 95.50, 'Excellent participation in advanced mathematics'),
(2, 2, 'Active', 88.20, 'Good progress in English comprehension');

-- Display database summary
SELECT 'Database Setup Complete!' as status;
SELECT 'Users created:' as info, COUNT(*) as count FROM users;
SELECT 'Students created:' as info, COUNT(*) as count FROM students;
SELECT 'Teachers created:' as info, COUNT(*) as count FROM teachers;
SELECT 'Assignments created:' as info, COUNT(*) as count FROM teacher_subject_assignments;
SELECT 'Enrollments created:' as info, COUNT(*) as count FROM student_class_enrollments;
