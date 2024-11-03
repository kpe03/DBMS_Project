-- TASK 4 
-- create the tables
-- CREATE TABLE Person(
--     ssn VARCHAR(9) PRIMARY KEY,
--     pname VARCHAR(100),
--     gender VARCHAR(10),
--     profession VARCHAR(50),
--     on_mailing_list VARCHAR(1), --either yes or no
--     mailing_addr VARCHAR(100),
--     email_addr VARCHAR(100),
--     phone_num VARCHAR(13) --no dashes
-- );


-- kaitlyn -- query 7 and 10

CREATE TABLE EmergencyContact(
    cname VARCHAR(256) PRIMARY KEY,
    contact_phone_number VARCHAR(256),
    relationship VARCHAR(256)
);

CREATE TABLE Clients(
    ssn INTEGER PRIMARY KEY,
    pname VARCHAR(100),
    gender VARCHAR(10),
    profession VARCHAR(50),
    on_mailing_list VARCHAR(1), --either yes or no
    mailing_addr VARCHAR(100),
    email_addr VARCHAR(100),
    phone_num VARCHAR(13), --no dashes
    email_address VARCHAR(256),
    assignment_date DATE,
    doctor_name VARCHAR(256),
    doctor_phone_number VARCHAR(256),
    emergency_contact_name VARCHAR(256),
    FOREIGN KEY (emergency_contact_name) REFERENCES EmergencyContact(cname)
);

CREATE TABLE InsurancePolicy(
    policy_ID INTEGER PRIMARY KEY,
    provider_name VARCHAR(100),
    provider_addr VARCHAR(100),
    insurance_type VARCHAR(100)
);

CREATE TABLE Volunteers(
    ssn INTEGER PRIMARY KEY,
    pname VARCHAR(100),
    gender VARCHAR(10),
    profession VARCHAR(50),
    on_mailing_list VARCHAR(1), --either yes or no
    mailing_addr VARCHAR(100),
    email_addr VARCHAR(100),
    phone_num VARCHAR(13), --no dashes
    date_joined VARCHAR(50),
    date_training VARCHAR(50),
    location_training VARCHAR(256),
    emergency_contact_name VARCHAR(256),
    FOREIGN KEY(emergency_contact_name) references EmergencyContact(cname)
);

CREATE TABLE Team(
    team_name VARCHAR(100) PRIMARY KEY,
    team_type VARCHAR(100),
    date_formed DATE,
);

CREATE TABLE Employees(
    ssn INTEGER PRIMARY KEY,
    pname VARCHAR(100),
    gender VARCHAR(10),
    profession VARCHAR(50),
    on_mailing_list VARCHAR(1), --either yes or no
    mailing_addr VARCHAR(100),
    email_addr VARCHAR(100),
    phone_num VARCHAR(13), --no dashes
    salary INTEGER,
    marital_status VARCHAR(50),
    hire_date VARCHAR(50),
    emergency_contact_name VARCHAR(256),
    FOREIGN KEY(emergency_contact_name) references EmergencyContact(cname)
);

CREATE TABLE Expenses(
    ssn INTEGER,
    expense_date VARCHAR(50),
    expense_amount DECIMAL(10,2),
    expense_description VARCHAR(255),
    FOREIGN KEY(ssn) references Employees,
);

CREATE TABLE Donors(
    ssn INTEGER PRIMARY KEY,
    pname VARCHAR(100),
    gender VARCHAR(10),
    profession VARCHAR(50),
    on_mailing_list VARCHAR(1), --either yes or no
    mailing_addr VARCHAR(100),
    email_addr VARCHAR(100),
    phone_num VARCHAR(13), --no dashes
    is_anonymous VARCHAR(1), --represents a boolean 
    emergency_contact_name VARCHAR(256),
    FOREIGN KEY(emergency_contact_name) references EmergencyContact(cname)
);

CREATE TABLE Donations(
    ssn INTEGER,
    donation_date INTEGER,
    donation_amount INTEGER,
    donation_type VARCHAR(50),
    campaign_name VARCHAR(255),
    FOREIGN KEY(ssn) references Donors(ssn),
);

CREATE TABLE Checks(
    ssn INTEGER,
    card_number INTEGER,
    card_type VARCHAR(50),
    FOREIGN KEY(ssn) references Donors(ssn)
);

CREATE TABLE CreditCard(
    ssn INTEGER,
    card_number INTEGER,
    card_type VARCHAR(50),
    expiration_date VARCHAR(50),
    FOREIGN KEY(ssn) references Donors(ssn)
);


-- relationship tables
CREATE TABLE ServesOn(
    ssn INTEGER,
    team_name VARCHAR(100),
    serve_month VARCHAR(255),
    serve_hours INTEGER,
    active VARCHAR(255)
    FOREIGN KEY(ssn) REFERENCES Volunteers(ssn),
    FOREIGN KEY(team_name) REFERENCES Team(team_name)
);

CREATE TABLE Reports(
    ssn INTEGER,
    team_name VARCHAR(100),
    report_status VARCHAR(255),
    report_description VARCHAR(255),
    report_date VARCHAR(255)
    FOREIGN KEY(ssn) REFERENCES Employees(ssn),
    FOREIGN KEY (team_name) REFERENCES Team(team_name)
);

CREATE TABLE CaresFor(
    ssn INTEGER,
    team_name VARCHAR(100),
    FOREIGN KEY (ssn) REFERENCES Clients(ssn),
    FOREIGN KEY (team_name) REFERENCES Team(team_name)
)

CREATE TABLE Leads(
    ssn INTEGER,
    team_name VARCHAR(100),
    FOREIGN KEY(ssn) REFERENCES Volunteers(ssn),
    FOREIGN KEY(team_name) REFERENCES Team(team_name)
);

CREATE TABLE Has(
    ssn INTEGER,
    policy_ID INTEGER,
    FOREIGN KEY(ssn) REFERENCES Clients(ssn),
    FOREIGN KEY(policy_ID) REFERENCES InsurancePolicy(policy_ID)
);

CREATE TABLE Needs(
    ssn INTEGER,
    need VARCHAR(255),
    importance_value INTEGER,
    FOREIGN KEY(ssn) REFERENCES Clients(ssn)
);

