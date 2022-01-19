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
end 
