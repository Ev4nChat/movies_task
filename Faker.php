<?php

use Faker\Factory;

require_once 'vendor/autoload.php';

$faker = Factory::create();

$pdo = new PDO('mysql:host=db;dbname=movies_db', 'root', 'root');

// Ensure PDO throws exceptions for errors
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

$directors = [];
$actors = [];
$genres = [];
$movies = [];
$users = [];

// Insert directors
for ($i = 0; $i < 10; $i++) {
    $stmt = $pdo->prepare("INSERT INTO directors (firstname, lastname) VALUES (?, ?)");
    $stmt->execute([$faker->firstName, $faker->lastName]);
    $directors[] = $pdo->lastInsertId(); // Save director IDs
}

for ($i = 0; $i < 10; $i++) {
    // Insert actors
    $stmt = $pdo->prepare("INSERT INTO actors (firstname, lastname) VALUES (?, ?)");
    $stmt->execute([$faker->firstName, $faker->lastName]);
    $actors[] = $pdo->lastInsertId();
    // Insert genres
    $stmt = $pdo->prepare("INSERT INTO genres (name) VALUES (?)");
    $stmt->execute([$faker->word]);
    $genres[] = $pdo->lastInsertId();
    // Insert movies (with unique titles)
    $stmt = $pdo->prepare("INSERT INTO movies (title, release_year, director_id) VALUES (?, ?, ?)");
    $stmt->execute([$faker->unique()->sentence(), $faker->year, $directors[array_rand($directors)]]);
    $movies[] = $pdo->lastInsertId();
    // Insert users
    $stmt = $pdo->prepare("INSERT INTO users (firstname, lastname) VALUES (?, ?)");
    $stmt->execute([$faker->firstName, $faker->lastName]);
    $users[] = $pdo->lastInsertId();
}

// Insert ratings
for ($i = 0; $i < 10; $i++) {
    $stmt = $pdo->prepare("INSERT INTO ratings (movie_id, user_id, rating) VALUES (?, ?, ?)");
    $stmt->execute([
        $movies[array_rand($movies)], // Random movie
        $users[array_rand($users)], // Random user
        rand(1, 5) // Random rating between 1 and 5
    ]);
}

// Link movies with actors and genres
for ($i = 0; $i < 10; $i++) {
    $stmt = $pdo->prepare("INSERT INTO actor_to_movies (actor_id, movie_id) VALUES (?, ?)");
    $stmt->execute([
        $actors[array_rand($actors)], // Random actor
        $movies[array_rand($movies)] // Random movie
    ]);
    $stmt = $pdo->prepare("INSERT INTO movie_to_genre (movie_id, genre_id) VALUES (?, ?)");
    $stmt->execute([
        $movies[array_rand($movies)], // Random movie
        $genres[array_rand($genres)] // Random genre
    ]);
}