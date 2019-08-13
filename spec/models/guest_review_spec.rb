require 'rails_helper'

RSpec.describe GuestReview, type: :model do
  it { should belong_to :guest }

  describe 'validates' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:room) { create(:room, user: user) }
    let!(:reservation) { create(:reservation, user: another_user, room: room,
                                start_date: '2019-08-07', end_date: '2019-08-10') }
    let!(:first_guest_review) { create(:guest_review, host_id: user, guest: another_user,
                                       reservation: reservation, room: room) }

    it 'guest can not create more than one review for a room reservation' do
      second_guest_review = build(:guest_review, host_id: user, guest: another_user,
                                  reservation: reservation, room: room)
      second_guest_review.save
      expect(second_guest_review).to_not be_valid
      expect(second_guest_review.errors.full_messages).to include('You have already made a review')
    end
  end
end
