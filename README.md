# Movies Database

This project involves building a database to store and manage movie-related data.

Specifically, the database will include movies, actors, directors, genres, and user ratings.
The relationships between these entities are as follows:

- Each movie has one director.
- Each movie features multiple actors.
- Each movie belongs to one or more genres.
- A director has a firstname and a lastname.
- An actor has a firstname and a lastname.
- Actors may appear in multiple movies.
- Directors may have directed multiple movies.
- Movies can have multiple user ratings.
- User ratings are numerical values ranging from 1 to 5.

The database is seeded with dummy data, using [FakerPHP](https://fakerphp.org/).

The deliverable queries can be found in `queries.sql` file.

To run the database and feed it with some dummy data, the following commands should be executed:

`docker-compose build`

`docker-compose up`

`docker-compose run --rm php php Faker.php`