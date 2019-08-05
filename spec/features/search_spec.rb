require 'rails_helper'

feature 'Search' do
  given(:user) { create(:user) }
  given!(:room) { create(:room, user: user, address: 'San Francisco', listing_name: 'Happy Home', active: true) }

  scenario 'User can search room', js: true do
    visit root_path
    fill_in 'search', with: 'San Francisco'

    click_on 'Search'

    expect(current_path).to eq search_path
    expect(page).to have_content 'Happy Home'
  end
end