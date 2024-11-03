--TASK 5 -- QUERIES


-- 1) Enter a new team into the database (1/month).
DROP PROCEDURE IF EXISTS enterTeam;
GO

CREATE PROCEDURE enterTeam
(
    --team
    @team_name VARCHAR(100),
    @team_type VARCHAR(100),
    @date_formed DATE
)
AS
BEGIN
    INSERT INTO Team
    VALUES (
        @team_name,
        @team_type,
        @date_formed
    );
END
GO

-- 2) Enter a new client into the database and associate him or her with one or more teams 
DROP PROCEDURE IF EXISTS enterClient;
GO

CREATE PROCEDURE enterClient
(
    --emergency contact
    @cname VARCHAR(256),
    @contact_phone_number VARCHAR(256),
    @relationship VARCHAR(256),
    --client
    @ssn INT,
    @person_name VARCHAR(256),
    @gender VARCHAR(256),
    @profession VARCHAR(256),
    @on_mailing_list BIT,
    @mailing_address VARCHAR(256),
    @email_address VARCHAR(256),
    @phone_number VARCHAR(256),
    @assignment_date DATE,
    @doctor_name VARCHAR(256),
    @doctor_phone_number VARCHAR(256),
    --cares for (for the association for a team)
    @team_name VARCHAR(100)
)
AS
BEGIN
    INSERT INTO EmergencyContact
    VALUES(
        @cname,
        @contact_phone_number,
        @relationship
    );
    INSERT INTO Clients
    VALUES (
        @ssn, 
        @person_name, 
        @gender, @profession, 
        @on_mailing_list,
        @mailing_address, 
        @phone_number, 
        @email_address, 
        @assignment_date, 
        @doctor_name, 
        @doctor_phone_number, 
        @team_name
    );
    INSERT INTO CaresFor
    VALUES(
        @team_name
    );
END
GO

-- 3) Enter a new volunteer into the database and associate him or her with one or more teams (2/month).
DROP PROCEDURE IF EXISTS enterClient;
GO

CREATE PROCEDURE enterVolunteer
(
    -- emergency contact for volunteer
    @cname VARCHAR(256),
    @contact_phone_number VARCHAR(256),
    @relationship VARCHAR(256),
    --volunteer
    @ssn INTEGER,
    @pname VARCHAR(100),
    @gender VARCHAR(10),
    @profession VARCHAR(50),
    @on_mailing_list VARCHAR(1), --either yes or no
    @mailing_addr VARCHAR(100),
    @email_addr VARCHAR(100),
    @phone_num VARCHAR(13), --no dashes
    @date_joined VARCHAR(50),
    @date_training VARCHAR(50),
    @location_training VARCHAR(256),
    @emergency_contact_name VARCHAR(256),
    --associate with team (ServesOn)
    @team_name VARCHAR(100),
    @serve_month VARCHAR(255),
    @serve_hours INTEGER,
    @active VARCHAR(255)
)
AS
BEGIN
    INSERT INTO EmergencyContact
    VALUES (
        @cname,
        @contact_phone_number,
        @relationship
    )
    INSERT INTO Volunteers
    VALUES(
        @ssn, 
        @pname, 
        @gender, 
        @profession,
        @on_mailing_list,
        @mailing_addr,
        @email_addr,
        @phone_num, 
        @date_joined,
        @date_training,
        @location_training,
        @emergency_contact_name
    )
    INSERT INTO ServesOn
    VALUES(
        @team_name,
        @serve_month,
        @serve_hours,
        @active
    )
END
GO

-- 4) Enter the number of hours a volunteer worked this month for a particular team (30/month).
DROP PROCEDURE IF EXISTS insertNumberHoursWorked;
GO;

CREATE PROCEDURE insertNumberHoursWorked
(
    --servesOn
    @ssn INTEGER,
    @team_name VARCHAR(100),
    @serve_month VARCHAR(255),
    @serve_hours INTEGER,
    @active VARCHAR(255)
)
AS
BEGIN
    INSERT INTO ServesOn
    Values(
        @ssn,
        @team_name,
        @serve_month,
        @serve_hours,
        @active
    )
END
GO

-- 5) Enter a new employee into the database and associate him or her with one or more teams (1/year).
DROP PROCEDURE IF EXISTS enterEmployees;
GO;

CREATE PROCEDURE enterEmployees 
(
    --emergency contact
    @cname VARCHAR(256),
    @contact_phone_number VARCHAR(256),
    @relationship VARCHAR(256),
    --employees
    @ssn INTEGER,
    @pname VARCHAR(100),
    @gender VARCHAR(10),
    @profession VARCHAR(50),
    @on_mailing_list VARCHAR(1), --either yes or no
    @mailing_addr VARCHAR(100),
    @email_addr VARCHAR(100),
    @phone_num VARCHAR(13), --no dashes
    @salary INTEGER,
    @marital_status VARCHAR(50),
    @hire_date VARCHAR(50),
    @emergency_contact_name VARCHAR(256),
    --reports to 
    @team_name VARCHAR(100),
    @report_status VARCHAR(255),
    @report_description VARCHAR(255),
    @report_date VARCHAR(255)

)
AS
BEGIN
    INSERT INTO EmergencyContact
    VALUES(
        @cname,
        @contact_phone_number,
        @relationship
    );
    INSERT INTO Employees
    VALUES(
        @ssn,
        @pname, 
        @gender,
        @profession, 
        @on_mailing_list, 
        @mailing_addr,
        @email_addr, 
        @phone_num,
        @salary, 
        @marital_status, 
        @hire_date, 
        @emergency_contact_name,
    );
    INSERT INTO Reports
    VALUES(
        @team_name,
        @report_status,
        @report_description,
        @report_date
    );
END
GO

-- 6) Enter an expense charged by an employee (1/day).
DROP PROCEDURE IF EXISTS enterEmployeeExpense;
GO;

CREATE PROCEDURE enterEmployeeExpense
(
    --expense
    @ssn INTEGER,
    @expense_date VARCHAR(50),
    @expense_amount DECIMAL(10,2),
    @expense_description VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Expenses
    VALUES(
        @ssn,
        @expense_date,
        @expense_amount,
        @expense_description
    );
END
GO

-- 7) Enter a new donor and associate him or her with several donations (1/day).
DROP PROCEDURE IF EXISTS enterDonorAndDonations;
GO;

CREATE PROCEDURE enterDonorAndDonations
(
    --emergency contact
    @cname VARCHAR(256),
    @contact_phone_number VARCHAR(256),
    @relationship VARCHAR(256),
    --donor
    @ssn INTEGER,
    @pname VARCHAR(100),
    @gender VARCHAR(10),
    @profession VARCHAR(50),
    @on_mailing_list VARCHAR(1),
    @mailing_addr VARCHAR(100),
    @email_addr VARCHAR(100),
    @phone_num VARCHAR(13), 
    @is_anonymous VARCHAR(1), 
    @emergency_contact_name VARCHAR(256),
    --donation
    @donation_date INTEGER,
    @donation_amount INTEGER,
    @donation_type VARCHAR(50),
    @campaign_name VARCHAR(255)
)
AS
BEGIN
    --insert contact information for new donor
    INSERT INTO EmergencyContact
    VALUES(
        @cname,
        @contact_phone_number,
        @relationship
    );
    --update donor
    INSERT INTO Donors
    VALUES (
        @ssn, 
        @pname, 
        @gender, 
        @profession,
        @on_mailing_list,
        @mailing_addr,
        @email_addr,
        @phone_num, 
        @is_anonymous,
        @emergency_contact_name
    );
    --associate with a donation
    INSERT INTO Donations
    VALUES(
        @ssn,
        @donation_date,
        @donation_amount,
        @donation_type,
        @campaign_name
    );
END
GO

-- to test query 7
EXEC enterDonorAndDonations 
    @cname = 'Jane Doe',
    @contact_phone_number = '405-111-1111',
    @relationship = 'sister',
    @ssn = 123456789,
    @pname = 'John Doe',
    @gender = 'Male',
    @profession = 'Teacher',
    @on_mailing_list = 'Y',
    @mailing_addr = '123 Main St, Anytown, USA',
    @email_addr = 'johndoe@example.com',
    @phone_num = '555-1234',
    @is_anonymous = 'N',
    @emergency_contact_name = 'Jane Doe',
    @donation_amount = 5000,
    @donation_date = '20230101',
    @donation_type = 'Money',
    @campaign_name = 'Hospital'

-- 8) Retrieve the name and phone number of the doctor of a particular client (1/week).
DROP PROCEDURE IF EXISTS retrieveDoctorInformation;
GO;

CREATE PROCEDURE retrieveDoctorInformation
(
    @ssn INTEGER
)
AS
BEGIN
    SELECT doctor_name, doctor_phone_number
    FROM Clients where ssn = @ssn;
END
GO

-- 9) Retrieve the total amount of expenses charged by each employee for a particular period of time. 
-- The list should be sorted by the total amount of expenses (1/month).
DROP PROCEDURE IF EXISTS totalExpenses;
GO;

CREATE PROCEDURE totalExpenses
(
    -- constraints for querying period of time
    @time_start INTEGER,
    @time_end INTEGER
)
AS
BEGIN
    --sums the expenses 
    SELECT SUM(expense_amount)
    FROM Expenses
    WHERE expense_Date BETWEEN @time_start and @time_end
    GROUP BY ssn
    ORDER BY SUM(expense_amount)
END
GO

-- 10) Retrieve the list of volunteers that are members of teams that support a particular client (4/year).
DROP PROCEDURE IF EXISTS retrieveVolunteersOfClient;
GO;

CREATE PROCEDURE retrieveVolunteersOfClient
(
    @ssn INT
)
AS
BEGIN
    SELECT vol.pname --get all the names of the volunteers
    FROM Volunteers vol
    JOIN ServesOn serves ON vol.ssn = serves.ssn
    JOIN CaresFor cares ON serves.team_name = cares.team_name
    WHERE cares.ssn = @ssn;
END
GO

-- 11) Retrieve the names of all teams that were founded after a particular date (1/month).
DROP PROCEDURE IF EXISTS retrieveAllTeams;
GO;

CREATE PROCEDURE retrieveAllTeams
(
    @date_start DATE
)
AS
BEGIN
    SELECT t.team_name
    FROM Team t
    WHERE date_formed > @date_start --get teams formed AFTER start
END
GO

-- 12) Retrieve the names, social security numbers, contact information, and emergency contact
-- information of all people in the database (1/week).
DROP PROCEDURE IF EXISTS retrieveAllPeople;
GO;

CREATE PROCEDURE retrieveAllPeople
AS
BEGIN
    SELECT pname, ssn, mailing_addr, phone_num, email_addr, emergency_contact_name
    FROM Employees
    UNION
    SELECT pname, ssn, mailing_addr, phone_num, email_addr, emergency_contact_name
    From Clients
    UNION
    SELECT pname, ssn, mailing_addr, phone_num, email_addr, emergency_contact_name
    FROM Volunteers
    UNION
    SELECT pname, ssn, mailing_addr, phone_num, email_addr, emergency_contact_name
    FROM Donors
END
GO

-- 13) Retrieve the name and total amount donated by donors that are also employees. The list
-- should be sorted by the total amount of the donations, and indicate if each donor wishes to
-- remain anonymous (1/week)
DROP PROCEDURE allDonorsAndEmployees;
GO;

CREATE PROCEDURE allDonorsAndEmployees
AS
BEGIN
    SELECT donor.pname, SUM(donation.donation_amount) AS totalDonation, donor.is_anonymous
    FROM Donors donor
    --get donation amount corresponding to donor
    JOIN Donations donation on donor.ssn = donation.ssn
    WHERE donor.ssn IN (SELECT ssn FROM Employees)
    GROUP BY donor.pname, donor.is_anonymous
    -- sort by total donation
    ORDER BY totalDonation
END;
GO

-- 14) Increase the salary by 10% of all employees to whom more than one team must report. (1/year)
DROP PROCEDURE increaseSalary;
GO;

CREATE PROCEDURE increaseSalary
AS
BEGIN
    UPDATE Employees
    SET salary = salary * 1.1
    WHERE ssn in (SELECT ssn from reports GROUP BY ssn HAVING COUNT(team_name) > 1);
END;
GO

-- 15) Delete all clients who do not have health insurance and whose value of importance for
-- transportation is less than 5 (4/year).
DROP PROCEDURE deleteClientsWithoutInsurnace;
GO;

CREATE PROCEDURE deleteClientsWithoutInsurnace
AS
BEGIN
    DELETE FROM Clients
    WHERE ssn NOT IN (SELECT ssn FROM InsurancePolicy WHERE insurance_type = 'Health')
    AND ssn IN (SELECT ssn FROM Needs WHERE need = 'Transportantion'
        AND importance_value < 5);
END;
GO

-- 16)
-- in java

-- 17) export retrieve names and mailing addresses of all peple on the mamiling list and output them to a data file

DROP PROCEDURE exportMailingList;
GO;

CREATE PROCEDURE exportMailingList
AS
BEGIN
    SELECT pname, mailing_addr
      FROM Clients
     WHERE on_mailing_list = 1
     UNION
    SELECT pname, mailing_addr
      FROM Volunteers
     WHERE on_mailing_list = 1
     UNION
    SELECT pname, mailing_addr
      FROM Employees
     WHERE on_mailing_list = 1
     UNION
    SELECT pname, mailing_addr
      FROM Donors
     WHERE on_mailing_list = 1;
END;
GO

-- 18) quit the program
-- in java