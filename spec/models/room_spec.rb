require 'rails_helper'

RSpec.describe Room, type: :model do
  it { should belong_to :user }
  it { should have_many :reservations }
  it { should have_many :guest_reviews }

  it { should validate_presence_of :home_type }
  it { should validate_presence_of :room_type }
  it { should validate_presence_of :accommodate }
  it { should validate_presence_of :bedroom_amount }
  it { should validate_presence_of :bathroom_amount }

  describe 'available?' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:room) { create(:room, user: user) }
    let!(:reservation) { create(:reservation, user: another_user, room: room,
                                start_date: '2019-08-07', end_date: '2019-08-10') }

    it 'Room should be available' do
      expect(room).to be_available('2019-08-11', '2019-08-15')
    end

    it 'Room does not available' do
      expect(room).to_not be_available('2019-08-06', '2019-08-11')
      expect(room).to_not be_available('2019-08-08', '2019-08-09')
    end
  end
end
