CREATE TABLE spaces ( id SERIAL PRIMARY KEY, name VARCHAR (150), description VARCHAR (500), price NUMERIC (8, 2), available_from DATE, available_to DATE, user_id INTEGER REFERENCES users (id));