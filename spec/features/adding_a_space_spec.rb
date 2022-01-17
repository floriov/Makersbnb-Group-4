feature 'Adding a space' do
  scenario 'user can add a space' do
    visit '/spaces/add'
    
    fill_in 'Space name', with: '1, Space Avenue'
    fill_in 'Description', with: 'Big spacious space on Space Avenue for testing space tests'
    fill_in 'Price', with: '142.00'

    click_button('Add lovely space')
  end
end
