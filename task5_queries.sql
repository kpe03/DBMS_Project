-- Kaitlyn Peters
-- DBMS Project 2024
--TASK 5 -- QUERIES


-- 1) Enter a new team into the database (1/month).
DROP PROCEDURE IF EXISTS enterTeam;
GO

CREATE PROCEDURE enterTeam
(
    --team inforamtion
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
-- insert emergency contact to avoid getting errors in the db
DROP PROCEDURE IF EXISTS enterClient;
GO

CREATE PROCEDURE enterClient
(
    --client
    @ssn VARCHAR(9),
    @pname VARCHAR(100),
    @gender VARCHAR(10),
    @profession VARCHAR(50),
    @on_mailing_list VARCHAR(1), --either yes or no
    @mailing_addr VARCHAR(100),
    @email_addr VARCHAR(100),
    @phone_num VARCHAR(50),
    @assignment_date DATE,
    @doctor_name VARCHAR(256),
    @doctor_phone_number VARCHAR(256),
    --cares for (for the association for a team)
    @team_name VARCHAR(100)
)
AS
BEGIN
    INSERT INTO Clients
    VALUES (
        @ssn, 
        @pname, 
        @gender, 
        @profession,
        @on_mailing_list,
        @mailing_addr,
        @email_addr,
        @phone_num,
        @assignment_date,
        @doctor_name, 
        @doctor_phone_number
    );
    INSERT INTO CaresFor
    VALUES(
        @ssn,
        @team_name
    );
END
GO

-- 3) Enter a new volunteer into the database and associate him or her with one or more teams (2/month).
DROP PROCEDURE IF EXISTS enterVolunteer;
GO

CREATE PROCEDURE enterVolunteer
(
    --volunteer
    @ssn VARCHAR(9),
    @pname VARCHAR(100),
    @gender VARCHAR(10),
    @profession VARCHAR(50),
    @on_mailing_list VARCHAR(1), --either yes or no
    @mailing_addr VARCHAR(100),
    @email_addr VARCHAR(100),
    @phone_num VARCHAR(50),
    @date_joined DATE,
    @date_training DATE,
    @location_training VARCHAR(256),
    --associate with team (ServesOn)
    @team_name VARCHAR(100),
    @serve_month VARCHAR(100),
    @serve_hours INTEGER,
    @active VARCHAR(255)
)
AS
BEGIN
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
        @location_training
    )
    INSERT INTO ServesOn
    VALUES(
        @ssn,
        @team_name,
        @serve_month,
        @serve_hours,
        @active
    )
END
GO

-- 4) Enter the number of hours a volunteer worked this month for a particular team (30/month).
DROP PROCEDURE IF EXISTS insertNumberHoursWorked;
GO

CREATE PROCEDURE insertNumberHoursWorked
(
    --servesOn
    @ssn VARCHAR(9),
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
GO

CREATE PROCEDURE enterEmployees 
(
    --employees
    @ssn VARCHAR(9),
    @pname VARCHAR(100),
    @gender VARCHAR(10),
    @profession VARCHAR(50),
    @on_mailing_list VARCHAR(1), --either yes or no
    @mailing_addr VARCHAR(100),
    @email_addr VARCHAR(100),
    @phone_num VARCHAR(50), --no dashes
    @salary INTEGER,
    @marital_status VARCHAR(50),
    @hire_date DATE,
    --reports to 
    @team_name VARCHAR(100),
    @report_status VARCHAR(255),
    @report_description VARCHAR(255),
    @report_date DATE

)
AS
BEGIN
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
        @hire_date
    );
    INSERT INTO Reports
    VALUES(
        @ssn,
        @team_name,
        @report_status,
        @report_description,
        @report_date
    );
END
GO

-- 6) Enter an expense charged by an employee (1/day).
DROP PROCEDURE IF EXISTS enterEmployeeExpense;
GO

CREATE PROCEDURE enterEmployeeExpense
(
    --expense
    @ssn INTEGER,
    @expense_date DATE,
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
GO

CREATE PROCEDURE enterDonorAndDonations
(
    --donor
    @ssn VARCHAR(9),
    @pname VARCHAR(100),
    @gender VARCHAR(10),
    @profession VARCHAR(50),
    @on_mailing_list VARCHAR(1),
    @mailing_addr VARCHAR(100),
    @email_addr VARCHAR(100),
    @phone_num VARCHAR(50), 
    @is_anonymous VARCHAR(1),
    --donation
    @donation_date DATE,
    @donation_amount INTEGER,
    @donation_type VARCHAR(50),
    @campaign_name VARCHAR(255)
)
AS
BEGIN
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
        @is_anonymous
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

-- 8) Retrieve the name and phone number of the doctor of a particular client (1/week).
DROP PROCEDURE IF EXISTS retrieveDoctorInformation;
GO

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
GO

CREATE PROCEDURE totalExpenses
(
    -- constraints for querying period of time
    @time_start DATE,
    @time_end DATE
)
AS
BEGIN
    --sums the expenses 
    SELECT ssn, SUM(expense_amount) as totalExpenses
    FROM Expenses 
    WHERE expense_Date BETWEEN @time_start and @time_end
    GROUP BY ssn
    ORDER BY totalExpenses
END
GO

-- 10) Retrieve the list of volunteers that are members of teams that support a particular client (4/year).
DROP PROCEDURE IF EXISTS retrieveVolunteersOfClient;
GO

CREATE PROCEDURE retrieveVolunteersOfClient
(
    @ssn INT
)
AS
BEGIN
    SELECT DISTINCT vol.pname --get all the names of the volunteers
    FROM Volunteers vol
    JOIN ServesOn serves ON vol.ssn = serves.ssn
    JOIN CaresFor cares ON serves.team_name = cares.team_name
    WHERE cares.ssn = @ssn;
END
GO

-- 11) Retrieve the names of all teams that were founded after a particular date (1/month).
DROP PROCEDURE IF EXISTS retrieveAllTeams;
GO

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
GO

CREATE PROCEDURE retrieveAllPeople
AS
BEGIN
    --join the EC and person table for each type of person
    -- get the cname from the emergency contact table
    SELECT e.pname, e.ssn, e.mailing_addr, e.phone_num, e.email_addr, ec.cname
    FROM Employees as e
    JOIN EmergencyContact ec ON e.ssn = ec.employee_ssn
    UNION
    SELECT pname, ssn, mailing_addr, phone_num, email_addr, cname
    From Clients as client
    JOIN EmergencyContact ec ON client.ssn = ec.client_ssn
    UNION
    SELECT pname, ssn, mailing_addr, phone_num, email_addr, ec.cname
    FROM Volunteers as vol
    JOIN EmergencyContact ec ON vol.ssn = ec.volunteer_ssn
    UNION
    SELECT pname, ssn, mailing_addr, phone_num, email_addr, ec.cname
    FROM Donors as donor
    JOIN EmergencyContact ec ON donor.ssn = ec.donor_ssn
END
GO

-- 13) Retrieve the name and total amount donated by donors that are also employees. The list
-- should be sorted by the total amount of the donations, and indicate if each donor wishes to
-- remain anonymous (1/week)
DROP PROCEDURE IF EXISTS allDonorsAndEmployees;
GO

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
DROP PROCEDURE IF EXISTS increaseSalary;
GO

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
DROP PROCEDURE IF EXISTS deleteClientsWithoutInsurance;
GO

CREATE PROCEDURE deleteClientsWithoutInsurance
AS
BEGIN

    --Delete from the has table
    -- due to the foreign key within HAS
    DELETE FROM Has
    WHERE ssn IN (
        SELECT n.ssn
        FROM Needs n
        WHERE n.need = 'Transportation' 
        AND n.importance_value < 5
    )
    AND ssn NOT IN (
        SELECT h.ssn
        FROM Has h
        JOIN InsurancePolicy i ON h.policy_ID = i.policy_ID
        WHERE i.insurance_type = 'Health'
    );
    --then delete from the clients table
    -- JOIN has and insurance to find the policy id
    -- then delete where transportation is < 5

    DELETE FROM Needs
    WHERE ssn NOT IN (
        SELECT h.ssn
        FROM Has h
    );

    -- DELETE FROM CaresFor
    -- WHERE ssn NOT IN (
    --     SELECT h.ssn
    --     FROM Has h
    -- );

    --finally delete from insurance policy table
    -- -- if it does not exist in has
    DELETE FROM InsurancePolicy
    WHERE policy_ID NOT IN(
        SELECT policy_ID
        FROM Has
    );

    DELETE FROM Clients
        WHERE ssn NOT IN (
        SELECT h.ssn
        FROM Has h
    );

END;
GO

-- 16) Import: enter new teams from a data file until the file is empty (the user must be asked
-- to enter the input file name).
-- opens the file in the java and then inserts each line using 
-- this sql procedure
DROP PROCEDURE IF EXISTS importTeams
GO

CREATE PROCEDURE importTeams
(
    @team_name VARCHAR(100),
    @team_type VARCHAR(100),
    @date_formed DATE
)
AS
BEGIN
    INSERT INTO Team
    VALUES(
        @team_name,
        @team_type,
        @date_formed
    )
END;
GO

-- 17) export retrieve names and mailing addresses of all peple on the mamiling list and output them to a data file
-- going to use a csv file to export
DROP PROCEDURE IF EXISTS exportMailingList;
GO

CREATE PROCEDURE exportMailingList
AS
BEGIN
    SELECT pname, mailing_addr
      FROM Clients
     WHERE UPPER(on_mailing_list) = 'Y'
     UNION
    SELECT pname, mailing_addr
      FROM Volunteers
     WHERE UPPER(on_mailing_list) = 'Y'
     UNION
    SELECT pname, mailing_addr
      FROM Employees
     WHERE UPPER(on_mailing_list) = 'Y'
     UNION
    SELECT pname, mailing_addr
      FROM Donors
     WHERE UPPER(on_mailing_list) = 'Y'
END;
GO
