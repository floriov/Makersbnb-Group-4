# frozen_string_literal: true

require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec('TRUNCATE users CASCADE;')
  connection.exec('TRUNCATE bookings CASCADE;')
  connection.exec('TRUNCATE spaces CASCADE;')
end
