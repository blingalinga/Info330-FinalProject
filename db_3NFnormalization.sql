--Pull out names and genres into a table
CREATE TABLE genres AS
SELECT names, genre
FROM firstnf_movie_data;

--Creates a table of abilities sorted into separate columns with pokedex_number as primary key
CREATE TABLE genres_cleaned AS
SELECT names,
  MAX(CASE WHEN genre_num = 1 THEN genre ELSE NULL END) AS genre_1,
  MAX(CASE WHEN genre_num = 2 THEN genre ELSE NULL END) AS genre_2,
  MAX(CASE WHEN genre_num = 3 THEN genre ELSE NULL END) AS genre_3,
  MAX(CASE WHEN genre_num = 4 THEN genre ELSE NULL END) AS genre_4
FROM (
  SELECT names,
    genre,
    ROW_NUMBER() OVER (PARTITION BY names ORDER BY genre) AS genre_num
  FROM genres
) subquery
GROUP BY names;

-- Remove tables that are no longer needed and rename genres_cleaned to genres
DROP TABLE genres;

ALTER TABLE genres_cleaned RENAME TO genres;

--Third NF Table with genres separated out
CREATE TABLE second_temp as
SELECT * FROM firstnf_movie_data;

ALTER TABLE second_temp
DROP COLUMN genre;

--Get rid of duplicates of the same name
CREATE TABLE temp_table AS
SELECT DISTINCT *
FROM second_temp;

--Rename the temp_table and drop tables that we do not need anymore
ALTER TABLE temp_table RENAME TO thirdnf_movie_data;

DROP TABLE second_temp;