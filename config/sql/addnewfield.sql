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
INSERT INTO `kth_entry_custom_fields` (`area_id`, `entry_field_name`, `type`, `sort_order`, `visible`, `enabled`, `mandatory`) VALUES
(1, 'my_campus', 'custom', 411, 1, 1, 1);
*/

/* KTH_program (som hämtas från kth-api*/
ALTER TABLE `mrbs_entry` ADD `kth_program` varchar(50) NULL DEFAULT NULL AFTER `program`;

ALTER TABLE `mrbs_repeat` ADD `kth_program` varchar(50) NULL DEFAULT NULL AFTER `program`;

ALTER TABLE `mrbs_entry_delete` ADD `kth_program` varchar(50) NULL DEFAULT NULL AFTER `program`;