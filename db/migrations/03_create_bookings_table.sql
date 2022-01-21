CREATE TYPE status AS ENUM ('requested', 'approved', 'declined', 'unavailable');
CREATE TABLE bookings ( id SERIAL PRIMARY KEY, space_id INTEGER REFERENCES spaces (id) NOT NULL, host_id INTEGER REFERENCES users (id), customer_id int NOT NULL, start_date date NOT NULL, end_date date NOT NULL, status status);
