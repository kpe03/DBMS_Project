-- Kaitlyn Peters
-- DBMS Project 2024
-- TASK 4 -- creete the tables

-- insert statements
-- --for query 15 testing
-- INSERT INTO Clients
-- VALUES('1', 'Client1', 'Female', 'Doctor', 'Y', '1', '1', '1', '2022-01-01', 'Doctor1', '1');
-- INSERT INTO Needs
-- VALUES('1', 'Transportation', '1');
-- INSERT INTO InsurancePolicy
-- VALUES('1', '1', '1', 'NotHealth');
-- INSERT INTO Has
-- VALUES('1', '1');

-- INSERT INTO Volunteers
-- VALUES('2', 'Vol1', 'F', 'D', 'Y', '1011 St', '1' ,'1', '2022-01-01', '2022-02-02', 'a');

  
DROP TABLE Needs;
DROP TABLE Has;
DROP TABLE InsurancePolicy;
DROP TABLE EmergencyContact;

INSERT INTO Needs
VALUES('1', 'Transportation', 1),
('2', 'Other', 10),
('3', 'Transportation', 1),
('4', 'Health', 5),
('5', 'Transportation', 10);

INSERT INTO InsurancePolicy
VALUES
('2', 'a', 'a', 'Health'),
('3', 'a', 'a', 'NotHealth'),
('4', 'a', 'a', 'Health'),
('5', 'a', 'a', 'Health');

INSERT INTO Has
VALUES('1', '1'),
('2', '2'),
('3', '3'),
('4', '4'),
('5', '5');

-- CREATE TABLE Clients(
--     ssn VARCHAR(9) PRIMARY KEY,
--     pname VARCHAR(100),
--     gender VARCHAR(10),
--     profession VARCHAR(50),
--     on_mailing_list VARCHAR(1), --either yes or no
--     mailing_addr VARCHAR(100),
--     email_addr VARCHAR(100),
--     phone_num VARCHAR(50),
--     assignment_date DATE,
--     doctor_name VARCHAR(256),
--     doctor_phone_number VARCHAR(256),
-- );
INSERT INTO Clients
VALUES
('1', 'a', 'a', 'a', 'y', '111', '11@mail.com', '111-111', '2021-01-01', 'doctor' ,'111-111-111');

DELETE FROM Clients
WHERE ssn = '1';

INSERT INTO Donations
VALUES('13', '2022-01-01', 100, 'Type', 'C2');

INSERT INTO EmergencyContact --donor, vol, client, employee
--values for clients
VALUES
--values for volunteers
(NULL, '8', NULL, NULL, 'O', '111-777-3333', 'Brother'),
(NULL, '9', NULL, NULL, 'P', '111-000-1111', 'Sister'),
(NULL, '10', NULL, NULL, 'H', '777-222-3333', 'Mother'),
(NULL, '11', NULL, NULL, 'I', '111-000-1111', 'Father'),
(NULL, '12', NULL, NULL, 'J', '111-000-1111', 'Husband'),
--values for donors
('18', NULL, NULL, NULL, 'E', '111-333-1111', 'Brother'),
('19', NULL, NULL, NULL, 'G', '111-000-1111', 'Sister'),
('20', NULL, NULL, NULL, 'H', '122-222-1111', 'Mother'),
('21', NULL, NULL, NULL, 'I', '111-667-5555', 'Wife'),
('22', NULL, NULL, NULL, 'I', '111-667-5555', 'Wife'),
--values for employees
(NULL, NULL, NULL, '13', 'J', '111-111-5555', 'Brother'),
(NULL, NULL, NULL, '14', 'K', '222-000-1111', 'Father'),
(NULL, NULL, NULL, '15', 'L', '111-000-1111', 'Wife'),
(NULL, NULL, NULL, '16', 'M', '777-000-1111', 'Father'),
(NULL, NULL, NULL, '17', 'N', '111-777-5555', 'Mother'),
--clients
(NULL, NULL, '2', NULL, 'A', '111-000-1111', 'Wife'),
(NULL, NULL, '3', NULL, 'B', '222-111-0000', 'Mother'),
(NULL, NULL, '4', NULL, 'C', '222-222-1111', 'Sister'),
(NULL, NULL, '5', NULL, 'D', '111-000-2222', 'Father');


CREATE TABLE Volunteers(
    ssn VARCHAR(9) PRIMARY KEY,
    pname VARCHAR(100),
    gender VARCHAR(10),
    profession VARCHAR(50),
    on_mailing_list VARCHAR(1), --either yes or no
    mailing_addr VARCHAR(100),
    email_addr VARCHAR(100),
    phone_num VARCHAR(50), 
    date_joined DATE,    --make these a date object to store easier
    date_training DATE,  --make these a date object to store easier
    location_training VARCHAR(256),
);

CREATE TABLE Team(
    team_name VARCHAR(100) PRIMARY KEY,
    team_type VARCHAR(100),
    date_formed DATE,
);

CREATE TABLE Employees(
    ssn VARCHAR(9) PRIMARY KEY,
    pname VARCHAR(100),
    gender VARCHAR(10),
    profession VARCHAR(50),
    on_mailing_list VARCHAR(1), --either yes or no
    mailing_addr VARCHAR(100),
    email_addr VARCHAR(100),
    phone_num VARCHAR(50), --no dashes
    salary INTEGER,
    marital_status VARCHAR(50),
    hire_date DATE,
);

CREATE TABLE Expenses(
    ssn VARCHAR(9),
    expense_date DATE,
    expense_amount DECIMAL(10,2),
    expense_description VARCHAR(255),
    FOREIGN KEY(ssn) references Employees,
);

CREATE TABLE Clients(
    ssn VARCHAR(9) PRIMARY KEY,
    pname VARCHAR(100),
    gender VARCHAR(10),
    profession VARCHAR(50),
    on_mailing_list VARCHAR(1), --either yes or no
    mailing_addr VARCHAR(100),
    email_addr VARCHAR(100),
    phone_num VARCHAR(50),
    assignment_date DATE,
    doctor_name VARCHAR(256),
    doctor_phone_number VARCHAR(256),
);

CREATE TABLE Needs(
    ssn VARCHAR(9),
    need VARCHAR(255),
    importance_value INTEGER,
    FOREIGN KEY(ssn) REFERENCES Clients(ssn)
    --deletes automatically when we delete the clients table
);

-- INSERT INTO

CREATE TABLE InsurancePolicy(
    policy_ID INTEGER PRIMARY KEY,
    provider_name VARCHAR(100),
    provider_addr VARCHAR(100),
    insurance_type VARCHAR(100)
);


CREATE TABLE Donors(
    ssn VARCHAR(9) PRIMARY KEY,
    pname VARCHAR(100),
    gender VARCHAR(10),
    profession VARCHAR(50),
    on_mailing_list VARCHAR(1), --either yes or no
    mailing_addr VARCHAR(100),
    email_addr VARCHAR(100),
    phone_num VARCHAR(50),
    is_anonymous VARCHAR(1), --represents a boolean 
);

CREATE TABLE Donations(
    ssn VARCHAR(9),
    donation_date DATE,
    donation_amount INTEGER,
    donation_type VARCHAR(50),
    campaign_name VARCHAR(255),
    FOREIGN KEY(ssn) references Donors(ssn),
);

CREATE TABLE Checks(
    ssn VARCHAR(9),
    card_number INTEGER,
    card_type VARCHAR(50),
    FOREIGN KEY(ssn) references Donors(ssn)
);

CREATE TABLE CreditCard(
    ssn VARCHAR(9),
    card_number INTEGER,
    card_type VARCHAR(50),
    expiration_date DATE,
    FOREIGN KEY(ssn) references Donors(ssn)
);

-- ENTITY TABLES
CREATE TABLE EmergencyContact(
    donor_ssn VARCHAR(9),
    volunteer_ssn VARCHAR(9),
    client_ssn VARCHAR(9),
    employee_ssn VARCHAR(9),
    cname VARCHAR(256),
    contact_phone_number VARCHAR(256),
    relationship VARCHAR(256)
    FOREIGN KEY(donor_ssn) references Donors(ssn)
    ON DELETE CASCADE,
    FOREIGN KEY(volunteer_ssn) references Volunteers(ssn)
    ON DELETE CASCADE,
    FOREIGN KEY(client_ssn) references Clients(ssn)
    ON DELETE CASCADE,
    FOREIGN KEY(employee_ssn) references Employees(ssn)
    ON DELETE CASCADE,
);

-- relationship tables
-- volunteers <--> team
CREATE TABLE ServesOn(
    ssn VARCHAR(9),
    team_name VARCHAR(100),
    serve_month VARCHAR(100), -- stores the month as a string
    serve_hours INTEGER,
    active VARCHAR(255)
    FOREIGN KEY(ssn) REFERENCES Volunteers(ssn),
    FOREIGN KEY(team_name) REFERENCES Team(team_name)
);

-- clients <--> team
CREATE TABLE Reports(
    ssn VARCHAR(9),
    team_name VARCHAR(100),
    report_status VARCHAR(255),
    report_description VARCHAR(255),
    report_date DATE,
    FOREIGN KEY(ssn) REFERENCES Employees(ssn),
    FOREIGN KEY (team_name) REFERENCES Team(team_name)
);

-- clients <--> team
CREATE TABLE CaresFor(
    ssn VARCHAR(9),
    team_name VARCHAR(100),
    FOREIGN KEY (ssn) REFERENCES Clients(ssn),
    FOREIGN KEY (team_name) REFERENCES Team(team_name)
)

-- a volunteer <--> team
CREATE TABLE Leads(
    ssn VARCHAR(9),
    team_name VARCHAR(100),
    FOREIGN KEY(ssn) REFERENCES Volunteers(ssn),
    FOREIGN KEY(team_name) REFERENCES Team(team_name)
);

-- clients <--> insurance policy
CREATE TABLE Has(
    ssn VARCHAR(9),
    policy_ID INTEGER,
    FOREIGN KEY(ssn) REFERENCES Clients(ssn),
    FOREIGN KEY(policy_ID) REFERENCES InsurancePolicy(policy_ID)
);

