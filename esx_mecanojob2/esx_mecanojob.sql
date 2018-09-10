USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mecano2', 'Mechanic', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mecano2', 'Mechanic', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mecano2', 'Mechanic')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mecano2',0,'recrue','R&D',12,'{}','{}'),
	('mecano2',1,'novice','Towing',24,'{}','{}'),
	('mecano2',2,'experimente','Supervisor',36,'{}','{}'),
	('mecano2',3,'boss','CEO',0,'{}','{}')
;
