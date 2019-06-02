require 'rails_helper'

feature 'Edit room' do
  given(:user) { create(:user) }
  given(:room) { create(:room, user: user) }

  scenario 'Authenticated user edit description of room' do
    sign_in user

    visit description_room_path(room)
    fill_in 'Listing name', with: 'New listing name'
    fill_in 'Summary', with: 'Summary of new listing name'

    click_on 'Update Room'

    expect(current_path).to eq description_room_path(room)
    expect(page).to have_field 'Listing name', with: 'New listing name'
    expect(page).to have_field 'Summary', with: 'Summary of new listing name'
    expect(page).to have_button 'Update Room'
  end

  scenario 'Unauthenticated user try to edit description of room' do
    visit description_room_path(room)

    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Remember me Forgot Password'
  end
end