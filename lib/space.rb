require 'pg'
require_relative 'database_connection'

class Space
  
  attr_reader :name, :description, :price, :user_id

  def initialize(name:, description:, price:, user_id:)
    @name = name
    @description = description
    @price = price
    @user_id = user_id
  end

  def Space.all
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    result.map do |space|
      Space.new(name: space['name'], description: space['description'], price: space['price'], user_id: space['user_id'])
    end
  end

  def Space.add(name:, description:, price:, user_id:)
    result = DatabaseConnection.query('INSERT INTO spaces (name, description, price, user_id) VALUES ($1, $2, $3, $4) RETURNING id, name, description, price, user_id;', [name, description, price, user_id])
    Space.new(name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], user_id: result[0]['user_id'])
  end
end

