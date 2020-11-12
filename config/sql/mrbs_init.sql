-- phpMyAdmin SQL Dump
-- version 4.4.8
-- http://www.phpmyadmin.net
--
-- Värd: localhost
-- Tid vid skapande: 08 feb 2020 kl 23:15
-- Serverversion: 5.6.24-log
-- PHP-version: 5.6.0

--
-- Databas: `mrbs_APPNAME`
-- Ta bort s från sDROP och sCREATE och se till att sätta rätt databasnamn!
--
sDROP DATABASE IF EXISTS `mrbs_handledning`;
sCREATE DATABASE IF NOT EXISTS `mrbs_handledning` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
sUSE `mrbs_handledning`;

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_areatype`
--

DROP TABLE IF EXISTS `kth_areatype`;
CREATE TABLE IF NOT EXISTS `kth_areatype` (
  `id` int(11) NOT NULL,
  `areatype` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `enabled` int(11) NOT NULL,
  `mandatory` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_entry_custom_fields`
--
/*
--Handledning
INSERT INTO `kth_entry_custom_fields` (`area_id`, `entry_field_name`, `type`, `sort_order`, `visible`, `enabled`, `mandatory`) VALUES
(1, 'email', 'custom', 200, 1, 1, 1),
(1, 'phone', 'custom', 300, 1, 1, 1),
(1, 'user_group', 'custom', 150, 1, 0, 1),
(1, 'campus', 'custom', 410, 1, 1, 1),
(1, 'program', 'custom', 500, 1, 1, 1),
(1, 'consultation_info', 'custom', 600, 1, 1, 1),
(1, 'study_info', 'custom', 600, 1, 1, 1),
(1, 'previously', 'custom', 700, 1, 1, 1),
(1, 'subject_keywords', 'custom', 800, 1, 1, 1),
(1, 'instructor', 'custom', 400, 1, 1, 1),
(1, 'preferred_language', 'custom', 420, 1, 1, 1),
(1, 'start_time', 'standard', 100, 1, 1, 1),
(1, 'end_time', 'standard', 101, 1, 1, 1),
(1, 'name', 'standard', 140, 1, 1, 1);

--Talbok/inläsningstjänst
INSERT INTO `kth_entry_custom_fields` (`area_id`, `entry_field_name`, `type`, `sort_order`, `visible`, `enabled`, `mandatory`) VALUES
(1, 'email', 'custom', 200, 1, 1, 1),
(1, 'phone', 'custom', 300, 1, 1, 1),
(1, 'user_group', 'custom', 150, 1, 0, 1),
(1, 'campus', 'custom', 410, 1, 1, 1),
(1, 'preferred_language', 'custom', 800, 1, 1, 1),
(1, 'instructor', 'custom', 400, 1, 1, 1),
(1, 'start_time', 'standard', 100, 1, 1, 1),
(1, 'end_time', 'standard', 101, 1, 1, 1),
(1, 'name', 'standard', 140, 1, 1, 1),
(1, 'other_info', 'custom', 900, 1, 1, 1);

--Grupprum/lässtudio
INSERT INTO `kth_entry_custom_fields` (`area_id`, `entry_field_name`, `type`, `sort_order`, `visible`, `enabled`, `mandatory`) VALUES
(1, 'name', 'standard', 110, 1, 1, 1),
(1, 'decsription', 'standard', 115, 1, 1, 1),
(1, 'start_time', 'standard', 100, 1, 1, 1),
(1, 'end_time', 'standard', 105, 1, 1, 1),
(1, 'confirmation_status', 'standard', 130, 1, 1, 1);

--CAS
INSERT INTO `kth_entry_custom_fields` (`area_id`, `entry_field_name`, `type`, `sort_order`, `visible`, `enabled`, `mandatory`) VALUES
(1, 'start_time', 'standard', 100, 1, 1, 1),
(1, 'end_time', 'standard', 101, 1, 1, 1),
(1, 'name', 'standard', 103, 1, 1, 1),
(1, 'my_campus', 'custom', 104, 1, 1, 1),
(1, 'program', 'custom', 106, 1, 1, 1),
(1, 'instructor', 'custom', 108, 1, 1, 1),
(1, 'campus', 'custom', 110, 1, 1, 1),
(1, 'writing_help_get_started', 'custom', 200, 1, 1, 0),
(1, 'writing_help_overall_structure', 'custom', 210, 1, 1, 0),
(1, 'writing_help_paragraph_structure', 'custom', 220, 1, 1, 0),
(1, 'writing_help_sentence_construction', 'custom', 230, 1, 1, 0),
(1, 'writing_help_coherence_cohesion', 'custom', 240, 1, 1, 0),
(1, 'writing_help_style_formality', 'custom', 250, 1, 1, 0),
(1, 'writing_help_conventions', 'custom', 260, 1, 1, 0),
(1, 'writing_help_citation', 'custom', 270, 1, 1, 0),
(1, 'writing_help_references', 'custom', 280, 1, 1, 0),
(1, 'writing_help_otherformal', 'custom', 290, 1, 1, 0),
(1, 'oral_help_nervousness', 'custom', 300, 1, 1, 0),
(1, 'oral_help_overall_structure', 'custom', 310, 1, 1, 0),
(1, 'oral_help_act_interact', 'custom', 320, 1, 1, 0),
(1, 'oral_help_interact_computer', 'custom', 330, 1, 1, 0),
(1, 'oral_help_bodylanguage', 'custom', 340, 1, 1, 0),
(1, 'oral_help_images', 'custom', 350, 1, 1, 0),
(1, 'oral_help_keeptime', 'custom', 360, 1, 1, 0),
(1, 'help_other', 'custom', 370, 1, 1, 0);
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
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_instructors`
--
/*
--Handledning
INSERT INTO `kth_instructors` (`disabled`, `area_id`, `sort_key`, `full_name`, `email`) VALUES
(0, 1, '8', 'Thomas Lind', 'tholind@kth.se'),
(0, 1, '1', 'Miritt Zisser', 'miritt@kth.se'),
(0, 1, '2', 'Sara Akramy', 'akramy@kth.se'),
(0, 1, '3', 'Maria Unger', 'mariaun@kth.se'),
(0, 1, '4', 'Magdalena Svanberg', 'masvanbe@kth.se'),
(0, 1, '5', 'Lina Andrén', 'linaandr@kth.se'),
(0, 1, '6', 'Lenita Brodin Berggren', 'lenitabb@kth.se'),
(0, 1, '7', 'Ika Jorum', 'jorum@kth.se');

--Talbok/inläsningstjänst
INSERT INTO `kth_instructors` (`disabled`, `area_id`, `sort_key`, `full_name`, `email`) VALUES
(0, 1, '8', 'Thomas Lind', 'tholind@kth.se'),
(0, 1, '1', 'Moa-Lisa Björk', 'mlbjork@kth.se'),
(0, 1, '2', 'Michelle Mörck', 'mmorck@kth.se'),
(0, 1, '3', 'Viveka Norström Hallberg', 'vivekanh@kth.se'),
(0, 1, '4', 'Eva Westphal', 'evwe@kth.se');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `room_id` int(11) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_places`
--

/*
--Handledning
INSERT INTO `kth_places` (`disabled`, `room_id`, `sort_key`, `name`, `name_en`) VALUES
(0, 1, '3', 'Huvudbiblioteket', 'Main Library'),
(0, 1, '2', 'Distans', 'Distance'),
(0, 1, '1', '1none', '1none');

--Talbok,inläsningstjänst
INSERT INTO `kth_places` (`disabled`, `room_id`, `sort_key`, `name`, `name_en`) VALUES
(0, 1, '3', 'KTH Biblioteket', 'KTH Library'),
(0, 1, '2', 'Distans', 'Distance'),
(0, 1, '1', '1none', '1none');

*/

-- --------------------------------------------------------

--
-- Tabellstruktur `kth_campus`
--

CREATE TABLE IF NOT EXISTS `kth_campus` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `kth_campus`
--

INSERT INTO `kth_campus` (`id`, `disabled`, `sort_key`, `name`, `name_en`) VALUES
(1, 0, '1', 'Campus KTH', 'Campus KTH'),
(2, 0, '2', 'Campus Kista', 'Campus Kista'),
(3, 0, '3', 'Campus Södertälje', 'Campus Södertälje'),
(4, 0, '4', 'Campus Flemingsberg', 'Campus Flemingsberg'),
(5, 0, '5', 'Campus Solna', 'Campus Solna'),
(6, 0, '0', '1none', '1none');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_area`
--

/*
--Handledning
INSERT INTO `mrbs_area` (`disabled`, `area_name`, `area_name_en`, `area_sort_key`, `area_type`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_create_ahead_enabled`, `min_create_ahead_secs`, `max_create_ahead_enabled`, `max_create_ahead_secs`, `min_delete_ahead_enabled`, `min_delete_ahead_secs`, `max_delete_ahead_enabled`, `max_delete_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_hours_per_day_enabled`, `max_hours_per_day`, `max_hours_per_week_enabled`, `max_hours_per_week`, `max_hours_per_month_enabled`, `max_hours_per_month`, `max_hours_per_year_enabled`, `max_hours_per_year`, `max_hours_per_future_enabled`, `max_hours_per_future`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `max_global_per_day`, `max_global_per_day_enabled`, `max_global_per_week`, `max_global_per_week_enabled`, `max_global_per_month`, `max_global_per_month_enabled`, `max_global_per_year`, `max_global_per_year_enabled`, `max_global_per_future`, `max_global_per_future_enabled`, `max_duration_enabled`, `max_duration_secs`, `max_duration_periods`, `custom_html`, `custom_html_en`, `extra_info`, `extra_info_en`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`, `default_view`, `times_along_top`, `hide_links`, `extended_booking_form`, `reminder_email_enabled`, `area_map`, `area_map_image`) VALUES
(0, 'Boka handledning', 'Book consultation', 1, 6, 'Europe/Stockholm', '', 3600, 3600, 0, 8, 0, 16, 0, 0, 0, 0, 'none', 1, 86400, 0, 604800, 0, 0, 0, 604800, 1, 10, 0, 5, 1, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 7200, 2, '<ul>\r\n<li>Boka med ditt KTH-Konto <p></p></li>\r\n<li>Boka själv via schemat tidigast en vecka i förväg.<p></p></li>\r\n<li>Avboka alltid en tid du inte kommer att använda. Ej avbokad tid räknas som en bokning. <p></p></li>\r\n<li>Du kan boka ett pass per dag och max två pass per vecka.<p></p></li>\r\n<li>Du kan boka max två timmar per bokning.<p></p></li>\r\n\r\n</ul>', '<ul>\r\n<li>Boka med ditt KTH-Konto <p></p></li>\r\n<li>Boka själv via schemat tidigast en vecka i förväg.<p></p></li>\r\n<li>Avboka alltid en tid du inte kommer att använda. Ej avbokad tid räknas som en bokning. <p></p></li>\r\n<li>Du kan boka ett pass per dag och max två pass per vecka.<p></p></li>\r\n<li>Du kan boka max två timmar per bokning.<p></p></li>\r\n\r\n</ul>', '<div>\r\n<p>Vi erbjuder handledning på plats på de olika biblioteken eller på distans via Zoom. Klicka  på en ledig tid i schemat. Välj om du vill att mötet ska ske i biblioteket eller via Zoom, fyll i övriga fält.</p>\r\n\r\n<div class="alert alert-info"><div><div>Så länge biblioteket är stängt hålls alla talboksintroduktioner via Zoom.</div></div></div>', '<div>\r\n<p>We offer consultation on location in our libraries, or via Zoom. Click on an available time slot in the schedule. Then choose if you want the meeting be take place in the library or via Zoom, please provide information for the other fields.</p>\r\n\r\n<div class="alert alert-info"><div><div>As long as the library is closed, all introductions to talking books are held via Zoom.</div></div></div>', 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, '');

--Talbok
INSERT INTO `mrbs_area` (`disabled`, `area_name`, `area_name_en`, `area_sort_key`, `area_type`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_create_ahead_enabled`, `min_create_ahead_secs`, `max_create_ahead_enabled`, `max_create_ahead_secs`, `min_delete_ahead_enabled`, `min_delete_ahead_secs`, `max_delete_ahead_enabled`, `max_delete_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_hours_per_day_enabled`, `max_hours_per_day`, `max_hours_per_week_enabled`, `max_hours_per_week`, `max_hours_per_month_enabled`, `max_hours_per_month`, `max_hours_per_year_enabled`, `max_hours_per_year`, `max_hours_per_future_enabled`, `max_hours_per_future`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `max_global_per_day`, `max_global_per_day_enabled`, `max_global_per_week`, `max_global_per_week_enabled`, `max_global_per_month`, `max_global_per_month_enabled`, `max_global_per_year`, `max_global_per_year_enabled`, `max_global_per_future`, `max_global_per_future_enabled`, `max_duration_enabled`, `max_duration_secs`, `max_duration_periods`, `custom_html`, `custom_html_en`, `extra_info`, `extra_info_en`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`, `default_view`, `times_along_top`, `hide_links`, `extended_booking_form`, `reminder_email_enabled`, `area_map`, `area_map_image`) VALUES
(0, 'Talboksintroduktion', 'Introduction to talking books', 5, 5, 'Europe/Stockholm', '', 3600, 3600, 0, 9, 0, 16, 0, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 0, 0, 604800, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7200, 2, '<ul>\r\n<li>Boka med ditt KTH-Konto <p></p></li>\r\n<li>Boka själv via schemat tidigast en vecka i förväg.<p></p></li>\r\n<li>Avboka alltid en tid du inte kommer att använda. Ej avbokad tid räknas som en bokning. <p></p></li>\r\n<li>Du kan boka ett pass per dag och max två pass per vecka.<p></p></li>\r\n<li>Du kan boka max två timmar per bokning.<p></p></li>\r\n\r\n</ul>', '(english)\r\n<ul>\r\n<li>Boka med ditt KTH-Konto <p></p></li>\r\n<li>Boka själv via schemat tidigast en vecka i förväg.<p></p></li>\r\n<li>Avboka alltid en tid du inte kommer att använda. Ej avbokad tid räknas som en bokning. <p></p></li>\r\n<li>Du kan boka ett pass per dag och max två pass per vecka.<p></p></li>\r\n<li>Du kan boka max två timmar per bokning.<p></p></li>\r\n\r\n</ul>\r\n', '<div>\r\n<p>Vi erbjuder talsboksintroduktion på plats på de olika biblioteken eller på distans via Zoom. Välj bibliotek ovan och klicka sen på en ledig tid i schemat. Välj om du vill att mötet ska ske i biblioteket eller via Zoom, fyll i vilket språk du föredrar och eventuella övriga kommentarer.</p>\r\n\r\n<p>Om du vill ha mötet via Zoom spelar det ingen roll vilket bibliotek du väljer!</p>\r\n</div>\r\n<div class="alert alert-info"><div><div>Så länge biblioteket är stängt hålls alla talboksintroduktioner via Zoom.</div></div></div>', '<div>\r\n<p>We offer introductions to talking books on location in our libraries, or via Zoom. Choose a library above and then click on an available time slot in the schedule. Then choose if you want the meeting be take place in the library or via Zoom, mark what language you prefer and if you have any other comments.</p>\r\n\r\n<p>If you want the meeting in Zoom, you can pick any of the libraries!\r\n</p>\r\n</div>\r\n\r\n<div class="alert alert-info"><div><div>As long as the library is closed, all introductions to talking books are held via Zoom.</div></div></div>', 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, '');

--Inläsningstjänst
INSERT INTO `mrbs_area` (`disabled`, `area_name`, `area_name_en`, `area_sort_key`, `area_type`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_create_ahead_enabled`, `min_create_ahead_secs`, `max_create_ahead_enabled`, `max_create_ahead_secs`, `min_delete_ahead_enabled`, `min_delete_ahead_secs`, `max_delete_ahead_enabled`, `max_delete_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_hours_per_day_enabled`, `max_hours_per_day`, `max_hours_per_week_enabled`, `max_hours_per_week`, `max_hours_per_month_enabled`, `max_hours_per_month`, `max_hours_per_year_enabled`, `max_hours_per_year`, `max_hours_per_future_enabled`, `max_hours_per_future`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `max_global_per_day`, `max_global_per_day_enabled`, `max_global_per_week`, `max_global_per_week_enabled`, `max_global_per_month`, `max_global_per_month_enabled`, `max_global_per_year`, `max_global_per_year_enabled`, `max_global_per_future`, `max_global_per_future_enabled`, `max_duration_enabled`, `max_duration_secs`, `max_duration_periods`, `custom_html`, `custom_html_en`, `extra_info`, `extra_info_en`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`, `default_view`, `times_along_top`, `hide_links`, `extended_booking_form`, `reminder_email_enabled`, `area_map`, `area_map_image`) VALUES
(0, 'Inläsningstjänst', 'Reading service', 5, 5, 'Europe/Stockholm', '', 3600, 3600, 0, 9, 0, 16, 0, 0, 0, 0, 'none', 0, 0, 0, 604800, 0, 0, 0, 604800, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7200, 2, '<ul>\r\n<li>Boka med ditt KTH-Konto <p></p></li>\r\n<li>Boka själv via schemat tidigast en vecka i förväg.<p></p></li>\r\n<li>Avboka alltid en tid du inte kommer att använda. Ej avbokad tid räknas som en bokning. <p></p></li>\r\n<li>Du kan boka ett pass per dag och max två pass per vecka.<p></p></li>\r\n<li>Du kan boka max två timmar per bokning.<p></p></li>\r\n\r\n</ul>', '(english)\r\n<ul>\r\n<li>Boka med ditt KTH-Konto <p></p></li>\r\n<li>Boka själv via schemat tidigast en vecka i förväg.<p></p></li>\r\n<li>Avboka alltid en tid du inte kommer att använda. Ej avbokad tid räknas som en bokning. <p></p></li>\r\n<li>Du kan boka ett pass per dag och max två pass per vecka.<p></p></li>\r\n<li>Du kan boka max två timmar per bokning.<p></p></li></ul>\r\n', '<div>\r\n<p>Vi erbjuder talsboksintroduktion på plats på de olika biblioteken eller på distans via Zoom. Välj bibliotek ovan och klicka sen på en ledig tid i schemat. Välj om du vill att mötet ska ske i biblioteket eller via Zoom, fyll i vilket språk du föredrar och eventuella övriga kommentarer.</p>\r\n\r\n<p>Om du vill ha mötet via Zoom spelar det ingen roll vilket bibliotek du väljer!</p>\r\n</div>\r\n<div class="alert alert-info"><div><div>Så länge biblioteket är stängt hålls alla talboksintroduktioner via Zoom.</div></div></div>', '<div>\r\n<p>We offer introductions to talking books on location in our libraries, or via Zoom. Choose a library above and then click on an available time slot in the schedule. Then choose if you want the meeting be take place in the library or via Zoom, mark what language you prefer and if you have any other comments.</p>\r\n\r\n<p>If you want the meeting in Zoom, you can pick any of the libraries!\r\n</p>\r\n</div>\r\n\r\n<div class="alert alert-info"><div><div>As long as the library is closed, all introductions to talking books are held via Zoom.</div></div></div>', 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, '');

--Grupprum
INSERT INTO `mrbs_area` (`disabled`, `area_name`, `area_name_en`, `area_sort_key`, `area_type`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_create_ahead_enabled`, `min_create_ahead_secs`, `max_create_ahead_enabled`, `max_create_ahead_secs`, `min_delete_ahead_enabled`, `min_delete_ahead_secs`, `max_delete_ahead_enabled`, `max_delete_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_hours_per_day_enabled`, `max_hours_per_day`, `max_hours_per_week_enabled`, `max_hours_per_week`, `max_hours_per_month_enabled`, `max_hours_per_month`, `max_hours_per_year_enabled`, `max_hours_per_year`, `max_hours_per_future_enabled`, `max_hours_per_future`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `max_global_per_day`, `max_global_per_day_enabled`, `max_global_per_week`, `max_global_per_week_enabled`, `max_global_per_month`, `max_global_per_month_enabled`, `max_global_per_year`, `max_global_per_year_enabled`, `max_global_per_future`, `max_global_per_future_enabled`, `max_duration_enabled`, `max_duration_secs`, `max_duration_periods`, `custom_html`, `custom_html_en`, `extra_info`, `extra_info_en`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`, `default_view`, `times_along_top`, `hide_links`, `extended_booking_form`, `reminder_email_enabled`, `area_map`, `area_map_image`) VALUES
(0, 'Huvudbiblioteket - Grupprum', 'Main Library - Group study rooms', 1, 1, 'Europe/Stockholm', '', 3600, 7200, 0, 8, 0, 20, 0, 0, 0, 0, 'none', 0, 0, 1, 604800, 0, 0, 0, 604800, 1, 1, 1, 2, 1, 2, 1, 4, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 7200, 1, '<h2>Bokningsregler/Information</h2>\r\n<ul>\r\n<li>Boka med ditt KTH-Konto <p></p></li>\r\n<li>Boka själv via schemat tidigast en vecka i förväg.<p></p></li>\r\n<li>Bokningen <b>måste</b> kvitteras i tid annars förfaller den.<p></p></li>\r\n<li>Kvittering av bokat pass görs tidigast 15 minuter före och senast 15 minuter efter bokningstidens start.<p></p></li>\r\n<li>Avboka alltid en tid du inte kommer att använda. Ej avbokad tid räknas som en bokning. <p></p></li>\r\n<li>Ett pass som bokas sedan det börjat kvitteras automatiskt.<p></p></li>\r\n<li>Du kan boka ett rum per dag och max två rum per vecka.<p></p></li>\r\n<li>Du kan boka max två timmar per bokning.</li><p></p>\r\n<li>Grupprummen är avsedda för grupper på upp till 8 personer och minst 2 personer.<p></p></li>\r\n<li>Alla grupprum har en whiteboard och rum 4. Leopold har en skärm<p></p></li>\r\n<li>Du får inte ta med mat och dryck i grupprummen.<p></p></li>\r\n</ul>', '<h2>Booking rules/Information</h2>\r\n<ul>\r\n<li>Book an available time with your KTH account.<p></p></li>\r\n<li>A booking can be made a week ahead, you can do it yourself.<p></p></li>\r\n<li>You <b>must </b>confirm your time slot. This is done from 15 minutes before to 15 minutes after the start time.<p></p></li>\r\n<li>Always cancel your booking if you do not need the room. If you don''t cancel it will count as a booking.<p></p></li>\r\n<li>If you book a room after the start time it will be confirmed automatically.<p></p></li>\r\n<li>You may book up to one room/day and two/week.<p></p></li>\r\n<li>You may book maximum two hours per booking</li><p></p>\r\n<li>Group study rooms are intended for a group of people, i.e. for at least two persons.<p></p></li>\r\n<li>All group study rooms have a whiteboard and room 4. Leopold has a screen<p></p></li>\r\n<li>Food and drink may not be brought into the group study rooms.<p></p></li>\r\n</ul>', 'Här ska det stå lite inledande informationstext, som kan vara hur lång som helst. Men bra om det är ganska kortfattat så det inte fyller upp hela sidan.', '(english) Här ska det stå lite inledande informationstext, som kan vara hur lång som helst. Men bra om det är ganska kortfattat så det inte fyller upp hela sidan.', 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 'grupprum.jpg');

--Lässtudio
INSERT INTO `mrbs_area` (`disabled`, `area_name`, `area_name_en`, `area_sort_key`, `area_type`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_create_ahead_enabled`, `min_create_ahead_secs`, `max_create_ahead_enabled`, `max_create_ahead_secs`, `min_delete_ahead_enabled`, `min_delete_ahead_secs`, `max_delete_ahead_enabled`, `max_delete_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_hours_per_day_enabled`, `max_hours_per_day`, `max_hours_per_week_enabled`, `max_hours_per_week`, `max_hours_per_month_enabled`, `max_hours_per_month`, `max_hours_per_year_enabled`, `max_hours_per_year`, `max_hours_per_future_enabled`, `max_hours_per_future`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `max_global_per_day`, `max_global_per_day_enabled`, `max_global_per_week`, `max_global_per_week_enabled`, `max_global_per_month`, `max_global_per_month_enabled`, `max_global_per_year`, `max_global_per_year_enabled`, `max_global_per_future`, `max_global_per_future_enabled`, `max_duration_enabled`, `max_duration_secs`, `max_duration_periods`, `custom_html`, `custom_html_en`, `extra_info`, `extra_info_en`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`, `default_view`, `times_along_top`, `hide_links`, `extended_booking_form`, `reminder_email_enabled`, `area_map`, `area_map_image`) VALUES
(0, 'Lässtudio', 'Reading studio', 1, 2, 'Europe/Stockholm', '', 3600, 7200, 0, 8, 0, 20, 0, 0, 0, 0, 'none', 0, 0, 1, 604800, 0, 0, 0, 604800, 1, 1, 1, 2, 1, 2, 1, 4, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 7200, 1, '<h2>Bokningsregler/Information</h2>\r\n<ul>\r\n<li>Boka med ditt KTH-Konto <p></p></li>\r\n<li>Boka själv via schemat tidigast en vecka i förväg.<p></p></li>\r\n<li>Bokningen <b>måste</b> kvitteras i tid annars förfaller den.<p></p></li>\r\n<li>Kvittering av bokat pass görs tidigast 15 minuter före och senast 15 minuter efter bokningstidens start.<p></p></li>\r\n<li>Avboka alltid en tid du inte kommer att använda. Ej avbokad tid räknas som en bokning. <p></p></li>\r\n<li>Ett pass som bokas sedan det börjat kvitteras automatiskt.<p></p></li>\r\n<li>Du kan boka ett rum per dag och max två rum per vecka.<p></p></li>\r\n<li>Du kan boka max två timmar per bokning.</li><p></p>\r\n<li>Grupprummen är avsedda för grupper på upp till 8 personer och minst 2 personer.<p></p></li>\r\n<li>Alla grupprum har en whiteboard och rum 4. Leopold har en skärm<p></p></li>\r\n<li>Du får inte ta med mat och dryck i grupprummen.<p></p></li>\r\n</ul>', '<h2>Booking rules/Information</h2>\r\n<ul>\r\n<li>Book an available time with your KTH account.<p></p></li>\r\n<li>A booking can be made a week ahead, you can do it yourself.<p></p></li>\r\n<li>You <b>must </b>confirm your time slot. This is done from 15 minutes before to 15 minutes after the start time.<p></p></li>\r\n<li>Always cancel your booking if you do not need the room. If you don''t cancel it will count as a booking.<p></p></li>\r\n<li>If you book a room after the start time it will be confirmed automatically.<p></p></li>\r\n<li>You may book up to one room/day and two/week.<p></p></li>\r\n<li>You may book maximum two hours per booking</li><p></p>\r\n<li>Group study rooms are intended for a group of people, i.e. for at least two persons.<p></p></li>\r\n<li>All group study rooms have a whiteboard and room 4. Leopold has a screen<p></p></li>\r\n<li>Food and drink may not be brought into the group study rooms.<p></p></li>\r\n</ul>', '<div>Här ska det stå lite inledande informationstext, som kan vara hur lång som helst. Men bäst är väl om det är ganska kortfattat så det inte fyller upp hela sidan.</div>', '<div>(english)Här ska det stå lite inledande informationstext, som kan vara hur lång som helst. Men bäst är väl om det är ganska kortfattat så det inte fyller upp hela sidan.</div>', 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 'grupprum.jpg');

--CAS
INSERT INTO `mrbs_area` (`id`, `disabled`, `area_name`, `area_name_en`, `area_sort_key`, `area_type`, `timezone`, `area_admin_email`, `resolution`, `default_duration`, `default_duration_all_day`, `morningstarts`, `morningstarts_minutes`, `eveningends`, `eveningends_minutes`, `private_enabled`, `private_default`, `private_mandatory`, `private_override`, `min_create_ahead_enabled`, `min_create_ahead_secs`, `max_create_ahead_enabled`, `max_create_ahead_secs`, `min_delete_ahead_enabled`, `min_delete_ahead_secs`, `max_delete_ahead_enabled`, `max_delete_ahead_secs`, `max_per_day_enabled`, `max_per_day`, `max_per_week_enabled`, `max_per_week`, `max_hours_per_day_enabled`, `max_hours_per_day`, `max_hours_per_week_enabled`, `max_hours_per_week`, `max_hours_per_month_enabled`, `max_hours_per_month`, `max_hours_per_year_enabled`, `max_hours_per_year`, `max_hours_per_future_enabled`, `max_hours_per_future`, `max_per_month_enabled`, `max_per_month`, `max_per_year_enabled`, `max_per_year`, `max_per_future_enabled`, `max_per_future`, `max_global_per_day`, `max_global_per_day_enabled`, `max_global_per_week`, `max_global_per_week_enabled`, `max_global_per_month`, `max_global_per_month_enabled`, `max_global_per_year`, `max_global_per_year_enabled`, `max_global_per_future`, `max_global_per_future_enabled`, `max_duration_enabled`, `max_duration_secs`, `max_duration_periods`, `custom_html`, `custom_html_en`, `extra_info`, `extra_info_en`, `approval_enabled`, `reminders_enabled`, `enable_periods`, `confirmation_enabled`, `confirmed_default`, `default_view`, `times_along_top`, `hide_links`, `extended_booking_form`, `reminder_email_enabled`, `area_map`, `area_map_image`) VALUES
(1, 0, 'Centrum för akademiskt skrivande', 'Centre for Academic Writing', 1, 3, 'Europe/Stockholm', 'tholind@kth.se', 3600, 3600, 0, 8, 0, 18, 0, 0, 0, 0, 'none', 1, 86400, 0, 604800, 0, 0, 0, 604800, 1, 1, 1, 2, 1, 2, 1, 4, 0, 0, 0, 0, 0, 0, 0, 10, 0, 50, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 7200, 1, '<p>Följande gäller:</p>\r\n<ul>\r\n<li>Efter bokning kontaktas du av en CAS-handledare som ger dig detaljerad information om mötet. Ni träffas på KTH:s bibliotek (KTHB) eller på KTH Språk och kommunikation, Teknikringen 14. Läs mejlet från din handledare för att veta exakt var ni ska träffas.</li>\r\n<p>\r\n</p>\r\n<li>Avboka alltid din tid om du får förhinder. Avbokning görs genom att logga in i samma bokningssystem som vid bokning.</li>\r\n<p>\r\n</p>\r\n<li><strong>Du kan endast boka ett tillfälle för en text/presentation via hemsidan</strong> (45 min per möte). Ett andra tillfälle kan bokas vid behov och görs gemensamt med din CAS-handledare. Du erbjuds max. två handledningstillfällen per text/presentation.</li>\r\n<p>\r\n</p><li>Mejla din text/presentation och dina frågor <strong>senast 24 timmar i förväg till <a href="mailto:cas-handledning@kth.se">cas-handledning@kth.se</a></strong></li>\r\n<p>\r\n</p><li>Har du frågor om din bokning är du välkommen att höra av dig <a href="mailto:cas-handledning@kth.se">cas-handledning@kth.se</a></li><p></p>\r\n</ul>\r\n\r\n<!-- Nedan kan styling för respektive area definieras. En kopia även på "english"-->\r\n\r\n<style>#1dwm_rooms ul{position:relative;} #1dwm_rooms li{width:100%;float:none} #1dwm_rooms li:nth-of-type(3){position: absolute;top: -5px;left: 250px;}#1dwm_rooms li:nth-of-type(4){position: absolute;top: 29px;left: 250px;} @media (max-width: 500px) and (min-width: 200px) {#1dwm_rooms li:nth-of-type(3),#1dwm_rooms li:nth-of-type(4){position:static}}</style>', '<p>The following applies:</p>\r\n<ul>\r\n<li>When you have booked an appointment, a CAW tutor will contact you with detailed information about the meeting. Please note that you will meet in the KTH Library <i>or</i> at KTH Language and Communication, Teknikringen 14. Make sure you know where to go.</li>\r\n<p>\r\n</p>\r\n<li>If you are unable to attend, please cancel your appointment by logging on to the same booking system.</li>\r\n<p>\r\n</p>\r\n  <li>You can make only <strong>one appointment per text/presentation on the booking site</strong> (45 minutes per session). The second appointment, if needed, will be booked together with your CAW tutor. We offer a maximum of two sessions per text/presentation..</li>\r\n  <p> \r\n  </p><li>Please email your text/presentation and questions <strong>at least 24 hours in advance to <a href="mailto:cas-handledning@kth.se">cas-handledning@kth.se</a></strong></li>\r\n  <p>\r\n  </p><li>Questions about your booking? Email us at <a href="mailto:cas-handledning@kth.se">cas-handledning@kth.se</a></li><p></p>\r\n</ul>\r\n\r\n\r\n<!-- Nedan kan styling för respektive area definieras. En kopia även på "english"-->\r\n\r\n<style>#1dwm_rooms ul{position:relative;} #1dwm_rooms li{width:100%;float:none} #1dwm_rooms li:nth-of-type(3){position: absolute;top: -5px;left: 250px;}#1dwm_rooms li:nth-of-type(4){position: absolute;top: 29px;left: 250px;} @media (max-width: 500px) and (min-width: 200px) {#1dwm_rooms li:nth-of-type(3),#1dwm_rooms li:nth-of-type(4){position:static}}</style>', 'Här ska det stå lite inledande informationstext, som kan vara hur lång som helst. Men bra om det är ganska kortfattat så det inte fyller upp hela sidan.', '(english) Här ska det stå lite inledande informationstext, som kan vara hur lång som helst. Men bra om det är ganska kortfattat så det inte fyller upp hela sidan.', 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, '');

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
  `study_info` text,
  `previously` text,
  `subject_keywords` text,
  `campus` int(11) DEFAULT NULL,
  `my_campus` int(11) DEFAULT NULL,
  `preferred_language` varchar(10) DEFAULT NULL,
  `consultation_info` text,
  `other_info` text,
  `writing_help_get_started` smallint(6) DEFAULT NULL,
  `writing_help_overall_structure` smallint(6) DEFAULT NULL,
  `writing_help_paragraph_structure` smallint(6) DEFAULT NULL,
  `writing_help_sentence_construction` smallint(6) DEFAULT NULL,
  `writing_help_coherence_cohesion` smallint(6) DEFAULT NULL,
  `writing_help_style_formality` smallint(6) DEFAULT NULL,
  `writing_help_conventions` smallint(6) DEFAULT NULL,
  `writing_help_citation` smallint(6) DEFAULT NULL,
  `writing_help_references` smallint(6) DEFAULT NULL,
  `writing_help_otherformal` smallint(6) DEFAULT NULL,
  `oral_help_nervousness` smallint(6) DEFAULT NULL,
  `oral_help_overall_structure` smallint(6) DEFAULT NULL,
  `oral_help_act_interact` smallint(6) DEFAULT NULL,
  `oral_help_interact_computer` smallint(6) DEFAULT NULL,
  `oral_help_bodylanguage` smallint(6) DEFAULT NULL,
  `oral_help_images` smallint(6) DEFAULT NULL,
  `oral_help_keeptime` smallint(6) DEFAULT NULL,
  `help_other` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0',
  `ical_recur_id` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_entry`
--
/*
INSERT INTO mrbs_xxxxxx.mrbs_entry (`start_time`, `end_time`, `entry_type`, `repeat_id`, `room_id`, `timestamp`, `instructor`, `create_by`, `modified_by`, `name`, `type`, `description`, `status`, `reminded`, `lang`, `confirmation_code`, `info_time`, `info_user`, `info_text`, `email`, `phone`, `user_group`, `program`, `study_info`, `previously`, `subject_keywords`, `campus`, `preferred_language`, `consultation_info`, `other_info`, `ical_uid`, `ical_sequence`, `ical_recur_id`) 
*/ 
/*

GRUPPRUM
SELECT 
-- mrbs.mrbs_entry.id,
`start_time`, `end_time`, `entry_type`, `repeat_id`,
-- `room_id`, 
mrbs_grupprum.mrbs_room.id as room_id,
`timestamp`, null, 
`create_by`, `modified_by`, `name`, `type`, mrbs.mrbs_entry.description, `status`, `reminded`, `lang`, 
`confirmation_code`, `info_time`, `info_user`, `info_text`, 
null, null, null, null, null, null, null, null, null, null, null, `ical_uid`, `ical_sequence`, `ical_recur_id`
-- mrbs.mrbs_entry.room_id, 
-- mrbs_grupprum.mrbs_room.room_name, 
-- mrbs.mrbs_room.room_name, 
-- mrbs.mrbs_room.id as mrbs_room_id,  
-- mrbs.mrbs_entry.name
FROM mrbs.mrbs_entry
INNER JOIN mrbs.mrbs_room
ON mrbs.mrbs_room.id = mrbs.mrbs_entry.room_id
INNER JOIN mrbs_grupprum.mrbs_room
ON mrbs_grupprum.mrbs_room.room_name = mrbs.mrbs_room.room_name
AND mrbs.mrbs_room.area_id=2
WHERE mrbs.mrbs_entry.start_time > UNIX_TIMESTAMP('2020-03-01')
AND mrbs.mrbs_entry.type != 'C'
ORDER BY mrbs.mrbs_entry.id

CAS
SELECT 
-- mrbs.mrbs_entry.id,
`start_time`, `end_time`, `entry_type`, `repeat_id`,
-- `room_id`, 
mrbs_cas.mrbs_room.id as room_id,
`timestamp`, null, 
`create_by`, `modified_by`, `name`, `type`, mrbs.mrbs_entry.description, `status`, `reminded`, `lang`, 
`confirmation_code`, `info_time`, `info_user`, `info_text`, 
null, null, null, null, null, null, null, null, null, null, null, `ical_uid`, `ical_sequence`, `ical_recur_id`
-- mrbs.mrbs_entry.room_id, 
-- mrbs_grupprum.mrbs_room.room_name, 
-- mrbs.mrbs_room.room_name, 
-- mrbs.mrbs_room.id as mrbs_room_id,  
-- mrbs.mrbs_entry.name
FROM mrbs.mrbs_entry
INNER JOIN mrbs.mrbs_room
ON mrbs.mrbs_room.id = mrbs.mrbs_entry.room_id
INNER JOIN mrbs_cas.mrbs_room
ON mrbs_cas.mrbs_room.room_name = mrbs.mrbs_room.room_name
AND mrbs.mrbs_room.area_id=5
WHERE mrbs.mrbs_entry.start_time > UNIX_TIMESTAMP('2020-03-01')
AND mrbs.mrbs_entry.type != 'C'
ORDER BY mrbs.mrbs_entry.id
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
  `study_info` text,
  `previously` text,
  `subject_keywords` text,
  `campus` int(11) DEFAULT NULL,
  `my_campus` int(11) DEFAULT NULL,
  `preferred_language` varchar(10) DEFAULT NULL,
  `consultation_info` text,
  `other_info` text,
  `writing_help_get_started` smallint(6) DEFAULT NULL,
  `writing_help_overall_structure` smallint(6) DEFAULT NULL,
  `writing_help_paragraph_structure` smallint(6) DEFAULT NULL,
  `writing_help_sentence_construction` smallint(6) DEFAULT NULL,
  `writing_help_coherence_cohesion` smallint(6) DEFAULT NULL,
  `writing_help_style_formality` smallint(6) DEFAULT NULL,
  `writing_help_conventions` smallint(6) DEFAULT NULL,
  `writing_help_citation` smallint(6) DEFAULT NULL,
  `writing_help_references` smallint(6) DEFAULT NULL,
  `writing_help_otherformal` smallint(6) DEFAULT NULL,
  `oral_help_nervousness` smallint(6) DEFAULT NULL,
  `oral_help_overall_structure` smallint(6) DEFAULT NULL,
  `oral_help_act_interact` smallint(6) DEFAULT NULL,
  `oral_help_interact_computer` smallint(6) DEFAULT NULL,
  `oral_help_bodylanguage` smallint(6) DEFAULT NULL,
  `oral_help_images` smallint(6) DEFAULT NULL,
  `oral_help_keeptime` smallint(6) DEFAULT NULL,
  `help_other` text,
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
  `study_info` text,
  `previously` text,
  `subject_keywords` text,
  `campus` int(11) DEFAULT NULL,
  `my_campus` int(11) DEFAULT NULL,
  `preferred_language` varchar(10) DEFAULT NULL,
  `consultation_info` text,
  `other_info` text,
  `writing_help_get_started` smallint(6) DEFAULT NULL,
  `writing_help_overall_structure` smallint(6) DEFAULT NULL,
  `writing_help_paragraph_structure` smallint(6) DEFAULT NULL,
  `writing_help_sentence_construction` smallint(6) DEFAULT NULL,
  `writing_help_coherence_cohesion` smallint(6) DEFAULT NULL,
  `writing_help_style_formality` smallint(6) DEFAULT NULL,
  `writing_help_conventions` smallint(6) DEFAULT NULL,
  `writing_help_citation` smallint(6) DEFAULT NULL,
  `writing_help_references` smallint(6) DEFAULT NULL,
  `writing_help_otherformal` smallint(6) DEFAULT NULL,
  `oral_help_nervousness` smallint(6) DEFAULT NULL,
  `oral_help_overall_structure` smallint(6) DEFAULT NULL,
  `oral_help_act_interact` smallint(6) DEFAULT NULL,
  `oral_help_interact_computer` smallint(6) DEFAULT NULL,
  `oral_help_bodylanguage` smallint(6) DEFAULT NULL,
  `oral_help_images` smallint(6) DEFAULT NULL,
  `oral_help_keeptime` smallint(6) DEFAULT NULL,
  `help_other` text,
  `ical_uid` varchar(255) NOT NULL DEFAULT '',
  `ical_sequence` smallint(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `mailtext_en` text,
  `morningstarts_monday` int(11) DEFAULT '8',
  `morningstarts_minutes_monday` int(11) DEFAULT '0',
  `eveningends_monday` int(11) DEFAULT '20',
  `eveningends_minutes_monday` int(11) DEFAULT '0',
  `morningstarts_tuesday` int(11) DEFAULT '8',
  `morningstarts_minutes_tuesday` int(11) DEFAULT '0',
  `eveningends_tuesday` int(11) DEFAULT '20',
  `eveningends_minutes_tuesday` int(11) DEFAULT '0',
  `morningstarts_wednesday` int(11) DEFAULT '8',
  `morningstarts_minutes_wednesday` int(11) DEFAULT '0',
  `eveningends_wednesday` int(11) DEFAULT '20',
  `eveningends_minutes_wednesday` int(11) DEFAULT '0',
  `morningstarts_thursday` int(11) DEFAULT '8',
  `morningstarts_minutes_thursday` int(11) DEFAULT '0',
  `eveningends_thursday` int(11) DEFAULT '20',
  `eveningends_minutes_thursday` int(11) DEFAULT '0',
  `morningstarts_friday` int(11) DEFAULT '8',
  `morningstarts_minutes_friday` int(11) DEFAULT '0',
  `eveningends_friday` int(11) DEFAULT '18',
  `eveningends_minutes_friday` int(11) DEFAULT '0',
  `morningstarts_saturday` int(11) DEFAULT '10',
  `morningstarts_minutes_saturday` int(11) DEFAULT '0',
  `eveningends_saturday` int(11) DEFAULT '15',
  `eveningends_minutes_saturday` int(11) DEFAULT '0',
  `morningstarts_sunday` int(11) DEFAULT NULL,
  `morningstarts_minutes_sunday` int(11) DEFAULT NULL,
  `eveningends_sunday` int(11) DEFAULT NULL,
  `eveningends_minutes_sunday` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_room`
--
/*
--Grupprum
INSERT INTO mrbs_grupprum.mrbs_room (`disabled`, `area_id`, `room_name`, `room_name_english`, `sort_key`, `exchange_email`, `description`, `capacity`, `room_admin_email`, `custom_html`, `room_number`, `screen`, `mailtext`, `mailtext_en`) 
SELECT `disabled`, `area_id`, `room_name`, `room_name_english`, `sort_key`, null, `description`, `capacity`, `room_admin_email`, `custom_html`, `room_number`, `screen`, `mailtext`, `mailtext_en` 
FROM mrbs.mrbs_room
WHERE mrbs.mrbs_room.area_id=2

--Handledning
INSERT INTO `mrbs_room` (`disabled`, `area_id`, `room_name`, `room_name_english`, `sort_key`, `exchange_email`, `description`, `capacity`, `room_admin_email`, `custom_html`, `room_number`, `screen`, `mailtext`, `mailtext_en`, `morningstarts_monday`, `morningstarts_minutes_monday`, `eveningends_monday`, `eveningends_minutes_monday`, `morningstarts_tuesday`, `morningstarts_minutes_tuesday`, `eveningends_tuesday`, `eveningends_minutes_tuesday`, `morningstarts_wednesday`, `morningstarts_minutes_wednesday`, `eveningends_wednesday`, `eveningends_minutes_wednesday`, `morningstarts_thursday`, `morningstarts_minutes_thursday`, `eveningends_thursday`, `eveningends_minutes_thursday`, `morningstarts_friday`, `morningstarts_minutes_friday`, `eveningends_friday`, `eveningends_minutes_friday`, `morningstarts_saturday`, `morningstarts_minutes_saturday`, `eveningends_saturday`, `eveningends_minutes_saturday`, `morningstarts_sunday`, `morningstarts_minutes_sunday`, `eveningends_sunday`, `eveningends_minutes_sunday`) VALUES
(0, 1, 'Handledning', 'Handledning', 'Handledning', 'ece-kthb-undervisningsschema@ug.kth.se', '', 8, '', '', '', 0, 'Du har bokat tid för handledning på KTH Biblioteket', 'You have booked consultation at the KTH Library.', 8, 0, 16, 0, 8, 0, 16, 0, 8, 0, 16, 0, 8, 0, 16, 0, 8, 0, 14, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--Talbok
INSERT INTO `mrbs_room` (`id`, `disabled`, `area_id`, `room_name`, `room_name_english`, `sort_key`, `exchange_email`, `description`, `capacity`, `room_admin_email`, `custom_html`, `room_number`, `screen`, `mailtext`, `mailtext_en`, `morningstarts_monday`, `morningstarts_minutes_monday`, `eveningends_monday`, `eveningends_minutes_monday`, `morningstarts_tuesday`, `morningstarts_minutes_tuesday`, `eveningends_tuesday`, `eveningends_minutes_tuesday`, `morningstarts_wednesday`, `morningstarts_minutes_wednesday`, `eveningends_wednesday`, `eveningends_minutes_wednesday`, `morningstarts_thursday`, `morningstarts_minutes_thursday`, `eveningends_thursday`, `eveningends_minutes_thursday`, `morningstarts_friday`, `morningstarts_minutes_friday`, `eveningends_friday`, `eveningends_minutes_friday`, `morningstarts_saturday`, `morningstarts_minutes_saturday`, `eveningends_saturday`, `eveningends_minutes_saturday`, `morningstarts_sunday`, `morningstarts_minutes_sunday`, `eveningends_sunday`, `eveningends_minutes_sunday`) VALUES
(1, 0, 1, 'Huvudbiblioteket', 'Main Library', '1', 'gvs-kthb-talboksservice@ug.kth.se', '', 0, '', '', '', 0, '', '', 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 14, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 0, 1, 'Kista', 'Kista', '2', 'gvs-kthb-talboksservice@ug.kth.se', '', 0, '', '', '', 0, '', '', 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 14, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 0, 1, 'Södertälje', 'Södertälje', '3', 'gvs-kthb-talboksservice@ug.kth.se', '', 0, '', '', '', 0, '', '', 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 14, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 0, 1, 'Flemingsberg', 'Flemingsberg', '4', 'gvs-kthb-talboksservice@ug.kth.se', '', 1, '', '', '', 0, '', '', 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 14, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--Inläsningstjänst
INSERT INTO `mrbs_room` (`id`, `disabled`, `area_id`, `room_name`, `room_name_english`, `sort_key`, `exchange_email`, `description`, `capacity`, `room_admin_email`, `custom_html`, `room_number`, `screen`, `mailtext`, `mailtext_en`, `morningstarts_monday`, `morningstarts_minutes_monday`, `eveningends_monday`, `eveningends_minutes_monday`, `morningstarts_tuesday`, `morningstarts_minutes_tuesday`, `eveningends_tuesday`, `eveningends_minutes_tuesday`, `morningstarts_wednesday`, `morningstarts_minutes_wednesday`, `eveningends_wednesday`, `eveningends_minutes_wednesday`, `morningstarts_thursday`, `morningstarts_minutes_thursday`, `eveningends_thursday`, `eveningends_minutes_thursday`, `morningstarts_friday`, `morningstarts_minutes_friday`, `eveningends_friday`, `eveningends_minutes_friday`, `morningstarts_saturday`, `morningstarts_minutes_saturday`, `eveningends_saturday`, `eveningends_minutes_saturday`, `morningstarts_sunday`, `morningstarts_minutes_sunday`, `eveningends_sunday`, `eveningends_minutes_sunday`) VALUES
(1, 0, 1, 'Huvudbiblioteket', 'Main Library', '1', 'gvs-kthb-inlasningstjanst@ug.kth.se', '', 0, '', '', '', 0, '', '', 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 14, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 0, 1, 'Kista', 'Kista', '2', 'gvs-kthb-inlasningstjanst@ug.kth.se', '', 0, '', '', '', 0, '', '', 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 14, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 0, 1, 'Södertälje', 'Södertälje', '3', 'gvs-kthb-inlasningstjanst@ug.kth.se', '', 0, '', '', '', 0, '', '', 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 14, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 0, 1, 'Flemingsberg', 'Flemingsberg', '4', 'gvs-kthb-inlasningstjanst@ug.kth.se', '', 1, '', '', '', 0, '', '', 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 16, 0, 9, 0, 14, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--Readingstudios
INSERT INTO `mrbs_room` (`disabled`, `area_id`, `room_name`, `room_name_english`, `sort_key`, `exchange_email`, `description`, `capacity`, `room_admin_email`, `custom_html`, `room_number`, `screen`, `mailtext`, `mailtext_en`) VALUES
(0, 1, 'Huvudbiblioteket', 'Main Library', '1', '', '', 0, '', 'Bla bla bla blaBla bla bla blaBla bla bla bla', '', 0, '', ''),
(0, 1, 'Kista', 'Kista', '2', '', '', 0, '', '', '', 0, '', ''),
(0, 1, 'Södertälje', 'Södertälje', '3', '', '', 0, '', '', '', 0, '', ''),
(0, 1, 'Flemingsberg', 'Flemingsberg', '4', '', '', 1, '', '', '', 0, '', '');

--Grupprum
INSERT INTO `mrbs_room` (`disabled`, `area_id`, `room_name`, `room_name_english`, `sort_key`, `exchange_email`, `description`, `capacity`, `room_admin_email`, `custom_html`, `room_number`, `screen`, `mailtext`, `mailtext_en`) VALUES
(0, 1, 'Al-Khwarizmi', 'Al-Khwarizmi', '00', NULL, 'Grupprum', 8, '', 'Aktiverade nätverksuttag är markerade med "grön plupp". Kabel kan lånas och återlämnas i Låneexpeditionen, Informationen eller Receptionen.', '0', 0, NULL, NULL),
(0, 1, 'Leibniz', 'Leibniz', '01', NULL, 'Grupprum', 6, '', '', '1', 0, NULL, NULL),
(0, 1, 'Galvani', 'Galvani', '08', NULL, '', 6, '', '', '8', 0, NULL, NULL),
(0, 1, 'Watt', 'Watt', '09', NULL, '', 6, '', '', '9', 0, NULL, NULL),
(0, 1, 'Santorio', 'Santorio', '10', NULL, '', 6, '', '', '10', 0, NULL, NULL),
(0, 1, 'Kovalevsky', 'Kovalevsky', '11', NULL, '', 6, '', '', '11', 0, NULL, NULL),
(1, 1, 'Ekeblad', 'Ekeblad', '12', NULL, '', 6, '', '', '12', 0, '', ''),
(1, 1, 'Sundström', 'Sundström', '13', NULL, '', 5, '', '', '13', 0, '', ''),
(0, 1, 'Scheele', 'Scheele', '03', NULL, '', 6, '', '', '3', 0, NULL, NULL),
(0, 1, 'Pascal', 'Pascal', '02', NULL, '', 4, '', '', '2', 0, NULL, NULL),
(0, 1, 'Leopold', 'Leopold', '04', NULL, 'Whiteboard och skärm', 6, '', '', '4', 1, NULL, NULL),
(0, 1, 'Agricola', 'Agricola', '05', NULL, ' ', 6, '', '', '5', 0, NULL, NULL),
(0, 1, 'Bernoulli', 'Bernoulli', '06', NULL, '', 6, '', '', '6', 0, NULL, NULL),
(0, 1, 'Dürer', 'Dürer', '07', NULL, '', 6, '', '', '7', 0, NULL, NULL),
(1, 1, 'Hammarström', 'Hammarström', '14', NULL, '', 4, '', '', '', 0, NULL, NULL);

--CAS
INSERT INTO `mrbs_room` (`disabled`, `area_id`, `room_name`, `room_name_english`, `sort_key`, `exchange_email`, `description`, `capacity`, `room_admin_email`, `custom_html`, `room_number`, `screen`, `mailtext`, `mailtext_en`) VALUES
(0, 1, 'Skriftliga arbeten och/eller muntliga presentationer på svenska  <img src="images/sv_SE.png">', 'Written assignments and/or oral presentations in Swedish <img src="images/sv_SE.png">', '100', '', '', 8, '', '', '', 0, 'Du har bokat tid för handledning på KTH Biblioteket', 'You have booked consultation at the KTH Library.'),
(0, 1, 'Skriftliga arbeten och/eller muntliga presentationer på engelska <img src="images/en_UK.png">', 'Written assignments and/or oral presentations in English <img src="images/en_UK.png">', '110', '', '', 8, '', '', '', 0, 'Du har bokat tid för handledning på KTH Biblioteket', 'You have booked consultation at the KTH Library.');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `mrbs_zoneinfo`
--

INSERT INTO `mrbs_zoneinfo` (`id`, `timezone`, `outlook_compatible`, `vtimezone`, `last_updated`) VALUES
(1, 'Europe/Stockholm', 1, 'BEGIN:VTIMEZONE\r\nTZID:Europe/Stockholm\r\nTZURL:http://tzurl.org/zoneinfo-outlook/Europe/Stockholm\r\nX-LIC-LOCATION:Europe/Stockholm\r\nBEGIN:DAYLIGHT\r\nTZOFFSETFROM:+0100\r\nTZOFFSETTO:+0200\r\nTZNAME:CEST\r\nDTSTART:19700329T020000\r\nRRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU\r\nEND:DAYLIGHT\r\nBEGIN:STANDARD\r\nTZOFFSETFROM:+0200\r\nTZOFFSETTO:+0100\r\nTZNAME:CET\r\nDTSTART:19701025T030000\r\nRRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU\r\nEND:STANDARD\r\nEND:VTIMEZONE', 1580482785);

-- Kör till hit först!

-- Kör sen resten
--
-- Index för dumpade tabeller
--

--
-- Index för tabell `kth_areatype`
--
ALTER TABLE `kth_areatype`
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
-- Index för tabell `kth_campus`
--
ALTER TABLE `kth_campus`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_entry_custom_fields`
--
ALTER TABLE `kth_entry_custom_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_exchange_events`
--
ALTER TABLE `kth_exchange_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_instructors`
--
ALTER TABLE `kth_instructors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_periods`
--
ALTER TABLE `kth_periods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `kth_places`
--
ALTER TABLE `kth_places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT för tabell `kth_campus`
--
ALTER TABLE `kth_campus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT för tabell `mrbs_area`
--
ALTER TABLE `mrbs_area`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_entry`
--
ALTER TABLE `mrbs_entry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_entry_no_show`
--
ALTER TABLE `mrbs_entry_no_show`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_repeat`
--
ALTER TABLE `mrbs_repeat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_room`
--
ALTER TABLE `mrbs_room`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_users`
--
ALTER TABLE `mrbs_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_variables`
--
ALTER TABLE `mrbs_variables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `mrbs_zoneinfo`
--
ALTER TABLE `mrbs_zoneinfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
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
