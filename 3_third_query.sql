use movies_db;

SELECT
    u.idUser AS ID,
    u.username AS Username,
    GROUP_CONCAT(fm.movie_idMovie ORDER BY fm.movie_idMovie ASC) AS 'Favorite movie IDs'
FROM
    movies_db.user u
LEFT JOIN
    movies_db.favoriteMovies fm ON u.idUser = fm.user_idUser
GROUP BY
    u.idUser, u.username
ORDER BY
    u.idUser;