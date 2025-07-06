-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2025 at 04:56 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `idk`
--

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `student_number` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `grade` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `parent_name` varchar(100) DEFAULT NULL,
  `parent_phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `student_number`, `first_name`, `last_name`, `grade`, `phone`, `email`, `parent_name`, `parent_phone`, `address`, `is_active`) VALUES
(1, 'S0001', 'Yashan', 'Perera', 'Grade 13', '0712731398', 'yashanpererax223@gmail.com', 'Shanthi Perera', '0770530966', '1/7/A Obahena Road Madiwela Kotte', 1);

-- --------------------------------------------------------

--
-- Table structure for table `student_class_enrollments`
--

CREATE TABLE `student_class_enrollments` (
  `enrollment_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `assignment_id` int(11) NOT NULL,
  `enrollment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Active','Inactive','Pending','Completed','Dropped') DEFAULT 'Active',
  `grade_achieved` varchar(5) DEFAULT NULL,
  `attendance_percentage` decimal(5,2) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_class_enrollments`
--

INSERT INTO `student_class_enrollments` (`enrollment_id`, `student_id`, `assignment_id`, `enrollment_date`, `status`, `grade_achieved`, `attendance_percentage`, `remarks`, `date_modified`) VALUES
(1, 1, 1, '2025-07-06 11:00:00', 'Active', NULL, 95.50, 'Excellent participation in advanced mathematics', '2025-07-06 11:00:00'),
(2, 1, 2, '2025-07-06 11:30:00', 'Active', NULL, 88.20, 'Good progress in English comprehension', '2025-07-06 11:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_subject_assignments`
--

CREATE TABLE `teacher_subject_assignments` (
  `assignment_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `grade` varchar(20) NOT NULL,
  `schedule` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `date_assigned` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_subject_assignments`
--

INSERT INTO `teacher_subject_assignments` (`assignment_id`, `teacher_id`, `subject`, `grade`, `schedule`, `remarks`, `date_assigned`, `is_active`) VALUES
(1, 1, 'Mathematics', 'Grade 10', 'Mon-Wed-Fri 9:00-10:00', 'Advanced Mathematics curriculum', '2025-07-06 10:00:00', 1),
(2, 2, 'English', 'Grade 4', 'Tue-Thu 10:00-11:00', 'Basic English comprehension', '2025-07-06 10:30:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `teacher_id` int(11) NOT NULL,
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
  `status` enum('Active','Inactive') DEFAULT 'Active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `first_name`, `last_name`, `email`, `phone`, `subject`, `grade`, `qualification`, `experience_years`, `salary`, `date_registered`, `status`) VALUES
(1, 'idk', 'idk', 'yashanpererax223@gmail.com', '07700530966', 'Sinhala', 'Grade 6', '2years', 3, 2000.00, '2025-06-10 04:46:42', 'Active'),
(2, 'Idunil', 'IDK', 'inunil223@gmail.com', '+94762719992', 'English', 'Grade 4', 'Gradsadsa', 2, 40000.00, '2025-06-24 09:50:52', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `user_type` varchar(30) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `user_type`, `full_name`, `email`, `phone`, `is_active`) VALUES
(1, 'admin', 'admin123', 'Administrator', 'System Administrator', 'admin@example.com', '0711111111', 1),
(2, 'user', 'user123', 'User', 'Demo User', 'user@example.com', '0722222222', 1),
(6, 'deep', 'deep123', 'Administrator', 'Yashan Perera', 'yashanpererax223@gmail.com', '+94762719992', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `student_number` (`student_number`);

--
-- Indexes for table `student_class_enrollments`
--
ALTER TABLE `student_class_enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `assignment_id` (`assignment_id`),
  ADD KEY `idx_student_status` (`student_id`, `status`),
  ADD KEY `idx_enrollment_date` (`enrollment_date`);

--
-- Indexes for table `teacher_subject_assignments`
--
ALTER TABLE `teacher_subject_assignments`
  ADD PRIMARY KEY (`assignment_id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `idx_subject_grade` (`subject`, `grade`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacher_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_class_enrollments`
--
ALTER TABLE `student_class_enrollments`
  MODIFY `enrollment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `teacher_subject_assignments`
--
ALTER TABLE `teacher_subject_assignments`
  MODIFY `assignment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Constraints for table `student_class_enrollments`
--
ALTER TABLE `student_class_enrollments`
  ADD CONSTRAINT `fk_student_enrollment` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_assignment_enrollment` FOREIGN KEY (`assignment_id`) REFERENCES `teacher_subject_assignments` (`assignment_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher_subject_assignments`
--
ALTER TABLE `teacher_subject_assignments`
  ADD CONSTRAINT `fk_teacher_assignment` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
