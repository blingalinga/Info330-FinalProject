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