use movies_db;

/* Retrieve all movies in the Database */
SELECT * FROM movies;

/* Find all actors in a specific movie */
SELECT a.firstname, a.lastname
FROM actors a
JOIN actor_to_movies am ON a.id = am.actor_id
JOIN movies m ON am.movie_id = m.id
WHERE m.title = 'Ipsum ut fugit harum dolorem qui quisquam.';

/*List all movies released in a specific year */
SELECT m.id, m.title
FROM movies m
WHERE m.release_year = 2017;

/* Show all user ratings for a given movie */
SELECT r.rating, u.firstname, u.lastname
FROM ratings r
JOIN users u ON r.user_id = u.id
JOIN movies m ON r.movie_id = m.id
WHERE m.id = 5;

/* List all movies along with their directors */
SELECT m.id, m.title, d.firstname, d.lastname
FROM movies m
JOIN directors d ON m.director_id = d.id;

/* Find all actors who appeared in a specific movie */
SELECT a.id, a.firstname, a.lastname
FROM actors a
JOIN actor_to_movies am ON am.actor_id = a.id
JOIN movies m ON am.movie_id = m.id
WHERE m.id = 8;

/* Show movies along with their genres */
SELECT m.id, m.title, g.name
FROM movies m
JOIN movie_to_genre mg ON mg.movie_id = m.id
JOIN genres g ON mg.genre_id = g.id;

/* Retrieve user ratings along with the corresponding movie titles */
SELECT r.rating, u.firstname, u.lastname, m.id, m.title
FROM ratings r
JOIN users u ON r.user_id = u.id
JOIN movies m ON r.movie_id = m.id;

/* Count how many movies each director has directed */
SELECT d.id, d.firstname, d.lastname, COUNT(m.id)
FROM directors d
JOIN movies m ON d.id = m.director_id
GROUP BY d.id;

/* Find how many movies belong to each genre */
SELECT g.id, g.name, COUNT(m.id)
FROM genres g
JOIN movie_to_genre mg ON g.id = mg.genre_id
JOIN movies m ON m.id = mg.movie_id
GROUP BY g.id;

/* Count the number of user ratings for each movie */
SELECT m.id, m.title, COUNT(r.movie_id)
FROM movies m
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id;

/* Determine how many movies an actor has appeared in */
SELECT a.id, a.firstname, a.lastname, COUNT(am.movie_id)
FROM actors a
JOIN actor_to_movies am ON a.id = am.actor_id
GROUP BY a.id;

/* Calculate the average rating for each movie */
SELECT m.id, m.title, AVG(r.rating)
FROM ratings r
JOIN movies m ON r.movie_id = m.id
GROUP BY m.id;

/* Find the average rating of movies directed by a specific director */
SELECT d.id, d.firstname, d.lastname, COUNT(m.id), AVG(r.rating)
FROM directors d
JOIN movies m ON d.id = m.director_id
JOIN ratings r ON m.id = r.movie_id
WHERE d.id = 2
GROUP BY d.id;

/* Show the average rating for movies in a specific genre */
SELECT g.id, g.name, COUNT(m.id), AVG(r.rating)
FROM genres g
JOIN movie_to_genre mg ON g.id = mg.genre_id
JOIN movies m ON mg.movie_id = m.id
JOIN ratings r ON m.id = r.movie_id
WHERE g.id = 2
GROUP BY g.id;

/* List the number of movies per genre. */
SELECT g.id, g.name, COUNT(mg.movie_id)
FROM genres g
JOIN movie_to_genre mg ON g.id = mg.genre_id
GROUP BY g.id;

/* Show the number of movies each actor has appeared in */
SELECT a.id, a.firstname, a.lastname, COUNT(am.movie_id)
FROM actors a
JOIN actor_to_movies am ON a.id = am.actor_id
GROUP BY a.id;

/* Display the average rating for each director's movies */
SELECT d.id, d.firstname, d.lastname, COUNT(m.id), AVG(r.rating)
FROM directors d
JOIN movies m ON d.id = m.director_id
JOIN ratings r ON m.id = r.movie_id
GROUP BY d.id;

/* Count the total ratings received by each movie */
SELECT m.id, m.title, SUM(r.rating)
FROM movies m
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id;

/* Find movies that have an average rating greater than 4.0 */
SELECT m.id, m.title, AVG(r.rating)
FROM movies m
JOIN ratings r ON m.id = r.movie_id
GROUP BY m.id
HAVING AVG(r.rating) > 4.0;

/* List directors who have directed more than three movies */
SELECT d.id, d.firstname, d.lastname, COUNT(m.id)
FROM directors d
JOIN movies m ON d.id = m.director_id
GROUP BY d.id
HAVING COUNT(m.id) > 3;

/* Show genres that contain at least three movies */
SELECT g.id, g.name, COUNT(mg.movie_id)
FROM genres g
JOIN movie_to_genre mg ON g.id = mg.genre_id
GROUP BY g.id
HAVING COUNT(mg.movie_id) >= 3;

/* Retrieve actors who have appeared in more that three movies */
SELECT a.id, a.firstname, a.lastname, COUNT(am.movie_id)
FROM actors a
JOIN actor_to_movies am ON a.id = am.actor_id
GROUP BY a.id
HAVING COUNT(am.movie_id) > 3;