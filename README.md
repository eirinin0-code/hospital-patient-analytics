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
