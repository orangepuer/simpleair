require 'rails_helper'

RSpec.describe HostReservationJob, type: :job do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:room) { create(:room, user: user) }
  let(:reservation) { create(:reservation, user: another_user, room: room) }
  let(:service) { double('Services::HostNotification') }

  before { allow(Services::HostNotification).to receive(:new).and_return(service) }

  it 'calls Services::HostNotification#send_reservation' do
    expect(service).to receive(:send_reservation)
    HostReservationJob.perform_now(reservation)
  end
end