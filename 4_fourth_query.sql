use movies_db;

SELECT
    d.idDirector AS 'Director ID',
    CONCAT(p.firstName, ' ', p.lastName) AS 'Director name',
    AVG(m.budget) AS 'Average budget'
FROM
    movies_db.director d
JOIN
    movies_db.person p ON d.person_idPerson = p.idPerson
JOIN
    movies_db.movie m ON d.idDirector = m.director_idDirector
GROUP BY
    d.idDirector, p.firstName, p.lastName
ORDER BY
    d.idDirector;