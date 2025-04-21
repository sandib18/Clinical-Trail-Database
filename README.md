# Clinical Trail Database

A comprehensive relational database system for managing clinical trial data, built using SQL. This project captures various aspects of clinical trials, including participants (adults and minors), trial designs, enrollments, adverse events, and statistical analysis.

## 🚀 Features

- **Participant Management**: Tracks participant details including medical history, allergies, BMI, and guardian info for minors.
- **Trial Design**: Handles multiple types of trials (interventional, observational) with attributes such as objectives, phases, and sponsors.
- **Enrollment Tracking**: Logs participant enrollment, eligibility, and withdrawal details.
- **Adverse Events**: Categorizes adverse events by severity (mild, moderate, severe) and records outcomes and actions taken.
- **Statistical Analysis**: Stores analysis type, findings, and conclusions linked to each trial.
- **Stored Procedure**: `InsertSampleData()` for inserting mock data to test the schema.

## 🗃️ Entity-Relationship Overview

The project uses generalization/specialization techniques across tables:
- `Participant` is generalized into `AdultParticipant` and `MinorParticipant`
- `TrialDesign` is specialized into `InterventionalTrial` and `ObservationalTrial`
- `AdverseEvents` is categorized into `MildAdverseEvent`, `ModerateAdverseEvent`, and `SevereAdverseEvent`

## 🛠️ Tech Stack

- SQL (MySQL / MariaDB / Compatible RDBMS)
- Indexes for optimized queries
- Stored Procedures for mock data population

## 📂 Tables Included

- `Participant`
- `AdultParticipant`
- `MinorParticipant`
- `TrialDesign`
- `InterventionalTrial`
- `ObservationalTrial`
- `ParticipantEnrollment`
- `PrincipalInvestigator`
- `ConditionsID`
- `AdverseEvents` (+ severity-specific sub-tables)
- `StatisticalAnalysis`

## 🧪 Sample Data

To insert sample data use:
```sql
CALL InsertSampleData();
