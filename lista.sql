SELECT E.id AS entry_id, E.create_by, E.name, E.description, E.start_time, E.end_time,
                 R.area_id, A.enable_periods, R.room_name, A.area_name, 'booking' as 'info'
            FROM mrbs_entry E, mrbs_room R, mrbs_area A
           WHERE (  E.create_by LIKE '%%'  OR  E.name LIKE '%%'  OR  E.description LIKE '%%'  OR  E.help_other LIKE '%%' ) AND E.room_id = R.id AND R.area_id = A.id AND E.type != 'C' AND A.id != 10 UNION
			SELECT E.id AS entry_id, E.create_by, E.name, E.description, E.start_time, E.end_time,
                 R.area_id, A.enable_periods, R.room_name, A.area_name, 'no-show' as 'info'
            FROM mrbs_entry_no_show E, mrbs_room R, mrbs_area A
           WHERE (  E.create_by LIKE '%%'  OR  E.name LIKE '%%'  OR  E.description LIKE '%%'  OR  E.help_other LIKE '%%' ) AND E.room_id = R.id AND R.area_id = A.id AND E.type != 'C' AND A.id != 10 ORDER BY start_time asc



SELECT E.id AS ID, E.create_by AS 'Bokad av', E.name AS 'Namn',FROM_UNIXTIME(E.start_time) AS 'Starttid', 
FROM_UNIXTIME(E.end_time) AS 'Sluttid',R.room_name AS 'Rum', A.area_name AS 'Area'
FROM mrbs_entry E, mrbs_room R, mrbs_area A
WHERE E.room_id = R.id 
AND R.area_id = A.id 
AND A.id = 2
AND e.start_time > UNIX_TIMESTAMP('2018-01-01')
AND e.end_time < UNIX_TIMESTAMP('2018-12-31')
ORDER BY e.start_time