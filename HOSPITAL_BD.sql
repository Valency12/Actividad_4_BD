-- Crear base de datos y usarla
CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    ssn VARCHAR(30) NOT NULL, -- número de seguro social
    role ENUM('enfermero','auxiliar','guardia','administrativo') NOT NULL
) ENGINE=InnoDB;

DROP TABLE IF EXISTS doctors;
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_medico ENUM('titular','interino','sustituto') NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    ssn VARCHAR(30) NOT NULL,
    cedula VARCHAR(50) NOT NULL -- cédula profesional
) ENGINE=InnoDB;

DROP TABLE IF EXISTS doctor_substitutions;
CREATE TABLE doctor_substitutions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    fecha_alta DATE NOT NULL,
    fecha_baja DATE NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS vacations;
CREATE TABLE vacations (
    vacation_id INT AUTO_INCREMENT PRIMARY KEY,
    person_type ENUM('doctor','employee') NOT NULL,
    person_id INT NOT NULL, -- si person_type='doctor' -> doctors.doctor_id, else employees.employee_id
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    days INT NOT NULL,
    CHECK (days > 0)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    ssn VARCHAR(30) NOT NULL,
    doctor_id INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_analisis DATE NULL,
    fecha_intervencion DATE NULL,
    fecha_alta DATE NULL,
    historial_clinico TEXT,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS doctor_schedule;
CREATE TABLE doctor_schedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    day_of_week ENUM('Mon','Tue','Wed','Thu','Fri','Sat','Sun') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Insertar 30 médicos
INSERT INTO doctors (tipo_medico, full_name, address, phone, city, state, postal_code, ssn, cedula) VALUES
('titular','Dr. Alejandro Gómez','Calle A 123','555-0101','Ciudad A','Estado A','01000','SSN-D-0001','CED-0001'),
('interino','Dra. Beatriz López','Av. B 45','555-0102','Ciudad B','Estado B','01001','SSN-D-0002','CED-0002'),
('sustituto','Dr. Carlos Pérez','Calle C 7','555-0103','Ciudad C','Estado C','01002','SSN-D-0003','CED-0003'),
('titular','Dra. Daniela Ruiz','Calle D 12','555-0104','Ciudad D','Estado D','01003','SSN-D-0004','CED-0004'),
('interino','Dr. Eduardo Sánchez','Av. E 98','555-0105','Ciudad E','Estado E','01004','SSN-D-0005','CED-0005'),
('sustituto','Dra. Fernanda Torres','Calle F 34','555-0106','Ciudad F','Estado F','01005','SSN-D-0006','CED-0006'),
('titular','Dr. Gabriel Morales','Av. G 56','555-0107','Ciudad G','Estado G','01006','SSN-D-0007','CED-0007'),
('interino','Dra. Helena Navarro','Calle H 78','555-0108','Ciudad H','Estado H','01007','SSN-D-0008','CED-0008'),
('sustituto','Dr. Ignacio Castillo','Calle I 9','555-0109','Ciudad I','Estado I','01008','SSN-D-0009','CED-0009'),
('titular','Dra. Juliana Vega','Av. J 11','555-0110','Ciudad J','Estado J','01009','SSN-D-0010','CED-0010'),
('interino','Dr. Kevin Rojas','Calle K 22','555-0111','Ciudad K','Estado K','01010','SSN-D-0011','CED-0011'),
('sustituto','Dra. Laura Méndez','Av. L 33','555-0112','Ciudad L','Estado L','01011','SSN-D-0012','CED-0012'),
('titular','Dr. Manuel Ortega','Calle M 44','555-0113','Ciudad M','Estado M','01012','SSN-D-0013','CED-0013'),
('interino','Dra. Natalia Paredes','Av. N 55','555-0114','Ciudad N','Estado N','01013','SSN-D-0014','CED-0014'),
('sustituto','Dr. Oscar Ruiz','Calle O 66','555-0115','Ciudad O','Estado O','01014','SSN-D-0015','CED-0015'),
('titular','Dra. Patricia Solís','Av. P 77','555-0116','Ciudad P','Estado P','01015','SSN-D-0016','CED-0016'),
('interino','Dr. Quique Herrera','Calle Q 88','555-0117','Ciudad Q','Estado Q','01016','SSN-D-0017','CED-0017'),
('sustituto','Dra. Rosa Blanco','Av. R 99','555-0118','Ciudad R','Estado R','01017','SSN-D-0018','CED-0018'),
('titular','Dr. Samuel Medina','Calle S 100','555-0119','Ciudad S','Estado S','01018','SSN-D-0019','CED-0019'),
('interino','Dra. Teresa Álvarez','Av. T 101','555-0120','Ciudad T','Estado T','01019','SSN-D-0020','CED-0020'),
('sustituto','Dr. Ulises Campos','Calle U 202','555-0121','Ciudad U','Estado U','01020','SSN-D-0021','CED-0021'),
('titular','Dra. Valeria Rincón','Av. V 303','555-0122','Ciudad V','Estado V','01021','SSN-D-0022','CED-0022'),
('interino','Dr. Walter Díaz','Calle W 404','555-0123','Ciudad W','Estado W','01022','SSN-D-0023','CED-0023'),
('sustituto','Dra. Ximena Flores','Av. X 505','555-0124','Ciudad X','Estado X','01023','SSN-D-0024','CED-0024'),
('titular','Dr. Yahir Montes','Calle Y 606','555-0125','Ciudad Y','Estado Y','01024','SSN-D-0025','CED-0025'),
('interino','Dra. Zoe Palma','Av. Z 707','555-0126','Ciudad Z','Estado Z','01025','SSN-D-0026','CED-0026'),
('sustituto','Dr. Álvaro Peña','Calle AA 808','555-0127','Ciudad AA','Estado AA','01026','SSN-D-0027','CED-0027'),
('titular','Dra. Brenda Castro','Av. BB 909','555-0128','Ciudad BB','Estado BB','01027','SSN-D-0028','CED-0028'),
('interino','Dr. César León','Calle CC 1000','555-0129','Ciudad CC','Estado CC','01028','SSN-D-0029','CED-0029'),
('sustituto','Dra. Diana Sol','Av. DD 1100','555-0130','Ciudad DD','Estado DD','01029','SSN-D-0030','CED-0030');

SELECT * FROM doctors;
INSERT INTO employees (full_name, address, phone, city, state, postal_code, ssn, role) VALUES
('Ana Martínez','Calle E 1','555-0201','Ciudad A','Estado A','02000','SSN-E-0001','enfermero'),
('Bruno Pérez','Av. F 2','555-0202','Ciudad B','Estado B','02001','SSN-E-0002','auxiliar'),
('Carla Gómez','Calle G 3','555-0203','Ciudad C','Estado C','02002','SSN-E-0003','guardia'),
('David Ramírez','Av. H 4','555-0204','Ciudad D','Estado D','02003','SSN-E-0004','administrativo'),
('Elena Morales','Calle I 5','555-0205','Ciudad E','Estado E','02004','SSN-E-0005','enfermero'),
('Fernando Cruz','Av. J 6','555-0206','Ciudad F','Estado F','02005','SSN-E-0006','auxiliar'),
('Gabriela Ruiz','Calle K 7','555-0207','Ciudad G','Estado G','02006','SSN-E-0007','guardia'),
('Hugo Torres','Av. L 8','555-0208','Ciudad H','Estado H','02007','SSN-E-0008','administrativo'),
('Irene Navarro','Calle M 9','555-0209','Ciudad I','Estado I','02008','SSN-E-0009','enfermero'),
('Javier Castillo','Av. N 10','555-0210','Ciudad J','Estado J','02009','SSN-E-0010','auxiliar'),
('Karla Vega','Calle O 11','555-0211','Ciudad K','Estado K','02010','SSN-E-0011','guardia'),
('Luis Rojas','Av. P 12','555-0212','Ciudad L','Estado L','02011','SSN-E-0012','administrativo'),
('María Méndez','Calle Q 13','555-0213','Ciudad M','Estado M','02012','SSN-E-0013','enfermero'),
('Nicolás Ortega','Av. R 14','555-0214','Ciudad N','Estado N','02013','SSN-E-0014','auxiliar'),
('Olga Paredes','Calle S 15','555-0215','Ciudad O','Estado O','02014','SSN-E-0015','guardia'),
('Pablo Ruiz','Av. T 16','555-0216','Ciudad P','Estado P','02015','SSN-E-0016','administrativo'),
('Queta Herrera','Calle U 17','555-0217','Ciudad Q','Estado Q','02016','SSN-E-0017','enfermero'),
('Raúl Blanco','Av. V 18','555-0218','Ciudad R','Estado R','02017','SSN-E-0018','auxiliar'),
('Sara Medina','Calle W 19','555-0219','Ciudad S','Estado S','02018','SSN-E-0019','guardia'),
('Tomás Álvarez','Av. X 20','555-0220','Ciudad T','Estado T','02019','SSN-E-0020','administrativo'),
('Úrsula Campos','Calle Y 21','555-0221','Ciudad U','Estado U','02020','SSN-E-0021','enfermero'),
('Víctor Rincón','Av. Z 22','555-0222','Ciudad V','Estado V','02021','SSN-E-0022','auxiliar'),
('Wendy Díaz','Calle AA 23','555-0223','Ciudad W','Estado W','02022','SSN-E-0023','guardia'),
('Xavier Flores','Av. BB 24','555-0224','Ciudad X','Estado X','02023','SSN-E-0024','administrativo'),
('Yolanda Montes','Calle CC 25','555-0225','Ciudad Y','Estado Y','02024','SSN-E-0025','enfermero'),
('Zacarías Palma','Av. DD 26','555-0226','Ciudad Z','Estado Z','02025','SSN-E-0026','auxiliar'),
('Alicia Peña','Calle EE 27','555-0227','Ciudad AA','Estado AA','02026','SSN-E-0027','guardia'),
('Beto Castro','Av. FF 28','555-0228','Ciudad BB','Estado BB','02027','SSN-E-0028','administrativo'),
('Cecilia León','Calle GG 29','555-0229','Ciudad CC','Estado CC','02028','SSN-E-0029','enfermero'),
('Diego Sol','Av. HH 30','555-0230','Ciudad DD','Estado DD','02029','SSN-E-0030','auxiliar');
SELECT * FROM employees;

INSERT INTO patients (full_name, address, phone, postal_code, ssn, doctor_id, fecha_ingreso, fecha_analisis, fecha_intervencion, fecha_alta, historial_clinico) VALUES
('Paciente A','C. Pac A 1','555-0301','03000','SSN-P-0001',1,'2024-01-10','2024-01-12','2024-02-15','2024-02-20',NULL),
('Paciente B','C. Pac B 2','555-0302','03001','SSN-P-0002',2,'2024-02-05','2024-02-10',NULL,'2024-02-18',NULL),
('Paciente C','C. Pac C 3','555-0303','03002','SSN-P-0003',3,'2024-03-01',NULL,'2024-03-20','2024-03-25',NULL),
('Paciente D','C. Pac D 4','555-0304','03003','SSN-P-0004',4,'2024-04-02','2024-04-05','2024-06-10','2024-06-20',NULL),
('Paciente E','C. Pac E 5','555-0305','03004','SSN-P-0005',5,'2024-05-05','2024-05-10',NULL,'2024-05-30',NULL),
('Paciente F','C. Pac F 6','555-0306','03005','SSN-P-0006',6,'2024-06-08','2024-06-09','2025-02-15','2025-02-22',NULL),
('Paciente G','C. Pac G 7','555-0307','03006','SSN-P-0007',7,'2024-07-10','2024-07-12','2025-03-05','2025-03-10',NULL),
('Paciente H','C. Pac H 8','555-0308','03007','SSN-P-0008',8,'2024-08-01',NULL,'2025-02-20','2025-03-01',NULL),
('Paciente I','C. Pac I 9','555-0309','03008','SSN-P-0009',9,'2024-09-11','2024-09-20','2025-02-28','2025-03-07',NULL),
('Paciente J','C. Pac J 10','555-0310','03009','SSN-P-0010',10,'2024-10-05','2024-10-10',NULL,'2024-10-20',NULL),
('Paciente K','C. Pac K 11','555-0311','03010','SSN-P-0011',11,'2024-11-01','2024-11-03','2024-12-10','2024-12-20',NULL),
('Paciente L','C. Pac L 12','555-0312','03011','SSN-P-0012',12,'2024-12-12',NULL,NULL,'2025-01-10',NULL),
('Paciente M','C. Pac M 13','555-0313','03012','SSN-P-0013',13,'2025-01-15','2025-01-20','2025-02-25','2025-03-05',NULL),
('Paciente N','C. Pac N 14','555-0314','03013','SSN-P-0014',14,'2025-01-20',NULL,NULL,NULL,NULL),
('Paciente O','C. Pac O 15','555-0315','03014','SSN-P-0015',15,'2024-02-17','2024-02-19','2024-04-10','2024-04-20',NULL),
('Paciente P','C. Pac P 16','555-0316','03015','SSN-P-0016',16,'2024-03-21','2024-03-25',NULL,'2024-04-05',NULL),
('Paciente Q','C. Pac Q 17','555-0317','03016','SSN-P-0017',17,'2024-04-25','2024-04-27','2024-05-10','2024-05-20',NULL),
('Paciente R','C. Pac R 18','555-0318','03017','SSN-P-0018',18,'2024-05-30','2024-06-02','2024-07-12','2024-07-20',NULL),
('Paciente S','C. Pac S 19','555-0319','03018','SSN-P-0019',19,'2024-06-05',NULL,NULL,NULL,NULL),
('Paciente T','C. Pac T 20','555-0320','03019','SSN-P-0020',20,'2024-07-15','2024-07-20','2024-08-20','2024-08-30',NULL),
('Paciente U','C. Pac U 21','555-0321','03020','SSN-P-0021',21,'2024-08-18',NULL,NULL,NULL,NULL),
('Paciente V','C. Pac V 22','555-0322','03021','SSN-P-0022',22,'2024-09-22','2024-09-25','2025-02-18','2025-02-28',NULL),
('Paciente W','C. Pac W 23','555-0323','03022','SSN-P-0023',23,'2024-10-11',NULL,NULL,NULL,NULL),
('Paciente X','C. Pac X 24','555-0324','03023','SSN-P-0024',24,'2024-11-02','2024-11-05','2024-12-01','2024-12-10',NULL),
('Paciente Y','C. Pac Y 25','555-0325','03024','SSN-P-0025',25,'2024-12-15','2025-01-05','2025-02-20','2025-03-01',NULL),
('Paciente Z','C. Pac Z 26','555-0326','03025','SSN-P-0026',26,'2025-01-02',NULL,NULL,NULL,NULL),
('Paciente AA','C. Pac AA 27','555-0327','03026','SSN-P-0027',27,'2025-01-06',NULL,'2025-03-02','2025-03-10',NULL),
('Paciente AB','C. Pac AB 28','555-0328','03027','SSN-P-0028',28,'2025-01-08','2025-01-10',NULL,NULL,NULL),
('Paciente AC','C. Pac AC 29','555-0329','03028','SSN-P-0029',29,'2025-01-10',NULL,NULL,NULL,NULL),
('Paciente AD','C. Pac AD 30','555-0330','03029','SSN-P-0030',30,'2024-02-01','2024-02-05','2024-02-25','2024-03-05',NULL);
SELECT * FROM patients;

INSERT INTO vacations (person_type, person_id, start_date, end_date, days) VALUES
-- doctor 1
('doctor',1,'2024-01-01','2024-01-05',5),
('doctor',1,'2024-04-15','2024-04-25',11),
('doctor',1,'2025-02-10','2025-02-15',6),

-- doctor 2
('doctor',2,'2024-02-01','2024-02-12',12),
('doctor',2,'2024-06-01','2024-06-04',4),
('doctor',2,'2025-03-05','2025-03-12',8),

-- doctor 3
('doctor',3,'2024-03-01','2024-03-10',10),
('doctor',3,'2024-04-01','2024-04-03',3),
('doctor',3,'2025-02-14','2025-02-18',5),

-- doctor 4
('doctor',4,'2024-05-10','2024-05-20',11),
('doctor',4,'2024-10-01','2024-10-04',4),
('doctor',4,'2025-02-01','2025-02-10',10),

-- doctor 5
('doctor',5,'2024-01-15','2024-01-25',11),
('doctor',5,'2024-03-01','2024-03-05',5),
('doctor',5,'2025-03-10','2025-03-15',6),

-- doctor 6
('doctor',6,'2024-02-10','2024-02-20',11),
('doctor',6,'2024-07-01','2024-07-05',5),
('doctor',6,'2025-02-14','2025-02-20',7),

-- doctor 7
('doctor',7,'2024-04-05','2024-04-12',8),
('doctor',7,'2024-09-01','2024-09-05',5),
('doctor',7,'2025-02-18','2025-02-22',5),

-- doctor 8
('doctor',8,'2024-06-10','2024-06-20',11),
('doctor',8,'2024-11-01','2024-11-03',3),
('doctor',8,'2025-02-18','2025-02-24',7),

-- doctor 9
('doctor',9,'2024-01-20','2024-01-30',11),
('doctor',9,'2024-05-01','2024-05-03',3),
('doctor',9,'2025-03-01','2025-03-05',5),

-- doctor 10
('doctor',10,'2024-03-15','2024-03-25',11),
('doctor',10,'2024-12-01','2024-12-04',4),
('doctor',10,'2025-02-05','2025-02-12',8),

-- doctor 11
('doctor',11,'2024-02-12','2024-02-18',7),
('doctor',11,'2024-06-15','2024-06-20',6),
('doctor',11,'2025-03-12','2025-03-18',7),

-- doctor 12
('doctor',12,'2024-04-20','2024-04-25',6),
('doctor',12,'2024-07-10','2024-07-15',6),
('doctor',12,'2025-02-20','2025-02-28',9),

-- doctor 13
('doctor',13,'2024-02-01','2024-02-05',5),
('doctor',13,'2024-05-05','2024-05-08',4),
('doctor',13,'2025-03-01','2025-03-10',10),

-- doctor 14
('doctor',14,'2024-01-05','2024-01-12',8),
('doctor',14,'2024-08-01','2024-08-05',5),
('doctor',14,'2025-02-10','2025-02-14',5),

-- doctor 15
('doctor',15,'2024-02-20','2024-02-28',9),
('doctor',15,'2024-06-01','2024-06-05',5),
('doctor',15,'2025-03-05','2025-03-10',6),

-- doctor 16
('doctor',16,'2024-03-10','2024-03-20',11),
('doctor',16,'2024-09-10','2024-09-12',3),
('doctor',16,'2025-02-15','2025-02-20',6),

-- doctor 17
('doctor',17,'2024-04-01','2024-04-10',10),
('doctor',17,'2024-05-20','2024-05-22',3),
('doctor',17,'2025-03-10','2025-03-15',6),

-- doctor 18
('doctor',18,'2024-07-05','2024-07-15',11),
('doctor',18,'2024-12-10','2024-12-14',5),
('doctor',18,'2025-02-01','2025-02-06',6),

-- doctor 19
('doctor',19,'2024-01-10','2024-01-20',11),
('doctor',19,'2024-04-10','2024-04-12',3),
('doctor',19,'2025-03-01','2025-03-06',6),

-- doctor 20
('doctor',20,'2024-06-01','2024-06-10',10),
('doctor',20,'2024-08-15','2024-08-18',4),
('doctor',20,'2025-02-25','2025-03-03',7),

-- doctor 21
('doctor',21,'2024-03-01','2024-03-05',5),
('doctor',21,'2024-05-01','2024-05-05',5),
('doctor',21,'2025-02-10','2025-02-18',9),

-- doctor 22
('doctor',22,'2024-02-05','2024-02-14',10),
('doctor',22,'2024-09-01','2024-09-04',4),
('doctor',22,'2025-03-01','2025-03-06',6),

-- doctor 23
('doctor',23,'2024-01-15','2024-01-25',11),
('doctor',23,'2024-04-01','2024-04-03',3),
('doctor',23,'2025-02-05','2025-02-10',6),

-- doctor 24
('doctor',24,'2024-05-10','2024-05-20',11),
('doctor',24,'2024-11-10','2024-11-12',3),
('doctor',24,'2025-02-15','2025-02-22',8),

-- doctor 25
('doctor',25,'2024-01-01','2024-01-10',10),
('doctor',25,'2024-03-01','2024-03-03',3),
('doctor',25,'2025-03-05','2025-03-09',5),

-- doctor 26
('doctor',26,'2024-02-12','2024-02-22',11),
('doctor',26,'2024-06-01','2024-06-03',3),
('doctor',26,'2025-02-10','2025-02-16',7),

-- doctor 27
('doctor',27,'2024-03-15','2024-03-25',11),
('doctor',27,'2024-07-01','2024-07-03',3),
('doctor',27,'2025-02-18','2025-02-22',5),

-- doctor 28
('doctor',28,'2024-04-20','2024-04-30',11),
('doctor',28,'2024-12-20','2024-12-24',5),
('doctor',28,'2025-02-05','2025-02-10',6),

-- doctor 29
('doctor',29,'2024-01-20','2024-01-30',11),
('doctor',29,'2024-08-01','2024-08-05',5),
('doctor',29,'2025-03-01','2025-03-08',8),

-- doctor 30
('doctor',30,'2024-02-01','2024-02-12',12),
('doctor',30,'2024-05-10','2024-05-12',3),
('doctor',30,'2025-02-14','2025-02-18',5);

SELECT * FROM vacations;
INSERT INTO vacations (person_type, person_id, start_date, end_date, days) VALUES
('employee',1,'2024-01-10','2024-01-20',11),
('employee',1,'2024-06-01','2024-06-05',5),
('employee',1,'2025-02-10','2025-02-15',6),

('employee',2,'2024-02-05','2024-02-16',12),
('employee',2,'2024-07-01','2024-07-05',5),
('employee',2,'2025-03-01','2025-03-06',6),

('employee',3,'2024-03-01','2024-03-10',10),
('employee',3,'2024-04-01','2024-04-03',3),
('employee',3,'2025-02-01','2025-02-05',5),

('employee',4,'2024-05-10','2024-05-20',11),
('employee',4,'2024-08-01','2024-08-04',4),
('employee',4,'2025-02-20','2025-02-25',6),

('employee',5,'2024-01-02','2024-01-12',11),
('employee',5,'2024-03-05','2024-03-08',4),
('employee',5,'2025-03-10','2025-03-14',5),

('employee',6,'2024-02-10','2024-02-18',9),
('employee',6,'2024-09-01','2024-09-05',5),
('employee',6,'2025-02-12','2025-02-18',7),

('employee',7,'2024-04-05','2024-04-12',8),
('employee',7,'2024-06-01','2024-06-05',5),
('employee',7,'2025-02-14','2025-02-20',7),

('employee',8,'2024-06-10','2024-06-20',11),
('employee',8,'2024-11-05','2024-11-08',4),
('employee',8,'2025-02-18','2025-02-24',7),

('employee',9,'2024-01-20','2024-01-29',10),
('employee',9,'2024-05-01','2024-05-03',3),
('employee',9,'2025-03-01','2025-03-05',5),

('employee',10,'2024-03-15','2024-03-25',11),
('employee',10,'2024-12-01','2024-12-04',4),
('employee',10,'2025-02-05','2025-02-12',8),

('employee',11,'2024-02-12','2024-02-18',7),
('employee',11,'2024-06-15','2024-06-20',6),
('employee',11,'2025-03-12','2025-03-18',7),

('employee',12,'2024-04-20','2024-04-25',6),
('employee',12,'2024-07-10','2024-07-15',6),
('employee',12,'2025-02-20','2025-02-28',9),

('employee',13,'2024-02-01','2024-02-05',5),
('employee',13,'2024-05-05','2024-05-08',4),
('employee',13,'2025-03-01','2025-03-10',10),

('employee',14,'2024-01-05','2024-01-12',8),
('employee',14,'2024-08-01','2024-08-05',5),
('employee',14,'2025-02-10','2025-02-14',5),

('employee',15,'2024-02-20','2024-02-28',9),
('employee',15,'2024-06-01','2024-06-05',5),
('employee',15,'2025-03-05','2025-03-10',6),

('employee',16,'2024-03-10','2024-03-20',11),
('employee',16,'2024-09-10','2024-09-12',3),
('employee',16,'2025-02-15','2025-02-20',6),

('employee',17,'2024-04-01','2024-04-10',10),
('employee',17,'2024-05-20','2024-05-22',3),
('employee',17,'2025-03-10','2025-03-15',6),

('employee',18,'2024-07-05','2024-07-15',11),
('employee',18,'2024-12-10','2024-12-14',5),
('employee',18,'2025-02-01','2025-02-06',6),

('employee',19,'2024-01-10','2024-01-20',11),
('employee',19,'2024-04-10','2024-04-12',3),
('employee',19,'2025-03-01','2025-03-06',6),

('employee',20,'2024-06-01','2024-06-10',10),
('employee',20,'2024-08-15','2024-08-18',4),
('employee',20,'2025-02-25','2025-03-03',7),

('employee',21,'2024-03-01','2024-03-05',5),
('employee',21,'2024-05-01','2024-05-05',5),
('employee',21,'2025-02-10','2025-02-18',9),

('employee',22,'2024-02-05','2024-02-14',10),
('employee',22,'2024-09-01','2024-09-04',4),
('employee',22,'2025-03-01','2025-03-06',6),

('employee',23,'2024-01-15','2024-01-25',11),
('employee',23,'2024-04-01','2024-04-03',3),
('employee',23,'2025-02-05','2025-02-10',6),

('employee',24,'2024-05-10','2024-05-20',11),
('employee',24,'2024-11-10','2024-11-12',3),
('employee',24,'2025-02-15','2025-02-22',8),

('employee',25,'2024-01-01','2024-01-10',10),
('employee',25,'2024-03-01','2024-03-03',3),
('employee',25,'2025-03-05','2025-03-09',5),

('employee',26,'2024-02-12','2024-02-22',11),
('employee',26,'2024-06-01','2024-06-03',3),
('employee',26,'2025-02-10','2025-02-16',7),

('employee',27,'2024-03-15','2024-03-25',11),
('employee',27,'2024-07-01','2024-07-03',3),
('employee',27,'2025-02-18','2025-02-22',5),

('employee',28,'2024-04-20','2024-04-30',11),
('employee',28,'2024-12-20','2024-12-24',5),
('employee',28,'2025-02-05','2025-02-10',6),

('employee',29,'2024-01-20','2024-01-30',11),
('employee',29,'2024-08-01','2024-08-05',5),
('employee',29,'2025-03-01','2025-03-08',8),

('employee',30,'2024-02-01','2024-02-12',12),
('employee',30,'2024-05-10','2024-05-12',3),
('employee',30,'2025-02-14','2025-02-18',5);

SELECT * FROM vacations;
INSERT INTO doctor_substitutions (doctor_id, fecha_alta, fecha_baja) VALUES
(3,'2023-01-01','2023-03-01'),
(3,'2024-02-01','2024-03-01'),
(3,'2025-01-15',NULL); 

-- doctor 6
INSERT INTO doctor_substitutions (doctor_id, fecha_alta, fecha_baja) VALUES
(6,'2022-06-01','2022-09-01'),
(6,'2024-05-01','2024-06-01'),
(6,'2025-01-10',NULL);

-- doctor 9
INSERT INTO doctor_substitutions (doctor_id, fecha_alta, fecha_baja) VALUES
(9,'2024-01-01','2024-02-01'),
(9,'2024-09-01','2024-10-01');

-- doctor 12
INSERT INTO doctor_substitutions (doctor_id, fecha_alta, fecha_baja) VALUES
(12,'2023-07-01','2023-08-15'),
(12,'2024-11-01',NULL);

-- doctor 15
INSERT INTO doctor_substitutions (doctor_id, fecha_alta, fecha_baja) VALUES
(15,'2024-01-05','2024-02-05'),
(15,'2024-07-01','2024-08-01');

-- doctor 18
INSERT INTO doctor_substitutions (doctor_id, fecha_alta, fecha_baja) VALUES
(18,'2024-03-01','2024-04-01'),
(18,'2024-11-15',NULL);

-- doctor 21
INSERT INTO doctor_substitutions (doctor_id, fecha_alta, fecha_baja) VALUES
(21,'2024-02-01','2024-03-01'),
(21,'2025-01-01',NULL);

-- doctor 24
INSERT INTO doctor_substitutions (doctor_id, fecha_alta, fecha_baja) VALUES
(24,'2024-05-01','2024-06-01'),
(24,'2025-02-01','2025-03-01');

-- doctor 27
INSERT INTO doctor_substitutions (doctor_id, fecha_alta, fecha_baja) VALUES
(27,'2023-08-01','2023-09-01'),
(27,'2024-06-01',NULL);

-- doctor 30
INSERT INTO doctor_substitutions (doctor_id, fecha_alta, fecha_baja) VALUES
(30,'2024-01-01','2024-02-01'),
(30,'2025-01-10',NULL);

SELECT * FROM doctor_substitutions;
-- Consulta 1:
-- Muestra el nombre de aquellos médicos que han tomado vacaciones en el año 2024
-- hasta antes del mes de julio (i.e. hasta 2024-06-30). Orden alfabético.
SELECT DISTINCT d.full_name, v.start_date, v.end_date
FROM doctors d
JOIN vacations v ON v.person_type='doctor' AND v.person_id = d.doctor_id
WHERE v.start_date >= '2024-01-01' AND v.end_date <= '2024-06-30'
ORDER BY d.full_name;

-- Consulta 2:
-- A partir de Consulta 1, filtrar solo "interinos" y "sustitutos" que han tomado tres periodos vacacionales.
-- (Contar los periodos vacacionales registrados en 2024 para cada doctor y filtrar =3)
SELECT d.doctor_id, d.full_name, d.tipo_medico, COUNT(v.vacation_id) AS num_periodos_2024
FROM doctors d
JOIN vacations v ON v.person_type='doctor' AND v.person_id = d.doctor_id
WHERE d.tipo_medico IN ('interino','sustituto')
  AND YEAR(v.start_date) = 2024
GROUP BY d.doctor_id, d.full_name, d.tipo_medico
HAVING COUNT(v.vacation_id) = 3
ORDER BY d.full_name;

-- Consulta 3:
-- Agrupar a los médicos (de la consulta 2) que han tenido tres periodos vacacionales
-- con al menos uno de ellos con menos de tres días.
SELECT t.doctor_id, t.full_name, t.tipo_medico
FROM (
    SELECT d.doctor_id, d.full_name, d.tipo_medico,
           COUNT(v.vacation_id) AS total_periodos_2024,
           SUM(CASE WHEN v.days < 3 THEN 1 ELSE 0 END) AS periodos_menos_3_dias
    FROM doctors d
    JOIN vacations v ON v.person_type='doctor' AND v.person_id = d.doctor_id
    WHERE d.tipo_medico IN ('interino','sustituto') AND YEAR(v.start_date) = 2024
    GROUP BY d.doctor_id, d.full_name, d.tipo_medico
) AS t
WHERE t.total_periodos_2024 = 3 AND t.periodos_menos_3_dias >= 1
ORDER BY t.full_name;

-- Consulta 4:
-- De la consulta 3, seleccionar médicos sustitutos que han tenido su periodo vacacional
-- en los meses de febrero, abril y junio.
-- Esto interpretado como: han tenido periodos en esos 3 meses (puede que sean 3 periodos, cada uno en cada mes).
SELECT DISTINCT d.doctor_id, d.full_name
FROM doctors d
JOIN vacations v ON v.person_type='doctor' AND v.person_id = d.doctor_id
WHERE d.tipo_medico = 'sustituto'
  AND YEAR(v.start_date) = 2024
  AND MONTH(v.start_date) IN (2,4,6)
GROUP BY d.doctor_id, d.full_name
HAVING COUNT(DISTINCT MONTH(v.start_date)) = 3
ORDER BY d.full_name;

-- Consulta 5:
-- Médicos que tendrán algún periodo vacacional programado para los meses febrero y marzo de 2025
-- y relaciona las fechas de las intervenciones de cada paciente registrado con esas fechas.
-- Obtener: nombre del médico, periodo vacacional (start/end) y nombre del paciente intervenido en dichas fechas.
SELECT DISTINCT d.full_name AS medico,
       v.start_date AS vac_start, v.end_date AS vac_end,
       p.full_name AS paciente, p.fecha_intervencion
FROM doctors d
JOIN vacations v ON v.person_type='doctor' AND v.person_id = d.doctor_id
JOIN patients p ON p.doctor_id = d.doctor_id
WHERE (YEAR(v.start_date)=2025 AND MONTH(v.start_date) IN (2,3))
  AND p.fecha_intervencion IS NOT NULL
  -- comprobar si la fecha de intervención cae dentro del periodo vacacional
  AND p.fecha_intervencion BETWEEN v.start_date AND v.end_date
ORDER BY d.full_name, v.start_date, p.fecha_intervencion;

-- Consulta 6:
-- Con base en la consulta 5, ordena por fecha y presenta los nombres de los médicos sustitutos
-- que estarán en periodo vacacional para dichas fechas de intervención por cada paciente.
SELECT d.full_name AS medico, v.start_date AS vac_start, v.end_date AS vac_end,
       p.full_name AS paciente, p.fecha_intervencion
FROM doctors d
JOIN vacations v ON v.person_type='doctor' AND v.person_id = d.doctor_id
JOIN patients p ON p.doctor_id = d.doctor_id
WHERE d.tipo_medico = 'sustituto'
  AND (YEAR(v.start_date)=2025 AND MONTH(v.start_date) IN (2,3))
  AND p.fecha_intervencion IS NOT NULL
  AND p.fecha_intervencion BETWEEN v.start_date AND v.end_date
ORDER BY p.fecha_intervencion, d.full_name;

-- Consulta 7:
-- Determina cuáles son los médicos interinos que estarán en periodo vacacional, tomando en cuenta
-- la fecha de análisis clínicos de cada paciente (i.e., si la fecha_analisis cae dentro del periodo vacacional).
SELECT DISTINCT d.full_name AS medico, v.start_date, v.end_date, p.full_name AS paciente, p.fecha_analisis
FROM doctors d
JOIN vacations v ON v.person_type='doctor' AND v.person_id = d.doctor_id
JOIN patients p ON p.doctor_id = d.doctor_id
WHERE d.tipo_medico = 'interino'
  AND p.fecha_analisis IS NOT NULL
  AND p.fecha_analisis BETWEEN v.start_date AND v.end_date
ORDER BY d.full_name, p.fecha_analisis;

UPDATE patients SET historial_clinico =
CONCAT(
 'Historia 1: Consulta inicial (motivo: dolor). Fecha: 2024-01-10. Observaciones: control.\n',
 'Historia 2: Exámenes de laboratorio realizados. Fecha: 2024-01-12. Observaciones: OK.\n',
 'Historia 3: Tratamiento administrado. Fecha: 2024-01-20. Observaciones: seguimiento.\n',
 'Historia 4: Revisión. Fecha: 2024-02-05. Observaciones: mejoría.\n',
 'Historia 5: Alta médica. Fecha: 2024-02-20. Observaciones: paciente estable.\n'
) WHERE patient_id = 1;

SELECT * FROM patients;
UPDATE patients SET historial_clinico =
CONCAT(
 'Historia 1: Ingreso por trauma. Fecha: 2024-02-05. Observaciones: ingresa estable.\n',
 'Historia 2: Imagenología. Fecha: 2024-02-06. Observaciones: lesión leve.\n',
 'Historia 3: Procedimiento menor. Fecha: 2024-02-08. Observaciones: sin complicaciones.\n',
 'Historia 4: Rehabilitación. Fecha: 2024-02-20. Observaciones: en proceso.\n',
 'Historia 5: Alta parcial. Fecha: 2024-03-01. Observaciones: seguimiento ambulatorio.\n'
) WHERE patient_id = 2;
SELECT * FROM patients;

UPDATE patients SET historial_clinico =
CONCAT(
 'Historia 1: Síntomas respiratorios. Fecha: 2024-03-01. Observaciones: tratamiento iniciado.\n',
 'Historia 2: Pruebas diagnósticas. Fecha: 2024-03-03. Observaciones: seguimiento.\n',
 'Historia 3: Ajuste de medicación. Fecha: 2024-03-10. Observaciones: mejoría.\n',
 'Historia 4: Control. Fecha: 2024-03-20. Observaciones: estable.\n',
 'Historia 5: Alta. Fecha: 2024-03-25. Observaciones: OK.\n'
) WHERE patient_id = 3;

UPDATE patients SET historial_clinico =
CONCAT(
 'Historia 1: Dolor abdominal. Fecha: 2024-04-02. Observaciones: estudios solicitados.\n',
 'Historia 2: Laboratorio. Fecha: 2024-04-03. Observaciones: operación programada.\n',
 'Historia 3: Intervención. Fecha: 2024-06-10. Observaciones: sin complicaciones.\n',
 'Historia 4: Postoperatorio. Fecha: 2024-06-15. Observaciones: buena evolución.\n',
 'Historia 5: Alta. Fecha: 2024-06-20. Observaciones: seguimiento ambulatorio.\n'
) WHERE patient_id = 4;

UPDATE patients SET historial_clinico =
CONCAT(
 'Historia 1: Control prenatal. Fecha: 2024-05-05. Observaciones: control normal.\n',
 'Historia 2: Pruebas. Fecha: 2024-05-10. Observaciones: sin hallazgos.\n',
 'Historia 3: Visita. Fecha: 2024-05-25. Observaciones: saludable.\n',
 'Historia 4: Consulta extra. Fecha: 2024-06-05. Observaciones: seguimiento.\n',
 'Historia 5: Alta. Fecha: 2024-06-30. Observaciones: OK.\n'
) WHERE patient_id = 5;

SELECT * FROM patients;
SELECT full_name AS paciente, historial_clinico
FROM patients
WHERE patient_id IN (1,2,3,4,5)
ORDER BY full_name;
