# frozen_string_literal: true

feature 'Adding a space' do
  scenario 'user can add a space' do
    fill_in_add_space('Test Name', 'Test Description', '100.00', '01/02/2022', '04/02/2022')
    
    expect(page).to have_content 'Test Name'
    expect(page).to have_content 'Test Description'
    expect(page).to have_content '£100.00'
    expect(page).to have_content '2022-01-02'
    expect(page).to have_content '2022-04-02'
  end
end
