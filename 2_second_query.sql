use movies_db;

SELECT
    m.idMovie AS ID,
    m.title AS Title,
    COUNT(mc.character_idCharacter) AS 'Actors count'
FROM
    movies_db.movie m
JOIN
    movies_db.movieCharacter mc ON m.idMovie = mc.movie_idMovie
JOIN
    movies_db.character c ON mc.character_idCharacter = c.idCharacter
WHERE
    m.releaseDate >= CURDATE() - INTERVAL 5 YEAR
GROUP BY
    m.idMovie, m.title
ORDER BY
    m.releaseDate DESC;