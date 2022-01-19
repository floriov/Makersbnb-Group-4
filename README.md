# Makersbnb-Group-4

For this technical project we will be building a clone of Airbnb. 

Airbnb is an online platform that allows users to sign up and list their place as holiday accommodation and allows travellers to find a place to stay while they are away from home.

The program will allow:

Any signed-up user to list a new space.
Users can list multiple spaces.
Users should be able to name their space, provide a short description of the space, and a price per night.
Users should be able to offer a range of dates where their space is available.
Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
Nights for which a space has already been booked should not be available for users to book that space.
Until a user has confirmed a booking request, that space can still be booked for that night.

# User Stories
```
(1.Any signed-up user can list a new space.)
As a host
So that I can advertise my properties
I want to list a new space

(2.Users can list multiple spaces.)
As a host
So that I can advertise more than one property
I want to list multiple spaces

(3a. Users should be able to name their space, provide a short description of the space, and a price per night.)
As a host
So that customers can distinguish my spaces
I want to be able to name my space


(3b. Users should be able to name their space, provide a short description of the space, and a price per night.)
As a host
So that customers can learn about my spaces
I want to provide a short description of my spaces

(3c. Users should be able to name their space, provide a short description of the space, and a price per night.)
As a host
So that I can make some money
I want to provide a price per night

(4.Users should be able to offer a range of dates where their space is available.)
As a host
So that I can take a booking
I want to be able to offer a range of available dates

(5a. Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.)
As a customer
So that I can stay in a space
I want to be able to hire a space for one night

(5b. Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.)
As a host
So that I can hire out my space
I want to be able to approve a customer booking

(6.Nights for which a space has already been booked should not be available for users to book that space.)
As a host
So that my space doesn’t get double booked
I want to prevent a booked space from being available

(7.Until a user has confirmed a booking request, that space can still be booked for that night)
As a host
So that I don’t miss out on any bookings
I want a space to be available until I confirm a booking request
```


>>> #Testing Our Calendar BOokign 
# STEP 1 >> inserting availabilities of a specific space by the host
INSERT INTO sys_calendar VALUES
('2013-04-01'),
('2013-04-02'),
('2013-04-03'),
('2013-04-04'),
('2013-04-05'),
('2013-04-06'),
('2013-04-07');

# STEP 2 >> creating users booking request with start and end dates for a specific space (1)
INSERT INTO bookings (spaces_id, start_date, end_date) VALUES (1, '2013-04-01', '2013-04-03');

# STEP 3 >> query to check if the dates requested are available 
SELECT	c.dt,
		CASE WHEN COUNT(b.id) > 0 THEN 'No' ELSE 'Yes' END AS Availability
FROM	sys_calendar c
		LEFT JOIN bookings b
			ON b.spaces_id = 1
			AND c.dt BETWEEN b.Start_Date AND b.End_Date
WHERE   c.dt BETWEEN '20130401' AND '20130430'
GROUP BY c.dt;


#Step 4 >> Add a new booking request

INSERT INTO bookings (spaces_id, host_id, customer_id, start_date, end_date, status) VALUES('2', '45', '55', '2013/04/01', '2013/04/02', 'requested');