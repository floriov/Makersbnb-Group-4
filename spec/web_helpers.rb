def fill_in_space_form(name, description, price)
  visit('/spaces/add')
  fill_in 'name', with: name
  fill_in 'description', with: description
  fill_in 'price', with: price
  click_button 'Add lovely space'
end