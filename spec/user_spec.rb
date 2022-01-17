require 'user'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(email: 'test@test.com', username: 'user.test', password: 'test123')

      expect(user).to be_a User
      expect(user.email).to eq 'test@test.com'
      expect(user.username).to eq 'user.test'
      expect(user.password).to eq 'test123'

    end
  end
end


