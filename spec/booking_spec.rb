require 'booking'

describe Booking do 
  describe '.add' do 
    it 'creates a booking request' do 
      connection = PG.connect(dbname: 'makersbnb_test')
      host = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [1])
      customer = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [2])
      space = Space.add(name: 'test name', description: 'test description', price: '22.22', user_id: 1, start_date: '2022-01-01', end_date: '2022-01-31')

      #need space_id to be readable - pending Ben and Victoria
      booking = Bookings.add(space_id: space_id, host_id: 1, customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )

      expect(booking).to be_a Booking
      expect(booking.space_id).to eq space.space_id
      expect(booking.host_id).to eq space.user_id
      expect(booking.customer_id).to eq customer.id
      expect(booking.start_date).to eq '2022-01-01'
      expect(booking.end_date).to eq '2022-01-31'
      expect(booking.status).to eq 'requested'
      
    end 
  end 

  describe '.all' do 
    it 'shows all bookings' do
      host = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [1])
      connection = PG.connect(dbname: 'makersbnb_test')
      customer = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [2])
      space = Space.add(name: 'test name', description: 'test description', price: '22.22', user_id: 1, start_date: '2022-01-01', end_date: '2022-01-31')

      booking = Bookings.add(space_id: space_id, host_id: 1, customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )
                Bookings.add(space_id: space_id, host_id: 1, customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )

        bookings = Booking.all
      
      expect(bookings.length).to eq 2
      expect(bookings.first).to be_a Booking
      expect(bookings.first.space_id).to eq booking.space_id
      expect(bookings.first.host_id).to eq booking.host_id
      expect(bookings.first.customer_id).to eq booking.customer_id
      expect(bookings.first.start_date).to eq booking.start_date
      expect(bookings.first.end_date).to eq booking.end_date
      expect(bookings.first.status).to eq booking.status

    end
  end

  describe '.all_booking_made' do
    it 'shows the bookings requested by the customer' do
      connection = PG.connect(dbname: 'makersbnb_test')
      host = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [1])
      customer = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [2])
      space = Space.add(name: 'test name', description: 'test description', price: '22.22', user_id: 1, start_date: '2022-01-01', end_date: '2022-01-31')
      booking = Bookings.add(space_id: space_id, host_id: 1, customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )
      Bookings.add(space_id: space_id, host_id: 1, customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )
    
      bookings = Booking.all

      expect(bookings.all_booking_made(customer_id: 2).length).to eq 2
      
    end
  end
  
end 

