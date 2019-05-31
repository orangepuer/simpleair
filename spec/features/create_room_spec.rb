require 'rails_helper'

feature 'Create room' do
  given(:user) { create(:user) }

  scenario 'Authenticated user creates room' do
    sign_in user

    visit new_room_path
    select 'Apartment', from: 'Home type'
    select 'Entire', from: 'Room type'
    select '1', from: 'Accommodate'
    select '2', from: 'Bedroom amount'
    select '3', from: 'Bathroom amount'

    click_on 'Create Room'

    expect(page).to have_content 'listing'
    expect(page).to have_select 'Home type', with_selected: 'Apartment'
    expect(page).to have_select 'Room type', with_selected: 'Entire'
    expect(page).to have_select 'Accommodate', with_selected: '1'
    expect(page).to have_select 'Bedroom amount', with_selected: '2'
    expect(page).to have_select 'Bathroom amount', with_selected: '3'
    expect(page).to_not have_button 'Create Room'
    expect(page).to have_button 'Update Room'
  end

  scenario 'Unauthenticated user try to create room' do
    visit new_room_path

    expect(current_path).to eq '/users/login'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Remember me Forgot Password'
  end
end