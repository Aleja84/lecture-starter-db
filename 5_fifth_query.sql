use movies_db;

SELECT
    m.idMovie AS 'ID',
    m.title AS 'Title',
    m.releaseDate AS 'Release date',
    m.duration AS 'Duration',
    m.description AS 'Description',
    JSON_OBJECT(
        'fileName', f.fileName,
        'mimeType', f.mimeType,
        'keyFile', f.keyFile,
        'url', f.url
    ) AS 'Poster',
    JSON_OBJECT(
        'ID', d.idDirector,
        'First name', p.firstName,
        'Last name', p.lastName
    ) AS 'Director'
FROM
    movies_db.movie m
JOIN
    movies_db.country c ON m.country_idCountry = c.idCountry
JOIN
    movies_db.files f ON m.files_idFiles = f.idFiles
JOIN
    movies_db.director d ON m.director_idDirector = d.idDirector
JOIN
    movies_db.person p ON d.person_idPerson = p.idPerson
JOIN
    movies_db.MovieGenre mg ON m.idMovie = mg.movie_idMovie
JOIN
    movies_db.genre g ON mg.genre_idGenre = g.idGenre
WHERE
    c.idCountry = 1
    AND m.releaseDate >= '2022-01-01'
    AND m.duration > 135
    AND g.name IN ('Action', 'Drama')
GROUP BY
    m.idMovie, m.title, m.releaseDate, m.duration, m.description, f.fileName, f.mimeType, f.keyFile, f.url, d.idDirector, p.firstName, p.lastName;