class GuestNotificationMailer < ApplicationMailer
  def reservation(reservation)
    @guest = reservation.user
    @host = reservation.room.user
    @room = reservation.room

    mail to: @guest.email
  end
end