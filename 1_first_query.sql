use movies_db;

SELECT
    p.idPerson AS ID,
    p.firstName AS 'First name',
    p.lastName AS 'Last name',
    SUM(m.budget) AS 'Total movies budget'
FROM
    movies_db.person p
JOIN
    movies_db.character c ON p.idPerson = c.person_idPerson
JOIN
    movies_db.movieCharacter mc ON c.idCharacter = mc.character_idCharacter
JOIN
    movies_db.movie m ON mc.movie_idMovie = m.idMovie
GROUP BY
    p.idPerson, p.firstName, p.lastName
ORDER BY
    'Total movies budget' DESC;