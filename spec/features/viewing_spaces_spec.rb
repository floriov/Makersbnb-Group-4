feature 'Viewing Spaces' do
  scenario 'user can view spaces' do
    visit('/spaces')
    expect(page).to have_content('Beautiful Relaxing Space')
    expect(page).to have_content('Less Beautiful, Less Relaxing Space')
    expect(page).to have_content('Ugly Fear-Inducing Space')
  end
end
