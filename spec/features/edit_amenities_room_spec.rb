require 'rails_helper'

feature 'Edit room' do
  given(:user) { create(:user) }
  given(:room) { create(:room, user: user) }

  scenario 'Authenticated user edit amenities of room' do
    sign_in user

    visit amenities_room_path(room)
    check 'TV'
    check 'Kitchen'
    check 'Internet'
    check 'Heating'
    check 'Air'

    click_on 'Update Room'

    expect(current_path).to eq amenities_room_path(room)
    expect(page).to have_checked_field 'TV'
    expect(page).to have_checked_field 'Kitchen'
    expect(page).to have_checked_field 'Internet'
    expect(page).to have_checked_field 'Heating'
    expect(page).to have_checked_field 'Air'
    expect(page).to have_button 'Update Room'
  end

  scenario 'Unauthenticated user try to edit amenities of room' do
    visit amenities_room_path(room)

    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Remember me Forgot Password'
  end
end