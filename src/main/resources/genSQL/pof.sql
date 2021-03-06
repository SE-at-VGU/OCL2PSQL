DROP DATABASE IF EXISTS unipof;
CREATE DATABASE unipof 
 DEFAULT CHARACTER SET utf8 
 DEFAULT COLLATE utf8_general_ci;
USE unipof;
CREATE TABLE Account (Account_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, password VARCHAR (100) NOT NULL, username VARCHAR (100) UNIQUE NOT NULL);
CREATE TABLE Program (Program_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, doe DATE NOT NULL, name VARCHAR (100) UNIQUE NOT NULL, code VARCHAR (100) UNIQUE NOT NULL);
CREATE TABLE Period (Period_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, starts DATE NOT NULL, ends DATE NOT NULL, name VARCHAR (100) );
CREATE TABLE Lecturer (Lecturer_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, midname VARCHAR (100) , lastname VARCHAR (100) NOT NULL, firstname VARCHAR (100) NOT NULL);
CREATE TABLE Student (Student_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, code VARCHAR (100) NOT NULL UNIQUE, lastname VARCHAR (100) NOT NULL, birthplace VARCHAR (100) NOT NULL, dob DATE NOT NULL, firstname VARCHAR (100) NOT NULL, midname VARCHAR (100) , gender VARCHAR (100) NOT NULL);
CREATE TABLE Role (Role_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, role VARCHAR (100) UNIQUE NOT NULL);
CREATE TABLE Module_Period (Module_Period_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR (100) UNIQUE NOT NULL, starts DATE NOT NULL, ends DATE NOT NULL);
CREATE TABLE Module_Group (Module_Group_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, code VARCHAR (100) UNIQUE NOT NULL, group_name VARCHAR (100) NOT NULL);
CREATE TABLE University (University_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, doe DATE , name VARCHAR (100) NOT NULL UNIQUE);
CREATE TABLE Assistant (Assistant_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, email VARCHAR (100) NOT NULL UNIQUE, lastname VARCHAR (100) NOT NULL, firstname VARCHAR (100) NOT NULL, midname VARCHAR (100) );
CREATE TABLE Registration_Exam (Registration_Exam_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, datetime DATETIME NOT NULL, status VARCHAR (100) NOT NULL);
CREATE TABLE Enrollment (Enrollment_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, ends DATE , starts DATE NOT NULL);
CREATE TABLE Record (Record_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, status VARCHAR (100) NOT NULL);
CREATE TABLE Module (Module_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, code VARCHAR (100) UNIQUE NOT NULL, name VARCHAR (100) NOT NULL);
CREATE TABLE Room (Room_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR (100) NOT NULL, capacity INT (11) NOT NULL, type VARCHAR (100) );
CREATE TABLE Exam (Exam_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, date DATE NOT NULL, deadline DATETIME NOT NULL, ends TIME NOT NULL, starts TIME NOT NULL);
CREATE TABLE Session (Session_id INT (11) NOT NULL AUTO_INCREMENT PRIMARY KEY, ends TIME NOT NULL, date DATE NOT NULL, starts TIME NOT NULL);
ALTER TABLE Module_Period ADD COLUMN period INT (11), ADD FOREIGN KEY (period) REFERENCES Period (Period_id);
ALTER TABLE Registration_Exam ADD COLUMN exam INT (11), ADD FOREIGN KEY (exam) REFERENCES Exam (Exam_id);
ALTER TABLE Module_Period ADD COLUMN lecturer INT (11), ADD FOREIGN KEY (lecturer) REFERENCES Lecturer (Lecturer_id);
ALTER TABLE Module_Period ADD COLUMN module INT (11), ADD FOREIGN KEY (module) REFERENCES Module (Module_id);
ALTER TABLE Module ADD COLUMN module_group INT (11), ADD FOREIGN KEY (module_group) REFERENCES Module_Group (Module_Group_id);
ALTER TABLE Record ADD COLUMN module_period INT (11), ADD FOREIGN KEY (module_period) REFERENCES Module_Period (Module_Period_id);
ALTER TABLE Record ADD COLUMN student INT (11), ADD FOREIGN KEY (student) REFERENCES Student (Student_id);
CREATE TABLE Module_modules_prerequisites_Module (modules INT (11), prerequisites INT (11));
ALTER TABLE Module_modules_prerequisites_Module ADD FOREIGN KEY (modules) REFERENCES Module (Module_id), ADD FOREIGN KEY (prerequisites) REFERENCES Module (Module_id);
ALTER TABLE Enrollment ADD COLUMN program INT (11), ADD FOREIGN KEY (program) REFERENCES Program (Program_id);
CREATE TABLE Exam_exams_rooms_Room (exams INT (11), rooms INT (11));
ALTER TABLE Exam_exams_rooms_Room ADD FOREIGN KEY (exams) REFERENCES Exam (Exam_id), ADD FOREIGN KEY (rooms) REFERENCES Room (Room_id);
ALTER TABLE Assistant ADD COLUMN account INT (11), ADD FOREIGN KEY (account) REFERENCES Account (Account_id);
ALTER TABLE Account ADD COLUMN assistant INT (11), ADD FOREIGN KEY (assistant) REFERENCES Assistant (Assistant_id);
ALTER TABLE Enrollment ADD COLUMN student INT (11), ADD FOREIGN KEY (student) REFERENCES Student (Student_id);
ALTER TABLE Registration_Exam ADD COLUMN record INT (11), ADD FOREIGN KEY (record) REFERENCES Record (Record_id);
ALTER TABLE Session ADD COLUMN room INT (11), ADD FOREIGN KEY (room) REFERENCES Room (Room_id);
ALTER TABLE Student ADD COLUMN account INT (11), ADD FOREIGN KEY (account) REFERENCES Account (Account_id);
ALTER TABLE Account ADD COLUMN student INT (11), ADD FOREIGN KEY (student) REFERENCES Student (Student_id);
ALTER TABLE Session ADD COLUMN module_period INT (11), ADD FOREIGN KEY (module_period) REFERENCES Module_Period (Module_Period_id);
ALTER TABLE Exam ADD COLUMN module_period INT (11), ADD FOREIGN KEY (module_period) REFERENCES Module_Period (Module_Period_id);
ALTER TABLE Module ADD COLUMN program INT (11), ADD FOREIGN KEY (program) REFERENCES Program (Program_id);
ALTER TABLE Lecturer ADD COLUMN account INT (11), ADD FOREIGN KEY (account) REFERENCES Account (Account_id);
ALTER TABLE Account ADD COLUMN lecturer INT (11), ADD FOREIGN KEY (lecturer) REFERENCES Lecturer (Lecturer_id);
CREATE TABLE Record_records_sessions_Session (records INT (11), sessions INT (11));
ALTER TABLE Record_records_sessions_Session ADD FOREIGN KEY (records) REFERENCES Record (Record_id), ADD FOREIGN KEY (sessions) REFERENCES Session (Session_id);
ALTER TABLE Account ADD COLUMN role INT (11), ADD FOREIGN KEY (role) REFERENCES Role (Role_id);
ALTER TABLE Program ADD COLUMN university INT (11), ADD FOREIGN KEY (university) REFERENCES University (University_id);
