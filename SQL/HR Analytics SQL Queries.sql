CREATE DATABASE HR_DB;

SELECT * FROM hrdata;

DESCRIBE hrdata;

ALTER TABLE hrdata
CHANGE COLUMN ï»¿emp_no emp_no INT8 PRIMARY KEY;

ALTER TABLE hrdata
    MODIFY COLUMN gender VARCHAR(50) NOT NULL,
    MODIFY COLUMN marital_status VARCHAR(50),
    MODIFY COLUMN age_band VARCHAR(50),
    MODIFY COLUMN age INT8,
    MODIFY COLUMN department VARCHAR(50),
    MODIFY COLUMN education VARCHAR(50),
    MODIFY COLUMN education_field VARCHAR(50),
    MODIFY COLUMN job_role VARCHAR(50),
    MODIFY COLUMN business_travel VARCHAR(50),
    MODIFY COLUMN employee_count INT8,
    MODIFY COLUMN attrition VARCHAR(50),
    MODIFY COLUMN attrition_label VARCHAR(50),
    MODIFY COLUMN job_satisfaction INT8,
    MODIFY COLUMN active_employee INT8;

-- Total No of Employees
SELECT SUM(employee_count)
FROM hrdata;


-- Extracting Employees Count for Different Education Level
SELECT SUM(employee_count) FROM hrdata
WHERE education = 'High School';

-- Extracting Employees Count for Different Departments
SELECT SUM(employee_count) FROM hrdata
WHERE department = 'Sales';

-- Extracting Employees Count for Different Education Field
SELECT SUM(employee_count) FROM hrdata
WHERE education_field = 'Medical';


-- Extracting Total Attrition Count
SELECT COUNT(attrition) FROM  hrdata
WHERE attrition = 'Yes';

-- Attrition Count for 'Doctoal Degree'
SELECT COUNT(attrition) FROM  hrdata
WHERE attrition = 'Yes' AND education = 'Doctoral Degree';

-- Attrition Count for 'R&D Dept'
SELECT COUNT(attrition) FROM  hrdata
WHERE attrition = 'Yes' AND department = 'R&D';

-- Attrition Count for 'R&D Dept and Education_field is Medical'
SELECT COUNT(attrition) FROM  hrdata
WHERE attrition = 'Yes' AND department = 'R&D' AND education_field = 'Medical';



-- Overall Attrition Rate
SELECT
	((SELECT COUNT(attrition) 
    FROM hrdata
	WHERE attrition = 'Yes')
    /
SUM(employee_count))*100 AS attrition_rate 
FROM hrdata;

-- Attriton Rate of Sales Department
SELECT 
	((SELECT COUNT(attrition) 
    FROM hrdata WHERE attrition = 'Yes' AND department = 'Sales') 
    /
SUM(employee_count))*100 AS attrition_rate 
FROM hrdata WHERE department = 'Sales';



-- Total Active Employees
SELECT SUM(employee_count)
	- 
    (SELECT COUNT(attrition) FROM hrdata 
    WHERE attrition = 'Yes') AS active_emp 
FROM hrdata;

-- Count of Male Active Employees
SELECT SUM(employee_count)
	- 
    (SELECT COUNT(attrition) FROM hrdata
	WHERE attrition = 'Yes' AND gender = 'male') AS active_emp
FROM hrdata
WHERE gender = 'male';



-- Average Age of All Employees
SELECT ROUND(AVG(age), 0) AS avg_age FROM hrdata;



-- Attrition Count by Gender
SELECT gender, COUNT(attrition)from hrdata 
WHERE attrition = 'Yes'
GROUP BY gender
ORDER BY Count(attrition) DESC;

-- Attrition Count by Gender for High School Employees
SELECT gender, COUNT(attrition)from hrdata 
WHERE attrition = 'Yes' AND education = 'High School'
GROUP BY gender
ORDER BY Count(attrition) DESC;



-- Department wise Attrition Count
SELECT department, COUNT(attrition) FROM hrdata
WHERE attrition  = 'Yes'
GROUP BY department;

-- Department-wise Attrition Count and Attrition Rate
SELECT 
	department, 
    COUNT(attrition) AS attrition_count, 
    (COUNT(attrition) / 
        (SELECT COUNT(attrition) 
        FROM hrdata 
        WHERE attrition = 'YES'))*100 AS dept_attrition_rate 
FROM hrdata
WHERE attrition  = 'Yes'
GROUP BY department;


-- Total no. of Employees with different age_bands
SELECT age_band, SUM(employee_count) FROM hrdata
GROUP BY age_band;

-- Total no. of Employees of 'R&D Dept' with different 'age_bands'  
SELECT age_band, SUM(employee_count) FROM hrdata
WHERE department = 'R&D'
GROUP BY age_band;



-- Attrition Count of Employees for different 'education_field'
SELECT education_field, COUNT(attrition) from hrdata
WHERE attrition = 'Yes'
GROUP BY education_field
ORDER BY COUNT(attrition) DESC;

-- Attrition Count of Employees for different 'education_field' Where department is 'Sales'
SELECT education_field, COUNT(attrition) from hrdata
WHERE attrition = 'Yes' AND department = 'Sales'
GROUP BY education_field
ORDER BY COUNT(attrition) DESC;



-- Attrition Count and Attrition Rate by for different age_bands and gender
SELECT age_band, gender, COUNT(attrition),
(COUNT(attrition) / (SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes'))*100
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY age_band, gender
ORDER BY COUNT(attrition) DESC;

