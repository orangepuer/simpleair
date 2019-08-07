require 'rails_helper'

RSpec.describe GuestReservationJob, type: :job do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:room) { create(:room, user: user) }
  let(:reservation) { create(:reservation, user: another_user, room: room) }
  let(:service) { double('Services::GuestNotification') }

  before { allow(Services::GuestNotification).to receive(:new).and_return(service) }

  it 'calls Services::GuestNotification#send_reservation' do
    expect(service).to receive(:send_reservation).with(reservation)
    GuestReservationJob.perform_now(reservation)
  end
end