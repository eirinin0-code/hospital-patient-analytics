-- ============================================================
-- Hospital Patient Outcomes & Operational Analysis
-- SQL Analysis Script
-- Table: hospital_patients
-- ============================================================

-- ============================================================
-- 1. BASIC DATA CHECKS
-- ============================================================

SELECT *
FROM hospital_patients
LIMIT 10;

SELECT COUNT(*) AS Total_Records
FROM hospital_patients;

SELECT COUNT(*) AS Missing_Length_of_Stay
FROM hospital_patients
WHERE Length_of_Stay IS NULL;


-- ============================================================
-- 2. OVERALL KPIs
-- ============================================================

SELECT ROUND(AVG(Length_of_Stay), 2) AS Avg_Length_of_Stay
FROM hospital_patients;

SELECT ROUND(AVG(Total_Cost), 2) AS Avg_Total_Cost
FROM hospital_patients;

SELECT COUNT(*) AS Readmissions
FROM hospital_patients
WHERE Readmission = 'Yes';

SELECT
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM hospital_patients),
        2
    ) AS Readmission_Rate
FROM hospital_patients
WHERE Readmission = 'Yes';


-- ============================================================
-- 3. READMISSION ANALYSIS BY CONDITION
-- ============================================================

SELECT
    `Condition`,
    COUNT(*) AS Total_Admissions,
    SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END) AS Readmissions,
    ROUND(
        SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Readmission_Rate
FROM hospital_patients
GROUP BY `Condition`
ORDER BY Readmission_Rate DESC;


-- ============================================================
-- 4. COST & LENGTH OF STAY BY CONDITION
-- ============================================================

SELECT
    `Condition`,
    ROUND(AVG(Total_Cost), 2) AS Avg_Cost
FROM hospital_patients
GROUP BY `Condition`
ORDER BY Avg_Cost DESC;

SELECT
    `Condition`,
    ROUND(AVG(Length_of_Stay), 2) AS Avg_Stay
FROM hospital_patients
GROUP BY `Condition`
ORDER BY Avg_Stay DESC;

SELECT
    `Condition`,
    ROUND(AVG(Total_Cost), 2) AS Avg_Cost,
    ROUND(AVG(Length_of_Stay), 2) AS Avg_Stay
FROM hospital_patients
GROUP BY `Condition`
ORDER BY Avg_Cost DESC;


-- ============================================================
-- 5. ALLERGIC REACTION LENGTH-OF-STAY INVESTIGATION
-- ============================================================

SELECT
    Patient_ID,
    `Condition`,
    Length_of_Stay
FROM hospital_patients
WHERE `Condition` = 'Allergic Reaction'
ORDER BY Length_of_Stay ASC;

SELECT
    MIN(Length_of_Stay) AS Min_Stay,
    MAX(Length_of_Stay) AS Max_Stay,
    ROUND(AVG(Length_of_Stay), 2) AS Avg_Stay
FROM hospital_patients
WHERE `Condition` = 'Allergic Reaction';

SELECT
    CASE
        WHEN Length_of_Stay BETWEEN 1 AND 7 THEN '1-7 days'
        WHEN Length_of_Stay BETWEEN 8 AND 14 THEN '8-14 days'
        WHEN Length_of_Stay BETWEEN 15 AND 30 THEN '15-30 days'
        ELSE '31+ days'
    END AS Stay_Range,
    COUNT(*) AS Admissions
FROM hospital_patients
WHERE `Condition` = 'Allergic Reaction'
GROUP BY Stay_Range
ORDER BY MIN(Length_of_Stay);


-- ============================================================
-- 6. INSURANCE CLAIM ANALYSIS
-- ============================================================

SELECT
    Insurance_Claimed,
    COUNT(*) AS Admissions
FROM hospital_patients
GROUP BY Insurance_Claimed;

SELECT
    Insurance_Claimed,
    COUNT(*) AS Admissions,
    ROUND(AVG(Total_Cost), 2) AS Avg_Cost
FROM hospital_patients
GROUP BY Insurance_Claimed;

SELECT
    Insurance_Claimed,
    COUNT(*) AS Admissions,
    ROUND(AVG(Total_Cost), 2) AS Avg_Cost,
    ROUND(
        SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Readmission_Rate
FROM hospital_patients
GROUP BY Insurance_Claimed;


-- ============================================================
-- 7. OUTCOME ANALYSIS
-- ============================================================

SELECT
    Outcome,
    COUNT(*) AS Admissions
FROM hospital_patients
GROUP BY Outcome
ORDER BY Admissions DESC;

SELECT
    `Condition`,
    COUNT(*) AS Total_Admissions,
    SUM(CASE WHEN Outcome = 'Recovered' THEN 1 ELSE 0 END) AS Recovered,
    ROUND(
        SUM(CASE WHEN Outcome = 'Recovered' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Recovery_Rate
FROM hospital_patients
GROUP BY `Condition`
ORDER BY Recovery_Rate DESC;

SELECT
    Insurance_Claimed,
    COUNT(*) AS Total_Admissions,
    SUM(CASE WHEN Outcome = 'Recovered' THEN 1 ELSE 0 END) AS Recovered,
    ROUND(
        SUM(CASE WHEN Outcome = 'Recovered' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Recovery_Rate
FROM hospital_patients
GROUP BY Insurance_Claimed;


-- ============================================================
-- 8. SATISFACTION ANALYSIS
-- ============================================================

SELECT
    MIN(Satisfaction) AS Min_Satisfaction,
    MAX(Satisfaction) AS Max_Satisfaction,
    ROUND(AVG(Satisfaction), 2) AS Avg_Satisfaction
FROM hospital_patients;

SELECT
    Readmission,
    ROUND(AVG(Satisfaction), 2) AS Avg_Satisfaction
FROM hospital_patients
GROUP BY Readmission;

SELECT
    Outcome,
    ROUND(AVG(Satisfaction), 2) AS Avg_Satisfaction
FROM hospital_patients
GROUP BY Outcome;

SELECT
    `Condition`,
    ROUND(AVG(Satisfaction), 2) AS Avg_Satisfaction
FROM hospital_patients
GROUP BY `Condition`
ORDER BY Avg_Satisfaction DESC;


-- ============================================================
-- 9. AGE ANALYSIS
-- ============================================================

SELECT
    MIN(Age) AS Min_Age,
    MAX(Age) AS Max_Age,
    ROUND(AVG(Age), 2) AS Avg_Age
FROM hospital_patients;

SELECT
    CASE
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS Age_Group,
    COUNT(*) AS Admissions
FROM hospital_patients
GROUP BY Age_Group
ORDER BY MIN(Age);

SELECT
    CASE
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS Age_Group,
    COUNT(*) AS Admissions,
    ROUND(
        SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Readmission_Rate
FROM hospital_patients
GROUP BY Age_Group
ORDER BY MIN(Age);

SELECT
    CASE
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS Age_Group,
    ROUND(AVG(Length_of_Stay), 2) AS Avg_Stay
FROM hospital_patients
GROUP BY Age_Group
ORDER BY MIN(Age);

SELECT
    CASE
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS Age_Group,
    ROUND(AVG(Total_Cost), 2) AS Avg_Cost
FROM hospital_patients
GROUP BY Age_Group
ORDER BY MIN(Age);

SELECT
    CASE
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS Age_Group,
    COUNT(*) AS Admissions,
    ROUND(AVG(Length_of_Stay), 2) AS Avg_Stay,
    ROUND(AVG(Total_Cost), 2) AS Avg_Cost,
    ROUND(
        SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Readmission_Rate
FROM hospital_patients
GROUP BY Age_Group
ORDER BY MIN(Age);


-- ============================================================
-- 10. GENDER ANALYSIS & SYNTHETIC-DATA CHECK
-- ============================================================

SELECT
    Gender,
    COUNT(*) AS Admissions,
    ROUND(AVG(Age), 2) AS Avg_Age,
    ROUND(AVG(Length_of_Stay), 2) AS Avg_Stay,
    ROUND(AVG(Total_Cost), 2) AS Avg_Cost,
    ROUND(
        SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Readmission_Rate,
    ROUND(AVG(Satisfaction), 2) AS Avg_Satisfaction
FROM hospital_patients
GROUP BY Gender;

SELECT
    Gender,
    `Condition`,
    COUNT(*) AS Admissions,
    ROUND(
        SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Readmission_Rate
FROM hospital_patients
GROUP BY Gender, `Condition`
ORDER BY Gender, Readmission_Rate DESC;

SELECT
    `Condition`,
    Gender,
    COUNT(*) AS Admissions
FROM hospital_patients
GROUP BY `Condition`, Gender
ORDER BY `Condition`, Gender;


-- ============================================================
-- 11. YEARLY TRENDS
-- ============================================================

SELECT
    Year_of_Admission,
    COUNT(*) AS Admissions,
    ROUND(AVG(Total_Cost), 2) AS Avg_Cost,
    ROUND(AVG(Length_of_Stay), 2) AS Avg_Stay
FROM hospital_patients
GROUP BY Year_of_Admission
ORDER BY Year_of_Admission;

SELECT
    Year_of_Admission,
    COUNT(*) AS Admissions,
    ROUND(
        SUM(CASE WHEN Readmission = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Readmission_Rate
FROM hospital_patients
GROUP BY Year_of_Admission
ORDER BY Year_of_Admission;


-- ============================================================
-- DATASET LIMITATION NOTES
-- ============================================================
-- This dataset appears to be synthetic / educational.
-- Several strong deterministic patterns were observed, including:
-- - Conditions assigned exclusively to one gender
-- - Recovery outcomes strongly determined by condition
-- - Very clean/extreme readmission patterns for certain conditions
--
-- Findings should therefore be treated as portfolio / learning
-- insights rather than real-world clinical benchmarks.
