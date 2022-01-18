feature 'Viewing Spaces' do
  scenario 'user can view spaces' do
    
    fill_in_space_form('Beautiful Relaxing Space', 'Less Beautiful, Less Relaxing Space', '142.00')
    fill_in_space_form('1 test drive', 'Ugly room', '200.00')
    
    expect(page).to have_content('Beautiful Relaxing Space')
    expect(page).to have_content('Ugly room')
    expect(page).to have_content('£142.00')
  end
end

def fill_in_space_form(name, description, price)
  visit('/spaces/add')
  fill_in 'name', with: name
  fill_in 'description', with: description
  fill_in 'price', with: price
  click_button 'Add lovely space'
end
