feature 'registration' do 
  scenario 'a user can sign up' do
    visit '/'
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'test123'
    fill_in 'username', with: 'user_test'
    click_button('Sign up')

    expect(page).to have_content "Beautiful Relaxing Space Less Beautiful, Less Relaxing Space Ugly Fear-Inducing Space"

  end 
end 
