require 'booking'
require 'pg'

describe Booking do 
  describe '.add' do 
    it 'creates a booking request' do 
      connection = PG.connect(dbname: 'makersbnb_test')
      host = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [1])
      customer = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [2])
      space = Space.add(name: 'test name', description: 'test description', price: '22.22', user_id: 1, available_from: '2022-01-01', available_to: '2022-01-31')

      #need space_id to be readable - pending Ben and Victoria
      booking = Booking.add(space_id: 1, host_id: 1, customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )

      expect(booking).to be_a Booking
      expect(booking.space_id).to eq '1'
      expect(booking.host_id).to eq space.user_id
      expect(booking.customer_id).to eq '2'
      expect(booking.start_date).to eq '2022-01-01'
      expect(booking.end_date).to eq '2022-01-31'
      expect(booking.status).to eq 'requested'
      
    end 
  end 

  describe '.all' do 
    it 'show all Booking' do
      connection = PG.connect(dbname: 'makersbnb_test')
      host = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [1])
      customer = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [2])
      space = Space.add(name: 'test name', description: 'test description', price: '22.22', user_id: 1, available_from: '2022-01-01', available_to: '2022-01-31')

      booking = Booking.add(space_id: '1', host_id: '1', customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )
      Booking.add(space_id: '1', host_id: '1', customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )

      bookings = Booking.all
      
      expect(bookings.length).to eq 2
      expect(bookings.first).to be_a Booking
      expect(bookings.first.space_id).to eq "1"
      expect(bookings.first.host_id).to eq booking.host_id
      expect(bookings.first.customer_id).to eq '2'
      expect(bookings.first.start_date).to eq booking.start_date
      expect(bookings.first.end_date).to eq booking.end_date
      expect(bookings.first.status).to eq booking.status

    end
  end

  describe '.all_booking_made' do
    it 'shows the Booking requested by the customer' do
      #connected to the database
      connection = PG.connect(dbname: 'makersbnb_test')
      
      #created a host user with user_id 1 
      host = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [1])

      #created a customer user with user_id 2 
      customer = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [2])

      #created a space with owner / user_id as 1 // WHAT IS THE SPACE ID? double check if this is 1 
      space = Space.add(name: 'test name', description: 'test description', price: '22.22', user_id: 1, available_from: '2022-01-01', available_to: '2022-01-31')
      
      spaces = Space.all

      expect(spaces.last.id).to eq space.id

      #submit a booking request 
      booking = Booking.add(space_id: "#{space.id}", host_id: "#{space.user_id}", customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )
      Booking.add(space_id: "#{space.id}", host_id: "#{space.user_id}", customer_id: 2, start_date: '2022-02-02', end_date: '2022-02-22', status: 'requested' )
      Booking.add(space_id: "#{space.id}", host_id: "#{space.user_id}", customer_id: 99, start_date: '2022-02-02', end_date: '2022-02-22', status: 'requested' )

      expect(booking.space_id).to eq spaces.last.id

      #combine all our bookings into a single request 
      bookings = Booking.all_booking_made(customer_id: 2)

      #final tests 
      expect(bookings.length).to eq 2
      expect(bookings.first).to be_a Booking
      expect(bookings.first.space_id).to eq booking.space_id
      expect(bookings.first.host_id).to eq booking.host_id
      expect(bookings.first.customer_id).to eq '2'
      expect(bookings.first.start_date).to eq booking.start_date
      expect(bookings.first.end_date).to eq booking.end_date
      expect(bookings.first.status).to eq booking.status
      
    end
  end

  describe '.all_booking_received' do
    it 'shows all the booking requests received by the host' do
      #connected to the database
      connection = PG.connect(dbname: 'makersbnb_test')
      
      #created a host user with user_id 1 
      host = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [1])

      #created a customer user with user_id 2 
      customer = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [2])

      #created a space with owner / user_id as 1 // WHAT IS THE SPACE ID? double check if this is 1 
      space = Space.add(name: 'test name', description: 'test description', price: '22.22', user_id: 1, available_from: '2022-01-01', available_to: '2022-01-31')
      
      spaces = Space.all

      expect(spaces.last.id).to eq space.id

      #submit a booking request 
      booking = Booking.add(space_id: "#{space.id}", host_id: "#{space.user_id}", customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )
      Booking.add(space_id: "#{space.id}", host_id: "#{space.user_id}", customer_id: 2, start_date: '2022-02-02', end_date: '2022-02-22', status: 'requested' )
      Booking.add(space_id: "#{space.id}", host_id: "#{space.user_id}", customer_id: 99, start_date: '2022-02-02', end_date: '2022-02-22', status: 'requested' )

      #combine all our bookings into a single request 
      bookings = Booking.all_booking_received(host_id: "#{space.user_id}" )

      #final tests 
      expect(bookings.length).to eq 3
      expect(bookings.first).to be_a Booking
      expect(bookings.first.space_id).to eq booking.space_id
      expect(bookings.first.host_id).to eq booking.host_id
      # expect(bookings.first.customer_id).to eq '2'
      # expect(bookings.first.start_date).to eq booking.start_date
      # expect(bookings.first.end_date).to eq booking.end_date
      # expect(bookings.first.status).to eq booking.status
      
    end
  end




  
end 

