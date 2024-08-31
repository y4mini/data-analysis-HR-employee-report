CREATE DATABASE projects;
USE projects;
SELECT * FROM hr;
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

/*change data types for all columns*/
DESCRIBE hr;
SELECT birthdate FROM hr;
SET sql_safe_updates=0;
UPDATE hr
SET birthdate=CASE
 WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
 WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
 ELSE NULL
END;
/*we have change the format now we can change data type to datetime*/
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;
UPDATE hr
SET hire_date=CASE
 WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
 WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
 ELSE NULL
END;
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;
/*time also mentioned in termdate so we remove it*/
UPDATE hr
SET termdate=IF(termdate IS NOT NULL AND termdate!='',date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
WHERE TRUE;
SELECT termdate from hr;
SET sql_mode='ALLOW_INVALID_DATES';
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

/*add age column*/
ALTER TABLE hr
ADD COLUMN age INT;
/*calulate age from birthdate using timestampdiff*/
UPDATE HR
SET age=timestampdiff(YEAR,birthdate,curdate());
SELECT birthdate,age FROM hr;

/*youngest and oldest values*/
SELECT
min(age) AS youngest,
max(age) AS oldest
FROM hr;

