-- phpMyAdmin SQL Dump
-- version 4.4.8
-- http://www.phpmyadmin.net
--
-- Värd: localhost
-- Tid vid skapande: 08 feb 2020 kl 23:15
-- Serverversion: 5.6.24-log
-- PHP-version: 5.6.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databas: `mrbs_APPNAME`
--
CREATE DATABASE IF NOT EXISTS `mrbs_handledning` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `mrbs_handledning`;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_areatype`
--

DROP TABLE IF EXISTS `kth_areatype`;
CREATE TABLE IF NOT EXISTS `kth_areatype` (
  `id` int(11) NOT NULL,
  `areatype` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_areatype`
--

INSERT INTO `kth_areatype` (`id`, `areatype`) VALUES
(1, 'Grouproom'),
(2, 'Readingstudio'),
(3, 'Supervision'),
(4, 'Openinghours'),
(5, 'Talkingbooks'),
(6, 'Consultation');

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_area_instructors`
--

DROP TABLE IF EXISTS `kth_area_instructors`;
CREATE TABLE IF NOT EXISTS `kth_area_instructors` (
  `id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `instructor_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_area_instructors`
--
/*
INSERT INTO `kth_area_instructors` (`id`, `area_id`, `instructor_id`) VALUES
(1, 1, 1);
*/

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_area_places`
--

DROP TABLE IF EXISTS `kth_area_places`;
CREATE TABLE IF NOT EXISTS `kth_area_places` (
  `id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `places_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_area_places`
--
/*
INSERT INTO `kth_area_places` (`id`, `area_id`, `places_id`) VALUES
(1, 1, 1);
*/
-- --------------------------------------------------------

--
-- Tabellstruktur `kth_entry_custom_fields`
--

DROP TABLE IF EXISTS `kth_entry_custom_fields`;
CREATE TABLE IF NOT EXISTS `kth_entry_custom_fields` (
  `id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `entry_field_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `visible` int(11) NOT NULL,
  `enabled` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_entry_custom_fields`
--
/*
INSERT INTO `kth_entry_custom_fields` (`id`, `area_id`, `entry_field_name`, `type`, `sort_order`, `visible`, `enabled`) VALUES
(1, 1, 'email', 'custom', 200, 1, 1),
(2, 1, 'phone', 'custom', 300, 1, 1),
(3, 1, 'user_group', 'custom', 150, 1, 0),
(4, 1, 'campus', 'custom', 130, 1, 1),
(5, 1, 'program', 'custom', 500, 1, 1),
(6, 1, 'study_info', 'custom', 600, 1, 1),
(7, 1, 'previously', 'custom', 700, 1, 1),
(8, 1, 'subject_keywords', 'custom', 800, 1, 1),
(9, 1, 'instructor', 'custom', 110, 1, 1),
(10, 1, 'preferred_language', 'custom', 120, 1, 1),
(11, 1, 'start_time', 'standard', 100, 1, 1),
(12, 1, 'end_time', 'standard', 101, 1, 1),
(13, 1, 'name', 'standard', 140, 1, 1),
(14, 2, 'email', 'custom', 200, 1, 1),
(15, 2, 'phone', 'custom', 300, 1, 1),
(16, 2, 'user_group', 'custom', 150, 1, 0),
(17, 2, 'preferred_language', 'custom', 800, 1, 1),
(18, 2, 'instructor', 'custom', 110, 0, 0),
(19, 2, 'start_time', 'standard', 100, 1, 1),
(20, 2, 'end_time', 'standard', 101, 1, 1),
(21, 2, 'name', 'standard', 140, 1, 1),
(22, 2, 'other_info', 'custom', 900, 1, 1),
(23, 3, 'name', 'standard', 100, 1, 1),
(24, 3, 'start_time', 'standard', 110, 1, 1),
(25, 3, 'end_time', 'standard', 120, 1, 1),
(26, 3, 'confirmation_status', 'standard', 130, 1, 1);
*/

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_exchange_events`
--

DROP TABLE IF EXISTS `kth_exchange_events`;
CREATE TABLE IF NOT EXISTS `kth_exchange_events` (
  `id` int(11) NOT NULL,
  `entry_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `event_id` varchar(200) NOT NULL,
  `change_key` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_instructors`
--

DROP TABLE IF EXISTS `kth_instructors`;
CREATE TABLE IF NOT EXISTS `kth_instructors` (
  `id` int(11) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_instructors`
--
/*
INSERT INTO `kth_instructors` (`id`, `full_name`, `email`) VALUES
(1, 'Thomas Lind', 'tholind@kth.se');
*/

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_periods`
--

DROP TABLE IF EXISTS `kth_periods`;
CREATE TABLE IF NOT EXISTS `kth_periods` (
  `id` int(11) NOT NULL,
  `start_time` varchar(5) NOT NULL,
  `end_time` varchar(5) NOT NULL,
  `entry_start_time` varchar(5) NOT NULL,
  `weekday` int(11) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_periods`
--
/*
INSERT INTO `kth_periods` (`id`, `start_time`, `end_time`, `entry_start_time`, `weekday`, `area_id`) VALUES
(1, '08:00', '10:00', '12:00', 0, 3);
*/

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_places`
--

DROP TABLE IF EXISTS `kth_places`;
CREATE TABLE IF NOT EXISTS `kth_places` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_places`
--

INSERT INTO `kth_places` (`id`, `name`, `name_en`) VALUES
(1, 'Huvudbiblioteket', 'Main Library'),
(2, 'Distans', 'Distance');

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_area`
--

DROP TABLE IF EXISTS `mrbs_area`;
CREATE TABLE IF NOT EXISTS `mrbs_area` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_name` varchar(50) DEFAULT NULL,
  `area_name_en` varchar(50) DEFAULT NULL,
  `area_sort_key` int(11) NOT NULL DEFAULT '0',
  `area_type` tinyint(4) NOT NULL DEFAULT '0',
  `timezone` varchar(50) DEFAULT NULL,
  `area_admin_email` text,
  `resolution` int(11) DEFAULT NULL,
  `default_duration` int(11) DEFAULT NULL,
  `default_duration_all_day` tinyint(1) NOT NULL DEFAULT '0',
  `morningstarts` int(11) DEFAULT NULL,
  `morningstarts_minutes` int(11) DEFAULT NULL,
  `eveningends` int(11) DEFAULT NULL,
  `eveningends_minutes` int(11) DEFAULT NULL,
  `private_enabled` tinyint(1) DEFAULT NULL,
  `private_default` tinyint(1) DEFAULT NULL,
  `private_mandatory` tinyint(1) DEFAULT NULL,
  `private_override` varchar(32) DEFAULT NULL,
  `min_create_ahead_enabled` tinyint(1) DEFAULT NULL,
  `min_create_ahead_secs` int(11) DEFAULT NULL,
  `max_create_ahead_enabled` tinyint(1) DEFAULT NULL,
  `max_create_ahead_secs` int(11) DEFAULT NULL,
  `min_delete_ahead_enabled` tinyint(1) DEFAULT NULL,
  `min_delete_ahead_secs` int(11) DEFAULT NULL,
  `max_delete_ahead_enabled` tinyint(1) DEFAULT NULL,
  `max_delete_ahead_secs` int(11) DEFAULT NULL,
  `max_per_day_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_day` int(11) NOT NULL DEFAULT '0',
  `max_per_week_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_week` int(11) NOT NULL DEFAULT '0',
  `max_hours_per_day_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_hours_per_day` int(11) NOT NULL DEFAULT '0',
  `max_hours_per_week_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_hours_per_week` int(11) NOT NULL DEFAULT '0',
  `max_hours_per_month_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_hours_per_month` int(11) NOT NULL DEFAULT '0',
  `max_hours_per_year_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_hours_per_year` int(11) NOT NULL DEFAULT '0',
  `max_hours_per_future_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_hours_per_future` int(11) NOT NULL DEFAULT '0',
  `max_per_month_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_month` int(11) NOT NULL DEFAULT '0',
  `max_per_year_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_year` int(11) NOT NULL DEFAULT '0',
  `max_per_future_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_per_future` int(11) NOT NULL DEFAULT '0',
  `max_global_per_day` int(11) NOT NULL DEFAULT '0',
  `max_global_per_day_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_global_per_week` int(11) NOT NULL DEFAULT '0',
  `max_global_per_week_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_global_per_month` int(11) NOT NULL DEFAULT '0',
  `max_global_per_month_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_global_per_year` int(11) NOT NULL DEFAULT '0',
  `max_global_per_year_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_global_per_future` int(11) NOT NULL DEFAULT '0',
  `max_global_per_future_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_duration_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `max_duration_secs` int(11) NOT NULL DEFAULT '0',
  `max_duration_periods` int(11) NOT NULL DEFAULT '0',
  `custom_html` text,
  `custom_html_en` text,
  `extra_info` text,
  `extra_info_en` text,
  `approval_enabled` tinyint(1) DEFAULT NULL,
  `reminders_enabled` tinyint(1) DEFAULT NULL,
  `enable_periods` tinyint(1) DEFAULT NULL,
  `confirmation_enabled` tinyint(1) DEFAULT NULL,
  `confirmed_default` tinyint(1) DEFAULT NULL,
  `default_view` int(11) NOT NULL DEFAULT '0',
  `times_along_top` int(11) NOT NULL DEFAULT '0',
  `hide_links` int(11) NOT NULL DEFAULT '1',
  `extended_booking_form` int(11) NOT NULL DEFAULT '0',
  `reminder_email_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_map` tinyint(1) NOT NULL DEFAULT '0',
  `area_map_image` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_area`
--

/*
INSERT INTO `mrbs_area` (`id`, `disabled`, `area_name`, `area_name_en`, `area_sort_key`, `area_type`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_create_ahead_enabled`, `min_create_ahead_secs`, `max_create_ahead_enabled`, `max_create_ahead_secs`, `min_delete_ahead_enabled`, `min_delete_ahead_secs`, `max_delete_ahead_enabled`, `max_delete_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_hours_per_day_enabled`, `max_hours_per_day`, `max_hours_per_week_enabled`, `max_hours_per_week`, `max_hours_per_month_enabled`, `max_hours_per_month`, `max_hours_per_year_enabled`, `max_hours_per_year`, `max_hours_per_future_enabled`, `max_hours_per_future`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `max_global_per_day`, `max_global_per_day_enabled`, `max_global_per_week`, `max_global_per_week_enabled`, `max_global_per_month`, `max_global_per_month_enabled`, `max_global_per_year`, `max_global_per_year_enabled`, `max_global_per_future`, `max_global_per_future_enabled`, `max_duration_enabled`, `max_duration_secs`, `max_duration_periods`, `custom_html`, `custom_html_en`, `extra_info`, `extra_info_en`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`, `default_view`, `times_along_top`, `hide_links`, `extended_booking_form`, `reminder_email_enabled`, `area_map`, `area_map_image`) VALUES
(1, 0, 'Boka handledning', 'Book consultation', 1, 6, 'Europe/Stockholm', 'tholind@kth.se', 3600, 3600, 0, 9, 0, 16, 0, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 0, 0, 604800, 1, 1, 0, 5, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 7200, 2, 'Svenska\r\nLorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum ', 'English\r\nLorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum ', NULL, NULL, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 'grupprum.jpg'),
(2, 0, 'Talboksintroduktion', 'Introduction to talking books', 5, 5, 'Europe/Stockholm', '', 3600, 3600, 0, 9, 0, 16, 0, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 0, 0, 604800, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7200, 2, '<p style="color:red">Custom svenska html</p>', '<p style="color:red">Custom english html</p>\r\n', NULL, NULL, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, ''),
(3, 0, 'Huvudbiblioteket - Grupprum', 'Main Library - Group study rooms', 1, 1, 'Europe/Stockholm', '', 3600, 7200, 0, 8, 0, 20, 0, 0, 0, 0, 'none', 0, 0, 1, 604800, 0, 0, 0, 604800, 1, 1, 1, 2, 1, 2, 1, 4, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 7200, 1, '<h2>Bokningsregler/Information</h2>\r\n<ul>\r\n<li>Boka med ditt KTH-Konto <p></p></li>\r\n<li>Boka själv via schemat tidigast en vecka i förväg.<p></p></li>\r\n<li>Bokningen <b>måste</b> kvitteras i tid annars förfaller den.<p></p></li>\r\n<li>Kvittering av bokat pass görs tidigast 15 minuter före och senast 15 minuter efter bokningstidens start.<p></p></li>\r\n<li>Avboka alltid en tid du inte kommer att använda. Ej avbokad tid räknas som en bokning. <p></p></li>\r\n<li>Ett pass som bokas sedan det börjat kvitteras automatiskt.<p></p></li>\r\n<li>Du kan boka ett rum per dag och max två rum per vecka.<p></p></li>\r\n<li>Du kan boka max två timmar per bokning.</li><p></p>\r\n<li>Grupprummen är avsedda för grupper på upp till 8 personer och minst 2 personer.<p></p></li>\r\n<li>Alla grupprum har en whiteboard och rum 4. Leopold har en skärm<p></p></li>\r\n<li>Du får inte ta med mat och dryck i grupprummen.<p></p></li>\r\n</ul>', '<h2>Booking rules/Information</h2>\r\n<ul>\r\n<li>Book an available time with your KTH account.<p></p></li>\r\n<li>A booking can be made a week ahead, you can do it yourself.<p></p></li>\r\n<li>You <b>must </b>confirm your time slot. This is done from 15 minutes before to 15 minutes after the start time.<p></p></li>\r\n<li>Always cancel your booking if you do not need the room. If you don''t cancel it will count as a booking.<p></p></li>\r\n<li>If you book a room after the start time it will be confirmed automatically.<p></p></li>\r\n<li>You may book up to one room/day and two/week.<p></p></li>\r\n<li>You may book maximum two hours per booking</li><p></p>\r\n<li>Group study rooms are intended for a group of people, i.e. for at least two persons.<p></p></li>\r\n<li>All group study rooms have a whiteboard and room 4. Leopold has a screen<p></p></li>\r\n<li>Food and drink may not be brought into the group study rooms.<p></p></li>\r\n</ul>', NULL, NULL, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 'grupprum.jpg'),
(4, 0, 'Huvudbiblioteket - Lässtudio', NULL, 0, 0, 'Europe/Stockholm', NULL, 1800, 3600, 0, 7, 0, 18, 30, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 0, 0, 604800, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7200, 2, NULL, NULL, NULL, NULL, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, NULL),
(5, 0, 'Kista - Lässtudio', NULL, 0, 0, 'Europe/Stockholm', NULL, 1800, 3600, 0, 7, 0, 18, 30, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 0, 0, 604800, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7200, 2, NULL, NULL, NULL, NULL, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, NULL),
(6, 0, 'Flemingsberg - Lässtudio', NULL, 0, 0, 'Europe/Stockholm', NULL, 1800, 3600, 0, 7, 0, 18, 30, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 0, 0, 604800, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7200, 2, NULL, NULL, NULL, NULL, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, NULL);
*/
-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_entry`
--

DROP TABLE IF EXISTS `mrbs_entry`;
CREATE TABLE IF NOT EXISTS `mrbs_entry` (
  `id` int(11) NOT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `entry_type` int(11) NOT NULL DEFAULT '0',
  `repeat_id` int(11) DEFAULT NULL,
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `instructor` varchar(50) DEFAULT NULL,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `modified_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `lang` varchar(2) NOT NULL DEFAULT 'en',
  `confirmation_code` varchar(255) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `user_group` varchar(50) DEFAULT NULL,
  `program` varchar(100) DEFAULT NULL,
  `study_info` varchar(500) DEFAULT NULL,
  `previously` varchar(500) DEFAULT NULL,
  `subject_keywords` varchar(500) DEFAULT NULL,
  `campus` int(11) DEFAULT NULL,
  `preferred_language` varchar(10) DEFAULT NULL,
  `other_info` varchar(500) DEFAULT NULL,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0',
  `ical_recur_id` varchar(16) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1213 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_entry`
--
/*
INSERT INTO `mrbs_entry` (`id`, `start_time`, `end_time`, `entry_type`, `repeat_id`, `room_id`, `timestamp`, `instructor`, `create_by`, `modified_by`, `name`, `type`, `description`, `status`, `reminded`, `lang`, `confirmation_code`, `info_time`, `info_user`, `info_text`, `email`, `phone`, `user_group`, `program`, `study_info`, `previously`, `subject_keywords`, `campus`, `preferred_language`, `other_info`, `ical_uid`, `ical_sequence`, `ical_recur_id`) VALUES
(1, 1580288400, 1580292000, 0, NULL, 1, '2020-01-28 15:45:55', 'tholind@kth.se', 'testtl@kth.se', 'testtl@kth.se', 'Thomas Lind(testkonto)', 'I', NULL, 0, NULL, 'en', NULL, NULL, NULL, NULL, 'tholind@kth.se', '888888888', 'KTH Student', '', '', '', '', 2, '', NULL, 'MRBS-5e304d7721b88-ead86773@apps.lib.kth.se', 7, '');
*/
--
-- Trigger `mrbs_entry`
--
DROP TRIGGER IF EXISTS `ondeleteentry`;
DELIMITER $$
CREATE TRIGGER `ondeleteentry` BEFORE DELETE ON `mrbs_entry`
 FOR EACH ROW INSERT INTO mrbs_entry_delete
  select * from mrbs_entry where id = OLD.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_entry_delete`
--

DROP TABLE IF EXISTS `mrbs_entry_delete`;
CREATE TABLE IF NOT EXISTS `mrbs_entry_delete` (
  `id` int(11) NOT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `entry_type` int(11) NOT NULL DEFAULT '0',
  `repeat_id` int(11) DEFAULT NULL,
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `instructor` varchar(50) DEFAULT NULL,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `modified_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `lang` varchar(2) NOT NULL DEFAULT 'en',
  `confirmation_code` varchar(255) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `user_group` varchar(50) DEFAULT NULL,
  `program` varchar(100) DEFAULT NULL,
  `study_info` varchar(500) NOT NULL DEFAULT '0',
  `previously` varchar(500) NOT NULL DEFAULT '0',
  `subject_keywords` varchar(500) NOT NULL DEFAULT '0',
  `campus` int(11) NOT NULL DEFAULT '0',
  `preferred_language` int(10) NOT NULL,
  `other_info` varchar(500) NOT NULL,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0',
  `ical_recur_id` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_entry_delete`
--
/*
INSERT INTO `mrbs_entry_delete` (`id`, `start_time`, `end_time`, `entry_type`, `repeat_id`, `room_id`, `timestamp`, `instructor`, `create_by`, `modified_by`, `name`, `type`, `description`, `status`, `reminded`, `lang`, `confirmation_code`, `info_time`, `info_user`, `info_text`, `email`, `phone`, `user_group`, `program`, `study_info`, `previously`, `subject_keywords`, `campus`, `preferred_language`, `other_info`, `ical_uid`, `ical_sequence`, `ical_recur_id`) VALUES
(1, 1579096800, 1579104000, 0, NULL, 15, '2020-01-15 13:23:36', '', 'testtl@kth.se', '', 'Ankor & Pingviner', 'I', NULL, 4, NULL, 'en', NULL, NULL, NULL, NULL, '', '', '', '', '', '', '', 0, 0, '', 'MRBS-5e1f1258e72f1-5cb3439f@kthb-hv.lib.kth.se', 0, NULL);
*/
-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_entry_no_show`
--

DROP TABLE IF EXISTS `mrbs_entry_no_show`;
CREATE TABLE IF NOT EXISTS `mrbs_entry_no_show` (
  `id` int(11) NOT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `entry_type` int(11) NOT NULL DEFAULT '0',
  `repeat_id` int(11) DEFAULT NULL,
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `instructor` varchar(50) NOT NULL,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `modified_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0',
  `ical_recur_id` varchar(16) DEFAULT NULL,
  `help_other` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_repeat`
--

DROP TABLE IF EXISTS `mrbs_repeat`;
CREATE TABLE IF NOT EXISTS `mrbs_repeat` (
  `id` int(11) NOT NULL,
  `exchange_event_id` varchar(200) DEFAULT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `rep_type` int(11) NOT NULL DEFAULT '0',
  `end_date` int(11) NOT NULL DEFAULT '0',
  `rep_opt` varchar(32) NOT NULL DEFAULT '',
  `room_id` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `instructor` varchar(50) DEFAULT NULL,
  `create_by` varchar(80) NOT NULL DEFAULT '',
  `modified_by` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` char(1) NOT NULL DEFAULT 'E',
  `description` text,
  `rep_num_weeks` smallint(6) DEFAULT NULL,
  `month_absolute` smallint(6) DEFAULT NULL,
  `month_relative` varchar(4) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reminded` int(11) DEFAULT NULL,
  `lang` varchar(2) NOT NULL DEFAULT 'en',
  `confirmation_code` varchar(255) DEFAULT NULL,
  `info_time` int(11) DEFAULT NULL,
  `info_user` varchar(80) DEFAULT NULL,
  `info_text` text,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `user_group` varchar(50) DEFAULT NULL,
  `program` varchar(100) DEFAULT NULL,
  `study_info` varchar(500) DEFAULT NULL,
  `previously` varchar(500) DEFAULT NULL,
  `subject_keywords` varchar(500) DEFAULT NULL,
  `campus` varchar(50) DEFAULT NULL,
  `preferred_language` int(10) DEFAULT NULL,
  `other_info` varchar(500) DEFAULT NULL,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_repeat`
--
/*
INSERT INTO `mrbs_repeat` (`id`, `exchange_event_id`, `start_time`, `end_time`, `rep_type`, `end_date`, `rep_opt`, `room_id`, `timestamp`, `instructor`, `create_by`, `modified_by`, `name`, `type`, `description`, `rep_num_weeks`, `month_absolute`, `month_relative`, `status`, `reminded`, `lang`, `confirmation_code`, `info_time`, `info_user`, `info_text`, `email`, `phone`, `user_group`, `program`, `study_info`, `previously`, `subject_keywords`, `campus`, `preferred_language`, `other_info`, `ical_uid`, `ical_sequence`) VALUES
(1, NULL, 1581174000, 1581192000, 2, 1609426800, '0000001', 6, '2020-02-07 22:33:59', '', 'tholind@kth.se', '', 'Stängt', 'C', NULL, 1, NULL, NULL, 0, NULL, 'en', NULL, NULL, NULL, NULL, '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, 'MRBS-5e3de5d7ca03a-4ce861a7@apps-ref.lib.kth.se', 0);
*/
-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_room`
--

DROP TABLE IF EXISTS `mrbs_room`;
CREATE TABLE IF NOT EXISTS `mrbs_room` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `room_name` varchar(100) NOT NULL DEFAULT '',
  `room_name_english` varchar(100) NOT NULL DEFAULT '',
  `sort_key` varchar(25) NOT NULL DEFAULT '',
  `exchange_email` varchar(100) DEFAULT NULL,
  `description` varchar(60) DEFAULT NULL,
  `capacity` int(11) NOT NULL DEFAULT '0',
  `room_admin_email` text,
  `custom_html` text,
  `room_number` varchar(4) NOT NULL DEFAULT '',
  `screen` tinyint(4) NOT NULL DEFAULT '0',
  `mailtext` text,
  `mailtext_en` text
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_room`
--
/*
INSERT INTO `mrbs_room` (`id`, `disabled`, `area_id`, `room_name`, `room_name_english`, `sort_key`, `exchange_email`, `description`, `capacity`, `room_admin_email`, `custom_html`, `room_number`, `screen`, `mailtext`, `mailtext_en`) VALUES
(1, 0, 1, 'Handledning', 'Handledning', 'Handledning', '', '', 8, '', '', '', 0, 'Du har bokat tid för handledning på KTH Biblioteket', 'You have booked consultation at the KTH Library.'),
(2, 0, 2, 'Huvudbiblioteket', 'Main Library', '1', '', '', 0, '', 'Bla bla bla blaBla bla bla blaBla bla bla bla', '', 0, '', ''),
(3, 0, 2, 'Kista', 'Kista', '2', '', '', 0, '', '', '', 0, '', ''),
(4, 0, 2, 'Södertälje', 'Södertälje', '3', '', '', 0, '', '', '', 0, '', ''),
(5, 0, 2, 'Flemingsberg', 'Flemingsberg', '4', '', '', 1, '', '', '', 0, '', ''),
(6, 0, 3, 'Al-Khwarizmi', 'Al-Khwarizmi', '00', NULL, 'Grupprum', 8, '', 'Aktiverade nätverksuttag är markerade med "grön plupp". Kabel kan lånas och återlämnas i Låneexpeditionen, Informationen eller Receptionen.', '0', 0, NULL, NULL),
(7, 0, 3, 'Leibniz', 'Leibniz', '01', NULL, 'Grupprum', 6, '', '', '1', 0, NULL, NULL),
(8, 0, 3, 'Galvani', 'Galvani', '08', NULL, '', 6, '', '', '8', 0, NULL, NULL),
(9, 0, 3, 'Watt', 'Watt', '09', NULL, '', 6, '', '', '9', 0, NULL, NULL),
(10, 0, 3, 'Santorio', 'Santorio', '10', NULL, '', 6, '', '', '10', 0, NULL, NULL),
(11, 0, 3, 'Kovalevsky', 'Kovalevsky', '11', NULL, '', 6, '', '', '11', 0, NULL, NULL),
(12, 1, 3, 'Ekeblad', 'Ekeblad', '12', NULL, '', 6, '', '', '12', 0, '', ''),
(13, 1, 3, 'Sundström', 'Sundström', '13', NULL, '', 5, '', '', '13', 0, '', ''),
(14, 0, 3, 'Scheele', 'Scheele', '03', NULL, '', 6, '', '', '3', 0, NULL, NULL),
(15, 0, 3, 'Pascal', 'Pascal', '02', NULL, '', 4, '', '', '2', 0, NULL, NULL),
(16, 0, 3, 'Leopold', 'Leopold', '04', NULL, 'Whiteboard och skärm', 6, '', '', '4', 1, NULL, NULL),
(17, 0, 3, 'Agricola', 'Agricola', '05', NULL, ' ', 6, '', '', '5', 0, NULL, NULL),
(18, 0, 3, 'Bernoulli', 'Bernoulli', '06', NULL, '', 6, '', '', '6', 0, NULL, NULL),
(19, 0, 3, 'Dürer', 'Dürer', '07', NULL, '', 6, '', '', '7', 0, NULL, NULL),
(20, 0, 4, 'Vitruvius', 'Vitruvius', '01', NULL, '', 4, '', '', '', 0, NULL, NULL),
(21, 0, 5, 'Kista', 'Kista', '01', NULL, '', 0, '', '', '', 0, NULL, NULL);
*/

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_users`
--

DROP TABLE IF EXISTS `mrbs_users`;
CREATE TABLE IF NOT EXISTS `mrbs_users` (
  `id` int(11) NOT NULL,
  `level` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_users`
--
/*
INSERT INTO `mrbs_users` (`id`, `level`, `name`, `password_hash`, `email`) VALUES
(1, 2, 'tholind', '$2y$10$9xe0r9TjKald2Qzzmeu8zuYti06cogyjLMonJNuRLeNt43OcnRz3q', 'tholind@kth.se');
*/
-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_variables`
--

DROP TABLE IF EXISTS `mrbs_variables`;
CREATE TABLE IF NOT EXISTS `mrbs_variables` (
  `id` int(11) NOT NULL,
  `variable_name` varchar(80) DEFAULT NULL,
  `variable_content` text
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_variables`
--

INSERT INTO `mrbs_variables` (`id`, `variable_name`, `variable_content`) VALUES
(1, 'db_version', '47'),
(2, 'local_db_version', '1');

-- --------------------------------------------------------

--
-- Tabellstruktur `mrbs_zoneinfo`
--

DROP TABLE IF EXISTS `mrbs_zoneinfo`;
CREATE TABLE IF NOT EXISTS `mrbs_zoneinfo` (
  `id` int(11) NOT NULL,
  `timezone` varchar(255) NOT NULL DEFAULT '',
  `outlook_compatible` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `vtimezone` text,
  `last_updated` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_zoneinfo`
--

INSERT INTO `mrbs_zoneinfo` (`id`, `timezone`, `outlook_compatible`, `vtimezone`, `last_updated`) VALUES
(1, 'Europe/Stockholm', 1, 'BEGIN:VTIMEZONE\r\nTZID:Europe/Stockholm\r\nTZURL:http://tzurl.org/zoneinfo-outlook/Europe/Stockholm\r\nX-LIC-LOCATION:Europe/Stockholm\r\nBEGIN:DAYLIGHT\r\nTZOFFSETFROM:+0100\r\nTZOFFSETTO:+0200\r\nTZNAME:CEST\r\nDTSTART:19700329T020000\r\nRRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU\r\nEND:DAYLIGHT\r\nBEGIN:STANDARD\r\nTZOFFSETFROM:+0200\r\nTZOFFSETTO:+0100\r\nTZNAME:CET\r\nDTSTART:19701025T030000\r\nRRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU\r\nEND:STANDARD\r\nEND:VTIMEZONE', 1580482785);

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `kth_areatype`
--
ALTER TABLE `kth_areatype`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_area_instructors`
--
ALTER TABLE `kth_area_instructors`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_area_places`
--
ALTER TABLE `kth_area_places`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_entry_custom_fields`
--
ALTER TABLE `kth_entry_custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_exchange_events`
--
ALTER TABLE `kth_exchange_events`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_instructors`
--
ALTER TABLE `kth_instructors`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_periods`
--
ALTER TABLE `kth_periods`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `kth_places`
--
ALTER TABLE `kth_places`
  ADD PRIMARY KEY (`id`);

--
-- Index för tabell `mrbs_area`
--
ALTER TABLE `mrbs_area`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_area_name` (`area_name`);

--
-- Index för tabell `mrbs_entry`
--
ALTER TABLE `mrbs_entry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `repeat_id` (`repeat_id`),
  ADD KEY `idxStartTime` (`start_time`),
  ADD KEY `idxEndTime` (`end_time`);

--
-- Index för tabell `mrbs_entry_no_show`
--
ALTER TABLE `mrbs_entry_no_show`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unikt_index` (`start_time`,`room_id`,`create_by`) USING BTREE,
  ADD KEY `room_id` (`room_id`),
  ADD KEY `repeat_id` (`repeat_id`),
  ADD KEY `idxStartTime` (`start_time`),
  ADD KEY `idxEndTime` (`end_time`);

--
-- Index för tabell `mrbs_repeat`
--
ALTER TABLE `mrbs_repeat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`);

--
-- Index för tabell `mrbs_room`
--
ALTER TABLE `mrbs_room`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_room_name` (`area_id`,`room_name`),
  ADD KEY `idxSortKey` (`sort_key`);

--
-- Index för tabell `mrbs_users`
--
ALTER TABLE `mrbs_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_name` (`name`);

--
-- Index för tabell `mrbs_variables`
--
ALTER TABLE `mrbs_variables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_variable_name` (`variable_name`);

--
-- Index för tabell `mrbs_zoneinfo`
--
ALTER TABLE `mrbs_zoneinfo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_timezone` (`timezone`,`outlook_compatible`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `kth_areatype`
--
ALTER TABLE `kth_areatype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT för tabell `kth_area_instructors`
--
ALTER TABLE `kth_area_instructors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT för tabell `kth_area_places`
--
ALTER TABLE `kth_area_places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT för tabell `kth_entry_custom_fields`
--
ALTER TABLE `kth_entry_custom_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT för tabell `kth_exchange_events`
--
ALTER TABLE `kth_exchange_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_instructors`
--
ALTER TABLE `kth_instructors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT för tabell `kth_periods`
--
ALTER TABLE `kth_periods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT för tabell `kth_places`
--
ALTER TABLE `kth_places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT för tabell `mrbs_area`
--
ALTER TABLE `mrbs_area`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT för tabell `mrbs_entry`
--
ALTER TABLE `mrbs_entry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1213;
--
-- AUTO_INCREMENT för tabell `mrbs_entry_no_show`
--
ALTER TABLE `mrbs_entry_no_show`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_repeat`
--
ALTER TABLE `mrbs_repeat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT för tabell `mrbs_room`
--
ALTER TABLE `mrbs_room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT för tabell `mrbs_users`
--
ALTER TABLE `mrbs_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT för tabell `mrbs_variables`
--
ALTER TABLE `mrbs_variables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT för tabell `mrbs_zoneinfo`
--
ALTER TABLE `mrbs_zoneinfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `mrbs_entry`
--
ALTER TABLE `mrbs_entry`
  ADD CONSTRAINT `mrbs_entry_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `mrbs_room` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `mrbs_entry_ibfk_2` FOREIGN KEY (`repeat_id`) REFERENCES `mrbs_repeat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restriktioner för tabell `mrbs_entry_no_show`
--
ALTER TABLE `mrbs_entry_no_show`
  ADD CONSTRAINT `mrbs_entry_no_show_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `mrbs_room` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `mrbs_entry_no_show_ibfk_2` FOREIGN KEY (`repeat_id`) REFERENCES `mrbs_repeat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restriktioner för tabell `mrbs_repeat`
--
ALTER TABLE `mrbs_repeat`
  ADD CONSTRAINT `mrbs_repeat_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `mrbs_room` (`id`) ON UPDATE CASCADE;

--
-- Restriktioner för tabell `mrbs_room`
--
ALTER TABLE `mrbs_room`
  ADD CONSTRAINT `mrbs_room_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `mrbs_area` (`id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
