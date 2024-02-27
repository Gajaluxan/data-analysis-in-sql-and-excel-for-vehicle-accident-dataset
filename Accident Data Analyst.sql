use VhclAcc;
select * from [dbo].[accident];
select * from [dbo].[vehicle];

--QUES-01--
SELECT [Area], COUNT([AccidentIndex]) AS 'Total Accident'
FROM [dbo].[accident]
GROUP BY [Area];
--QUES-01--

--QUES-02--
SELECT [Day], COUNT([AccidentIndex]) AS 'Total Accident'
FROM [dbo].[accident]
GROUP BY [Day]
ORDER BY 'Total Accident' DESC;
--QUES-02--

--QUES-03--
ALTER TABLE [dbo].[vehicle]
ALTER COLUMN [AgeVehicle] TINYINT;

UPDATE [dbo].[vehicle] 
SET [AgeVehicle] = NULL
WHERE [AgeVehicle] = 0;


SELECT [VehicleType], COUNT([AccidentIndex]) AS 'Total Accident', AVG([AgeVehicle]) AS 'Average Year'
FROM [dbo].[vehicle]
WHERE [AgeVehicle] IS NOT NULL
GROUP BY [VehicleType]
ORDER BY 'Total Accident' DESC;
--QUES-03--

--QUES-04--
SELECT  AgeGroup, COUNT([AccidentIndex]) AS 'Total Accident', AVG([AgeVehicle]) AS 'Average Year'
FROM (
	SELECT
		[AccidentIndex],
		[AgeVehicle],
		CASE 
			WHEN [AgeVehicle] BETWEEN 0 AND 5 THEN 'New'
			WHEN [AgeVehicle] BETWEEN 6 AND 10 THEN 'Regular'
			ELSE 'Old'
		END AS 'AgeGroup' FROM [dbo].[vehicle]
) AS SUBQUERY
GROUP BY AgeGroup;
--QUES-04--

--QUES-05--
SELECT  [WeatherConditions], COUNT([Severity]) AS 'Total Accident'
FROM [dbo].[accident]
GROUP BY [WeatherConditions]
ORDER BY 'Total Accident' DESC;

DECLARE @Severity VARCHAR (100)
SET @Severity = 'Slight'

SELECT  [WeatherConditions], COUNT([Severity]) AS 'Total Accident'
FROM [dbo].[accident]
WHERE [Severity] = @Severity
GROUP BY [WeatherConditions]
ORDER BY 'Total Accident' DESC;
--QUES-05--

--QUES-06--
SELECT [LeftHand], COUNT([AccidentIndex]) AS 'Total Accident'
FROM [dbo].[vehicle] 
GROUP BY [LeftHand]
HAVING [LeftHand] IS NOT NULL;
--QUES-06--

--QUES-07--
SELECT V.[JourneyPurpose], COUNT(A.[Severity]) AS 'Total Accident',
		CASE
			WHEN COUNT(A.[Severity]) BETWEEN 0 AND 1000 THEN 'Low'
			WHEN COUNT(A.[Severity]) BETWEEN 1001 AND 3000 THEN 'Moderate'
			ELSE 'High'
		END AS 'Level'
FROM [dbo].[accident] AS A
JOIN [dbo].[vehicle] AS V 
ON V.[AccidentIndex] = A.[AccidentIndex]
GROUP BY V.[JourneyPurpose]
ORDER BY 'Total Accident' DESC;
--QUES-07--

--QUES-08--
SELECT A.[LightConditions], V.[PointImpact], AVG(V.[AgeVehicle]) AS 'Average Year'
FROM [dbo].[accident] AS A
JOIN [dbo].[vehicle] AS V 
ON V.[AccidentIndex] = A.[AccidentIndex]
GROUP BY A.[LightConditions], V.[PointImpact]
--HAVING [PointImpact] = 'Front' AND [LightConditions] = 'Daylight';

DECLARE @P_Impact VARCHAR(100)
DECLARE @L_Conditions VARCHAR(100)

SET @P_Impact = 'Front'
SET  @L_Conditions = 'Darkness'

SELECT A.[LightConditions], V.[PointImpact], AVG(V.[AgeVehicle]) AS 'Average Year'
FROM [dbo].[accident] AS A
JOIN [dbo].[vehicle] AS V 
ON V.[AccidentIndex] = A.[AccidentIndex]
GROUP BY A.[LightConditions], V.[PointImpact]
HAVING [PointImpact] = @P_Impact AND [LightConditions] =  @L_Conditions;
--QUES-08--


