-- first rename billionaires-by-country-2024 to something else to avoid "-" syntax error

-- 1.	Show the top 10 countries by Billionaires Total Net Worth 2023
SELECT country, BillionairesTotalNetWorth2023
FROM billionaires_by_country_2024
ORDER BY BillionairesTotalNetWorth2023 DESC
LIMIT 10;
-- strange error where first digit value is being prioritized over total value, ex. 8.8 > 74.4 or 669.2

-- 2.	What is the average population growth rate by region?
SELECT region, AVG(Population_growthRate)
FROM billionaires_by_country_2024
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

-- 5.	Of those countries how many are UN Members?
WITH CountryRanking AS (
SELECT row_number() OVER (ORDER BY BillionairesPerMillionPeople2023 DESC) AS CountryRank, country, BillionairesPerMillionPeople2023, unMember
FROM billionaires_by_country_2024
)
SELECT CountryRank, country, BillionairesPerMillionPeople2023, unMember
FROM CountryRanking
WHERE CountryRank BETWEEN 40 AND 60 AND unMember = TRUE
ORDER BY CountryRank;

