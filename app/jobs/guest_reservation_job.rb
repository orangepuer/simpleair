class GuestReservationJob < ApplicationJob
  def perform(reservation)
    Services::GuestNotification.new.send_reservation(reservation)
  end
end