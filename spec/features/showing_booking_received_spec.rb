
feature 'Showing booking received' do
  xscenario 'shows the booking received as a host' do
    fill_in_add_space('Beautiful Relaxing Space', 'Less Beautiful, Less Relaxing Space', '142.00', '2022-01-02', '2022-04-02')
    visit 'spaces/1'
    fill_in 'start_date'
    fill_in 'end_date'
    click_button 'Submit'
  
    expect(page).to have_content('one request pending')

  end
end





      

    