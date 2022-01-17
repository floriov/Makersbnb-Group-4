feature 'registration' do 
  scenario 'a user can sign up' do
    visit '/users/new'
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'test123'
    fill_in 'username', with: 'user.test'
    click_button('Sign up')

    expect(page).to have_content "Welcome to Makersbnb, user.test"

  end 
end 
