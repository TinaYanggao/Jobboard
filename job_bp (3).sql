-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2025 at 02:39 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `job_bp`
--

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `application_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `applicant_name` varchar(255) NOT NULL,
  `applicant_email` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `cover_letter` text DEFAULT NULL,
  `resume_path` varchar(255) DEFAULT NULL,
  `status` enum('Pending','Accepted','Rejected') DEFAULT 'Pending',
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applications`
--

INSERT INTO `applications` (`application_id`, `job_id`, `applicant_name`, `applicant_email`, `user_id`, `cover_letter`, `resume_path`, `status`, `applied_at`) VALUES
(1, 1, 'Admin', 'admina@gmail.com', NULL, 'I loved reading books ', 'uploads/resumes/1756434279_JOB-BROAD-PLATFORM (1).docx', 'Pending', '2025-08-29 02:24:39'),
(2, 1, 'Admin', 'admin@gmail.com', NULL, 'because i love books', 'uploads/resumes/1756435067_JOB-BROAD-PLATFORM (1).docx', 'Pending', '2025-08-29 02:37:47'),
(3, 1, 'Admin', 'admin@gmail.com', NULL, 'i loved books', 'uploads/resumes/1756435437_JOB-BROAD-PLATFORM (1).docx', 'Rejected', '2025-08-29 02:43:57'),
(4, 2, 'Admin', 'admin@gmail.com', NULL, 'kase malabo mata ko', 'uploads/resumes/1756442811_1756435437_JOB-BROAD-PLATFORM (1).docx', 'Accepted', '2025-08-29 04:46:51'),
(5, 5, 'Noa', 'Noa@gmail.com', NULL, 'I can hear ghost', 'uploads/resumes/1757118093_BABAEAKOL-HINDI-BABAE-LANG-TALUMPATI.docx', 'Accepted', '2025-09-06 00:21:33'),
(6, 6, 'Lauren', 'Lauren@gmail.com', NULL, 'I can detect Lies', 'uploads/resumes/1757118761_Malware Attack_Quiz.pdf', 'Accepted', '2025-09-06 00:32:41');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `requirements` text DEFAULT NULL,
  `salary` varchar(100) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `employment_type` enum('Full-time','Part-time','Contract','Internship') DEFAULT 'Full-time',
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `title`, `description`, `requirements`, `salary`, `location`, `employment_type`, `contact_name`, `contact_email`, `contact_phone`, `category`, `created_at`) VALUES
(1, 'ReadN\'Reflect', 'organizing book and encoding and decoding books', 'should be a bookworm', '25000', 'Bamban', 'Part-time', 'Tina', 'tinabi@gmail.com', '09292525633', NULL, '2025-08-29 02:23:50'),
(2, 'EyeWeart', 'should be good at glasses', 'should have a 4 years degree', '30000', 'Tarlac', 'Full-time', 'Marites', 'tinabi@gmail.com', '09292525633', NULL, '2025-08-29 03:13:44'),
(5, 'Phantom Whisper Detective Co.', 'As a Spiritual Guide and Investigator, your primary responsibility is to assist individuals who are entangled in supernatural events, particularly those who are sensitive to or affected by otherworldly entities. You will serve as a conduit between the living and the spirit world, offering guidance, support, and insight to help navigate complex and often dangerous situations.', 'Mediumship: Ability to perceive and interact with spirits and other non-physical entities.\r\nEmpathy: Strong understanding of human emotions and experiences, enabling effective support and guidance.\r\nAnalytical Thinking: Capability to assess situations critically and solve complex problems involving supernatural elements.\r\nDiscretion: Maintaining confidentiality and handling sensitive information with care and respect.', '100,000', 'Supernatural Realm / Unseen Dimensions', 'Full-time', 'Cain', 'Cain@gmail.com', '09292525633', NULL, '2025-09-06 00:20:32'),
(6, 'Purple Hyacinth Detective Co.', 'Operatives and investigators in the Purple Hyacinth world are responsible for maintaining law and order while handling high-risk situations involving organized crime, assassins, and morally complex cases. The role requires both fieldwork and investigative analysis, combining physical prowess, strategic thinking, and intelligence gathering to protect civilians and enforce justice.', 'Combat Proficiency: Skilled in hand-to-hand combat and the use of weapons.\r\nStrategic Thinking: Ability to plan and execute operations with efficiency.\r\nObservation & Analytical Skills: Keen insight into human behavior and crime patterns.\r\nDiscretion: Handle sensitive cases with confidentiality.\r\nAdaptability: Respond effectively to rapidly changing or dangerous situations\r\n', '100,000', 'Urban centers under the Ardhalis Police Department / Field assignments', 'Full-time', 'Kieran', 'Kieran@gmail.com', '09292525633', NULL, '2025-09-06 00:30:06');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `receiver_email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('unread','read') DEFAULT 'unread',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `job_id`, `sender_id`, `receiver_id`, `receiver_email`, `message`, `sent_at`, `status`, `created_at`) VALUES
(1, 1, 1, 0, 'admin@gmail.com', 'i would like to have an interview with u', '2025-08-29 03:42:28', 'unread', '2025-08-29 11:57:34'),
(2, 1, 1, 0, 'admin@gmail.com', 'i would love to work with u, but for now, are u available for an interview about the job you applied with', '2025-08-29 03:57:58', 'unread', '2025-08-29 11:57:58'),
(3, 1, 1, 0, 'admin@gmail.com', 'i would like to have an interview with u', '2025-08-29 03:58:15', 'unread', '2025-08-29 11:58:15'),
(4, 1, 1, 0, 'admin@gmail.com', 'i would love to work with u', '2025-08-29 04:01:41', 'unread', '2025-08-29 12:01:41'),
(5, 1, 1, 0, 'admin@gmail.com', 'i would like to work with u', '2025-08-29 04:05:07', 'unread', '2025-08-29 12:05:07'),
(6, 1, 1, 0, 'admin@gmail.com', 'thank u so muchh i would like to have an interview with u soon', '2025-08-29 04:20:03', 'unread', '2025-08-29 12:20:03'),
(7, 1, 1, 0, 'admin@gmail.com', 'i would like to work with u', '2025-08-29 04:52:14', 'unread', '2025-08-29 12:52:14'),
(8, 1, 1, 0, 'admin@gmail.com', 'thank u so muchh', '2025-08-29 05:14:18', 'unread', '2025-08-29 13:14:18'),
(9, 2, 1, 0, 'admin@gmail.com', 'i would love to interview u', '2025-08-29 05:14:46', 'unread', '2025-08-29 13:14:46'),
(10, 1, 1, 1, '', 'thank u', '2025-08-29 10:15:25', 'unread', '2025-08-29 18:15:25'),
(11, 1, 1, 1, '', 'huh', '2025-08-29 10:26:27', 'unread', '2025-08-29 18:26:27'),
(12, 1, 1, 0, 'admin@gmail.com', 'houy', '2025-08-29 10:54:37', 'unread', '2025-08-29 18:54:37'),
(13, 1, 1, 0, 'tinabi@gmail.com', 'yes ?', '2025-08-29 10:57:57', 'unread', '2025-08-29 18:57:57'),
(14, 2, 1, 0, 'admin@gmail.com', 'hey grull', '2025-08-29 10:58:08', 'unread', '2025-08-29 18:58:08'),
(15, 2, 1, 0, 'tinabi@gmail.com', 'sup bebe gurll', '2025-08-29 10:58:25', 'unread', '2025-08-29 18:58:25'),
(16, 1, 1, 0, 'admin@gmail.com', 'yes', '2025-08-29 11:07:20', 'unread', '2025-08-29 19:07:20'),
(17, 1, 1, 0, 'tinabi@gmail.com', 'hey', '2025-08-29 11:09:03', 'unread', '2025-08-29 19:09:03'),
(18, 1, 1, 0, 'tinabi@gmail.com', 'aayoko na', '2025-08-29 11:11:39', 'unread', '2025-08-29 19:11:39'),
(19, 1, 1, 0, 'admin@gmail.com', 'pagod na pagod na ako kakabuhat sianyo AG BCHEIY YG', '2025-08-29 11:12:54', 'unread', '2025-08-29 19:12:54'),
(20, 2, 1, 0, 'admin@gmail.com', 'THE HOUSE OF US, feel na feel kita George', '2025-08-29 11:13:31', 'unread', '2025-08-29 19:13:31');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `profile_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `resume_path` varchar(255) DEFAULT NULL,
  `profile_pic_path` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'active',
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `resume` varchar(255) DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `status`, `role`, `created_at`, `phone`, `address`, `skills`, `resume`, `profile_pic`) VALUES
(1, 'Jhen', 'tinabi@gmail.com', '1234', 'active', 'user', '2025-08-29 04:12:33', '09292525633', 'Bamban, Tarlac', 'funny, charistmatic, adorable, cute, panget', 'uploads/resume/1756460113_1.jpg', 'uploads/profile/1756460113_1swap.jpg'),
(3, 'Admin', 'admin@gmail.com', '1234', 'active', 'user', '2025-08-29 11:16:02', NULL, NULL, NULL, NULL, NULL),
(6, 'Noa', 'Noa@gmail.com', '$2y$10$QbT6dOUAsGQlUje3Snd52eg6khqMVsbd8sj9SVx8D6UrKeOs7uTby', 'active', 'user', '2025-09-05 23:36:06', '09292525633', 'Phantom Whispers', 'Auditory Perception, Empathy, Analytical Thinking, Resilience', 'uploads/resume/1757118162_noa.jpg', 'uploads/profile/1757118162_noa.jpg'),
(7, 'Cain', 'Cain@gmail.com', '$2y$10$SfUzghdps76UfGin06PSK.I27d6J2Nzn94bdQUd2qPoWggK6W9JLW', 'active', 'admin', '2025-09-05 23:59:55', '09292525633', 'Phantom Whispers', 'Communicating with Spirits, Providing Support and Guidance, Empathy and Understanding, Observant and Insightful', 'uploads/resume/1757117900_cain.jpg', 'uploads/profile/1757117900_cain.jpg'),
(8, 'Kieran White', 'Kieran@gmail.com', '$2y$10$.5VnzFq8UbVbKZ2nehb5k.epF32zphynnbmrfuOaQpU.G4ta66R52', 'active', 'admin', '2025-09-06 00:25:19', '09292525633', 'Purple Hyacinth', 'Expert Assassin, Swordsmanship, Artistic Talent, Infiltration & Espionage', 'uploads/resume/1757118468_Kieran.jpg', 'uploads/profile/1757118468_Kieran.jpg'),
(9, 'Lauren Sinclair', 'Lauren@gmail.com', '$2y$10$HLg/uyKqoRi64yTLR6nuXOusGmRENNaU3SvIORcMkKmwWLzp3tbWu', 'active', 'user', '2025-09-06 00:30:56', '09292525633', 'Purple Hyacinth', 'Lie Detection, Combat Proficiency, Investigative Expertise, Tactical Intelligence', 'uploads/resume/1757118730_Lauren.jpg', 'uploads/profile/1757118730_Lauren.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`application_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`profile_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `application_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `profile_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applications`
--
ALTER TABLE `applications`
  ADD CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`);

--
-- Constraints for table `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
