require 'rails_helper'

feature 'Edit room' do
  given(:user) { create(:user) }
  given(:room) { create(:room, user: user) }

  scenario 'Authenticated user edit location of room' do
    sign_in user

    visit location_room_path(room)
    fill_in 'Address', with: 'New address'

    click_on 'Update Room'

    expect(current_path).to eq location_room_path(room)
    expect(page).to have_field 'Address', with: 'New address'
    expect(page).to have_button 'Update Room'
  end

  scenario 'Unauthenticated user try to edit location of room' do
    visit location_room_path(room)

    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Remember me Forgot Password'
  end
end