# frozen_string_literal: true

require 'pg'
require_relative 'database_connection'

class User
  attr_reader :id, :email, :username, :password

  def initialize(id:, email:, username:, password:)
    @id = id
    @email = email
    @username = username
    @password = password
  end

  def self.add(username:, password:, email:)
    result = DatabaseConnection.query(
      'INSERT INTO users (username, password, email) 
      VALUES ($1, $2, $3) 
      RETURNING id, username, password, email', [
        username, password, email
      ]
    )
    User.new(
    id: result[0]['id'],
    username: result[0]['username'], 
    password: result[0]['password'], 
    email: result[0]['email'], 
    )
  end

  def self.find_id(user)
    DatabaseConnection.query("SELECT id FROM users WHERE username = '#{user}';").first['id']
  end

  def self.match?(user, password)
    DatabaseConnection.query("SELECT id FROM users WHERE username = '#{user}';").first ==
      DatabaseConnection.query("SELECT id FROM users WHERE password = '#{password}';").first
  end
end
