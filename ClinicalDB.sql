-- Participant Table (General Entity)
CREATE TABLE Participant (
    ParticipantID VARCHAR(10) PRIMARY KEY,
    ParticipantFirstName VARCHAR(50),
    ParticipantLastName VARCHAR(50),
    Dob DATE,
    Gender VARCHAR(10),
    MedicalConditions TEXT,
    MedicationHistory TEXT,
    Allergies TEXT,
    BMI DECIMAL(5,2),
    ParticipantType VARCHAR(10) -- 'Adult' or 'Minor'
);
CREATE INDEX idx_ParticipantID ON Participant(ParticipantID);

select * from TrialDesign;

-- Adult Participant Table (Specialized Entity)
CREATE TABLE AdultParticipant (
    ParticipantID VARCHAR(10) PRIMARY KEY,
    ConsentStatus VARCHAR(20), -- attribute for Adult Participant
    FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID)
);
CREATE INDEX idx_AdultParticipantID ON AdultParticipant(ParticipantID);

-- Minor Participant Table (Specialized Entity)
CREATE TABLE MinorParticipant (
    ParticipantID VARCHAR(10) PRIMARY KEY,
    GuardianName VARCHAR(100), 
    GuardianContactInfo VARCHAR(50), -- attribute for Minor Participant
    FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID)
);
CREATE INDEX idx_MinorParticipantID ON MinorParticipant(ParticipantID);

-- Trial Design Table
CREATE TABLE TrialDesign (
    TrialID VARCHAR(10) PRIMARY KEY,
    TrialName VARCHAR(255),
    Objective TEXT,
    Phase VARCHAR(5), 
    StartDate DATE,
    EndDate DATE,
    PrincipalInvestigatorID INT,
    Sponsor VARCHAR(255)
);
CREATE INDEX idx_TrialID ON TrialDesign(TrialID);

-- Interventional Trial Table (Specialized Entity)
CREATE TABLE InterventionalTrial (
    TrialID VARCHAR(10) PRIMARY KEY,
    InterventionType VARCHAR(50), -- attribute for Interventional Trial
    FOREIGN KEY (TrialID) REFERENCES TrialDesign(TrialID)
);
CREATE INDEX idx_InterventionalTrialID ON InterventionalTrial(TrialID);

-- Observational Trial Table (Specialized Entity)
CREATE TABLE ObservationalTrial (
    TrialID VARCHAR(10) PRIMARY KEY,
    ObservationMethod VARCHAR(50), -- attribute for Observational Trial
    FOREIGN KEY (TrialID) REFERENCES TrialDesign(TrialID)
);
CREATE INDEX idx_ObservationalTrialID ON ObservationalTrial(TrialID);

-- Participant Enrollment Table
CREATE TABLE ParticipantEnrollment (
    EnrollmentID VARCHAR(10) PRIMARY KEY,
    ParticipantID VARCHAR(10),
    TrialID VARCHAR(10),
    ConsentDate DATE,
    EligibilityStatus VARCHAR(20), 
    EnrollmentDate DATE,
    WithdrawalDate DATE,
    ReasonForWithdrawal TEXT
);
CREATE INDEX idx_ParticipantID ON ParticipantEnrollment(ParticipantID);
CREATE INDEX idx_TrialID ON ParticipantEnrollment(TrialID);

-- Principal Investigator Table
CREATE TABLE PrincipalInvestigator (
    PrincipalInvestigatorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(20),
    Institution VARCHAR(255),
    Department VARCHAR(255),
    Specialty VARCHAR(255),
    ExperienceYears INT
);
CREATE INDEX idx_PrincipalInvestigatorID ON PrincipalInvestigator(PrincipalInvestigatorID);

-- Conditions ID Table
CREATE TABLE ConditionsID (
    ConditionID VARCHAR(10) PRIMARY KEY,
    ParticipantID VARCHAR(10),
    ConditionName TEXT,
    Allergies TEXT,
    MedicationHistory TEXT
);
CREATE INDEX idx_ParticipantID ON ConditionsID(ParticipantID);

-- Adverse Events Table
CREATE TABLE AdverseEvents (
    EventID VARCHAR(10) PRIMARY KEY,
    ParticipantID VARCHAR(10),
    TrialID VARCHAR(10),
    DateReported DATE,
    Description TEXT,
    Severity VARCHAR(10), 
    ActionTaken TEXT,
    Outcome TEXT
);
CREATE INDEX idx_ParticipantID ON AdverseEvents(ParticipantID);
CREATE INDEX idx_TrialID ON AdverseEvents(TrialID);

-- Mild Adverse Event Table (Specialized Entity)
CREATE TABLE MildAdverseEvent (
    EventID VARCHAR(10) PRIMARY KEY,
    FOREIGN KEY (EventID) REFERENCES AdverseEvents(EventID)
);

-- Moderate Adverse Event Table (Specialized Entity)
CREATE TABLE ModerateAdverseEvent (
    EventID VARCHAR(10) PRIMARY KEY,
    FOREIGN KEY (EventID) REFERENCES AdverseEvents(EventID)
);

-- Severe Adverse Event Table (Specialized Entity)
CREATE TABLE SevereAdverseEvent (
    EventID VARCHAR(10) PRIMARY KEY,
    FOREIGN KEY (EventID) REFERENCES AdverseEvents(EventID)
);

-- Statistical Analysis Table
CREATE TABLE StatisticalAnalysis (
    AnalysisID VARCHAR(10) PRIMARY KEY,
    TrialID VARCHAR(10),
    AnalysisType VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    MainFindings TEXT,
    Conclusion TEXT
);
CREATE INDEX idx_TrialID ON StatisticalAnalysis(TrialID);

CREATE PROCEDURE InsertSampleData()
BEGIN
    -- Inserting example data into Participant table
    INSERT INTO Participant (ParticipantID, ParticipantFirstName, ParticipantLastName, Dob, Gender, MedicalConditions, MedicationHistory, Allergies, BMI, ParticipantType)
    VALUES
    ('P001', 'John', 'Doe', '1990-05-15', 'Male', 'None', 'None', 'Pollen', 23.5, 'Adult'),
    ('P002', 'Jane', 'Smith', '2002-08-20', 'Female', 'Asthma', 'Albuterol', 'Peanuts', 19.8, 'Minor'),
    ('P003', 'Michael', 'Johnson', '1987-11-30', 'Male', 'High blood pressure', 'Losartan', 'Shellfish', 28.3, 'Adult'),
    ('P004', 'Emily', 'Brown', '1995-04-10', 'Female', 'None', 'None', 'None', 22.1, 'Adult'),
    ('P005', 'David', 'Wilson', '2008-03-25', 'Male', 'None', 'None', 'Cat hair', 17.9, 'Minor');

    -- Inserting example data into AdultParticipant table
    INSERT INTO AdultParticipant (ParticipantID, ConsentStatus)
    VALUES
    ('P001', 'Signed'),
    ('P003', 'Unsigned');

    -- Inserting example data into MinorParticipant table
    INSERT INTO MinorParticipant (ParticipantID, GuardianName, GuardianContactInfo)
    VALUES
    ('P002', 'Alice Smith', 'alice@example.com'),
    ('P005', 'Mary Wilson', 'mary@example.com');

    -- Inserting example data into TrialDesign table
    INSERT INTO TrialDesign (TrialID, TrialName, Objective, Phase, StartDate, EndDate, PrincipalInvestigatorID, Sponsor)
    VALUES
    ('T001', 'COVID-19 Vaccine Trial', 'Evaluate the efficacy of a new COVID-19 vaccine.', 'Phase 3', '2021-01-01', '2023-12-31', 1, 'National Institute of Health'),
    ('T002', 'Diabetes Management Study', 'Assess the effectiveness of a novel diabetes management program.', 'Phase 4', '2020-06-01', '2022-06-30', 2, 'American Diabetes Association');

    -- Inserting example data into InterventionalTrial table
    INSERT INTO InterventionalTrial (TrialID, InterventionType)
    VALUES
    ('T001', 'Vaccine administration');

    -- Inserting example data into ObservationalTrial table
    INSERT INTO ObservationalTrial (TrialID, ObservationMethod)
    VALUES
    ('T002', 'Longitudinal study');

    -- Inserting example data into ParticipantEnrollment table
    INSERT INTO ParticipantEnrollment (EnrollmentID, ParticipantID, TrialID, ConsentDate, EligibilityStatus, EnrollmentDate, WithdrawalDate, ReasonForWithdrawal)
    VALUES
    ('E001', 'P001', 'T001', '2021-01-05', 'Eligible', '2021-01-10', NULL, NULL),
    ('E002', 'P002', 'T001', '2021-02-01', 'Ineligible', '2021-02-05', '2021-03-01', 'Adverse reaction'),
    ('E003', 'P003', 'T002', '2020-06-10', 'Eligible', '2020-06-15', NULL, NULL),
    ('E004', 'P004', 'T002', '2020-06-20', 'Eligible', '2020-06-25', NULL, NULL),
    ('E005', 'P005', 'T002', '2020-07-01', 'Eligible', '2020-07-05', NULL, NULL);
END;

drop table Participant;
drop procedure InsertSampleData;

CALL InsertSampleData(); 

ALTER TABLE TrialDesign MODIFY phase VARCHAR(200) ;

