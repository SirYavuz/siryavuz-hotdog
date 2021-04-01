INSERT INTO `jobs` (name, label) VALUES
	('sosisci', 'Sosisli Dukkani')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('sosisci',0,'calisan','Çalışan',20,'{}','{}'),
	('sosisci',1,'patron','Patron',40,'{}','{}');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('sosis', 'Çiğ Sosis', 0.1, 0, 1),
('pismissosis', 'Pişmiş Sosis', 0.1, 0, 1),
('sosisekmek', 'Sosisli Ekmeği', 0.1, 0, 1),
('paketsosisli', 'Paket Sosisli', 0.1, 0, 1),
('ketcap', 'Ketcap', 0.1, 0, 1),
('hardal', 'Hardal', 0.1, 0, 1),
('ketcapsosis', 'Ketcap Sosisli', 0.1, 0, 1),
('hardalsosis', 'Hardal Sosisli', 0.1, 0, 1),
('sprite', 'Sptire', 0.1, 0, 1),
('sosiscola', 'Sptire', 0.1, 0, 1),
('soda', 'Soda', 0.1, 0, 1),
('hotdog', 'Sosisli', 1, 0, 1);