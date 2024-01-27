-- first rename billionaires-by-country-2024 to something else to avoid "-" syntax error

-- 1.	Show the top 10 countries by Billionaires Total Net Worth 2023
SELECT country, CAST (BillionairesTotalNetWorth2023 AS INT)
FROM billionaires_by_country_2024
ORDER BY CAST(BillionairesTotalNetWorth2023 AS INT) DESC
LIMIT 10;
-- strange error where first digit value is being prioritized over total value, ex. 8.8 > 74.4 or 669.2
-- CAST fixes type change from text to integer 

-- 2.	What is the average population growth rate by region?
SELECT region, AVG(Population_growthRate)
FROM billionaires_by_country_2024
WHERE region is not NULL
GROUP BY region;

-- 3.	Create a ranking of the countries by Billionaires Per Million People 2023 (the country with the highest value would be 1)
SELECT row_number() OVER (ORDER BY BillionairesPerMillionPeople2023 DESC) AS CountryRank, country, BillionairesPerMillionPeople2023
FROM billionaires_by_country_2024
ORDER BY CountryRank;

-- 4.	Using the rank show the countries with rank 40-60
WITH CountryRanking AS (
SELECT row_number() OVER (ORDER BY BillionairesPerMillionPeople2023 DESC) AS CountryRank, country, BillionairesPerMillionPeople2023
FROM billionaires_by_country_2024
)
SELECT CountryRank, country, BillionairesPerMillionPeople2023
FROM CountryRanking
WHERE CountryRank BETWEEN 40 AND 60
ORDER BY CountryRank;
-- next time title temp table as ranked_table or something like that

-- 5.	Of those countries how many are UN Members?
WITH CountryRanking AS (
SELECT row_number() OVER (ORDER BY BillionairesPerMillionPeople2023 DESC) AS CountryRank, country, BillionairesPerMillionPeople2023, unMember
FROM billionaires_by_country_2024
)
SELECT CountryRank, country, BillionairesPerMillionPeople2023, unMember
FROM CountryRanking
WHERE CountryRank BETWEEN 40 AND 60 AND unMember = "TRUE"
ORDER BY CountryRank;
--not showing results, something wrong with code
-- fix is to use " " around TRUE

-- if running into Null issues, use safe cast or say Null = 0

-- BillionairesTotalNetWorth2023/BillionairesRichestNetWorth2023
SELECT country, Round(BillionairesRichestNetWorth2023/CAST(BillionairesTotalNetWorth2023 AS INT),3) AS "%"
FROM billionaires_by_country_2024
;

--BillionairesTotalNetWorth2023/count of countries
SELECT Round(SUM(CAST(BillionairesTotalNetWorth2023 AS INT))/Count(DISTINCT country),3) AS "$_per_country"
FROM billionaires_by_country_2024
;
-- clearer
SELECT SUM(CAST(BillionairesTotalNetWorth2023 AS INT)) AS "Total_Net_Worth_All_Countries", Count(DISTINCT country) AS "count_of_country"
FROM billionaires_by_country_2024
;

--
SELECT BillionairesRichestBillionaire2023, row_number() OVER (PARTITION BY region ORDER BY BillionairesPerMillionPeople2023 DESC) AS CountryRank, region, BillionairesPerMillionPeople2023
FROM billionaires_by_country_2024
WHERE region IN("North America", "South America")
ORDER BY region;

--
SELECT BillionairesRichestBillionaire2023, row_number() OVER (PARTITION BY region ORDER BY BillionairesPerMillionPeople2023 DESC) AS CountryRank, region, BillionairesPerMillionPeople2023
FROM billionaires_by_country_2024
WHERE region IN("North America", "South America")
ORDER BY region;