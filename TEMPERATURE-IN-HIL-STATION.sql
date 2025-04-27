-- Q1;
Create Database Sql_Assignment;

Use Sql_Assignment;

Create Table STATION(
ID  int Primary Key,
CITY char(20),
STATE char(20),
LAT_N int,
LONG_N int);

Alter Table STATION
Rename Column LONG_N TO LONG_W;

-- Q2;
Insert Into STATION(ID, CITY, STATE, LAT_N,LONG_W)
 Values (13, "PHOENIX", "AZ", 33, 112),
 (44, "DENVER", "CO", 40, 105),
 (66, "CARIBOU", "ME", 47, 68);

--  Q3;
Select * From STATION;

--  Q4;
Select * From STATION Where LAT_N > 39.7;

--  Q5;
Create Table STATS(
ID Int,
MONTH Int Check (Month Between 1 and 12),
TEMP_F Int Check (TEMP_F Between -80 and 150),
RAIN_I Int Check (RAIN_I Between 0 and 100),
Primary Key (ID,MONTH),
Foreign Key (ID) References STATION (ID));

--  Q6 ;
Insert Into STATS(ID, MONTH, TEMP_F, RAIN_I)
 Values (13, 1, 57.4, 0.31),
 (13, 7, 91.7, 5.15),
 (44, 1, 27.3, 0.18),
 (44, 7, 74.8, 2.11),
 (66, 1, 6.7, 2.1),
 (66, 7, 65.8, 4.52);

Alter Table STATS
Modify TEMP_F Float Check (TEMP_F Between -80 and 150),
Modify RAIN_I Decimal(5,2) Check (RAIN_I BETWEEN 0 AND 100);

--  Q7 ;
Select STATION.CITY, 
STATS.TEMP_F From STATS
Join STATION ON STATS.ID = STATION.ID;

-- Q8 ;
Select STATION.CITY,
STATS.TEMP_F, 
STATS.RAIN_I, 
STATS.MONTH From STATS
Join STATION ON STATS.ID = STATION.ID
Order by STATS.RAIN_I DESC;

-- Q9 ;
Select STATION.CITY, 
STATION.LAT_N, 
STATS.MONTH, 
STATS.TEMP_F FROM STATS
Join STATION ON STATS.ID = STATION.ID
Where STATS.MONTH = 7
Order BY STATS.TEMP_F ASC;

-- Q10 ;
Select STATION.CITY,
MAX(STATS.TEMP_F) AS Max_Temp,
MIN(STATS.TEMP_F) AS Min_Temp,
AVG(STATS.RAIN_I) AS Avg_Rainfall
From STATS
Join STATION ON STATS.ID = STATION.ID
Group BY STATION.CITY;

-- Q11 ;
SELECT CITY, MONTH, 
ROUND((TEMP_F - 32) * 5 / 9, 1) AS TEMP_C, 
ROUND(STATS.RAIN_I * 2.54, 2) AS RAIN_CM
FROM STATS
JOIN STATION ON STATS.ID = STATION.ID;

-- Q12 ;
SET SQL_SAFE_UPDATES = 0;

Update STATS
SET RAIN_I = RAIN_I + 0.01;

SET SQL_SAFE_UPDATES = 1;

-- Q13 ;
UPDATE STATS
SET TEMP_F = 74.9
Where ID = (Select ID From STATION Where CITY = 'DENVER')AND MONTH = 7;

SELECT STATION.CITY, STATS.MONTH, STATS.TEMP_F
FROM STATS
JOIN STATION ON STATS.ID = STATION.ID
WHERE STATION.CITY = 'DENVER' AND STATS.MONTH = 7;



















