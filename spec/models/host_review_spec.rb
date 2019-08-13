require 'rails_helper'

RSpec.describe HostReview, type: :model do
  it { should belong_to :host }

  describe 'validates' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:room) { create(:room, user: user) }
    let!(:reservation) { create(:reservation, user: another_user, room: room,
                                start_date: '2019-08-07', end_date: '2019-08-10') }
    let!(:first_host_review) { create(:host_review, host: user, guest_id: another_user,
                                      reservation: reservation, room: room) }

    it 'host can not create more than one review for a room reservation' do
      second_host_review = build(:host_review, host: user, guest_id: another_user,
                                 reservation: reservation, room: room)
      second_host_review.save
      expect(second_host_review).to_not be_valid
      expect(second_host_review.errors.full_messages).to include('You have already made a review')
    end
  end
end
