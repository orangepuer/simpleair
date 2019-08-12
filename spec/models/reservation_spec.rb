require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { should belong_to :user }
  it { should belong_to :room }
  it { should have_one :host_review }
  it { should have_one :guest_review }

  describe 'validates' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:room) { create(:room, user: user) }
    let!(:first_reservation) { create(:reservation, user: another_user, room: room,
                                start_date: '2019-08-07', end_date: '2019-08-10') }

    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }

    it 'room should be available' do
      reservation = build(:reservation, user: another_user, room: room,
                          start_date: '2019-08-06', end_date: '2019-08-11')
      reservation.save
      expect(reservation).to_not be_valid
      error_message = 'This date is not available, please check the booking date entered'
      expect(reservation.errors.full_messages).to include(error_message)
    end
  end

  describe 'notify host' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:room) { create(:room, user: user) }
    let(:reservation) { build(:reservation, user: another_user, room: room) }

    it 'calls HostReservationJob after create' do
      expect(HostReservationJob).to receive(:perform_later).with(reservation)
      reservation.save
    end
  end

  describe 'notify guest' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:room) { create(:room, user: user) }
    let(:reservation) { build(:reservation, user: another_user, room: room) }

    it 'calls GuestReservationJob after create' do
      expect(GuestReservationJob).to receive(:perform_later).with(reservation)
      reservation.save
    end
  end
end
