
class User

  attr_reader :email, :username, :password

  def initialize(email:, username:, password:)
    @email = email
    @username = username
    @password = password
  end


  def self.create(email:, username:, password:)
    # user
  end 
end