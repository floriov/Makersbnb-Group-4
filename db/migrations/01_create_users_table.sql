CREATE TABLE users ( id SERIAL PRIMARY KEY, username VARCHAR (150) UNIQUE, password VARCHAR (500), email VARCHAR (500) UNIQUE);