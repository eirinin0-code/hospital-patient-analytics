# Hospital Patient Outcomes & Operational Analysis

## Project Overview

This project analyzes a synthetic hospital patient dataset using SQL and Power BI to explore hospital admissions, treatment outcomes, readmissions, patient satisfaction, length of stay, costs, insurance claims, demographic patterns, and yearly trends.

The goal was to practice an end-to-end analytics workflow, beginning with data exploration and analysis in SQL and continuing with data preparation, DAX measures, interactive visualizations, and dashboard development in Power BI.

The analysis also included data-quality checks and investigation of unusual patterns in the dataset. Several variables showed highly deterministic relationships, reinforcing the importance of validating analytical findings before interpreting them as real-world healthcare insights.

## Tools Used

- MySQL Workbench
- SQL
- Power BI Desktop
- Power Query
- DAX

## Business Questions

The analysis focused on the following questions:

1. What are the overall hospital admission volume, average cost, average length of stay, readmission rate, and patient satisfaction?
2. Which medical conditions are associated with the highest average cost and longest hospital stays?
3. How do readmission rates vary across medical conditions?
4. Do insurance claims appear to be associated with differences in cost, readmission, or recovery outcomes?
5. How does patient satisfaction vary by readmission status, outcome, and condition?
6. How do age groups differ in average length of stay, cost, and readmission rate?
7. How do average cost, length of stay, and readmission rate change over time?
8. Are there unusual or deterministic patterns in the dataset that limit real-world interpretation?

## Data Preparation & SQL Analysis

The dataset was first explored and validated in MySQL Workbench before being used in Power BI.

Key preparation and analysis steps included:

- Imported 984 hospital admission records into MySQL.
- Verified row counts and checked key analytical fields for missing values.
- Reviewed data types and identified date fields that required conversion during the Power BI preparation stage.
- Calculated overall KPIs including average length of stay, average total cost, readmission rate, and patient satisfaction.
- Used `GROUP BY`, `CASE WHEN`, `AVG`, `SUM`, `COUNT`, `MIN`, `MAX`, `ROUND`, and `ORDER BY` to analyze patterns across conditions, insurance status, outcomes, age groups, gender, and admission years.
- Investigated unusual results rather than accepting aggregate metrics at face value.
- Examined length-of-stay distributions when certain averages appeared clinically unrealistic.
- Identified several deterministic relationships in the data, including conditions being assigned exclusively to one gender, supporting the conclusion that the dataset is synthetic.

## Key Findings

### 1. Overall Hospital Performance
- The dataset contains **984 hospital admissions**.
- Average hospitalization cost was approximately **8,367.48**.
- Average length of stay was approximately **37.66 days**.
- The overall readmission rate was **26.83%**.
- Average patient satisfaction was **3.60**.

### 2. Conditions Associated with Higher Cost and Longer Stays
- **Cancer**, **Prostate Cancer**, and **Heart Attack** ranked among the highest conditions for both average hospitalization cost and average length of stay.
- Cancer recorded the highest average cost at approximately **25,000** and an average stay of **42.65 days**.
- These results indicate that certain conditions were consistently associated with greater resource use within the dataset.

### 3. Readmission Patterns
- Readmission rates varied substantially across conditions, with several conditions showing unusually high or low rates.
- Because many of these rates were extremely deterministic, they were treated cautiously and interpreted as characteristics of the synthetic dataset rather than real-world clinical benchmarks.

### 4. Patient Satisfaction
- Admissions without readmission had higher average satisfaction (**3.78**) than admissions followed by readmission (**3.11**).
- Recovered admissions also showed higher average satisfaction (**3.84**) compared with stable outcomes (**3.24**).
- These relationships indicate association only and should not be interpreted as causal effects.

### 5. Age-Group Patterns
- Average length of stay increased progressively across older age groups, from **34.50 days** among patients aged 25–34 to **38.93 days** among those aged 65+.
- Average hospitalization cost generally increased with age, peaking in the **55–64** group at approximately **11,331.88**, before declining in the 65+ group.
- Readmission rates varied across age groups without following a consistent linear trend.

### 6. Insurance Claim Comparison
- Admissions without an insurance claim had a slightly higher average cost and readmission rate than admissions where insurance was claimed.
- Readmission rates were **27.49%** without an insurance claim and **25.64%** with an insurance claim.

### 7. Yearly Trends
- Average hospitalization cost peaked in **2023** at approximately **9,348.66**, before declining in 2024 and 2025.
- Readmission rates increased modestly from **24.00% in 2022** to approximately **28.3% by 2024–2025**.

### 8. Dataset Limitations
- Several conditions were assigned exclusively to one gender.
- Recovery outcomes and readmission patterns also showed highly deterministic relationships.
- These findings strongly suggest that the dataset is synthetic and educational, so results should not be interpreted as real-world clinical evidence.
