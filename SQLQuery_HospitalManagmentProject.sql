CREATE DATABASE HOSPITAL
use HOSPITAL

CREATE TABLE Patient (

    Patient_id INT PRIMARY KEY IDENTITY(1,1),

    F_name VARCHAR(30) NOT NULL,

    L_name VARCHAR(30) NOT NULL,

    Email VARCHAR(50) UNIQUE,

    Address VARCHAR(100),

    DOB DATE,

    Gender VARCHAR(10),

    Blood_group VARCHAR(5)

);
CREATE TABLE Patient_Phone (

    Patient_id INT,

    Phone_num VARCHAR(20) ,

    PRIMARY KEY (Patient_id, Phone_num),

    FOREIGN KEY (Patient_id)
    REFERENCES Patient(Patient_id)

);
CREATE TABLE Department (

    Dept_id INT PRIMARY KEY IDENTITY(1,1),

    Dept_name VARCHAR(50) NOT NULL ,

    Location VARCHAR(50) NOT NULL,

    No_of_doctor INT CHECK (No_of_doctor >= 0),

    Contact VARCHAR(30),

    Head_doc_id INT

);
CREATE TABLE Doctor (

    Doctor_id INT PRIMARY KEY IDENTITY(1,1),

    Name VARCHAR(50),

    Specialization VARCHAR(50) NOT NULL ,

    Email VARCHAR(50) UNIQUE,

    Lisence_no VARCHAR(30) UNIQUE,

    Qualification VARCHAR(50) NOT NULL ,

    Year_exp INT CHECK (Year_exp >= 0),

    Dept_id INT,

    FOREIGN KEY (Dept_id)
    REFERENCES Department(Dept_id)

);
ALTER TABLE Department

ADD FOREIGN KEY (Head_doc_id)

REFERENCES Doctor(Doctor_id);

CREATE TABLE Doctor_Phone (

    Doctor_id INT,

    Phone_num VARCHAR(20),

    PRIMARY KEY (Doctor_id, Phone_num),

    FOREIGN KEY (Doctor_id)
    REFERENCES Doctor(Doctor_id)

);
CREATE TABLE Appointment (

    App_id INT PRIMARY KEY IDENTITY(1,1),

    Date DATE,

    Time TIME,

    Status VARCHAR(20) NOT NULL,

    App_type VARCHAR(30) NOT NULL,

    Reason VARCHAR(100),

    Patient_id INT,

    Doctor_id INT,

    FOREIGN KEY (Patient_id)
    REFERENCES Patient(Patient_id),

    FOREIGN KEY (Doctor_id)
    REFERENCES Doctor(Doctor_id)

);
CREATE TABLE Services (

    Service_id INT PRIMARY KEY IDENTITY(1,1),

    Service_name VARCHAR(50) NOT NULL,

    Service_type VARCHAR(50) NOT NULL ,

    Unit_price DECIMAL(10,2) CHECK (Unit_price >= 0),

    Descrip VARCHAR(100),

    Dept_id INT,

    FOREIGN KEY (Dept_id)
    REFERENCES Department(Dept_id)

);
CREATE TABLE Appointment_Services (

    App_id INT,

    Service_id INT,

    Quantity INT CHECK (Quantity > 0),

    PRIMARY KEY (App_id, Service_id),

    FOREIGN KEY (App_id)
    REFERENCES Appointment(App_id),

    FOREIGN KEY (Service_id)
    REFERENCES Services(Service_id)

);
CREATE TABLE Medical_Record (

    Record_id INT PRIMARY KEY IDENTITY(1,1),

    Visit_date DATE,

    Diagnosis VARCHAR(100),

    Treatment VARCHAR(100) NOT NULL,

    Prescribed_medication VARCHAR(100) NOT NULL,

    Doctor_note VARCHAR(100),

    Follow_up VARCHAR(50),

    Patient_id INT,

    Doctor_id INT,

    App_id INT,

    FOREIGN KEY (Patient_id)
    REFERENCES Patient(Patient_id),

    FOREIGN KEY (Doctor_id)
    REFERENCES Doctor(Doctor_id),

    FOREIGN KEY (App_id)
    REFERENCES Appointment(App_id)

);
CREATE TABLE Billing (

    Bill_id INT PRIMARY KEY IDENTITY(1,1),

    Bill_date DATE,

    Total_amount DECIMAL(10,2) CHECK (Total_amount > 0),

    Payment_status VARCHAR(20) NOT NULL,

    Payment_method VARCHAR(20) NOT NULL,

    Due_date DATE,

    Patient_id INT,

    App_id INT,

    FOREIGN KEY (Patient_id)
    REFERENCES Patient(Patient_id),

    FOREIGN KEY (App_id)
    REFERENCES Appointment(App_id)

);