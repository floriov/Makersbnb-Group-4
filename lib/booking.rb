require 'pg'

class Booking 

  def self.add(space_id:, host_id:, customer_id:, start_date:, end_date:, status:)
    # if self.available?(space_id, start_date, end_date)
    result = DatabaseConnection.query('INSERT INTO bookings (space_id, host_id, customer_id, start_date, end_date, status) 
    VALUES ($1, $2, $3, $4, $5, $6) RETURNING space_id, host_id, customer_id, start_date, end_date, status;', [space_id, host_id, customer_id, start_date, end_date, status])
    
    Booking.new(space_id: result[0]['space_id'], host_id: result[0]['host_id'], customer_id: result[0]['customer_id'], start_date: result[0]['start_date'], end_date: result[0]['end_date'], status: result[0]['status'])
    # @status = 'requested'??
    # else
      # "Sorry, this space is unavailable on those dates" or something like that?
    # end
  end 

  def self.all_booking_made(customer_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE customer_id = '#{customer_id}'")
    
  end

  def self.all_booking_received(host_id:)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE host_id = '#{host_id}'")
  end

  def initialize(space_id:, host_id:, customer_id:, start_date:, end_date:, status:)
    @space_id = space_id
    @host_id = host_id
    @customer_id = customer_id
    @start_date = start_date
    @end_date = end_date
    @status = status
  end 

  attr_reader :space_id, :host_id, :customer_id, :start_date, :end_date, :status
=begin
  def self.availability(space_id)
    dates = DatabaseConnection.query(
    "SELECT available_from, available_to FROM spaces WHERE id = '#{space_id}';")
    # turn dates into hash
  end

  def self.bookings(space_id)
    dates = DatabaseConnection.query(
    "SELECT start_date, end_date FROM bookings WHERE space_id = '#{space_id}' AND status = 'approved';")
    # turn dates into array
  end

  def self.available?(space_id, start_date, end_date)
    available = self.availability(space_id)
    bookings = self.bookings(space_id)

    return false unless start_date.between?(available_from:, available_to:) && end_date.between?(available[0], available[1])
    return false if bookings.include?(start_date) || bookings.include?(end_date)
    true
  end
=end
end 