class HostNotificationMailer < ApplicationMailer
  def reservation(reservation)
    @host = reservation.room.user
    @guest = reservation.user
    @room = reservation.room

    mail to: @host.email
  end
end