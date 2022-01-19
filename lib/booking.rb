class Booking 

  def self.add(space_id:, host_id:, customer_id:, start_date:, end_date:, status:)
    result = DatabaseConnection.query('INSERT INTO bookings (spaces_id, host_id, customer_id, start_date, end_date, status) 
    VALUES($1, $2, $3, $4, $5, $6) RETURNING spaces_id, host_id, customer_id, start_date, end_date, status;' [spaces_id, host_id, customer_id, start_date, end_date, status])
   
    Bookings.new(space_id: result[0]['space_id'], host_id: result[0]['host_id'], customer_id: result[0]['customer_id'], start_date: result[0]['start_date'], end_date: result[0]['end_date'])
    
  end 

  def self.all_booking_made(customer_id: )
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

end 