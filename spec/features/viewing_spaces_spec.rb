# frozen_string_literal: true

feature 'Viewing Spaces' do
  scenario 'user can view spaces' do
    fill_in_add_space('Beautiful Relaxing Space', 'Less Beautiful, Less Relaxing Space', '142.00', '2022-01-02', '2022-04-02')
    fill_in_add_space('1 test drive', 'Ugly room', '200.00', '01-02-2022', '04-02-2022')

    expect(page).to have_content('Beautiful Relaxing Space')
    expect(page).to have_content('Ugly room')
    expect(page).to have_content('£142.00')
  end
end
