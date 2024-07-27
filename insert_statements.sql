-- -----------------------------------------------------
-- Insert into `timestamps`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`timestamps` (`createdAt`, `updatedAt`) VALUES
('2023-01-01 00:00:00', NULL),
('2023-02-01 00:00:00', NULL),
('2023-03-01 00:00:00', NULL),
('2023-04-01 00:00:00', NULL);

-- -----------------------------------------------------
-- Insert into `country`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`country` (`nameCountry`, `timestamps_idTimestamps`) VALUES
('USA', 1),
('Canada', 2),
('UK', 3),
('France', 4);

-- -----------------------------------------------------
-- Insert into `person`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`person` (`firstName`, `lastName`, `dateOfBirth`, `gender`, `country_idCountry`, `timestamps_idTimestamps`, `biography`) VALUES
('John', 'Doe', '1980-01-01', b'1', 1, 1, 'An accomplished actor known for his versatility.'),
('Jane', 'Smith', '1990-02-01', b'0', 2, 2, 'A renowned actress with numerous awards.'),
('Alice', 'Johnson', '1975-03-01', b'0', 3, 3, 'A talented director and producer.'),
('Bob', 'Brown', '1985-04-01', b'1', 4, 4, 'A skilled writer and screenwriter.');

-- -----------------------------------------------------
-- Insert into `files`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`files` (`fileName`, `mimeType`, `keyFile`, `url`, `timestamps_idTimestamps`, `person_idPerson`) VALUES
('profile1.jpg', 'image/jpeg', 'file_key_1', 'http://example.com/file1.jpg', 1, 1),
('profile2.jpg', 'image/jpeg', 'file_key_2', 'http://example.com/file2.jpg', 2, 2),
('profile3.jpg', 'image/jpeg', 'file_key_3', 'http://example.com/file3.jpg', 3, 3),
('profile4.jpg', 'image/jpeg', 'file_key_4', 'http://example.com/file4.jpg', 4, 4);

-- -----------------------------------------------------
-- Insert into `user`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`user` (`username`, `email`, `password`, `timestamps_idTimestamps`, `files_idFiles`, `firstName`, `lastName`) VALUES
('johndoe', 'johndoe@example.com', 'password1', 1, 1, 'John', 'Doe'),
('janesmith', 'janesmith@example.com', 'password2', 2, 2, 'Jane', 'Smith'),
('alicejohnson', 'alicejohnson@example.com', 'password3', 3, 3, 'Alice', 'Johnson'),
('bobbrown', 'bobbrown@example.com', 'password4', 4, 4, 'Bob', 'Brown');

-- -----------------------------------------------------
-- Insert into `director`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`director` (`person_idPerson`, `timestamps_idTimestamps`) VALUES
(3, 1),
(4, 2),
(1, 3),
(2, 4);

-- -----------------------------------------------------
-- Insert into `character`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`character` (`name`, `description`, `role`, `timestamps_idTimestamps`, `person_idPerson`) VALUES
('Character A', 'Main protagonist', 'leading', 1, 1),
('Character B', 'Supporting character', 'supporting', 2, 2),
('Character C', 'Background character', 'background', 3, 3),
('Character D', 'Antagonist', 'leading', 4, 4);

-- -----------------------------------------------------
-- Insert into `movie`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`movie` (`title`, `description`, `budget`, `releaseDate`, `duration`, `timestamps_idTimestamps`, `files_idFiles`, `director_idDirector`, `country_idCountry`) VALUES
('Movie 1', 'An exciting adventure', 1000000.00, '2023-05-01', 155, 1, 1, 1, 1),
('Movie 2', 'A dramatic tale', 2000000.00, '2023-06-01', 90, 2, 2, 2, 2),
('Movie 3', 'A comedic escapade', 1500000.00, '2023-07-01', 110, 3, 3, 3, 3),
('Movie 4', 'A thrilling mystery', 1800000.00, '2023-08-01', 105, 4, 4, 4, 4);

-- -----------------------------------------------------
-- Insert into `genre`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`genre` (`name`, `timestamps_idTimestamps`) VALUES
('Action', 1),
('Drama', 2),
('Comedy', 3),
('Thriller', 4);

-- -----------------------------------------------------
-- Insert into `MovieGenre`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`MovieGenre` (`movie_idMovie`, `genre_idGenre`, `timestamps_idTimestamps`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4);

-- -----------------------------------------------------
-- Insert into `movieCharacter`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`movieCharacter` (`movie_idMovie`, `character_idCharacter`, `timestamps_idTimestamps`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4);

-- -----------------------------------------------------
-- Insert into `favoriteMovies`
-- -----------------------------------------------------
INSERT INTO `movies_db`.`favoriteMovies` (`movie_idMovie`, `user_idUser`, `timestamps_idTimestamps`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4);