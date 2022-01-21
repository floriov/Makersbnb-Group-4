require 'pg'
require_relative 'database_connection'
class Booking
  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookings;")
    result.map do |booking|
      Booking.new(space_id: booking['space_id'],
      customer_id: booking['customer_id'],
      host_id: booking['host_id'],
      start_date: booking['start_date'],
      end_date: booking['end_date'],
      status: booking['status'])
    end
  end

  def self.add(space_id:, customer_id:, start_date:, end_date:, status:)
    host_id = DatabaseConnection.query("SELECT * FROM spaces WHERE id = #{space_id};").first['user_id']
    #if self.available?(space_id, start_date, end_date)
      result = DatabaseConnection.query('INSERT INTO bookings (space_id, customer_id, host_id, start_date, end_date, status)
      VALUES ($1, $2, $3, $4, $5, $6) RETURNING space_id, customer_id, host_id, start_date, end_date, status;',
      [space_id, customer_id, host_id, start_date, end_date, status])
      Booking.new(space_id: result[0]['space_id'],
        host_id: result[0]['host_id'],
        customer_id: result[0]['customer_id'],
        start_date: result[0]['start_date'],
        end_date: result[0]['end_date'],
        status: result[0]['status'])
    # else
    #   raise
    # end
  end

  def self.all_booking_made(user_id)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE customer_id = #{user_id};")
    result.map do |booking|
      Booking.new(space_id: booking['space_id'],
      customer_id: booking['customer_id'],
      host_id: booking['host_id'],
      start_date: booking['start_date'],
      end_date: booking['end_date'],
      status: booking['status'])
    end
  end

  def self.all_booking_received(user_id)
    result = DatabaseConnection.query("SELECT * FROM bookings WHERE host_id = #{user_id};")
    result.map do |booking|
      Booking.new(space_id: booking['space_id'],
      customer_id: booking['customer_id'],
      host_id: booking['host_id'],
      start_date: booking['start_date'],
      end_date: booking['end_date'],
      status: booking['status'])
    end
  end

  def self.availability(space_id)
    dates = DatabaseConnection.query(
    "SELECT available_from, available_to FROM spaces WHERE id = #{space_id};").first
  end

  def self.bookings(space_id)
    dates = DatabaseConnection.query(
    "SELECT start_date, end_date FROM bookings WHERE space_id = #{space_id} AND status = 'approved';").first
  end

  def self.available?(space_id, start_date, end_date)
    available = self.availability(space_id)
    bookings = self.bookings(space_id)
    return false unless start_date.between?(available[:available_from], available[:available_to]) && end_date.between?(available[:available_from], available[:available_to])
    return false if bookings.has_value?(start_date) || bookings.has_value?(end_date)
    true
  end

  def initialize(space_id:, customer_id:, host_id:, start_date:, end_date:, status:)
    @space_id = space_id
    @customer_id = customer_id
    @host_id = host_id
    @start_date = start_date
    @end_date = end_date
    @status = status
  end
  
  attr_reader :space_id, :customer_id, :host_id, :start_date, :end_date, :status
end