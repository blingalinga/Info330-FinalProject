--Ling Ling's Queries

--Query 1: Selecting the average rating out and sorting by country, ordered from highest to lowest rating
SELECT country, AVG(score)
FROM thirdnf_movie_data
GROUP BY country
ORDER BY AVG(score) DESC;

--Query 2: Retrieves the top 10 movies with their release dates, associated genres, and average ratings
SELECT m.names, m.date_x, g.genre_1, genre_2, genre_3, genre_4, AVG(m.score) AS average_rating
FROM thirdnf_movie_data AS m
JOIN genres AS g ON m.names = g.names
GROUP BY m.names
ORDER BY average_rating DESC
LIMIT 10;

-- Angie's Queries
--Query 1： Calculates the average ratings of movies based on their production budget
SELECT budget_range, AVG(score) as average_rating
from(
	SELECT
		CASE
			WHEN budget_x >= '0' AND budget_x < '1000000' THEN '0-1M'
			WHEN budget_x >= '1000000' AND budget_x < '10000000' THEN '1M-10M'
			WHEN budget_x >= '10000000' AND budget_x < '50000000' THEN '10M-50M'
			WHEN budget_x >= '50000000' AND budget_x < '75000000' THEN '50M-75M'
			WHEN budget_x >= '75000000' AND budget_x < '100000000' THEN '75M-100M'
			ELSE 'More than 100M'
		END AS budget_range,
		score
	FROM thirdnf_movie_data
) AS subquery
group by budget_range
order by budget_range;

-- Query 2: Calculates the proportion of movies genres released each year
SELECT genre, release_year, COUNT(*) AS movie_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY release_year), 2) AS proportion
FROM (
    SELECT g.names, g.genre_1 AS genre, SUBSTR(m.date_x, -5) AS release_year
    FROM genres g
    JOIN thirdnf_movie_data m ON g.names = m.names
    WHERE g.genre_1 IS NOT NULL
    UNION ALL
    SELECT g.names, g.genre_2 AS genre, SUBSTR(m.date_x, -5) AS release_year
    FROM genres g
    JOIN thirdnf_movie_data m ON g.names = m.names
    WHERE g.genre_2 IS NOT NULL
    UNION ALL
    SELECT g.names, g.genre_3 AS genre, SUBSTR(m.date_x, -5) AS release_year
    FROM genres g
    JOIN thirdnf_movie_data m ON g.names = m.names
    WHERE g.genre_3 IS NOT NULL
    UNION ALL
    SELECT g.names, g.genre_4 AS genre, SUBSTR(m.date_x, -5) AS release_year
    FROM genres g
    JOIN thirdnf_movie_data m ON g.names = m.names
    WHERE g.genre_4 IS NOT NULL
) AS subquery
GROUP BY genre, release_year
ORDER BY release_year, genre;

-- bernita's queries
-- query 1: Determine which movies are originally released in languages other than English:
SELECT m.names
FROM thirdnf_movie_data AS m
WHERE orig_lang <> 'English'
GROUP BY orig_lang;

-- query2: Identify movies released within the current year (2023), and see what the top 10 movies were based on user rating:
SELECT m.names, AVG(score)
FROM thirdnf_movie_data AS m
WHERE date_x LIKE '%2023%'
GROUP BY m.names
ORDER BY AVG(score) DESC
LIMIT 10;

--Thomas's Queries

--Query 1: Counting the Number of Movies by Country
SELECT country, COUNT(*) AS movie_count
FROM thirdnf_movie_data
GROUP BY country
ORDER BY movie_count DESC;

--Query 2: identify dominant genres for each country in the Dataset
SELECT country, dominant_genres
FROM (
    SELECT m.country, g.genre_1 AS dominant_genres,
           ROW_NUMBER() OVER (PARTITION BY m.country ORDER BY COUNT(*) DESC) AS rn
    FROM thirdnf_movie_data AS m
    JOIN genres AS g ON m.names = g.names
    GROUP BY m.country, g.genre_1
) AS sub
WHERE rn = 1
ORDER BY country;