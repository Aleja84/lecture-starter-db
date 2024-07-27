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
        'Last name', p.lastName,
        'Photo', JSON_OBJECT(
            'fileName', fp.fileName,
            'mimeType', fp.mimeType,
            'keyFile', fp.keyFile,
            'url', fp.url
        )
    ) AS 'Director',
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'ID', a.idPerson,
            'First name', a.firstName,
            'Last name', a.lastName,
            'Photo', JSON_OBJECT(
                'fileName', af.fileName,
                'mimeType', af.mimeType,
                'keyFile', af.keyFile,
                'url', af.url
            )
        )
    ) AS 'Actors',
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'ID', g.idGenre,
            'Name', g.name
        )
    ) AS 'Genres'
FROM
    movies_db.movie m
JOIN
    movies_db.files f ON m.files_idFiles = f.idFiles
JOIN
    movies_db.director d ON m.director_idDirector = d.idDirector
JOIN
    movies_db.person p ON d.person_idPerson = p.idPerson
LEFT JOIN
    movies_db.files fp ON p.idPerson = fp.person_idPerson AND fp.mimeType = 'photo'
LEFT JOIN
    movies_db.MovieCharacter mc ON m.idMovie = mc.movie_idMovie
LEFT JOIN
    movies_db.person a ON mc.character_idCharacter = a.idPerson
LEFT JOIN
    movies_db.files af ON a.idPerson = af.person_idPerson AND af.mimeType = 'photo'
LEFT JOIN
    movies_db.MovieGenre mg ON m.idMovie = mg.movie_idMovie
LEFT JOIN
    movies_db.genre g ON mg.genre_idGenre = g.idGenre
WHERE
    m.idMovie = 1
GROUP BY
    m.idMovie, m.title, m.releaseDate, m.duration, m.description, f.fileName, f.mimeType, f.keyFile, f.url, d.idDirector, p.firstName, p.lastName, fp.fileName, fp.mimeType, fp.keyFile, fp.url;