create table firstnf AS
WITH split(names, genre, nextgenre) AS (
    select names, '' as genre, genre||',' as nextgenre
    from imported_movie_data
    union all
        select names,
            substr(nextgenre, 0, instr(nextgenre, ',')) as genre,
            substr(nextgenre, instr(nextgenre, ',')+1) as nextgenre
        from split
        where nextgenre !=''
)
select names, genre
from split
where genre !=''
order by names;

-- creates a temp table with all data from the original data (imported_pokemon_data)
-- and drops the abilities column to avoid duplication during the join
create table first_temp as
select * from imported_movie_data;

alter table first_temp
drop column genre;

-- creates the final 1NF pokemon data table using our recursively broken down table
-- (firstnf) and temp table (first_temp)
create table firstnf_movie_data AS
select firstnf.*, first_temp.*
from firstnf
join first_temp on first_temp.names=firstnf.names;

alter table firstnf_movie_data
drop column 'names:1';

-- -- drops the temporary tables we do not need anymore, leaving the 1NF table
-- drop table imported_movie_data;
-- drop table firstnf;
-- drop table first_temp;