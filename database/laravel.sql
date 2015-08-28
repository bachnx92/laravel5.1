-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 28, 2015 at 04:23 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `laravel_test2`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_10_12_000000_create_users_table', 1),
('2014_10_12_100000_create_password_resets_table', 1),
('2015_06_22_144236_entrust_setup_tables', 1),
('2015_06_26_173412_create_routes_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `enabled`, `created_at`, `updated_at`) VALUES
(1, 'guest-only', 'Guest only access', 'Only guest users can access these.', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(2, 'open-to-all', 'Open to all', 'Everyone can access these, even unauthenticated or guest users.', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(3, 'basic-authenticated', 'Basic authenticated', 'Basic permission after being authenticated.', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(4, 'test-level-success', 'Test level success', 'Testing level success', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(5, 'test-level-info', 'Test level info', 'Testing level info', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(6, 'test-level-warning', 'Test level warning', 'Testing level warning', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(7, 'test-level-error', 'Test level error', 'Testing level error', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(8, 'manage-users', 'Manage users', 'Allows a user to manage the site users.', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(9, 'manage-roles', 'Manage roles', 'Allows a user to manage the site roles.', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(10, 'manage-permissions', 'Manage permissions', 'Allows a user to manage the site permissions.', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(11, 'manage-routes', 'Manage routes', 'Allows a user to Manage the site routes.', 1, '2015-08-18 19:34:30', '2015-08-18 19:34:30');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE IF NOT EXISTS `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `resync_on_login` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `enabled`, `resync_on_login`, `created_at`, `updated_at`) VALUES
(1, 'admins', 'Administrators', 'Site administrators', 1, 0, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(2, 'users', 'Users', 'Authenticated users', 1, 0, '2015-08-18 19:34:30', '2015-08-18 19:34:30');

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE IF NOT EXISTS `role_user` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_user_role_id_foreign` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `role_user`
--

INSERT INTO `role_user` (`user_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(7, 2);

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE IF NOT EXISTS `routes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `method` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `action_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `permission_id` int(10) unsigned DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `routes_permission_id_foreign` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `auth_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `username`, `email`, `password`, `enabled`, `auth_type`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Root', 'SuperUser', 'admin', 'admin@admin.com', '$2y$10$IYa.sT1skq72sFJl7FAQ8ehtytIBd0FlYvnIZ0P4V2KbELIRfTPsq', 1, NULL, '7xXBaUPUDSLMRZkJIZ6uYjFGYIrwpvolHuwiehjORAeRuMs6jOQru9XLYgTK', '2015-08-18 19:34:30', '2015-08-27 19:18:18'),
(2, 'User', 'One', 'demo1', 'user1@email.com', '$2y$10$8.KIRa00LIqFqCYTYj6nM.gswVALh6nU3M.0nO.pjcem5IDkwwIkS', 1, NULL, NULL, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(3, 'User', 'Two', 'demo2', 'user2@email.com', '$2y$10$de7GEx8CZOAJCUdvyvZ5auV4GTnYlMtL4mK9oqENKqFvm4OrIibLC', 1, NULL, NULL, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(4, 'User', 'Three', 'demo3', 'user3@email.com', '$2y$10$VB8qdqgBSSDhg3DOlirKxOmVTD/lfSZIxyZAi90Qzz4bDCXHdzzB6', 1, NULL, NULL, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(5, 'User', 'Four', 'demo4', 'user4@email.com', '$2y$10$OeU0AyHkWro.V6s0bi5..uG8qIdixlwnUX0ZTsqlIZQkftU00XhNq', 1, NULL, NULL, '2015-08-18 19:34:30', '2015-08-18 19:34:30'),
(7, 'bachnx', 'bachnx', 'bachnx99', 'admin@gmail.com', '$2y$10$3dT5r/iIzaXHy0u1stA1eOLEoMfwn8Ary2gMzdcmrbrlx1GWmvZbO', 1, NULL, 'kxHKSvDrRziOOefHUlOxymGA68A7tQAgBaJ1F3eo9Hba8Wy8X2gYOU2ilfQ7', '2015-08-27 03:57:27', '2015-08-27 19:06:22');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `routes`
--
ALTER TABLE `routes`
  ADD CONSTRAINT `routes_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
