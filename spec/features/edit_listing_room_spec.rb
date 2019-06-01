require 'rails_helper'

feature 'Edit room' do
  given(:user) { create(:user) }
  given(:room) { create(:room, user: user) }

  scenario 'Authenticated user edit listing of room' do
    sign_in user

    visit listing_room_path(room)
    select 'Apartment', from: 'Home type'
    select 'Entire', from: 'Room type'
    select '2', from: 'Accommodate'
    select '3', from: 'Bedroom amount'
    select '4+', from: 'Bathroom amount'

    click_on 'Update Room'

    expect(current_path).to eq listing_room_path(room)
    expect(page).to have_select 'Home type', with_selected: 'Apartment'
    expect(page).to have_select 'Room type', with_selected: 'Entire'
    expect(page).to have_select 'Accommodate', with_selected: '2'
    expect(page).to have_select 'Bedroom amount', with_selected: '3'
    expect(page).to have_select 'Bathroom amount', with_selected: '4+'
    expect(page).to have_button 'Update Room'
  end

  scenario 'Unauthenticated user try to edit listing of room' do
    visit listing_room_path(room)

    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Remember me Forgot Password'
  end
end