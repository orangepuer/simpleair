class HostReservationJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    Services::HostNotification.new.send_reservation(reservation)
  end
end