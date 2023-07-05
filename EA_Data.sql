SELECT * FROM ea;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

ALTER TABLE ea 
CHANGE COLUMN ï»¿Age Age INT NULL;

-- Find the details of the employees under attrition having 5+ years of experience in between the age group of 27-35.

SELECT * FROM ea
WHERE Attrition = 'Yes' AND TotalWorkingYears>=5 AND Age BETWEEN 27 AND 35;


-- Find the details of the employees having maximum and minimum of salary working in different department and who have received less than 13% hike.

SELECT Department,
	min(MonthlyIncome) AS Lowest_Salary,
    max(MonthlyIncome) AS Highest_Salary
FROM ea
WHERE  PercentSalaryHike <13
GROUP BY Department;

-- Calculate the average monthly income of all employees who worked more than 3 years and who's education background in Medical

SELECT avg(MonthlyIncome)
FROM ea 
WHERE YearsAtCompany > 3 AND EducationField= 'Medical';

-- Identify the total number of male and female employee under attrition whose marital status is married and haven't received promotion in the last 2 years.

SELECT Gender,
	count(EmployeeNumber),
	YearsInCurrentRole
FROM ea
WHERE MaritalStatus = 'Married' AND YearsInCurrentRole = 2 AND Attrition = 'Yes'
GROUP BY Gender;

-- Find the employee with the highest performance rating but no promotion in the last 4 years and above

SELECT *
FROM ea
WHERE PerformanceRating= (SELECT max(PerformanceRating) FROM ea) AND YearsSinceLastPromotion >=4;

--  Who has the highest and lowest percentage salary hike?

SELECT YearsAtCompany, PerformanceRating, YearsSinceLastPromotion,
max(PercentSalaryHike), min(PercentSalaryHike)
FROM ea 
GROUP BY YearsAtCompany, PerformanceRating, YearsSinceLastPromotion
ORDER BY max(PercentSalaryHike) DESC, min(PercentSalaryHike) ASC;


-- Employee working overtime but given min salary hike and are more than 5 years working in the company

SELECT *
FROM ea
WHERE PercentSalaryHike = (SELECT min(PercentSalaryHike) FROM ea) AND OverTime = 'Yes' AND YearsAtCompany > 5;



