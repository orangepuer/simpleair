require 'rails_helper'

feature 'Edit room' do
  given(:user) { create(:user) }
  given(:room) { create(:room, user: user) }

  scenario 'Authenticated user edit prising of room' do
    sign_in user

    visit pricing_room_path(room)
    fill_in 'Price', with: '1000'

    click_on 'Update Room'

    expect(current_path).to eq pricing_room_path(room)
    expect(page).to have_field 'Price', with: '1000'
    expect(page).to have_button 'Update Room'
  end

  scenario 'Unauthenticated user try to edit pricing of room' do
    visit pricing_room_path(room)

    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Remember me Forgot Password'
  end
end