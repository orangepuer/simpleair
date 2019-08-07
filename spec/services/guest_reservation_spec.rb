require 'rails_helper'

RSpec.describe Services::GuestNotification do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:room) { create(:room, user: user) }
  let(:reservation) { create(:reservation, user: another_user, room: room) }

  it 'reservation should be send to guest' do
    expect(GuestNotificationMailer).to receive(:reservation).with(reservation).and_call_original
    subject.send_reservation(reservation)
  end
end