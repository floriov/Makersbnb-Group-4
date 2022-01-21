require 'booking'
require 'pg'

describe Booking do 
  describe '.add' do 
    it 'creates a booking request' do 
      DatabaseConnection.query("INSERT INTO users (id) VALUES ($1)", [1])
      DatabaseConnection.query("INSERT INTO users (id) VALUES ($1)", [2])
      DatabaseConnection.query("INSERT INTO spaces (id) VALUES ($1)", [1])

      space = Space.add(name: 'test name', 
        description: 'test description', 
        price: '22.22', 
        user_id: 1, 
        available_from: '2022-01-01', 
        available_to: '2022-01-31')

      booking = Booking.add(space_id: 1, 
        customer_id: 2,
        start_date: '2022-01-01', 
        end_date: '2022-01-31', 
        status: 'requested' )

      expect(booking).to be_a Booking
      expect(booking.space_id).to eq '1'
      expect(booking.customer_id).to eq '2'
      expect(booking.start_date).to eq '2022-01-01'
      expect(booking.end_date).to eq '2022-01-31'
      expect(booking.status).to eq 'requested'
    end 
  end 

  describe '.all' do 
    it 'show all Booking' do
      DatabaseConnection.query("INSERT INTO users (id) VALUES ($1)", [1])
      DatabaseConnection.query("INSERT INTO users (id) VALUES ($1)", [2])
      DatabaseConnection.query("INSERT INTO spaces (id) VALUES ($1)", [1])
      
      Space.add(name: 'test name', 
        description: 'test description', 
        price: '22.22', 
        user_id: 1, 
        available_from: '2022-01-01', 
        available_to: '2022-01-31')

      booking = Booking.add(space_id: '1', 
        customer_id: 2,
        start_date: '2022-01-01', 
        end_date: '2022-01-31', 
        status: 'requested' )
      Booking.add(space_id: '1', 
        customer_id: 2,
        start_date: '2022-01-01', 
        end_date: '2022-01-31', 
        status: 'requested' )

      bookings = Booking.all
      
      expect(bookings.length).to eq 2
      expect(bookings.first).to be_a Booking
      expect(bookings.first.space_id).to eq '1'
      expect(bookings.first.customer_id).to eq '2'
      expect(bookings.first.start_date).to eq booking.start_date
      expect(bookings.first.end_date).to eq booking.end_date
      expect(bookings.first.status).to eq booking.status

    end
  end

  describe '.all_booking_made' do
    it 'shows the Booking requested by the customer' do
      DatabaseConnection.query("INSERT INTO users (id) VALUES ($1)", [1])
      DatabaseConnection.query("INSERT INTO users (id) VALUES ($1)", [2])

      space = Space.add(name: 'test name', 
        description: 'test description', 
        price: '22.22', 
        user_id: 1, 
        available_from: '2022-01-01', 
        available_to: '2022-01-31')
      spaces = Space.all

      expect(spaces.last.id).to eq space.id

      booking = Booking.add(space_id: space.id, 
        customer_id: 2, 
        start_date: '2022-01-01', 
        end_date: '2022-01-31', 
        status: 'requested' )
      Booking.add(space_id: space.id, 
        customer_id: 2, 
        start_date: '2022-02-02', 
        end_date: '2022-02-22', 
        status: 'requested' )
      Booking.add(space_id: space.id, 
        customer_id: 99, 
        start_date: '2022-02-02', 
        end_date: '2022-02-22', 
        status: 'requested' )

      bookings = Booking.all_booking_made(2)

      expect(booking.space_id).to eq spaces.last.id
      expect(bookings.length).to eq 2
      expect(bookings.first).to be_a Booking
      expect(bookings.first.space_id).to eq booking.space_id
      expect(bookings.first.customer_id).to eq '2'
      expect(bookings.first.start_date).to eq booking.start_date
      expect(bookings.first.end_date).to eq booking.end_date
      expect(bookings.first.status).to eq booking.status
    end
  end

  describe '.all_booking_received' do
    it 'shows all the booking requests received by the host' do
      DatabaseConnection.query("INSERT INTO users (id) VALUES ($1)", [1])
      DatabaseConnection.query("INSERT INTO users (id) VALUES ($1)", [2])

      space = Space.add(name: 'test name', 
        description: 'test description', 
        price: '22.22', 
        user_id: 1, 
        available_from: '2022-01-01', 
        available_to: '2022-01-31')
      
      spaces = Space.all

      expect(spaces.last.id).to eq space.id

      booking = Booking.add(space_id: space.id, 
        customer_id: 2, 
        start_date: '2022-01-01', 
        end_date: '2022-01-31', 
        status: 'requested' )
      Booking.add(space_id: space.id, 
        customer_id: 2, 
        start_date: '2022-02-02', 
        end_date: '2022-02-22', 
        status: 'requested' )
      Booking.add(space_id: space.id, 
        customer_id: 99, 
        start_date: '2022-02-02', 
        end_date: '2022-02-22', 
        status: 'requested' )
 
      bookings = Booking.all_booking_received(space.user_id)
 
      expect(bookings.length).to eq 3
      expect(bookings.first).to be_a Booking
      expect(bookings.first.space_id).to eq booking.space_id
      expect(bookings.first.customer_id).to eq '2'
      expect(bookings.first.start_date).to eq booking.start_date
      expect(bookings.first.end_date).to eq booking.end_date
      expect(bookings.first.status).to eq booking.status 
    end
  end
end 