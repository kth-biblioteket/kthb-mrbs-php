/* Exempel på att lägga till ett nytt fält, DATATYP? (int, varchar) */
/* Lägg också till fältet i mrbs_init.sql*/

/* KTH Campus för Handledning */

ALTER TABLE `mrbs_entry` ADD `my_campus` INT NULL DEFAULT NULL AFTER `campus`;

ALTER TABLE `mrbs_repeat` ADD `my_campus` INT NULL DEFAULT NULL AFTER `campus`;

ALTER TABLE `mrbs_entry_delete` ADD `my_campus` INT NULL DEFAULT NULL AFTER `campus`;

CREATE TABLE IF NOT EXISTS `kth_campus` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `kth_campus`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `kth_campus`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

INSERT INTO `kth_campus` (`disabled`, `sort_key`, `name`, `name_en`) VALUES
(0, '1', 'Campus KTH', 'Campus KTH'),
(0, '2', 'Campus Kista', 'Campus Kista'),
(0, '3', 'Campus Södertälje', 'Campus Södertälje'),
(0, '4', 'Campus Flemingsberg', 'Campus Flemingsberg'),
(0, '5', 'Campus Solna', 'Campus Solna'),
(0, '0', '1none', '1none');

/*Kör bara för den Applikation som ska ha med fältet i bokningen*/
/*
INSERT INTO `kth_entry_custom_fields` (`area_id`, `entry_field_name`, `field_type`, `type`, `sort_order`, `visible`, `enabled`, `mandatory`) VALUES
(1, 'kth_campus', 6, 'custom', 422, 1, 1, 1);
*/

/* KTH Assigmnent för CAS */

ALTER TABLE `mrbs_entry` ADD `kth_assignment` INT NULL DEFAULT NULL AFTER `my_campus`;

ALTER TABLE `mrbs_repeat` ADD `kth_assignment` INT NULL DEFAULT NULL AFTER `my_campus`;

ALTER TABLE `mrbs_entry_delete` ADD `kth_assignment` INT NULL DEFAULT NULL AFTER `my_campus`;

CREATE TABLE IF NOT EXISTS `kth_assignments` (
  `id` int(11) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `sort_key` varchar(25) NOT NULL,
  `name` varchar(100) NOT NULL,
  `name_en` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `kth_assignments`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `kth_assignments`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

INSERT INTO `kth_assignments` (`disabled`, `sort_key`, `name`, `name_en`) VALUES
(0, '1', 'Mitt kandidatexamensarbete', "My Bachelor's thesis"),
(0, '2', 'Min presentation av kandidatexamensarbete', "My Bachelor's thesis presentation"),
(0, '3', 'Mitt magisterexamensarbete', "My Master's thesis"),
(0, '4', 'Min presentation av magisterexamensarbete', "My Master's thesis presentation"),
(0, '0', '1none', '1none');

/*Kör bara för den Applikation som ska ha med fältet i bokningen*/
/*
INSERT INTO `kth_entry_custom_fields` (`area_id`, `entry_field_name`, `field_type`, `type`, `sort_order`, `visible`, `enabled`, `mandatory`) VALUES
(1, 'kth_assignment', 6, 'custom', 112, 1, 1, 1);
*/

/* KTH_program (som hämtas från kth-api*/
ALTER TABLE `mrbs_entry` ADD `kth_program` varchar(50) NULL DEFAULT NULL AFTER `program`;

ALTER TABLE `mrbs_repeat` ADD `kth_program` varchar(50) NULL DEFAULT NULL AFTER `program`;

ALTER TABLE `mrbs_entry_delete` ADD `kth_program` varchar(50) NULL DEFAULT NULL AFTER `program`;

/* Cas other assignments(written, oral) */
ALTER TABLE `mrbs_entry` ADD `kth_other_written_assignments` TEXT NULL DEFAULT NULL AFTER `kth_assignment`;

ALTER TABLE `mrbs_repeat` ADD `kth_other_written_assignments` TEXT NULL DEFAULT NULL AFTER `kth_assignment`;

ALTER TABLE `mrbs_entry_delete` ADD `kth_other_written_assignments` TEXT NULL DEFAULT NULL AFTER `kth_assignment`;

ALTER TABLE `mrbs_entry` ADD `kth_other_oral_assignments` TEXT NULL DEFAULT NULL AFTER `kth_other_written_assignments`;

ALTER TABLE `mrbs_repeat` ADD `kth_other_oral_assignments` TEXT NULL DEFAULT NULL AFTER `kth_other_written_assignments`;

ALTER TABLE `mrbs_entry_delete` ADD `kth_other_oral_assignments` TEXT NULL DEFAULT NULL AFTER `kth_other_written_assignments`;

ALTER TABLE `mrbs_entry` ADD `understand_purpose_audience` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `get_started_assignment` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `understand_assignment_instruction` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `main_message_argument_logic` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `overall_structure_text` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `paragraph_sentence_structure` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `using_sources_support_argument` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `presenting_data_discuss_result` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `grammar_punctuation` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `words_phrases` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `academic_style` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `pronuncation` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `body_language_eye_contact` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `communicate_visual_info` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry` ADD `present_digitally` smallint(6) DEFAULT NULL;

ALTER TABLE `mrbs_repeat` ADD `understand_purpose_audience` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `get_started_assignment` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `understand_assignment_instruction` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `main_message_argument_logic` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `overall_structure_text` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `paragraph_sentence_structure` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `using_sources_support_argument` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `presenting_data_discuss_result` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `grammar_punctuation` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `words_phrases` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `academic_style` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `pronuncation` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `body_language_eye_contact` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `communicate_visual_info` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_repeat` ADD `present_digitally` smallint(6) DEFAULT NULL;

ALTER TABLE `mrbs_entry_delete` ADD `understand_purpose_audience` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `get_started_assignment` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `understand_assignment_instruction` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `main_message_argument_logic` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `overall_structure_text` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `paragraph_sentence_structure` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `using_sources_support_argument` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `presenting_data_discuss_result` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `grammar_punctuation` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `words_phrases` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `academic_style` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `pronuncation` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `body_language_eye_contact` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `communicate_visual_info` smallint(6) DEFAULT NULL;
ALTER TABLE `mrbs_entry_delete` ADD `present_digitally` smallint(6) DEFAULT NULL;

INSERT INTO `kth_entry_custom_fields` (`area_id`, `entry_field_name`, `field_type`, `type`, `sort_order`, `visible`, `enabled`, `user_hidden`, `mandatory`) VALUES
(1, 'understand_purpose_audience', 6, 'custom', 200, 1, 1, 0, 1),
(1, 'get_started_assignment', 6, 'custom', 205, 1, 1, 0, 1),
(1, 'understand_assignment_instruction', 6, 'custom', 210, 1, 1, 0, 1),
(1, 'main_message_argument_logic', 6, 'custom', 215, 1, 1, 0, 1),
(1, 'overall_structure_text', 6, 'custom', 220, 1, 1, 0, 1),
(1, 'paragraph_sentence_structure', 6, 'custom', 225, 1, 1, 0, 1),
(1, 'using_sources_support_argument', 6, 'custom', 230, 1, 1, 0, 1),
(1, 'presenting_data_discuss_result', 6, 'custom', 235, 1, 1, 0, 1),
(1, 'grammar_punctuation', 6, 'custom', 240, 1, 1, 0, 1),
(1, 'words_phrases', 6, 'custom', 245, 1, 1, 0, 1),
(1, 'academic_style', 6, 'custom', 250, 1, 1, 0, 1),
(1, 'pronuncation', 6, 'custom', 255, 1, 1, 0, 1),
(1, 'body_language_eye_contact', 6, 'custom', 260, 1, 1, 0, 1),
(1, 'communicate_visual_info', 6, 'custom', 265, 1, 1, 0, 1),
(1, 'present_digitally', 6, 'custom', 270, 1, 1, 0, 1)

--
-- Tabellstruktur `kth_radio_values`
--
DROP TABLE IF EXISTS `kth_radio_values`;
CREATE TABLE IF NOT EXISTS `kth_radio_values` (
  `id` int(11) NOT NULL,
  `entry_field_name` varchar(50) NOT NULL,
  `radio_id` int(11) NOT NULL,
  `value_en` varchar(100) NOT NULL,
  `value_sv` varchar(100) NOT NULL,
  `default_choice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index för tabell `kth_radio_values`
--
ALTER TABLE `kth_radio_values`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT för tabell `kth_radio_values`
--
ALTER TABLE `kth_radio_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

  INSERT INTO `mrbs_cas`.`kth_radio_values` (`entry_field_name`, `radio_id`, `value_en`, `value_sv`, `default_choice`) VALUES 
  ('understand_purpose_audience', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('understand_purpose_audience', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('get_started_assignment', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('get_started_assignment', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('understand_assignment_instruction', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('understand_assignment_instruction', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('main_message_argument_logic', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('main_message_argument_logic', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('overall_structure_text', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('overall_structure_text', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('paragraph_sentence_structure', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('paragraph_sentence_structure', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('using_sources_support_argument', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('using_sources_support_argument', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('presenting_data_discuss_result', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('presenting_data_discuss_result', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('grammar_punctuation', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('grammar_punctuation', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('words_phrases', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('words_phrases', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('academic_style', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('academic_style', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('pronuncation', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('pronuncation', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('body_language_eye_contact', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('body_language_eye_contact', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('communicate_visual_info', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('communicate_visual_info', '2', 'I''d like to discuss', 'Jag vill diskutera', '0'),
  ('present_digitally', '1', 'I feel confident!', 'Jag känner mig säker', '1'), 
  ('present_digitally', '2', 'I''d like to discuss', 'Jag vill diskutera', '0');
