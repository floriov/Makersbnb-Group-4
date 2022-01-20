# frozen_string_literal: true

def fill_in_add_space(name, description, price, available_from, available_to)
  visit('/spaces/add')
  fill_in 'name', with: name
  fill_in 'description', with: description
  fill_in 'price', with: price
  fill_in 'available_from',  with: available_from
  fill_in 'available_to', with: available_to
  click_button 'list property'
end

