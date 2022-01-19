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
    it 'shows all Booking' do
      connection = PG.connect(dbname: 'makersbnb_test')
      host = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [1])
      customer = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [2])
      space = Space.add(name: 'test name', description: 'test description', price: '22.22', user_id: 1, available_from: '2022-01-01', available_to: '2022-01-31')

      booking = Booking.add(space_id: 1, host_id: 1, customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )
                Booking.add(space_id: 1, host_id: 1, customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )

        booking = Booking.all
      
      expect(booking.length).to eq 2
      expect(booking.first).to be_a Booking
      expect(booking.first.space_id).to eq 1
      expect(booking.first.host_id).to eq booking.host_id
      expect(booking.first.customer_id).to eq '2'
      expect(booking.first.start_date).to eq booking.start_date
      expect(booking.first.end_date).to eq booking.end_date
      expect(booking.first.status).to eq booking.status

    end
  end

  describe '.all_booking_made' do
    it 'shows the Booking requested by the customer' do
      connection = PG.connect(dbname: 'makersbnb_test')
      host = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [1])
      customer = connection.exec_params("INSERT INTO users (id) VALUES ($1)", [2])
      space = Space.add(name: 'test name', description: 'test description', price: '22.22', user_id: 1, available_from: '2022-01-01', available_to: '2022-01-31')
      booking = Booking.add(space_id: 1, host_id: 1, customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )
      Booking.add(space_id: 1, host_id: 1, customer_id: 2, start_date: '2022-01-01', end_date: '2022-01-31', status: 'requested' )
    
      booking = Booking.all

      expect(booking.all_booking_made(customer_id: 2).length).to eq 2
      
    end
  end
  
end 

