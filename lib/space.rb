# frozen_string_literal: true

require 'pg'
require_relative 'database_connection'

class Space
  attr_reader :name, :description, :price, :available_from, :available_to, :user_id, :space_id

  def initialize(name:, description:, price:, available_from:, available_to:, user_id:, space_id:)
    @name = name
    @description = description
    @price = price
    @available_from = available_from
    @available_to = available_to
    @user_id = user_id
    @space_id = space_id
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM spaces;')
    result.map do |space|
      Space.new(name: space['name'], 
      description: space['description'], 
      price: space['price'], 
      available_from: space['available_from'], 
      available_to: space['available_to'],
      user_id: space['user_id'], 
      space_id: space['id'])
    end
  end

  def self.add(name:, description:, price:, available_from:, available_to:, user_id:)
    result = DatabaseConnection.query(
      'INSERT INTO spaces (name, description, price, available_from, available_to, user_id) 
      VALUES ($1, $2, $3, $4, $5, $6) RETURNING id, name, description, price, available_from, available_to, user_id;', [
        name, description, price, available_from, available_to, user_id
      ]
    )
    Space.new(
    space_id: result[0]['id'],
    name: result[0]['name'], 
    description: result[0]['description'], 
    price: result[0]['price'], 
    available_from: result[0]['available_from'], 
    available_to: result[0]['available_to'],
    user_id: result[0]['user_id']
    )
  end
end

