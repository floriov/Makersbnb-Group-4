class Booking 

  def self.add(space_id:, host_id:, customer_id:, start_date:, end_date:, status:)
    result = DatabaseConnection.query('INSERT INTO bookings (spaces_id, host_id, customer_id, start_date, end_date, status) 
    VALUES($1, $2, $3, $4, $5, $6) RETURNING spaces_id, host_id, customer_id, start_date, end_date, status;' [spaces_id, host_id, customer_id, start_date, end_date, status])
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